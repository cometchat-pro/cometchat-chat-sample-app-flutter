import 'package:flutter/material.dart';

///[CometChatAiOptionSheetStyle] is a data class that has styling-related properties
///to customize the appearance of [CometChatAiOptionSheet]
///
/// ``` dart
/// CometChatAiOptionSheetStyle(
///  backgroundColor: Colors.white,
///  borderRadius: BorderRadius.circular(16),
///  iconColor: Colors.black,
///  textStyle: TextStyle(color: Colors.black),
///  );
///  ```
class CometChatAiOptionSheetStyle extends ThemeExtension<CometChatAiOptionSheetStyle>{

  const CometChatAiOptionSheetStyle({
    this.backgroundColor,
    this.borderRadius,
    this.border,
    this.iconColor,
    this.textStyle,
  });

  ///[backgroundColor] defines the background color of the widget
  final Color? backgroundColor;

  ///[borderRadius] defines the border radius of the widget
  final BorderRadiusGeometry? borderRadius;

  ///[border] defines the border of the widget
  final BorderSide? border;

  ///[iconColor] defines the color of the icon
  final Color? iconColor;

  ///[textStyle] defines the style of the text
  final TextStyle? textStyle;

  @override
  CometChatAiOptionSheetStyle copyWith({
    Color? backgroundColor,
    BorderRadiusGeometry? borderRadius,
    BorderSide? border,
    Color? iconColor,
    TextStyle? textStyle,
  }) {
    return CometChatAiOptionSheetStyle(
      backgroundColor: backgroundColor ?? this.backgroundColor,
      borderRadius: borderRadius ?? this.borderRadius,
      border: border ?? this.border,
      iconColor: iconColor ?? this.iconColor,
      textStyle: textStyle ?? this.textStyle,
    );
  }

  CometChatAiOptionSheetStyle merge(CometChatAiOptionSheetStyle? other) {
    if (other is! CometChatAiOptionSheetStyle) return this;
    return copyWith(
      backgroundColor: other.backgroundColor,
      borderRadius: other.borderRadius,
      border: other.border,
      iconColor: other.iconColor,
      textStyle: other.textStyle,
    );
  }

  static CometChatAiOptionSheetStyle of(BuildContext context)=> const CometChatAiOptionSheetStyle();

  @override
  CometChatAiOptionSheetStyle lerp(ThemeExtension<CometChatAiOptionSheetStyle>? other, double t) {
    if (other is! CometChatAiOptionSheetStyle) return this;
    return CometChatAiOptionSheetStyle(
      backgroundColor: Color.lerp(backgroundColor, other.backgroundColor, t),
      borderRadius: BorderRadiusGeometry.lerp(borderRadius, other.borderRadius, t),
      border: BorderSide.lerp(border ?? BorderSide.none, other.border ?? BorderSide.none, t),
      iconColor: Color.lerp(iconColor, other.iconColor, t),
      textStyle: TextStyle.lerp(textStyle, other.textStyle, t),
    );
  }
}