import 'package:flutter/material.dart';
import 'package:cometchat_calls_uikit/cometchat_calls_uikit.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

/// [CometChatCallButtons] is a button widget with voice and video call icons.
///
/// ```dart
/// CometChatCallButtons(
///   user: User(),
///   group: Group(),
///   onVoiceCallClick: (context, user, group) {
///     // Handle voice call click
///   },
///   onVideoCallClick: (context, user, group) {
///     // Handle video call click
///   },
/// );
/// ```
class CometChatCallButtons extends StatelessWidget {
  CometChatCallButtons({
    Key? key,
    this.user,
    this.group,
    this.onVoiceCallClick,
    this.onVideoCallClick,
    this.style,
    OnError? onError,
    this.hideVideoCall,
    this.hideVoiceCall,
    this.voiceCallIcon,
    this.videoCallIcon,
    this.outgoingCallConfiguration,
    this.callSettingsBuilder,
  })  : _callButtonsController = CometChatCallButtonsController(
            user: user,
            group: group,
            onError: onError,
            outgoingCallConfiguration: outgoingCallConfiguration,
            callSettingsBuilder: callSettingsBuilder),
        super(key: key);

  ///[user] is a object of [User] for which call is to be initiated
  final User? user;

  ///[group] is a object of [Group] for which call is to be initiated
  final Group? group;

  ///[onVoiceCallClick] is a callback which gets called when voice call icon is clicked
  final Function(BuildContext, User?, Group?)? onVoiceCallClick;

  ///[onVideoCallClick] is a callback which gets called when video call icon is clicked
  final Function(BuildContext, User?, Group?)? onVideoCallClick;

  ///[style] is a object of [CometChatCallButtonsStyle] which sets the style for the call buttons
  final CometChatCallButtonsStyle? style;

  ///[hideVoiceCall] is a bool which hides the voice call icon
  final bool? hideVoiceCall;

  ///[hideVideoCall] is a bool which hides the video call icon
  final bool? hideVideoCall;

  ///[voiceCallIcon] is a Widget which sets the icon for the voice call
  final Widget? voiceCallIcon;

  ///[videoCallIcon] is a Widget which sets the icon for the video call
  final Widget? videoCallIcon;

  ///[outgoingCallConfiguration] is a object of [OutgoingCallConfiguration] which sets the configuration for outgoing call
  final CometChatOutgoingCallConfiguration? outgoingCallConfiguration;

  ///[callSettingsBuilder] is used to configure the meet settings builder
  final CallSettingsBuilder Function(
      User? user, Group? group, bool? isAudioOnly)? callSettingsBuilder;

  ///[_callButtonsController] is an instance of [CometChatCallButtonsController] the view model of this widget
  final CometChatCallButtonsController _callButtonsController;

  @override
  Widget build(BuildContext context) {
    final callButtonsStyle =
        CometChatThemeHelper.getTheme<CometChatCallButtonsStyle>(
                context: context, defaultTheme: CometChatCallButtonsStyle.of)
            .merge(style);
    final colorPalette = CometChatThemeHelper.getColorPalette(context);
    return Material(
      color: colorPalette.transparent ?? Colors.transparent,
      child: GetBuilder(
        init: _callButtonsController,
        global: false,
        dispose: (GetBuilderState<CometChatCallButtonsController> state) =>
            state.controller?.onClose(),
        builder: (CometChatCallButtonsController viewModel) {
          return Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              if (hideVoiceCall != true)
                IconButton(
                  style: IconButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: callButtonsStyle.voiceCallButtonBorderRadius ?? BorderRadius.circular(0),
                      side: callButtonsStyle.voiceCallButtonBorder ?? BorderSide.none,
                    ),
                    backgroundColor: callButtonsStyle.voiceCallButtonColor,
                  ),
                  onPressed: () {
                    if (!viewModel.disabled) {
                      if (onVoiceCallClick != null) {
                        onVoiceCallClick!(context, user, group);
                      } else {
                        viewModel.initiateCall(CallTypeConstants.audioCall, context);
                      }
                    }
                  },
                  icon: voiceCallIcon ??
                      Icon(
                        Icons.call_outlined,
                        size: 24,
                        color: callButtonsStyle.voiceCallIconColor ??
                            colorPalette.iconPrimary,
                      ),
                ),
              if (hideVideoCall != true)
                IconButton(
                  style: IconButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: callButtonsStyle.videoCallButtonBorderRadius ?? BorderRadius.circular(0),
                      side: callButtonsStyle.videoCallButtonBorder ?? BorderSide.none,
                    ),
                    backgroundColor: callButtonsStyle.videoCallButtonColor,
                  ),
                  onPressed: () {
                    if (viewModel.disabled == false) {
                      if (onVideoCallClick != null) {
                        onVideoCallClick!(context, user, group);
                      } else {
                        viewModel.initiateCall(CallTypeConstants.videoCall, context);
                      }
                    }
                  },
                  icon: videoCallIcon ??
                  SvgPicture.asset(
                     SvgAssetConstants.videoCall,
                      height: 24,
                      width: 24,
                      color: callButtonsStyle.videoCallIconColor ??
                          colorPalette.iconPrimary,
                    package: UIConstants.packageName,
                  ),
                ),
            ],
          );
        },
      ),
    );
  }
}
