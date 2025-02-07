import 'package:flutter/material.dart';
import 'package:cometchat_calls_uikit/cometchat_calls_uikit.dart';


///[CallButtonsConfiguration] is a data class that has configuration properties
///
/// ```dart
/// CallButtonsConfiguration(
/// onVoiceCallClick: (context) {
/// print('Voice Call');
/// },
/// onVideoCallClick: (context) {
/// print('Video Call');
/// },
/// );
///
class CallButtonsConfiguration {
  CallButtonsConfiguration({
    this.onVoiceCallClick,
    this.onVideoCallClick,
    this.callButtonsStyle,
    this.onError,
    this.outgoingCallConfiguration,
    this.hideVideoCall,
    this.hideVoiceCall,
    this.voiceCallIcon,
    this.videoCallIcon,
    this.callSettingsBuilder,
  });

  ///[onVoiceCallClick] is a callback which gets called when voice call icon is clicked
  final Function(BuildContext, User?, Group?)? onVoiceCallClick;

  ///[onVideoCallClick] is a callback which gets called when video call icon is clicked
  final Function(BuildContext, User?, Group?)? onVideoCallClick;

  ///[callButtonsStyle] is a object of [CometChatCallButtonsStyle] which sets the style for the call buttons
  final CometChatCallButtonsStyle? callButtonsStyle;

  ///[onError] is a callback which gets called when there is an error in call
  final OnError? onError;

  ///[outgoingCallConfiguration] is a object of [OutgoingCallConfiguration] which sets the configuration for outgoing call
  final CometChatOutgoingCallConfiguration? outgoingCallConfiguration;

  ///[hideVoiceCall] is a bool which hides the voice call icon
  final bool? hideVoiceCall;

  ///[hideVideoCall] is a bool which hides the video call icon
  final bool? hideVideoCall;

  ///[voiceCallIcon] is a Widget which sets the icon for the voice call
  final Widget? voiceCallIcon;

  ///[videoCallIcon] is a Widget which sets the icon for the video call
  final Widget? videoCallIcon;

  ///[callSettingsBuilder] is used to configure the meet settings builder
  final CallSettingsBuilder Function(
      User? user, Group? group, bool? isAudioOnly)? callSettingsBuilder;
}
