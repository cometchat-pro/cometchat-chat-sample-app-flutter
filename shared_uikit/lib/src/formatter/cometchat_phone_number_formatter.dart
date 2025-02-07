import 'package:cometchat_uikit_shared/cometchat_uikit_shared.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

///[CometChatPhoneNumberFormatter] is a class which is used to style the phone number text
/// ```dart
/// CometChatPhoneNumberFormatter(
///     pattern: RegExp(RegexConstants.phoneNumberRegexPattern),
///     onSearch: (phoneNumber) async {
///     await launchUrl(Uri.parse(('tel:$phoneNumber')));
///     },
///     messageBubbleTextStyle: (theme, alignment,{forConversation}) {
///     return TextStyle(
///     color: Colors.pink,
///     );
///     },
///     );
///     ```
class CometChatPhoneNumberFormatter extends CometChatTextFormatter {
  CometChatPhoneNumberFormatter(
      {String? trackingCharacter,
      RegExp? pattern,
      super.showLoadingIndicator,
      super.onSearch,
      super.messageBubbleTextStyle,
      super.messageInputTextStyle,
      super.message,
      super.composerId,
      super.suggestionListEventSink,
      super.previousTextEventSink,
      super.user,
      super.group})
      : super(
            trackingCharacter: null,
            pattern:
                pattern ?? RegExp(RegexConstants.phoneNumberRegexPattern)) {
    pattern ??= RegExp(RegexConstants.phoneNumberRegexPattern);
  }

  @override
  void init() {
    pattern ??= RegExp(RegexConstants.phoneNumberRegexPattern);
  }

  @override
  void handlePreMessageSend(BuildContext context, BaseMessage baseMessage) {
    // TODO: implement handlePreMessageSend
  }

  @override
  TextStyle getMessageInputTextStyle(BuildContext context) {
    // TODO: implement messageInputTextStyle
    throw UnimplementedError();
  }

  @override
  void onScrollToBottom(TextEditingController textEditingController) {
    // TODO: implement onScrollToBottom
  }

  @override
  TextStyle getMessageBubbleTextStyle(
      BuildContext context, BubbleAlignment? alignment,
      {bool forConversation = false}) {
    if (messageBubbleTextStyle != null) {
      return messageBubbleTextStyle!(context, alignment,
          forConversation: forConversation);
    } else {
      CometChatColorPalette colorPalette = CometChatThemeHelper.getColorPalette(context);
      CometChatTypography typography = CometChatThemeHelper.getTypography(context);
      return TextStyle(
          color: alignment == BubbleAlignment.right
              ?colorPalette.white
              : colorPalette.neutral900,
          fontWeight: typography.body?.regular?.fontWeight,
          fontSize: typography.body?.regular?.fontSize,
          fontFamily: typography.body?.regular?.fontFamily,
          decoration: TextDecoration.underline);
    }
  }

  @override
  void onChange(
      TextEditingController textEditingController, String previousText) {
    // TODO: implement onChange
  }

  @override
  List<AttributedText> getAttributedText(
      String text, BuildContext context, BubbleAlignment? alignment,
      {List<AttributedText>? existingAttributes,
      Function(String)? onTap,
      bool forConversation = false}) {
    return super.getAttributedText(text, context, alignment,
        existingAttributes: existingAttributes,
        onTap: onTap ??
            (text) async {
              if (pattern != null && pattern!.hasMatch(text)) {
                await launchUrl(Uri.parse(('tel:$text')));
              }
            },
        forConversation: forConversation);
  }
}
