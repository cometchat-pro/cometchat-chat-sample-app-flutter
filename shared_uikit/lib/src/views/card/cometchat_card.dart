import 'package:flutter/material.dart';
import 'package:cometchat_uikit_shared/cometchat_uikit_shared.dart';

///[CometChatCard] is a prebuilt widget which is used to display a card with title, subtitle, avatar and bottom view.
///
/// ```dart
/// CometChatCard(
///  title: 'Title',
///  subtitle: 'Subtitle',
///  avatar: CometChatAvatar(),
///  bottomView: Text('Bottom View'),
///  );
///  ```
///
class CometChatCard extends StatelessWidget {
  const CometChatCard({
    super.key,
    this.title,
    this.subtitle,
    this.cardStyle,
    this.avatarName,
    this.avatarUrl,
    this.bottomView,
    this.avatarWidth,
    this.avatarHeight,
    this.avatarPadding,
    this.avatarMargin,
    this.titlePadding,
  });

  ///[title] sets title for card
  final String? title;

  ///[subtitle] sets subtitle for card
  final Widget? subtitle;

  ///[cardStyle] sets style for card
  final CardStyle? cardStyle;

  ///[avatarUrl] sets avatarUrl for avatar
  final String? avatarUrl;

  ///[avatarName] sets avatarName for avatar
  final String? avatarName;

  ///[bottomView] sets bottomView for card
  final Widget? bottomView;

  ///[avatarWidth] sets avatarWidth for avatar
  final double? avatarWidth;

  ///[avatarHeight] sets avatarHeight for avatar
  final double? avatarHeight;

  ///[avatarPadding] sets avatarPadding for avatar
  final EdgeInsetsGeometry? avatarPadding;

  ///[avatarMargin] sets avatarMargin for avatar
  final EdgeInsetsGeometry? avatarMargin;

  ///[titlePadding] sets titlePadding for title
  final EdgeInsetsGeometry? titlePadding;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        if (title != null || subtitle != null)
          Wrap(
            direction: Axis.vertical,
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              if (title != null)
                Padding(
                  padding: titlePadding ?? EdgeInsets.zero,
                  child: Text(
                    title!,
                    style: cardStyle?.titleStyle,
                  ),
                ),
              if (subtitle != null) subtitle!,
              CometChatAvatar(
                image: avatarUrl,
                name: avatarName,
                height: avatarHeight ?? 120,
                width: avatarWidth ?? 120,
                padding: avatarPadding,
                margin: avatarMargin,
                style: cardStyle?.avatarStyle,
              ),
            ],
          ),
        if (bottomView != null) bottomView!
      ],
    );
  }
}
