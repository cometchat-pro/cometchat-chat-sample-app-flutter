import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:firebase_core/firebase_core.dart';

/// Function signature for callbacks executed when push message is available;
typedef Future<void> MessageHandler(RemoteMessage message);

/// Interface for either APNS or Firebase connector, implementing common features.
abstract class PushConnector {
  /// User declined to allow for push messages.
  /// initially nil
  ValueNotifier<bool?> get isDisabledByUser;

  /// Value of registered token
  /// initially nil
  ValueNotifier<String?> get token;

  /// Either GCM or APNS
  String get providerType;

  /// Configures callbacks for supported message situations.
  /// It should be called as soon as app is launch or you won't get the `onLaunch` callback
  Future<void> configure({
    /// iOS only: return true to display notification while app is in foreground
    MessageHandler? onMessage,
    MessageHandler? onLaunch,
    MessageHandler? onResume,
    MessageHandler? onBackgroundMessage,
    FirebaseOptions? options,
  });

  /// Prompts (if need) the user to enable push notifications.
  /// After user makes their choice, isDisabledByUser will become either true or false.
  /// If accepted, token.value will be set
  void requestNotificationPermissions();

  /// Unregisters from the service and clears the token.
  Future<void> unregister();

  /// Deletes used resources.
  void dispose() {}
}
