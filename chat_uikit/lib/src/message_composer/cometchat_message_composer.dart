import 'package:flutter/material.dart';
import 'package:cometchat_chat_uikit/cometchat_chat_uikit.dart';
import 'package:get/get.dart';

///
/// [CometChatMessageComposer] component allows users to
/// send messages and attachments to the chat, participating in the conversation.
///
/// ```dart
///  CometChatMessageComposer(
///        user: User(uid: 'uid', name: 'name'),
///        group: Group(guid: 'guid', name: 'name', type: 'public'),
///        messageComposerStyle: MessageComposerStyle(),
///        stateCallBack: (CometChatMessageComposerController state) {},
///        customSoundForMessage: 'asset url',
///        disableSoundForMessages: true,
///        placeholderText: 'Message',
///      );
///
/// ```
///
///
///
class CometChatMessageComposer extends StatefulWidget {
  const CometChatMessageComposer({
    super.key,
    this.user,
    this.group,
    this.style,
    this.placeholderText,
    this.disableTypingEvents = false,
    this.disableSoundForMessages = false,
    this.parentMessageId = 0,
    this.customSoundForMessage,
    this.customSoundForMessagePackage,
    this.auxiliaryButtonView,
    this.headerView,
    this.footerView,
    this.secondaryButtonView,
    this.sendButtonView,
    this.attachmentOptions,
    this.text,
    this.onChange,
    this.maxLine,
    this.auxiliaryButtonsAlignment,
    this.attachmentIconURL,
    this.stateCallBack,
    this.attachmentIcon,
    this.onError,
    this.mediaRecorderStyle,
    this.onSendButtonTap,
    this.hideVoiceRecording,
    this.voiceRecordingIcon,
    this.aiIcon,
    this.aiIconURL,
    this.aiIconPackageName,
    this.aiOptionStyle,
    this.textFormatters,
    this.disableMentions,
    this.textEditingController,
    this.padding,
    this.messageInputPadding,
    this.suggestionListStyle,
    this.recorderStartButtonIcon,
    this.recorderPauseButtonIcon,
    this.recorderDeleteButtonIcon,
    this.recorderStopButtonIcon,
    this.recorderSendButtonIcon,
  }) : assert(user != null || group != null,
  "One of user or group should be passed"),
        assert(user == null || group == null,
        "Only one of user or group should be passed");


  ///sets [user] for message composer
  final User? user;

  ///set [group] for message composer
  final Group? group;

  ///[style] message composer style
  final CometChatMessageComposerStyle? style;

  ///[auxiliaryButtonView] ui component to be forwarded to message input component
  final ComposerWidgetBuilder? auxiliaryButtonView;

  ///[secondaryButtonView] ui component to be forwarded to message input component
  final ComposerWidgetBuilder? secondaryButtonView;

  ///[sendButtonView] ui component to be forwarded to message input component
  final Widget? sendButtonView;

  ///[text] initial text for the input field
  final String? text;

  ///[placeholderText] hint text for input field
  final String? placeholderText;

  ///[onChange] callback to handle change in value of text in the input field
  final Function(String)? onChange;

  ///[maxLine] maximum lines allowed to increase in the input field
  final int? maxLine;

  ///[auxiliaryButtonsAlignment] controls position auxiliary button view
  final AuxiliaryButtonsAlignment? auxiliaryButtonsAlignment;

  ///[attachmentIconURL] path of the icon to show in the attachments button
  final String? attachmentIconURL;

  ///[attachmentIcon] custom attachment icon
  final Widget? attachmentIcon;

  ///[mediaRecorderStyle] provides style to the media recorder
  final CometChatMediaRecorderStyle? mediaRecorderStyle;

  ///[hideVoiceRecording] provides option to hide voice recording
  final bool? hideVoiceRecording;

  ///[voiceRecordingIcon] provides icon to the voice recording Icon/widget
  final Widget? voiceRecordingIcon;

  final int parentMessageId;

  ///[attachmentIcon] custom ai icon
  final Widget? aiIcon;

  ///[aiIconURL] path of the icon to show in the ai button
  final String? aiIconURL;

  ///[aiIconPackageName] package name to show icon from
  final String? aiIconPackageName;

