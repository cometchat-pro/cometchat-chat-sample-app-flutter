import 'dart:async';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart' hide MessageHandler;

class ApnsRemoteMessage {
  ApnsRemoteMessage.fromMap(this.payload);

  final Map<String, dynamic> payload;

  String? get actionIdentifier => UNNotificationAction.getIdentifier(payload);
}

typedef ApnsMessageHandler = Future<void> Function(ApnsRemoteMessage);
typedef WillPresentHandler = Future<bool> Function(ApnsRemoteMessage);

enum ApnsAuthorizationStatus {
  authorized,
  denied,
  notDetermined,
  unsupported,
}

class ApnsPushConnectorOnly {
  final MethodChannel _channel = () {
    assert(Platform.isIOS,
        'ApnsPushConnectorOnly can only be created on iOS platform!');
    return const MethodChannel('flutter_apns');
  }();
  ApnsMessageHandler? _onMessage;
  ApnsMessageHandler? _onLaunch;
  ApnsMessageHandler? _onResume;

  Future<bool> requestNotificationPermissions(
      [IosNotificationSettings iosSettings = const IosNotificationSettings()]) async {
    final bool? result = await _channel.invokeMethod<bool>(
        'requestNotificationPermissions', iosSettings.toMap());
    return result ?? false;
  }

  Future<ApnsAuthorizationStatus> getAuthorizationStatus() async {
    return _authorizationStatusForString(await _channel.invokeMethod<String?>('getAuthorizationStatus', []));
  }

  final StreamController<IosNotificationSettings> _iosSettingsStreamController =
      StreamController<IosNotificationSettings>.broadcast();

  Stream<IosNotificationSettings> get onIosSettingsRegistered {
    return _iosSettingsStreamController.stream;
  }

  /// Sets up [MessageHandler] for incoming messages.
  void configureApns ({
    ApnsMessageHandler? onMessage,
    ApnsMessageHandler? onLaunch,
    ApnsMessageHandler? onResume,
    ApnsMessageHandler? onBackgroundMessage,
  }) {
    _onMessage = onMessage;
    _onLaunch = onLaunch;
    _onResume = onResume;
    _channel.setMethodCallHandler(_handleMethod);
    _channel.invokeMethod('configure');
  }

  Future<dynamic> _handleMethod(MethodCall call) async {
    switch (call.method) {
      case 'onToken':
        token.value = call.arguments;
        return null;
      case 'onIosSettingsRegistered':
        final obj = IosNotificationSettings._fromMap(
            call.arguments.cast<String, bool>());

        isDisabledByUser.value = obj.alert == false;
        return null;
      case 'onMessage':
        return _onMessage?.call(_extractMessage(call));
      case 'onLaunch':
        return _onLaunch?.call(_extractMessage(call));
      case 'onResume':
        return _onResume?.call(_extractMessage(call));
      case 'willPresent':
        return shouldPresent?.call(_extractMessage(call)) ??
            Future.value(false);

      default:
        throw UnsupportedError('Unrecognized JSON message');
    }
  }

  ApnsRemoteMessage _extractMessage(MethodCall call) {
    final map = call.arguments as Map;
    // fix null safety errors
    map.putIfAbsent('contentAvailable', () => false);
    map.putIfAbsent('mutableContent', () => false);
    return ApnsRemoteMessage.fromMap(map.cast());
  }

  ApnsAuthorizationStatus _authorizationStatusForString(String? value) {
    switch (value) {
      case 'authorized':
        return ApnsAuthorizationStatus.authorized;
      case 'denied':
        return ApnsAuthorizationStatus.denied;
      case 'notDetermined':
        return ApnsAuthorizationStatus.notDetermined;
      case 'unsupported':
      default:
        return ApnsAuthorizationStatus.unsupported;
    }
  }

  /// Handler that returns true/false to decide if push alert should be displayed when in foreground.
  /// Returning true will delay onMessage callback until user actually clicks on it
  WillPresentHandler? shouldPresent;

  final isDisabledByUser = ValueNotifier<bool?>(null);

  final token = ValueNotifier<String?>(null);

  String get providerType => "APNS";

  void dispose() {
    _iosSettingsStreamController.close();
  }

  /// https://developer.apple.com/documentation/usernotifications/declaring_your_actionable_notification_types
  Future<void> setNotificationCategories(
      List<UNNotificationCategory> categories) {
    return _channel.invokeMethod(
      'setNotificationCategories',
      categories.map((e) => e.toJson()).toList(),
    );
  }

  Future<void> unregister() async {
    await _channel.invokeMethod('unregister');
    token.value = null;
  }
}

class IosNotificationSettings {
  const IosNotificationSettings({
    this.sound = true,
    this.alert = true,
    this.badge = true,
  });

  IosNotificationSettings._fromMap(Map<String, bool> settings)
      : sound = settings['sound'],
        alert = settings['alert'],
        badge = settings['badge'];

  final bool? sound;
  final bool? alert;
  final bool? badge;

  Map<String, dynamic> toMap() {
    return <String, bool?>{'sound': sound, 'alert': alert, 'badge': badge};
  }

  @override
  String toString() => 'PushNotificationSettings ${toMap()}';
}

/// https://developer.apple.com/documentation/usernotifications/unnotificationcategory
class UNNotificationCategory {
  final String identifier;
  final List<UNNotificationAction> actions;
  final List<String> intentIdentifiers;
  final List<UNNotificationCategoryOptions> options;

  Map<String, dynamic> toJson() {
    return {
      'identifier': identifier,
      'actions': actions.map((e) => e.toJson()).toList(),
      'intentIdentifiers': intentIdentifiers,
      'options': _optionsToJson(options),
    };
  }

  UNNotificationCategory({
    required this.identifier,
    required this.actions,
    required this.intentIdentifiers,
    required this.options,
  });
}

/// https://developer.apple.com/documentation/usernotifications/UNNotificationAction
class UNNotificationAction {
  final String identifier;
  final String title;
  final List<UNNotificationActionOptions> options;

  static const defaultIdentifier =
      'com.apple.UNNotificationDefaultActionIdentifier';

  /// Returns action identifier associated with this push.
  /// May be null, UNNotificationAction.defaultIdentifier, or value declared in setNotificationCategories
  static String? getIdentifier(Map<String, dynamic> payload) {
    final data = payload['data'] as Map?;
    return data?['actionIdentifier'] ?? payload['actionIdentifier'];
  }

  UNNotificationAction({
    required this.identifier,
    required this.title,
    required this.options,
  });

  dynamic toJson() {
    return {
      'identifier': identifier,
      'title': title,
      'options': _optionsToJson(options),
    };
  }
}

/// https://developer.apple.com/documentation/usernotifications/unnotificationactionoptions
enum UNNotificationActionOptions {
  authenticationRequired,
  destructive,
  foreground,
}

/// https://developer.apple.com/documentation/usernotifications/unnotificationcategoryoptions
enum UNNotificationCategoryOptions {
  customDismissAction,
  allowInCarPlay,
  hiddenPreviewsShowTitle,
  hiddenPreviewsShowSubtitle,
  allowAnnouncement,
}

List<String> _optionsToJson(List values) {
  return values.map((e) => e.toString()).toList();
}
