import 'package:flutter/material.dart';
import 'package:cometchat_chat_uikit/src/constants/emoji_category.dart';

import '../../cometchat_chat_uikit.dart';

///Public function to show emoji keyboard , returns the tapped emoji
Future<String?> showCometChatEmojiKeyboard({
  required BuildContext context,
  required CometChatColorPalette colorPalette,
}) {
  return showModalBottomSheet(
    backgroundColor: colorPalette.background1,
    context: context,
    isScrollControlled: true,
    isDismissible: true,
    shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16))),
    builder: (context) {
      return CometChatEmojiKeyboard();
    },
  );
}

class CometChatEmojiKeyboard extends StatefulWidget {
  const CometChatEmojiKeyboard({
    super.key,
  });
  @override
  State<CometChatEmojiKeyboard> createState() => _CometChatEmojiKeyboardState();
}

class _CometChatEmojiKeyboardState extends State<CometChatEmojiKeyboard> {
  int currentCategory = 0;
  ScrollController emojiScrollController = ScrollController();

  void scrollControllerListener() {
    double offset = emojiScrollController.offset;
    if (offset.clamp(0, 100) == offset || offset.clamp(2000, 2300) == offset) {
      currentCategory = 0;
      setState(() {});
    } else if (offset.clamp(2300, 2530) == offset ||
        offset.clamp(3500, 3700) == offset) {
      currentCategory = 1;
      setState(() {});
    } else if (offset.clamp(3700, 3900) == offset ||
        offset.clamp(4200, 4400) == offset) {
      currentCategory = 2;
      setState(() {});
    } else if (offset.clamp(4400, 4600) == offset ||
        offset.clamp(5000, 5200) == offset) {
      currentCategory = 3;
      setState(() {});
    } else if (offset.clamp(5100, 5300) == offset ||
        offset.clamp(5900, 6100) == offset) {
      currentCategory = 4;
      setState(() {});
    } else if (offset.clamp(6000, 6200) == offset ||
        offset.clamp(7300, 7500) == offset) {
      currentCategory = 5;
      setState(() {});
    } else if (offset.clamp(7440, 7640) == offset ||
        offset.clamp(9300, 9500) == offset) {
      currentCategory = 6;
      setState(() {});
    } else if (offset.clamp(9450, 9650) == offset) {
      currentCategory = 7;
      setState(() {});
    }
  }

  @override
  void initState() {
    emojiScrollController.addListener(scrollControllerListener);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final typography = CometChatThemeHelper.getTypography(context);
    final colorPalette = CometChatThemeHelper.getColorPalette(context);
    final spacing = CometChatThemeHelper.getSpacing(context);
    return SafeArea(
      child: DraggableScrollableSheet(
        initialChildSize: 0.5,
        minChildSize: 0.5,
        maxChildSize: 0.75,
        expand: false,
        builder: (BuildContext context, ScrollController scrollController) {
          // Main container
          return Container(
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: colorPalette.background1,
              borderRadius: BorderRadius.vertical(
                top: Radius.circular(
                  spacing.radius6 ?? 0,
                ),
              ),
            ),
            child: Column(
              children: [
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(
                      left: spacing.padding3 ?? 0,
                      right: spacing.padding3 ?? 0,
                      top: spacing.padding2 ?? 0,
                    ),
                    child: Column(
                      children: [
                        // Notch and category name
                        Column(
                          children: [
                            Container(
                              height: 4,
                              width: 32,
                              decoration: BoxDecoration(
                                color: colorPalette.neutral500,
                                borderRadius: BorderRadius.circular(
                                  spacing.radiusMax ?? 0,
                                ),
                              ),
                            ),
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Padding(
                                padding: EdgeInsets.only(
                                  top: spacing.padding2 ?? 0,
                                  bottom: spacing.padding1 ?? 0,
                                ),
                                child: Text(
                                  emojiData[currentCategory].name,
                                  style: TextStyle(
                                    color: colorPalette.textTertiary,
                                    fontSize:
                                        typography.body?.regular?.fontSize,
                                    fontFamily:
                                        typography.body?.regular?.fontFamily,
                                    fontWeight:
                                        typography.body?.regular?.fontWeight,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Expanded(
                          child: SingleChildScrollView(
                            controller: emojiScrollController,
                            child: Column(
                              children: [
                                for (EmojiCategory data in emojiData)
                                  Container(
                                    key: data.key,
                                    child: GridView.builder(
                                      shrinkWrap: true,
                                      physics:
                                          const NeverScrollableScrollPhysics(), // Prevent scrolling in GridView
                                      gridDelegate:
                                          const SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 8,
                                        crossAxisSpacing: 8.0,
                                        mainAxisSpacing: 8.0,
                                      ),
                                      itemCount: data.emojies.length,
                                      itemBuilder: (context, index) {
                                        final emoji = data.emojies[index];
                                        return GestureDetector(
                                          onTap: () {
                                            Navigator.pop(context, emoji.emoji);
                                          },
                                          child: FittedBox(
                                            child: Text(
                                              emoji.emoji,
                                              style: TextStyle(
                                                color: colorPalette.textPrimary,
                                                fontFamily: typography
                                                    .title?.bold?.fontFamily,
                                                fontWeight: typography
                                                    .title?.bold?.fontWeight,
                                              ),
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                // Bottom bar
                Container(
                  height: 50,
                  decoration: BoxDecoration(
                    color: colorPalette.background1,
                    border: Border.all(
                      color: colorPalette.borderLight ?? Colors.transparent,
                      width: 1,
                    ),
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(
                      spacing.padding2 ?? 0,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        for (EmojiCategory data in emojiData)
                          GestureDetector(
                            onTap: () {
                              Scrollable.ensureVisible(
                                  data.key.currentContext!);
                              currentCategory = data.id;
                              setState(() {});
                            },
                            child: Container(
                              height: 32,
                              width: 32,
                              decoration: BoxDecoration(
                                color: currentCategory == data.id
                                    ? colorPalette.extendedPrimary100
                                    : colorPalette.transparent,
                                borderRadius: BorderRadius.circular(
                                  spacing.radiusMax ?? 0,
                                ),
                              ),
                              child: Center(
                                child: Image.asset(
                                  data.symbolURL,
                                  package: UIConstants.packageName,
                                  height: 17,
                                  width: 17,
                                  color: currentCategory == data.id
                                      ? colorPalette.iconHighlight
                                      : colorPalette.iconSecondary,
                                ),
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