  ///set the style for ai options
  final AIOptionsStyle? aiOptionStyle;

  ///[disableMentions] disables mentions in the composer
  final bool? disableMentions;

  ///[textEditingController] controls the state of the text field
  final TextEditingController? textEditingController;

  ///[padding] provides padding to the message composer
  final EdgeInsetsGeometry? padding;

  ///[messageInputPadding] sets the padding to the message input field
  final EdgeInsetsGeometry? messageInputPadding;

  ///[suggestionListStyle] provides style to the mentions
  final CometChatSuggestionListStyle? suggestionListStyle;

  ///[customSoundForMessage] provides custom sound for message sent
  final String? customSoundForMessage;

  ///[customSoundForMessagePackage] package name to show icon from
  final String? customSoundForMessagePackage;

  ///[disableSoundForMessages] disables sound for message sent
  final bool disableSoundForMessages;

  ///[disableTypingEvents] disables typing events
  final bool disableTypingEvents;

  ///[headerView] ui component to be forwarded to message input component
  final ComposerWidgetBuilder? headerView;

  ///[footerView] ui component to be forwarded to message input component
  final ComposerWidgetBuilder? footerView;

  ///[attachmentOptions] provides options to attach files
  final ComposerActionsBuilder? attachmentOptions;

  ///[stateCallBack] callback to handle state of the message composer
  final void Function(CometChatMessageComposerController)? stateCallBack;

  ///[onError] callback to handle error
  final OnError? onError;

  ///[onSendButtonTap] callback to handle send button tap
  final Function(BuildContext, BaseMessage, PreviewMessageMode?)? onSendButtonTap;

  ///[textFormatters] provides list of text formatters
  final List<CometChatTextFormatter>? textFormatters;

  ///[recorderStartButtonIcon] defines the icon of the start button.
  final Widget? recorderStartButtonIcon;

  ///[recorderPauseButtonIcon] defines the icon of the pause button.
  final Widget? recorderPauseButtonIcon;

  ///[recorderDeleteButtonIcon] defines the icon of the delete button.
  final Widget? recorderDeleteButtonIcon;

  ///[recorderStopButtonIcon] defines the icon of the stop button.
  final Widget? recorderStopButtonIcon;

  ///[recorderSendButtonIcon] defines the icon of the send button.
  final Widget? recorderSendButtonIcon;

  @override
  State<CometChatMessageComposer> createState() => _CometChatMessageComposerState();
}

class _CometChatMessageComposerState extends State<CometChatMessageComposer> {


  ///[cometChatMessageComposerController] contains the business logic
  late CometChatMessageComposerController cometChatMessageComposerController;
  late Map<String, dynamic> composerId = {};


  late CometChatMessageComposerStyle messageComposerStyle;
  late CometChatColorPalette colorPalette;
  late CometChatSpacing spacing;
  late CometChatTypography typography;
  late CometChatSuggestionListStyle suggestionListStyle;
  late List<CometChatMessageComposerAction> elementList;

  @override
  void didChangeDependencies() {
    colorPalette =
        CometChatThemeHelper.getColorPalette(context);
    typography =
        CometChatThemeHelper.getTypography(context);
    spacing = CometChatThemeHelper.getSpacing(context);
    messageComposerStyle =
        CometChatThemeHelper.getTheme<CometChatMessageComposerStyle>(
            context: context,
            defaultTheme: CometChatMessageComposerStyle.of)
            .merge(widget.style);

    suggestionListStyle =
        CometChatThemeHelper.getTheme<CometChatSuggestionListStyle>(
            context: context, defaultTheme: CometChatSuggestionListStyle.of)
            .merge(widget.suggestionListStyle);

    elementList =
        CometChatUIKit.getDataSource().getAIOptions(
            widget.user, widget.group, context, composerId, widget.aiOptionStyle);


    cometChatMessageComposerController = CometChatMessageComposerController(
      parentMessageId: widget.parentMessageId,
      disableSoundForMessages: widget.disableSoundForMessages,
      customSoundForMessage: widget.customSoundForMessage,
      customSoundForMessagePackage: widget.customSoundForMessagePackage,
      group: widget.group,
      user: widget.user,
      text: widget.text,
      disableTypingEvents: widget.disableTypingEvents,
      attachmentOptions: widget.attachmentOptions,
      stateCallBack: widget.stateCallBack,
      footerView: widget.footerView,
      headerView: widget.headerView,
      onSendButtonTap: widget.onSendButtonTap,
      onError: widget.onError,
      aiOptionStyle: widget.aiOptionStyle,
      textFormatters: widget.textFormatters,
      textEditingController: widget.textEditingController,
      mentionsStyle: messageComposerStyle.mentionsStyle,
      style: widget.style,
      context: context,
      colorPalette: colorPalette,
      spacing: spacing,
      typography: typography,
      suggestionListStyle: suggestionListStyle,
      auxiliaryButtonIconColor: messageComposerStyle.auxiliaryButtonIconColor,
    );


    super.didChangeDependencies();
  }

