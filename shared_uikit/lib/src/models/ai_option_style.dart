import 'package:flutter/material.dart';

class AIOptionsStyle extends ThemeExtension<AIOptionsStyle> {
  ///[backgroundColor] background color of the avatar
  final Color? backgroundColor;

  ///[border] border of the avatar
  final Border? border;

  ///[borderRadius] border radius of the avatar
  final BorderRadiusGeometry? borderRadius;

  ///[titleTextStyle] place holder text style
  final TextStyle? titleTextStyle;

  ///[titleColor] place holder text color
  final Color? titleColor;

  ///[iconColor] icon color
  final Color? iconColor;


  AIOptionsStyle({
    this.backgroundColor,
    this.border,
    this.borderRadius,
    this.titleTextStyle,
    this.titleColor,
    this.iconColor,
  });

  static AIOptionsStyle of(BuildContext context) =>
      AIOptionsStyle();

  /// Copies current `AISmartRepliesStyle` with some changes
  @override
  AIOptionsStyle copyWith({
    Color? backgroundColor,
    Border? border,
    BorderRadiusGeometry? borderRadius,
    TextStyle? titleTextStyle,
    Color? titleColor,
    Color? iconColor,
  }) {
    return AIOptionsStyle(
      backgroundColor: backgroundColor ?? this.backgroundColor,
      border: border ?? this.border,
      titleTextStyle: titleTextStyle ?? this.titleTextStyle,
      titleColor: titleColor ?? this.titleColor,
      borderRadius: borderRadius ?? this.borderRadius,
      iconColor: iconColor ?? this.iconColor,
    );
  }

  /// Merges current [AIOptionsStyle] with [other]
  AIOptionsStyle merge(AIOptionsStyle? other) {
    if (other == null) return this;
    return copyWith(
      backgroundColor: other.backgroundColor,
      border: other.border,
      titleTextStyle: other.titleTextStyle,
      titleColor: other.titleColor,
      borderRadius: other.borderRadius,
      iconColor: other.iconColor,
    );
  }

  @override
  AIOptionsStyle lerp(
      ThemeExtension<AIOptionsStyle>? other, double t) {
    if (other is! AIOptionsStyle) {
      return this;
    }
    return AIOptionsStyle(
      backgroundColor: Color.lerp(backgroundColor, other.backgroundColor, t),
      border: Border.lerp(border, other.border, t),
      titleTextStyle: TextStyle.lerp(titleTextStyle, other.titleTextStyle, t),
      titleColor: Color.lerp(titleColor, other.titleColor, t),
      borderRadius:
      BorderRadiusGeometry.lerp(borderRadius, other.borderRadius, t),
      iconColor: Color.lerp(iconColor, other.iconColor, t),
    );
  }
}
