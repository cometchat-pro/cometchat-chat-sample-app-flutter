import 'package:cometchat_uikit_shared/cometchat_uikit_shared.dart';
import 'package:flutter/material.dart';

///[CometChatReactions] is a widget which is used to set the reactions
///It takes [reactionList], [theme], [alignment], [onReactionTap], [onReactionLongPress], [style] as a parameter
///
/// ```dart
/// CometChatReactions(
///  reactionList: reactionList,
///  theme: theme,
///  alignment: BubbleAlignment.left,
///  onReactionTap: (reaction) {
///  print("reaction tapped");
///  },
///  onReactionLongPress: (reaction) {
///  print("reaction long pressed");
///  },
///  );
class CometChatReactions extends StatefulWidget {
  const CometChatReactions(
      {super.key,
      required this.reactionList,
      this.alignment,
      this.onReactionTap,
      this.onReactionLongPress,
      this.style,
      this.padding,
      this.margin,
      this.width,
      this.height
      });

  ///[reactionList] is a list of ReactionCount which is used to set the reactions
  final List<ReactionCount> reactionList;

  ///[alignment] is used to set the alignment of the reactions
  final BubbleAlignment? alignment;

  ///[onReactionTap] is a callback which gets called when a reaction is pressed
  final Function(String? reaction)? onReactionTap;

  ///[onReactionLongPress] is a callback which gets called when a reaction is long pressed
  final Function(String? reaction)? onReactionLongPress;

  ///[style] is a parameter used to set the style for the reactions
  final CometChatReactionsStyle? style;

  ///[margin] can be used to apply margin around each reaction
  final EdgeInsets? margin;

  ///[padding] can be used to apply padding inside each reaction
  final EdgeInsets? padding;

  ///[width] provides width to the widget
  final double? width;

  ///[height] provides height to the widget
  final double? height;

  @override
  State<CometChatReactions> createState() => _CometChatReactionsState();
}

class _CometChatReactionsState extends State<CometChatReactions> {
  late List<ReactionCount> reactionList;
  Widget? extraReactions;
  @override
  void initState() {
    super.initState();
    reactionList = widget.reactionList;
  }

  @override
  void didUpdateWidget(covariant CometChatReactions oldWidget) {
    reactionList = widget.reactionList;

    setState(() {});
    super.didUpdateWidget(oldWidget);
  }

  late CometChatReactionsStyle style;
  late CometChatColorPalette colorPalette;
  late CometChatSpacing spacing;
  late CometChatTypography typography;

  @override
  void didChangeDependencies() {
    style =
        CometChatThemeHelper.getTheme<CometChatReactionsStyle>(
            context: context, defaultTheme: CometChatReactionsStyle.of)
            .merge(widget.style);
    colorPalette = CometChatThemeHelper.getColorPalette(context);
    spacing = CometChatThemeHelper.getSpacing(context);
    typography = CometChatThemeHelper.getTypography(context);
    super.didChangeDependencies();
  }



