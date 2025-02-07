import 'package:cometchat_calls_uikit/cometchat_calls_uikit.dart';
import 'package:flutter/material.dart';

class CometchatCallLogDetail extends StatefulWidget {
  const CometchatCallLogDetail({required this.callLog, super.key});

  final CallLog callLog;

  @override
  State<CometchatCallLogDetail> createState() => _CometchatCallLogDetailState();
}

class _CometchatCallLogDetailState extends State<CometchatCallLogDetail> {
  late CometChatColorPalette colorPalette;
  late CometChatTypography typography;
  late CometChatSpacing spacing;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Initialize typography, color palette, and spacing
    typography = CometChatThemeHelper.getTypography(context);
    colorPalette = CometChatThemeHelper.getColorPalette(context);
    spacing = CometChatThemeHelper.getSpacing(context);
  }

  @override
  Widget build(BuildContext context) {
    return CometChatListBase(
      title: 'Call Detail',
      hideSearch: true,
      showBackButton: true,
      style: ListBaseStyle(
        background: colorPalette.background1,
        titleStyle: TextStyle(
          color: colorPalette.textPrimary,
          fontSize: typography.heading1?.bold?.fontSize,
          fontWeight: typography.heading1?.bold?.fontWeight,
          fontFamily: typography.heading1?.bold?.fontFamily,
        ),
        backIconTint: colorPalette.iconPrimary,
      ),
      container: Column(
        children: [
          Divider(
            color: colorPalette.borderLight,
            height: 1,
          ),
          CometChatListItem(
            hideSeparator: true,
            avatarURL: CallLogsUtils.receiverAvatar(
              CometChatUIKit.loggedInUser,
              widget.callLog,
            ),
            avatarName: CallLogsUtils.receiverName(
              CometChatUIKit.loggedInUser,
              widget.callLog,
            ),
            title: CallLogsUtils.receiverName(
              CometChatUIKit.loggedInUser,
              widget.callLog,
            ),
            style: ListItemStyle(
              padding: EdgeInsets.symmetric(
                horizontal: spacing.padding4 ?? 16,
                vertical: spacing.padding5 ?? 20,
              ),
              titleStyle: TextStyle(
                color: colorPalette.textPrimary,
                fontSize: typography.heading4?.medium?.fontSize,
                fontWeight: typography.heading4?.medium?.fontWeight,
                fontFamily: typography.heading4?.medium?.fontFamily,
              ),
            ),
            subtitleView: Text(
              "Online",
              style: TextStyle(
                color: colorPalette.textSecondary,
                fontSize: typography.body?.regular?.fontSize,
                fontWeight: typography.body?.regular?.fontWeight,
                fontFamily: typography.body?.regular?.fontFamily,
              ),
            ),
            tailView: Padding(
              padding: EdgeInsets.only(
                left: spacing.padding3 ?? 12,
              ),
              child: Row(
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                      right: spacing.padding2 ?? 8,
                    ),
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: spacing.padding5 ?? 20,
                        vertical: spacing.padding2 ?? 8,
                      ),
                      decoration: BoxDecoration(
                        color: colorPalette.background1,
                        borderRadius: BorderRadius.circular(
                          spacing.radius2 ?? 8,
                        ),
                        border: Border.all(
                          color: colorPalette.borderDefault ?? Colors.transparent,
                          width: 1,
                        ),
                      ),
                      child: Icon(
                        Icons.call_outlined,
                        color: colorPalette.iconHighlight,
                        size: 24,
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: spacing.padding5 ?? 20,
                      vertical: spacing.padding2 ?? 8,
                    ),
                    decoration: BoxDecoration(
                      color: colorPalette.background1,
                      borderRadius: BorderRadius.circular(
                        spacing.radius2 ?? 8,
                      ),
                      border: Border.all(
                        color: colorPalette.borderDefault ?? Colors.transparent,
                        width: 1,
                      ),
                    ),
                    child: Icon(
                      Icons.call_outlined,
                      color: colorPalette.iconHighlight,
                      size: 24,
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
