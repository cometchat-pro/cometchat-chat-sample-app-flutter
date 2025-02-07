import 'package:cometchat_uikit_shared/cometchat_uikit_shared.dart';
import 'package:flutter/material.dart';

class CustomTextEditingController extends TextEditingController {

  List<CometChatTextFormatter>? formatters;
  CustomTextEditingController({
    super.text,
    this.formatters,
  }) {
    formatters;
  }

  @override
  TextSpan buildTextSpan(
      {required BuildContext context,
      TextStyle? style,
      required bool withComposing}) {
    if (formatters == null || formatters!.isEmpty) {
      return super.buildTextSpan(
          context: context, style: style!, withComposing: withComposing);
    } else {
      return TextSpan(
          style: style, children: buildSpan(context, style, withComposing));
    }
  }

  List<InlineSpan> buildSpan(
      BuildContext context, TextStyle? style, bool withComposing) {
    List<InlineSpan> textSpan = [];
    List<AttributedText> attributedTexts = [];
    CometChatColorPalette colorPalette = CometChatThemeHelper.getColorPalette(context);
    CometChatTypography typography = CometChatThemeHelper.getTypography(context);
    TextStyle defaultStyle = TextStyle(
      color: colorPalette.textPrimary,
      fontWeight: typography.body?.regular?.fontWeight,
      fontSize: typography.body?.regular?.fontSize,
      fontFamily: typography.body?.regular?.fontFamily,
    ).merge(style);

    for (CometChatTextFormatter formatter in formatters ?? []) {
      attributedTexts = formatter.buildInputFieldText(
          text: text,
          style: style,
          existingAttributes: attributedTexts,
          context: context,
          withComposing: withComposing,);
    }

    int start = 0;

    for (AttributedText attributedText in attributedTexts) {
      textSpan.add(TextSpan(
        text: text.substring(start, attributedText.start),
        style: defaultStyle,
      ));

      textSpan.add(WidgetSpan(child: Container(
        padding: attributedText.padding,
        decoration: BoxDecoration(
          color: attributedText.backgroundColor,
          borderRadius: BorderRadius.circular(attributedText.borderRadius ?? 0),
        ),
        child: Text(
          attributedText.underlyingText ??
              text.substring(attributedText.start, attributedText.end),
          style: attributedText.style ?? defaultStyle,
        ),
      )));
      start = attributedText.end;
    }

    textSpan.add(TextSpan(
      text: text.substring(start),
      style: defaultStyle,
    ));

    return textSpan;
  }
}
