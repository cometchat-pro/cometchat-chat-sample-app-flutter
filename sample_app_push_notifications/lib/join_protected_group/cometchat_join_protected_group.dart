import 'package:flutter/material.dart';
import 'package:cometchat_chat_uikit/cometchat_chat_uikit.dart';
import 'package:cometchat_chat_uikit/cometchat_chat_uikit.dart' as cc;
import 'package:get/get.dart';

import 'cometchat_join_protected_group_controller.dart';

class CometChatJoinProtectedGroup extends StatefulWidget {
  CometChatJoinProtectedGroup({
    super.key,
    required Group group,
  }) : cometChatJoinProtectedGroupController =
            CometChatJoinProtectedGroupController(
          group: group,
        );

  final CometChatJoinProtectedGroupController
      cometChatJoinProtectedGroupController;

  @override
  State<CometChatJoinProtectedGroup> createState() =>
      _CometChatJoinProtectedGroupState();
}

class _CometChatJoinProtectedGroupState
    extends State<CometChatJoinProtectedGroup> {
  late CometChatColorPalette colorPalette;
  late CometChatTypography typography;
  late CometChatSpacing spacing;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    typography = CometChatThemeHelper.getTypography(context);
    colorPalette = CometChatThemeHelper.getColorPalette(context);
    spacing = CometChatThemeHelper.getSpacing(context);
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: colorPalette.background1,
      borderRadius: BorderRadius.vertical(
        top: Radius.circular(
          spacing.radius6 ?? 0,
        ),
      ),
      child: GetBuilder(
        init: widget.cometChatJoinProtectedGroupController,
        global: false,
        dispose:
            (GetBuilderState<CometChatJoinProtectedGroupController> state) =>
                state.controller?.onClose(),
        builder: (CometChatJoinProtectedGroupController controller) {
          return SafeArea(
            child: GestureDetector(
              onTap: () {
                FocusScope.of(context).unfocus();
              },
              child: Container(
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
                    buildHeader(
                      context,
                      spacing,
                      typography,
                      colorPalette,
                    ),
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.only(
                          top: spacing.padding5 ?? 0,
                          left: spacing.padding6 ?? 0,
                          right: spacing.padding6 ?? 0,
                          bottom: spacing.padding10 ?? 0,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Center(
                              child: buildAvatar(
                                context,
                                spacing,
                                typography,
                                colorPalette,
                                controller,
                              ),
                            ),
                            buildInputs(controller),
                            (!controller.isEmpty && !controller.isError)
                                ? const SizedBox()
                                : Padding(
                                    padding: EdgeInsets.only(
                                      bottom: spacing.padding4 ?? 20,
                                    ),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: colorPalette.error?.withOpacity(
                                          0.1,
                                        ),
                                        borderRadius: BorderRadius.circular(
                                          spacing.radius2 ?? 8,
                                        ),
                                      ),
                                      child: Padding(
                                        padding: EdgeInsets.symmetric(
                                          horizontal: spacing.padding2 ?? 8,
                                          vertical: spacing.padding1 ?? 4,
                                        ),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Padding(
                                              padding: EdgeInsets.only(
                                                right: spacing.padding1 ?? 2,
                                              ),
                                              child: Icon(
                                                Icons.error_outline,
                                                color: colorPalette.error,
                                                size: 16,
                                              ),
                                            ),
                                            Expanded(
                                              child: Text(
                                                (controller.isEmpty)
                                                    ? "Please fill in all required fields before joining a group."
                                                    : (controller.isError)
                                                        ? "Something went wrong. Please try again."
                                                        : "",
                                                style: TextStyle(
                                                  color: colorPalette.error,
                                                  fontSize: typography.caption1
                                                      ?.regular?.fontSize,
                                                  fontFamily: typography
                                                      .caption1
                                                      ?.regular
                                                      ?.fontFamily,
                                                  fontWeight: typography
                                                      .caption1
                                                      ?.regular
                                                      ?.fontWeight,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                            ElevatedButton(
                              onPressed: () {
                                controller.requestJoinGroup(context);
                              },
                              style: ButtonStyle(
                                backgroundColor: WidgetStateProperty.all(
                                  colorPalette.primary,
                                ),
                                shape: WidgetStateProperty.all(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(
                                      spacing.radius2 ?? 8,
                                    ),
                                  ),
                                ),
                                padding: WidgetStateProperty.all(
                                  EdgeInsets.symmetric(
                                    vertical: spacing.padding2 ?? 8,
                                    horizontal: spacing.padding5 ?? 20,
                                  ),
                                ),
                              ),
                              child: Center(
                                child: (controller.isLoading)
                                    ? CircularProgressIndicator(
                                        color: colorPalette.white,
                                      )
                                    : Text(
                                        "Join Group",
                                        style: TextStyle(
                                          color: colorPalette.buttonIconColor,
                                          fontSize: typography
                                              .button?.medium?.fontSize,
                                          fontFamily: typography
                                              .button?.medium?.fontFamily,
                                          fontWeight: typography
                                              .button?.medium?.fontWeight,
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
              ),
            ),
          );
        },
      ),
    );
  }

  // Header Widget
  Widget buildHeader(
    BuildContext context,
    CometChatSpacing spacing,
    CometChatTypography typography,
    CometChatColorPalette colorPalette,
  ) {
    return Padding(
      padding: EdgeInsets.only(
        top: spacing.padding3 ?? 0,
        bottom: spacing.padding3 ?? 0,
      ),
      child: Container(
        height: 4,
        width: 32,
        decoration: BoxDecoration(
          color: colorPalette.neutral500,
          borderRadius: BorderRadius.circular(
            spacing.radiusMax ?? 0,
          ),
        ),
      ),
    );
  }

  // Header Widget
  Widget buildAvatar(
    BuildContext context,
    CometChatSpacing spacing,
    CometChatTypography typography,
    CometChatColorPalette colorPalette,
    CometChatJoinProtectedGroupController value,
  ) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: spacing.padding5 ?? 0,
      ),
      child: Column(
        children: [
          Stack(
            children: [
              Padding(
                padding: EdgeInsets.only(
                  bottom: spacing.padding3 ?? 0,
                ),
                child: CometChatAvatar(
                  height: 60,
                  width: 60,
                  name: value.group.name,
                  image: value.group.icon ?? "",
                ),
              ),
              Positioned(
                bottom: 12,
                right: 5,
                child: CometChatStatusIndicator(
                  style: CometChatStatusIndicatorStyle(
                    backgroundColor: colorPalette.success,
                    border: Border.all(
                      color: colorPalette.white ?? Colors.white,
                      width: 1,
                    ),
                  ),
                  backgroundImage: Icon(
                    Icons.lock,
                    size: 8,
                    color: colorPalette.white,
                  ),
                ),
              )
            ],
          ),
          Padding(
            padding: EdgeInsets.only(
              bottom: spacing.padding1 ?? 0,
            ),
            child: Text(
              value.group.name,
              style: TextStyle(
                fontFamily: typography.heading4?.medium?.fontFamily,
                fontSize: typography.heading4?.medium?.fontSize,
                color: colorPalette.textPrimary,
                fontWeight: typography.heading4?.medium?.fontWeight,
              ),
            ),
          ),
          Text(
            "${value.group.membersCount} ${cc.Translations.of(context).members}",
            style: TextStyle(
              fontFamily: typography.caption1?.regular?.fontFamily,
              fontSize: typography.caption1?.regular?.fontSize,
              color: colorPalette.textSecondary,
              fontWeight: typography.caption1?.regular?.fontWeight,
            ),
          ),
        ],
      ),
    );
  }

  Widget buildInputs(CometChatJoinProtectedGroupController value) {
    return Form(
      key: value.passwordsFieldKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          titleText("Enter Password"),
          Padding(
            padding: EdgeInsets.only(
              bottom: spacing.padding6 ?? 0,
            ),
            child: textInput(
              value.textEditingController,
              "Enter the password",
              value.onPasswordChange,
              value,
            ),
          ),
        ],
      ),
    );
  }

  Widget titleText(String title) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: spacing.padding1 ?? 0,
      ),
      child: Text(
        title,
        style: TextStyle(
          fontSize: typography.caption1?.medium?.fontSize,
          fontWeight: typography.caption1?.medium?.fontWeight,
          fontFamily: typography.caption1?.medium?.fontFamily,
          color: colorPalette.textPrimary,
        ),
      ),
    );
  }

  Widget textInput(
    TextEditingController controller,
    String hintText,
    void Function(String)? onChanged,
    CometChatJoinProtectedGroupController joinProtectedGroupController,
  ) {
    return TextFormField(
      controller: controller,
      validator: (value) {
        if (value == null || value.isEmpty) {
          joinProtectedGroupController.onEmpty(true);
          return "";
        }
        joinProtectedGroupController.onEmpty(false);
        return null;
      },
      onChanged: onChanged,
      style: TextStyle(
        color: colorPalette.textPrimary,
        fontSize: typography.body?.regular?.fontSize,
        fontFamily: typography.body?.regular?.fontFamily,
        fontWeight: typography.body?.regular?.fontWeight,
      ),
      decoration: InputDecoration(
        errorStyle: const TextStyle(
          fontSize: 0,
        ),
        isDense: true,
        contentPadding: EdgeInsets.symmetric(
          vertical: spacing.padding2 ?? 0,
          horizontal: spacing.padding2 ?? 0,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(
            spacing.radius2 ?? 0,
          ),
          borderSide: BorderSide(
            width: 1,
            color: colorPalette.borderLight ?? Colors.transparent,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(
            spacing.radius2 ?? 0,
          ),
          borderSide: BorderSide(
            width: 1,
            color: colorPalette.borderLight ?? Colors.transparent,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(
            spacing.radius2 ?? 0,
          ),
          borderSide: BorderSide(
            width: 1,
            color: colorPalette.borderLight ?? Colors.transparent,
          ),
        ),
        hintText: hintText,
        hintStyle: TextStyle(
          color: colorPalette.textTertiary,
          fontSize: typography.body?.regular?.fontSize,
          fontFamily: typography.body?.regular?.fontFamily,
          fontWeight: typography.body?.regular?.fontWeight,
        ),
        filled: true,
        fillColor: colorPalette.background2,
      ),
    );
  }
}

Future showJoinProtectedGroup({
  required BuildContext context,
  required CometChatColorPalette colorPalette,
  required CometChatTypography typography,
  required CometChatSpacing spacing,
  required Group group,
}) {
  return showModalBottomSheet(
    backgroundColor: colorPalette.background1,
    context: context,
    isDismissible: true,
    useSafeArea: true,
    isScrollControlled: true,
    builder: (BuildContext context) => Padding(
      padding:
          EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: IntrinsicHeight(
        child: CometChatJoinProtectedGroup(
          group: group,
        ),
      ),
    ),
  );
}
