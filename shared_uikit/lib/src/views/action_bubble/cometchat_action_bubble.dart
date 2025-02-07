import 'package:flutter/material.dart';
import 'package:cometchat_uikit_shared/cometchat_uikit_shared.dart';

///creates a widget that gives group action bubble
///
/// ```dart
///  CometChatActionBubble(
///            text: 'Group created',
///            style: CometChatActionBubbleStyle(
///            backgroundColor: Colors.green,
///            textStyle: TextStyle(
///            color: Colors.white,
///            fontSize: 14,
///            fontWeight: FontWeight.bold,
///            ),
///            ),
///        )
///  ```
///
class CometChatActionBubble extends StatelessWidget {
  const CometChatActionBubble(
      {super.key,
      this.message,
      required this.text,
      this.style,
      this.leadingIcon,
        this.padding, this.height, this.width
      });

  ///[message] action message object
  final String? message;

  ///[text] if message object is not passed then text should be passed
  final String? text;

  ///[style] group action bubble styling properties
  final CometChatActionBubbleStyle? style;

  ///[leadingIcon] leading icon to the action bubble
  final Widget? leadingIcon;

  ///[height] height of the action bubble
  final double? height;

  ///[width] width of the action bubble
  final double? width;

  /// [padding] provides padding to the widget
  final EdgeInsetsGeometry? padding;

  @override
  Widget build(BuildContext context) {
    final actionBubbleStyle = CometChatThemeHelper.getTheme<CometChatActionBubbleStyle>(context: context,defaultTheme: CometChatActionBubbleStyle.of).merge(style);

    CometChatColorPalette colorPalette = CometChatThemeHelper.getColorPalette(context);
    CometChatSpacing spacing = CometChatThemeHelper.getSpacing(context);
    CometChatTypography typography = CometChatThemeHelper.getTypography(context);

    String? text = this.text;
    if (text == null) {
      return const SizedBox(
        height: 0,
        width: 0,
      );
    }

    return Container(
      height: height,
      width: width,
      constraints: BoxConstraints(
        maxWidth: MediaQuery.of(context).size.width * 0.85,
      ),
      padding: padding ?? EdgeInsets.symmetric(vertical: spacing.padding1 ??0 , horizontal: spacing.padding3 ?? 0),
      decoration: BoxDecoration(
          color: actionBubbleStyle.backgroundColor ?? colorPalette.background2,
          border: actionBubbleStyle.border ??
              Border.all(
                color: colorPalette.borderDefault ?? Colors.transparent,
                width: 1
              ),
          borderRadius:actionBubbleStyle.borderRadius ??  BorderRadius.circular(spacing.radiusMax ?? 0),
        ),
      alignment: Alignment.center,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: [
          if (leadingIcon != null) leadingIcon!,
          Flexible(
            child: Text(
              text.replaceAll('', '\u{200B}'),
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
              style:
                  TextStyle(
                      fontSize: typography.caption1?.regular?.fontSize,
                      fontWeight: typography.caption1?.regular?.fontWeight,
                      fontFamily: typography.caption1?.regular?.fontFamily,
                      color: colorPalette.textSecondary,
                      letterSpacing: 0
                  ).merge(actionBubbleStyle.textStyle),
            ),
          ),
        ],
      ),
    );
  }
}