  Widget _getSendButton(
      CometChatMessageComposerController value,
      CometChatMessageComposerStyle messageComposerStyle,
      CometChatColorPalette colorPalette,
      CometChatSpacing spacing) {
    return Container(
      decoration: BoxDecoration(
        color: messageComposerStyle.sendButtonIconBackgroundColor ??
            ((value.textEditingController != null &&
                    value.textEditingController!.text.isEmpty)
                ? colorPalette.background4
                : colorPalette.primary),
        borderRadius:  messageComposerStyle.sendButtonBorderRadius ?? BorderRadius.circular(
                spacing.radiusMax ??
                0),
      ),
      alignment: Alignment.center,
      height: 32,
      width: 32,
      child: widget.sendButtonView ??
          IconButton(
              padding: const EdgeInsets.all(0),
              icon: messageComposerStyle.sendButtonIcon ??
                  Image.asset(
                    AssetConstants.send,
                    package: UIConstants.packageName,
                    height: 24,
                    width: 24,
                    color: messageComposerStyle.sendButtonIconColor,
                  ),
              onPressed: value.onSendButtonClick),
    );
  }

  final _link = LayerLink();

  @override
  Widget build(BuildContext context) {

    if (widget.group != null) {
      composerId['guid'] = widget.group!.guid;
    } else if (widget.user != null) {
      composerId['uid'] = widget.user!.uid;
    }

    return PopScope(
      canPop: true,
      child: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: widget.padding,
              child: GetBuilder(
                init: cometChatMessageComposerController,
                tag: cometChatMessageComposerController.tag,
                dispose: (GetBuilderState<CometChatMessageComposerController>
                        state) =>
                    Get.delete<CometChatMessageComposerController>(
                        tag: state.controller?.tag),
                builder: (CometChatMessageComposerController value) {

                  return Column(
                    children: [
                      //-----message preview container-----
                      //-----
                      Container(
                        child: Column(
                          children: [
                            if (value.header != null) value.header!,
                            if (value.messagePreviewTitle != null &&
                                    value.messagePreviewTitle!.isNotEmpty ||
                                value.preview != null)
                              CompositedTransformTarget(
                                link: _link,
                                child: OverlayPortal(
                                  controller: value.overlayPortalController,
                                  overlayChildBuilder: (context) {
                                    return CompositedTransformFollower(
                                      link: _link,
                                      targetAnchor: Alignment.bottomLeft,
                                      followerAnchor: Alignment.bottomLeft,
                                      child: Align(
                                        alignment: Alignment.bottomLeft,
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            if (value.messagePreviewTitle !=
                                                    null &&
                                                value.messagePreviewTitle!
                                                    .isNotEmpty)
                                              Padding(
                                                padding: EdgeInsets.only(
                                                  left: spacing.padding2 ?? 0,
                                                  right: spacing.padding2 ?? 0,
                                                  bottom: (value.preview != null
                                                      ? 8
                                                      : 0),
                                                ),
                                                child: CometChatMessagePreview(
                                                  messagePreviewTitle: value
                                                      .messagePreviewTitle!,
                                                  messagePreviewSubtitle: value
                                                          .messagePreviewSubtitle ??
                                                      '',
                                                  onCloseClick: value
                                                      .onMessagePreviewClose,
                                                  style:
                                                      CometChatMessagePreviewStyle(
                                                    messagePreviewTitleStyle:
                                                        TextStyle(
                                                      color: colorPalette
                                                          .textPrimary,
                                                      fontSize: typography.body
                                                          ?.regular?.fontSize,
                                                      fontWeight: typography
                                                          .body
                                                          ?.regular
                                                          ?.fontWeight,
                                                      fontFamily: typography
                                                          .body
                                                          ?.regular
                                                          ?.fontFamily,
                                                    ),
                                                    messagePreviewSubtitleStyle:
                                                        TextStyle(
                                                      color: colorPalette
                                                          .textSecondary,
                                                      fontSize: typography
                                                          .caption1
                                                          ?.regular
                                                          ?.fontSize,
                                                      fontWeight: typography
                                                          .caption1
                                                          ?.regular
                                                          ?.fontWeight,
                                                      fontFamily: typography
                                                          .caption1
                                                          ?.regular
                                                          ?.fontFamily,
                                                    ),
                                                    closeIconColor:
                                                        messageComposerStyle
                                                                .closeIconTint ??
                                                            colorPalette
                                                                .iconPrimary,
                                                    messagePreviewBackground:
                                                        colorPalette
                                                            .background3,
                                                  ),
                                                ),
                                              ),
                                            if (value.preview != null)
                                              value.preview!,
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                  child:
                                      Container(), // Placeholder child, can be empty or other widget
                                ),
                              ),
                            Padding(
                              padding: widget.messageInputPadding ??
                                  EdgeInsets.fromLTRB(
                                      spacing.padding2 ?? 0,
                                      0,
                                      spacing.padding2 ?? 0,
                                      spacing.padding2 ?? 0),
                              child: CometChatMessageInput(
                                text: widget.text,
                                textEditingController:
                                    value.textEditingController,
                                placeholderText: widget.placeholderText,
                                maxLine: widget.maxLine,
                                onChange: widget.onChange ?? value.onChange,
                                primaryButtonView: _getSendButton(
                                    value,
                                    messageComposerStyle,
                                    colorPalette,
                                    spacing),
                                secondaryButtonView: widget.secondaryButtonView != null
                                    ? widget.secondaryButtonView!(context, value.user,
                                        value.group, value.composerId)
                                    : DecoratedBox(
                                  decoration: BoxDecoration(
                                    color: messageComposerStyle.secondaryButtonIconBackgroundColor,
                                    borderRadius: messageComposerStyle.secondaryButtonBorderRadius
                                  ),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          Container(
                                            height: 24,
                                            width: 24,
                                            margin: EdgeInsets.only(right: spacing.margin4 ?? 0),
                                            child: IconButton(
                                                padding: const EdgeInsets.all(0),
                                                constraints: const BoxConstraints(),
                                                icon: widget.attachmentIcon ??
                                                    Image.asset(
                                                      widget.attachmentIconURL ??
                                                          AssetConstants.add,
                                                      package: UIConstants.packageName,
                                                      color: messageComposerStyle
                                                              .secondaryButtonIconColor ??
                                                          colorPalette.iconSecondary,
                                                    ),

                                                onPressed: () async {
                                                  value.showBottomActionSheet(context,colorPalette,typography);
                                                }),
                                          ),
                                          //-----show voice recording-----
                                          if (widget.hideVoiceRecording != true)
                                            Container(
                                              height: 24,
                                              width: 24,
                                              margin: EdgeInsets.only(right: spacing.margin4 ?? 0),
                                              child: IconButton(
                                                  padding:
                                                  const EdgeInsets.all(0),
                                                  constraints:
                                                  const BoxConstraints(),
                                                  icon: widget.voiceRecordingIcon ??
                                                      Image.asset(
                                                        AssetConstants.microphone,
                                                        package: UIConstants
                                                            .packageName,
                                                        color: messageComposerStyle
                                                            .secondaryButtonIconColor ??
                                                            colorPalette.iconSecondary,
                                                        // height: 24,
                                                        // width: 24,
                                                      ),
                                                  onPressed: () {
                                                    FocusManager.instance.primaryFocus?.unfocus();
                                                    showModalBottomSheet<void>(
                                                      context: context,
                                                      backgroundColor:
                                                      Colors.transparent,
                                                      builder:
                                                          (BuildContext context) {
                                                        return CometChatMediaRecorder(
                                                          startButtonIcon: widget.recorderStartButtonIcon,
                                                          pauseButtonIcon: widget.recorderPauseButtonIcon,
                                                          stopButtonIcon: widget.recorderStopButtonIcon,
                                                          deleteButtonIcon: widget.recorderDeleteButtonIcon,
                                                          sendButtonIcon: widget.recorderSendButtonIcon,
                                                          style:
                                                          widget.mediaRecorderStyle,
                                                          onSubmit: value
                                                              .sendMediaRecording,
                                                        );
                                                      },
                                                    );
                                                  }),
                                            ),
                                        ],
                                      ),
                                    ),
                                auxiliaryButtonsAlignment:
                                    widget.auxiliaryButtonsAlignment ??
                                        AuxiliaryButtonsAlignment.left,
                                auxiliaryButtonView: DecoratedBox(
                                  decoration: BoxDecoration(
                                      color: messageComposerStyle
                                          .auxiliaryButtonIconBackgroundColor,
                                  borderRadius: messageComposerStyle.auxiliaryButtonBorderRadius
                                  ),
                                  child: widget.auxiliaryButtonView != null
                                      ? widget.auxiliaryButtonView!(
                                          context,
                                          value.user,
                                          value.group,
                                          value.composerId)
                                      : Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            //-----show emoji keyboard-----

                                            if(value.auxiliaryOptions!=null)
                                              value.auxiliaryOptions!,

                                            if (elementList.isNotEmpty)
                                              SizedBox(
                                                height: 24,
                                                width: 24,
                                                child: IconButton(
                                                    padding:
                                                        const EdgeInsets.all(0),
                                                    constraints:
                                                        const BoxConstraints(),
                                                    icon: widget.aiIcon ??
                                                        Image.asset(
                                                          widget.aiIconURL ??
                                                              (value.activeAiFeatures ? AssetConstants.aiActive :AssetConstants.aiInactive),
                                                          package:
                                                             widget. aiIconPackageName ??
                                                                  UIConstants
                                                                      .packageName,
                                                          color: messageComposerStyle
                                                                  .auxiliaryButtonIconColor ??
                                                             (value.activeAiFeatures ? colorPalette.iconHighlight : colorPalette
                                                                  .iconSecondary),
                                                        ),
                                                    onPressed: () {
                                                      value.aiButtonTap(context,
                                                          value.composerId,messageComposerStyle.aiOptionSheetStyle);
                                                    }),
                                              ),
                                          ],
                                        ),
                                ),
                                style: CometChatMessageInputStyle(
                                    dividerTint:
                                        messageComposerStyle.dividerColor ??
                                            colorPalette.borderLight,
                                    dividerHeight: messageComposerStyle.dividerHeight,
                                    backgroundColor:
                                        messageComposerStyle.backgroundColor ??
                                            colorPalette.background1,
                                    textStyle:
                                    TextStyle(
                                      color: colorPalette.textPrimary,
                                      fontSize: typography.body?.regular?.fontSize,
                                      fontWeight: typography.body?.regular?.fontWeight,
                                      fontFamily: typography.body?.regular?.fontFamily,
                                    ).merge(messageComposerStyle
                                        .textStyle).copyWith(color:messageComposerStyle.textColor),
                                    placeholderTextStyle: TextStyle(
                                      color: colorPalette.textTertiary,
                                      fontSize: typography.body?.regular?.fontSize,
                                      fontWeight: typography.body?.regular?.fontWeight,
                                      fontFamily: typography.body?.regular?.fontFamily,
                                    ).merge(messageComposerStyle
                                        .placeHolderTextStyle).copyWith(color:messageComposerStyle.placeHolderTextColor),
                                  border:messageComposerStyle.border ?? Border.all(color: colorPalette.borderDefault ?? Colors.transparent,width: 1),
                                borderRadius: messageComposerStyle.borderRadius ?? BorderRadius.circular(spacing.radius2 ?? 0),
                                ),
                                focusNode: value.focusNode,
                              ),
                            ),
                            if (value.footer != null) value.footer!,
                          ],
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}