  void getExtraReactions(CometChatReactionsStyle style, CometChatColorPalette colorPalette, CometChatSpacing spacing, CometChatTypography typography) {
    if (reactionList.length > 4) {
      bool reactedByMe =
          reactionList.sublist(3).any((element) => element.reactedByMe == true);
      reactionList = reactionList.take(3).toList();
      int initialReactionsCount = widget.reactionList.length;
      int extraReactionsCount = initialReactionsCount - 3;

      if (extraReactionsCount > 1) {
        extraReactions = GestureDetector(
          onTap: () {
            if (widget.onReactionLongPress != null) {
              widget.onReactionLongPress!(ReactionConstants.allReactions);
            }
          },
          onLongPress: () {
            if (widget.onReactionLongPress != null) {
              widget.onReactionLongPress!(ReactionConstants.allReactions);
            }
          },
          child: Container(
            margin: widget.margin ?? getMargin(spacing),
            padding: widget.padding ?? EdgeInsets.symmetric(horizontal: spacing.padding2 ?? 0, vertical: spacing.padding ?? 0),
            constraints: const BoxConstraints(
              minHeight: 24,
            ),
            decoration: BoxDecoration(
              color:  (reactedByMe
                      ? style.activeReactionBackgroundColor ??
                      colorPalette.extendedPrimary100
                      : style.backgroundColor ?? colorPalette.background1) ?? Colors.transparent,
              border:reactedByMe == true?  style.activeReactionBorder ??
                  Border.all(
                      color:
                      colorPalette.extendedPrimary300 ?? Colors.transparent,
                      width: 1)
                  : (style.border ??
                  Border.all(
                      color: colorPalette.borderLight ?? Colors.transparent,
                      width: 1)),
              borderRadius: style.borderRadius ?? BorderRadius.all(Radius.circular(spacing.radius5 ?? 0)),
            ),
            child: Text("+$extraReactionsCount",
                style: TextStyle(
                    fontSize:typography.body?.regular?.fontSize,
                    color: colorPalette.textPrimary).merge(style.countTextStyle)),
          ),
        );
        setState(() {});
      }
    } else {
      extraReactions = null;
    }
  }

  @override
  Widget build(BuildContext context) {

    getExtraReactions(style, colorPalette, spacing, typography);

    return Row(children: [
      ...reactionList.map((reactionCount) => GestureDetector(
            onTap: () {
              if (widget.onReactionTap != null) {
                widget.onReactionTap!(reactionCount.reaction);
              }
            },
            onLongPress: () {
              if (widget.onReactionLongPress != null) {
                widget.onReactionLongPress!(reactionCount.reaction);
              }
            },
            child: Container(
                          height: widget.height,
                          width: widget.width,
                          alignment: Alignment.center,
                          margin: widget.margin ?? getMargin(spacing),
                          padding: widget.padding ??
               EdgeInsets.symmetric(horizontal: spacing.padding2 ?? 0, vertical: spacing.padding ?? 0),
                          decoration: BoxDecoration(
              color:
                  (reactionCount.reactedByMe == true
                      ? style.activeReactionBackgroundColor ??
                      colorPalette.extendedPrimary100
                      : style.backgroundColor ?? colorPalette.background1) ?? Colors.transparent,
              border: reactionCount.reactedByMe == true
                  ? style.activeReactionBorder ??
                      Border.all(
                          color:
                             colorPalette.extendedPrimary300 ?? Colors.transparent,
                          width: 1)
                  : (style.border ??
                      Border.all(
                          color: colorPalette.borderLight ?? Colors.transparent,
                          width: 1)),
              borderRadius: style.borderRadius ?? BorderRadius.all(Radius.circular(
                  spacing.radius5 ?? 0)),),
                          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                  reactionCount.reaction ?? "",
                  style: TextStyle(fontSize: typography.body?.regular?.fontSize,
                    fontWeight: typography.body?.regular?.fontWeight,
                  )
                      .merge(style.emojiTextStyle)
              ),
              Padding(
                padding: EdgeInsets.only(right: spacing.padding1 ?? 0),
                child: Text(
                    " ${reactionCount.count}",
                    style: TextStyle(
                        fontSize: typography.body?.regular?.fontSize,
                        fontWeight: typography.body?.regular?.fontWeight,
                        color: style.countTextColor ?? colorPalette.textPrimary)
                        .merge(
                        style.countTextStyle)
                ),
              )
            ],
                          ),
                        ),
          )
      ),
      if (extraReactions != null) extraReactions!
    ]);
  }

  EdgeInsets getMargin(CometChatSpacing spacing) {
    double leftAlignment = 0;
    if (widget.alignment == BubbleAlignment.right) {
      leftAlignment = spacing.margin ?? 0;
    }

    double rightAlignment = 0;
    if (widget.alignment == BubbleAlignment.left) {
      rightAlignment = spacing.margin ?? 0;
    }
    return EdgeInsets.only(left: leftAlignment, right: rightAlignment);
  }
}
