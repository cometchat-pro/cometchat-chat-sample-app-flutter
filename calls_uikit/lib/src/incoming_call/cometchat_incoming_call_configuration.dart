import 'package:flutter/material.dart';
import 'package:cometchat_calls_uikit/cometchat_calls_uikit.dart';

///[CometChatIncomingCallConfiguration] is a data class that has configuration properties
///
/// ```dart
/// CometChatIncomingCallConfiguration(
/// theme: cometChatTheme,
/// onError: (e) {
/// print(e.message);
/// },
/// disableSoundForCalls: true,
/// subtitle: 'Incoming Call',
/// customSoundForCalls: 'custom_sound_for_calls',
/// customSoundForCallsPackage: 'assets',
/// onDecline: (context, call) {
/// print('Call Declined');
/// },
/// declineButtonText: 'Decline',
/// declineButtonStyle: kit.ButtonStyle(
/// backgroundColor: Colors.red,
/// ),
/// declineButtonIconUrl: 'https://example.com/decline.png',
/// declineButtonIconUrlPackage: 'assets',
/// cardStyle: CardStyle( ),
/// );
class CometChatIncomingCallConfiguration {
  CometChatIncomingCallConfiguration({
    this.onError,
    this.disableSoundForCalls,
    this.subtitle,
    this.customSoundForCalls,
    this.customSoundForCallsPackage,
    this.onDecline,
    this.onAccept,
    this.incomingCallStyle,
    this.callSettingsBuilder,
    this.acceptButtonText,
    this.declineButtonText,
    this.height,
    this.width,
  });

  ///[onError] is called when some error occurs
  final OnError? onError;

  ///[subtitle] is used to set a custom subtitle
  final Widget? subtitle;

  ///[disableSoundForCalls] is used to disable sound for call
  final bool? disableSoundForCalls;

  ///[customSoundForCalls] is used to set a custom sound for calls
  final String? customSoundForCalls;

  ///[customSoundForCallsPackage] is used to define the custom sound for calls.
  final String? customSoundForCallsPackage;

  ///[onDecline] is called when the call is declined
  final Function(BuildContext, Call)? onDecline;

  ///[onAccept] is called when the call is accepted
  final Function(BuildContext, Call)? onAccept;

  ///[incomingCallStyle] is used to set a custom incoming call style
  final CometChatIncomingCallStyle? incomingCallStyle;

  ///[callSettingsBuilder] is used to set the call settings
  final CallSettingsBuilder? callSettingsBuilder;

  ///[declineButtonText] is used to set a custom decline text
  final String? declineButtonText;

  ///[acceptButtonText] is used to set a custom accept text
  final String? acceptButtonText;

  ///[height] is used to set the height of the widget.
  final double? height;

  ///[width] is used to set the width of the widget.
  final double? width;
}
