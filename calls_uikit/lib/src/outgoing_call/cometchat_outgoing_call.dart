import 'package:flutter/material.dart';
import 'package:cometchat_calls_uikit/cometchat_calls_uikit.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

// ignore: must_be_immutable
///[CometChatOutgoingCall] is a widget which is used to show outgoing call screen.
///when the logged-in user calls another user
///
/// ```dart
/// CometChatOutgoingCall(
///  call: call,
///  user: user,
///  onError: (error) {
///  print("Error: $error");
///  },
///  onDecline: (context, call) {
///  print("Decline Call");
///  },
///  subtitle: Text("Calling..."),
///  declineButtonIcon: Icon(Icons.call_end),
///  style: CometChatOutgoingCallStyle(
///  backgroundColor: Colors.white,
///  titleColor: Colors.black,
///  subtitleColor: Colors.black,
///  iconColor: Colors.black,
///  ),
///  );
/// ```
///
//ignore: must_be_immutable
class CometChatOutgoingCall extends StatelessWidget {
  ///[user] is used to define the user for which this widget is rendered and call is initiated.
  final User? user;

  ///[subtitle] is used to define the subtitle for the widget.
  final Widget? subtitle;

  ///[declineButtonIconUrl] is used to define the decline button icon url for the widget.
  final Widget? declineButtonIcon;

  ///[outgoingCallStyle] is used to set a custom outgoing call style
  final CometChatOutgoingCallStyle? style;

  ///[callSettingsBuilder] is used to set the call settings
  final CallSettingsBuilder? callSettingsBuilder;

  ///[height] is used to set the height of the widget.
  final double? height;

  ///[width] is used to set the width of the widget.
  final double? width;

  final CometChatOutgoingCallController _outgoingCallController;

  CometChatOutgoingCall({
    Key? key,
    required Call call,
    this.user,
    OnError? onError,
    Function(BuildContext, Call call)? onDecline,
    this.subtitle,
    bool? disableSoundForCalls,
    String? customSoundForCalls,
    String? customSoundForCallsPackage,
    this.declineButtonIcon,
    this.style,
    this.callSettingsBuilder,
    this.width,
    this.height,
  })  : _outgoingCallController = CometChatOutgoingCallController(
          activeCall: call,
          disableSoundForCalls: disableSoundForCalls,
          customSoundForCalls: customSoundForCalls,
          customSoundForCallsPackage: customSoundForCallsPackage,
          onError: onError,
          onDeclineCallTap: onDecline,
          callSettingsBuilder: callSettingsBuilder,
        ),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    final outgoingCallStyle =
        CometChatThemeHelper.getTheme<CometChatOutgoingCallStyle>(
                context: context, defaultTheme: CometChatOutgoingCallStyle.of)
            .merge(style);
    final typography = CometChatThemeHelper.getTypography(context);
    final colorPalette = CometChatThemeHelper.getColorPalette(context);
    final spacing = CometChatThemeHelper.getSpacing(context);

    return WillPopScope(
      onWillPop: () async {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              Translations.of(context).popScreenDisabled,
              style: TextStyle(
                color: colorPalette.white,
                fontSize: typography.button?.medium?.fontSize,
                fontWeight: typography.button?.medium?.fontWeight,
                fontFamily: typography.button?.medium?.fontFamily,
              ),
            ),
            backgroundColor: colorPalette.error,
          ),
        );
        return false;
      },
      child: Scaffold(
        backgroundColor: colorPalette.transparent,
        body: Container(
          height: height ?? double.infinity,
          width: width ?? double.infinity,
          decoration: BoxDecoration(
            color:
                outgoingCallStyle.backgroundColor ?? colorPalette.background1,
            border: outgoingCallStyle.border,
            borderRadius: outgoingCallStyle.borderRadius,
          ),
          child: GetBuilder(
            init: _outgoingCallController,
            global: false,
            dispose: (GetBuilderState<CometChatOutgoingCallController> state) =>
                state.controller?.onClose(),
            builder: (CometChatOutgoingCallController viewModel) {
              viewModel.context = context;
              return Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: spacing.padding5 ?? 0,
                  vertical: spacing.padding5 ?? 0,
                ),
                child: CometChatCard(
                  title: user?.name,
                  avatarName: user?.name,
                  avatarUrl: user?.avatar,
                  avatarHeight: 120,
                  avatarWidth: 120,
                  titlePadding: EdgeInsets.only(
                    bottom: spacing.padding2 ?? 0,
                  ),
                  subtitle: subtitle ??
                      Padding(
                        padding: EdgeInsets.only(
                          bottom: spacing.padding10 ?? 0,
                        ),
                        child: Text(
                          Translations.of(context).calling,
                          style: TextStyle(
                            fontSize: typography.body?.regular?.fontSize,
                            fontWeight: typography.body?.regular?.fontWeight,
                            fontFamily: typography.body?.regular?.fontFamily,
                            color: outgoingCallStyle.subtitleColor ??
                                colorPalette.textSecondary,
                          )
                              .merge(
                                outgoingCallStyle.subtitleTextStyle,
                              )
                              .copyWith(
                                color: outgoingCallStyle.subtitleColor,
                              ),
                        ),
                      ),
                  cardStyle: CardStyle(
                    titleStyle: TextStyle(
                      fontSize: typography.heading1?.bold?.fontSize,
                      fontWeight: typography.heading1?.bold?.fontWeight,
                      fontFamily: typography.heading1?.bold?.fontFamily,
                      color: outgoingCallStyle.titleColor ??
                          colorPalette.textPrimary,
                    )
                        .merge(
                          outgoingCallStyle.titleTextStyle,
                        )
                        .copyWith(
                          color: outgoingCallStyle.titleColor,
                        ),
                    avatarStyle: CometChatAvatarStyle(
                      placeHolderTextStyle: TextStyle(
                        fontSize: typography.heading1?.bold?.fontSize,
                        fontWeight: typography.heading1?.bold?.fontWeight,
                        fontFamily: typography.heading1?.bold?.fontFamily,
                      ).merge(
                        outgoingCallStyle.avatarStyle?.placeHolderTextStyle,
                      ),
                      backgroundColor:
                          outgoingCallStyle.avatarStyle?.backgroundColor,
                      placeHolderTextColor:
                          outgoingCallStyle.avatarStyle?.placeHolderTextColor,
                      borderRadius: outgoingCallStyle.avatarStyle?.borderRadius,
                      border: outgoingCallStyle.avatarStyle?.border,
                    ),
                  ),
                  bottomView: Container(
                    height: 60,
                    width: 60,
                    decoration: BoxDecoration(
                      color: outgoingCallStyle.declineButtonColor ??
                          colorPalette.error,
                      borderRadius: outgoingCallStyle.declineButtonBorderRadius ?? BorderRadius.circular(spacing.radiusMax ?? 0),
                    ),
                    child: IconButton(
                      onPressed: () {
                        viewModel.rejectCall(context, colorPalette, typography);
                      },
                      icon: declineButtonIcon ??
                          Icon(
                            Icons.call_end,
                            size: 32,
                            color: outgoingCallStyle.iconColor ??
                                colorPalette.white,
                          ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
