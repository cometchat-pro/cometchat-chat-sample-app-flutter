import 'package:cometchat_uikit_shared/cometchat_uikit_shared.dart';
import 'package:flutter/material.dart';

///[FormatterUtils] is an utility class which is used to style the text in the message bubble and the conversation subtitle
class FormatterUtils {
  ///[buildTextSpan] is a method which is used to style the text in the message bubble and the conversation subtitle
  ///It takes [text], [formatters], [theme], [alignment] and [forConversation] as a parameter
  ///[text] is a string which needs to be styled
  ///[formatters] is a list of [CometChatTextFormatter] which is used to style the text
  ///[theme] is a object of [CometChatTheme] which is used to style the text
  ///[alignment] is a object of [BubbleAlignment] which is used to style the text
  ///[forConversation] is a boolean which is used to style the text in the conversation subtitle
  static List<InlineSpan> buildTextSpan(
      String text,
      List<CometChatTextFormatter>? formatters,
      BuildContext context,
      BubbleAlignment? alignment,
      {bool forConversation = false, TextStyle? textStyle}) {
    List<InlineSpan> textSpan = [];
    List<AttributedText> attributedTexts = [];
    for (CometChatTextFormatter formatter in formatters ?? []) {
      attributedTexts = formatter.getAttributedText(text, context, alignment,
          existingAttributes: attributedTexts,
          forConversation: forConversation);
    }
    CometChatColorPalette colorPalette =
        CometChatThemeHelper.getColorPalette(context);
    CometChatTypography typography =
        CometChatThemeHelper.getTypography(context);

    int start = 0;

    for (AttributedText attributedText in attributedTexts) {
      textSpan.add(TextSpan(
        text: text.substring(start, attributedText.start),
        style:textStyle?.merge(TextStyle(
          color: alignment == BubbleAlignment.right
              ? colorPalette.white
              : forConversation
                  ? colorPalette.textSecondary
                  : colorPalette.textPrimary,
          fontWeight: typography.body?.regular?.fontWeight,
          fontSize: typography.body?.regular?.fontSize,
          fontFamily: typography.body?.regular?.fontFamily,
        )),
      ));

      textSpan.add(WidgetSpan(
          child: Container(
        padding: attributedText.padding,
        decoration: BoxDecoration(
          color: attributedText.backgroundColor,
          borderRadius: BorderRadius.circular(attributedText.borderRadius ?? 0),
        ),
        child: InkWell(
          onTap: () async {
            if (!forConversation && attributedText.onTap != null) {
              attributedText.onTap!(
                  text.substring(attributedText.start, attributedText.end));
            }
          },
          child: Text(
            attributedText.underlyingText ??
                text.substring(attributedText.start, attributedText.end),
            style: attributedText.style ??
                textStyle?.merge(TextStyle(
                  color: alignment == BubbleAlignment.right
                      ? colorPalette.white
                      : colorPalette.textPrimary,
                  fontWeight: typography.body?.regular?.fontWeight,
                  fontSize: typography.body?.regular?.fontSize,
                  fontFamily: typography.body?.regular?.fontFamily,
                )),
          ),
        ),
      )));
      start = attributedText.end;
    }

    textSpan.add(TextSpan(
      text: text.substring(start),
      style: textStyle?.merge(TextStyle(
        color: alignment == BubbleAlignment.right
            ? colorPalette.white
            : forConversation
                ? colorPalette.textSecondary
                : colorPalette.textPrimary,
        fontWeight: typography.body?.regular?.fontWeight,
        fontSize: typography.body?.regular?.fontSize,
        fontFamily: typography.body?.regular?.fontFamily,
      )),
    ));

    return textSpan;
  }

  static List<InlineSpan> buildConversationTextSpan(
    String text,
    List<CometChatTextFormatter>? formatters,
    BuildContext context,
    TextStyle? textStyle,
  ) {
    List<InlineSpan> textSpan = [];
    List<AttributedText> attributedTexts = [];
    for (CometChatTextFormatter formatter in formatters ?? []) {
      attributedTexts = formatter.getAttributedText(
          text, context, BubbleAlignment.left,
          existingAttributes: attributedTexts, forConversation: true);
    }
    CometChatColorPalette colorPalette =
        CometChatThemeHelper.getColorPalette(context);
    CometChatTypography typography =
        CometChatThemeHelper.getTypography(context);

    int start = 0;

    for (AttributedText attributedText in attributedTexts) {
      textSpan.add(TextSpan(
        text: text.substring(start, attributedText.start),
        style: TextStyle(
          color: colorPalette.textSecondary,
          fontWeight: typography.body?.regular?.fontWeight,
          fontSize: typography.body?.regular?.fontSize,
          fontFamily: typography.body?.regular?.fontFamily,
        ).merge(
          textStyle,
        ),
      ));

      textSpan.add(WidgetSpan(
          child: Container(
        padding: attributedText.padding,
        decoration: BoxDecoration(
          color: attributedText.backgroundColor,
          borderRadius: BorderRadius.circular(attributedText.borderRadius ?? 0),
        ),
        child: InkWell(
          onTap: () async {
            // if (!forConversation && attributedText.onTap != null) {
            //   attributedText.onTap!(
            //       text.substring(attributedText.start, attributedText.end));
            // }
          },
          child: Text(
            attributedText.underlyingText ??
                text.substring(attributedText.start, attributedText.end),
            style: attributedText.style ??
                TextStyle(
                  color: colorPalette.textSecondary,
                  fontWeight: typography.body?.regular?.fontWeight,
                  fontSize: typography.body?.regular?.fontSize,
                  fontFamily: typography.body?.regular?.fontFamily,
                ).merge(
                  textStyle,
                ),
          ),
        ),
      )));
      start = attributedText.end;
    }

    textSpan.add(TextSpan(
      text: text.substring(start),
      style: TextStyle(
        color: colorPalette.textSecondary,
        fontWeight: typography.body?.regular?.fontWeight,
        fontSize: typography.body?.regular?.fontSize,
        fontFamily: typography.body?.regular?.fontFamily,
      ).merge(
        textStyle,
      ),
    ));

    return textSpan;
  }
}
