import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../cometchat_chat_uikit.dart';
import '../../../cometchat_chat_uikit.dart' as cc;

///[CometChatUsers] is a component that displays a list of users with the help of [CometChatListBase] and [CometChatListItem]
///fetched users are listed down alphabetically and in order of recent activity
///users are fetched using [UsersBuilderProtocol] and [UsersRequestBuilder]
///
///
/// ```dart
///   CometChatUsers(
///   usersStyle: UsersStyle(),
/// );
/// ```
class CometChatUsers extends StatefulWidget {
  const CometChatUsers({
    super.key,
    this.usersProtocol,
    this.subtitleView,
    this.listItemView,
    this.usersStyle = const CometChatUsersStyle(),
    this.controller,
    this.searchPlaceholder,
    this.backButton,
    this.showBackButton = true,
    this.searchBoxIcon,
    this.hideSearch = false,
    this.selectionMode,
    this.onSelection,
    this.title,
    this.stateCallBack,
    this.usersRequestBuilder,
    this.loadingStateView,
    this.emptyStateView,
    this.errorStateView,
    this.options,
    this.appBarOptions,
    this.disableUsersPresence,
    this.activateSelection,
    this.onError,
    this.onBack,
    this.onItemTap,
    this.onItemLongPress,
    this.selectionIcon,
    this.submitIcon,
    this.hideAppbar = false,
    this.controllerTag,
    this.height,
    this.width,
    this.hideSectionSeparator = false,
  });

  ///property to be set internally by using passed parameters [usersProtocol] ,[selectionMode] ,[options]
  ///these are passed to the [CometChatUsersController] which is responsible for the business logic

  ///[usersProtocol] set custom users request builder protocol
  final UsersBuilderProtocol? usersProtocol;

  ///[usersRequestBuilder] custom request builder
  final UsersRequestBuilder? usersRequestBuilder;

  ///[subtitleView] to set subtitle for each user item
  final Widget? Function(BuildContext, User)? subtitleView;

  ///[listItemView] set custom view for each user item
  final Widget Function(User)? listItemView;

  ///[usersStyle] sets style
  final CometChatUsersStyle usersStyle;

  ///[controller] sets controller for the list
  final ScrollController? controller;

  final List<CometChatOption>? Function(
      User, CometChatUsersController controller)? options;

  ///[searchPlaceholder] placeholder text of search input
  final String? searchPlaceholder;

  ///[backButton] back button
  final Widget? backButton;

  ///[showBackButton] switch on/off back button
  final bool showBackButton;

  ///[searchBoxIcon] search icon
  final Widget? searchBoxIcon;

  ///[hideSearch] switch on/off search input
  final bool hideSearch;

  ///[selectionMode] specifies mode users module is opening in
  final SelectionMode? selectionMode;

  ///[onSelection] a custom callback that would utilize the selected users to execute some task
  final Function(List<User>?, BuildContext)? onSelection;

  ///[title] sets title for the list
  final String? title;

  ///[loadingStateView] returns view fow loading state
  final WidgetBuilder? loadingStateView;

  ///[emptyStateView] returns view fow empty state
  final WidgetBuilder? emptyStateView;

  ///[errorStateView] returns view fow error state behind the dialog
  final WidgetBuilder? errorStateView;

  ///[stateCallBack] to access controller functions  from parent pass empty reference of  CometChatUsersController object
  final Function(CometChatUsersController controller)? stateCallBack;

  ///[appBarOptions] list of options to be visible in app bar
  final List<Widget> Function(BuildContext context)? appBarOptions;

  ///[disableUsersPresence] controls visibility of status indicator shown if user is online
  final bool? disableUsersPresence;

  ///[activateSelection] lets the widget know if users are allowed to be selected
  final ActivateSelection? activateSelection;

  ///[onError] callback triggered in case any error happens when fetching users
  final OnError? onError;

  ///[onBack] callback triggered on closing this screen
  final VoidCallback? onBack;

  ///[onItemTap] callback triggered on tapping a user item
  final Function(BuildContext context, User)? onItemTap;

  ///[onItemLongPress] callback triggered on pressing for long on a user item
  final Function(BuildContext context, User)? onItemLongPress;

  ///[selectionIcon] will change selection icon
  final Widget? selectionIcon;

  ///[submitIcon] will override the default submit icon
  final Widget? submitIcon;

  ///[hideAppbar] toggle visibility for app bar
  final bool? hideAppbar;

  ///[controllerTag] tag to create from , if this is passed its parent responsibility to close this
  final String? controllerTag;

  ///[height] provides height to the widget
  final double? height;

  ///[width] provides width to the widget
  final double? width;

  ///[hideSectionSeparator] hides the section separator
  final bool? hideSectionSeparator;

  @override
  State<CometChatUsers> createState() => _CometChatUsersState();
}

class _CometChatUsersState extends State<CometChatUsers> {
  late CometChatUsersController usersController;
  late String dateString;

  final RxBool _isSelectionOn = false.obs;
  late String tag;

  late CometChatColorPalette colorPalette;
  late CometChatTypography typography;
  late CometChatSpacing spacing;

  late CometChatUsersStyle style;
  late CometChatAvatarStyle avatarStyle;
  late CometChatStatusIndicatorStyle statusIndicatorStyle;

  @override
  void dispose() {
    if (widget.controllerTag == null) {
      Get.delete<CometChatUsersController>(tag: tag);
    }

    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    dateString = DateTime.now().microsecondsSinceEpoch.toString();
    tag = widget.controllerTag ?? "default_tag_for_users_$dateString";

    if (widget.controllerTag != null &&
        Get.isRegistered<CometChatGroupsController>(
            tag: widget.controllerTag)) {
      usersController =
          Get.find<CometChatUsersController>(tag: widget.controllerTag);
    } else {
      usersController = Get.put<CometChatUsersController>(
          CometChatUsersController(
              usersBuilderProtocol: widget.usersProtocol ??
                  UIUsersBuilder(
                    widget.usersRequestBuilder ??
                        RequestBuilderConstants.getDefaultUsersRequestBuilder(),
                  ),
              mode: widget.selectionMode,
              onError: widget.onError,
              disableUsersPresence: widget.disableUsersPresence),
          tag: tag);
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Initialize typography, color palette, and spacing
    typography = CometChatThemeHelper.getTypography(context);
    colorPalette = CometChatThemeHelper.getColorPalette(context);
    spacing = CometChatThemeHelper.getSpacing(context);
    style = CometChatThemeHelper.getTheme<CometChatUsersStyle>(
            context: context, defaultTheme: CometChatUsersStyle.of)
        .merge(widget.usersStyle);

    avatarStyle = CometChatThemeHelper.getTheme<CometChatAvatarStyle>(
            context: context, defaultTheme: CometChatAvatarStyle.of)
        .merge(style.avatarStyle);

    statusIndicatorStyle =
        CometChatThemeHelper.getTheme<CometChatStatusIndicatorStyle>(
                context: context,
                defaultTheme: CometChatStatusIndicatorStyle.of)
            .merge(style.statusIndicatorStyle);
  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: style.borderRadius ??
          BorderRadius.circular(
            0,
          ),
      child: CometChatListBase(
        titleView: GetBuilder<CometChatUsersController>(
            tag: tag,
            builder: (CometChatUsersController value) => Text(
                  value.selectionMap.isNotEmpty
                      ? "${value.selectionMap.length}"
                      : widget.title ?? cc.Translations.of(context).users,
                  style: TextStyle(
                    color: colorPalette.textPrimary,
                    fontSize: typography.heading1?.bold?.fontSize,
                    fontWeight: typography.heading1?.bold?.fontWeight,
                    fontFamily: typography.heading1?.bold?.fontFamily,
                  )
                      .merge(style.titleTextStyle)
                      .copyWith(color: style.titleTextColor),
                )),
        titleSpacing: widget.showBackButton ? 0 : 16,
        hideSearch: widget.hideSearch,
        backIcon: GetBuilder<CometChatUsersController>(
            tag: tag,
            builder: (CometChatUsersController value) =>
                value.selectionMap.isNotEmpty
                    ? IconButton(
                        onPressed: () {
                          value.clearSelection();
                          _isSelectionOn.value = false;
                        },
                        icon: Icon(
                          Icons.clear,
                          color: colorPalette.iconPrimary,
                          size: 24,
                        ),
                        padding: EdgeInsets.zero,
                      )
                    : (widget.backButton ??
                        IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: Icon(
                            Icons.arrow_back,
                            color: colorPalette.iconPrimary,
                            size: 24,
                          ),
                          padding: EdgeInsets.zero,
                        ))),
        placeholder: widget.searchPlaceholder,
        showBackButton: widget.showBackButton,
        searchBoxIcon: widget.searchBoxIcon,
        onSearch: usersController.onSearch,
        hideAppBar: widget.hideAppbar,
        searchText: widget.searchPlaceholder,
        searchPadding: EdgeInsets.symmetric(
          horizontal: spacing.padding4 ?? 0,
          vertical: spacing.padding3 ?? 0,
        ),
        searchContentPadding: EdgeInsets.symmetric(
          horizontal: spacing.padding3 ?? 0,
          vertical: spacing.padding2 ?? 0,
        ),
        searchBoxHeight: 40,
        menuOptions: [
          if (widget.appBarOptions != null) ...widget.appBarOptions!(context),
          Obx(() => getSelectionWidget(usersController, context))
        ],
        onBack: widget.onBack,
        style: ListBaseStyle(
          width: widget.width,
          height: widget.height,
          background: style.backgroundColor ?? colorPalette.background1,
          titleStyle: TextStyle(
            color: style.titleTextColor ?? colorPalette.textPrimary,
            fontSize: typography.heading1?.bold?.fontSize,
            fontWeight: typography.heading1?.bold?.fontWeight,
            fontFamily: typography.heading1?.bold?.fontFamily,
          ).merge(style.titleTextStyle).copyWith(
                color: style.titleTextColor,
              ),
          backIconTint: style.backIconColor ?? colorPalette.iconPrimary,
          searchIconTint: style.searchIconColor ?? colorPalette.iconSecondary,
          border: style.border,
          borderRadius: style.borderRadius,
          searchTextStyle: TextStyle(
            color: style.searchInputTextColor ?? colorPalette.textPrimary,
            fontSize: typography.heading4?.regular?.fontSize,
            fontWeight: typography.heading4?.regular?.fontWeight,
            fontFamily: typography.heading4?.regular?.fontFamily,
          ).merge(style.searchInputTextStyle).copyWith(
                color: style.searchInputTextColor,
              ),
          searchPlaceholderStyle: TextStyle(
            color:
                style.searchPlaceHolderTextColor ?? colorPalette.textTertiary,
            fontSize: typography.heading4?.regular?.fontSize,
            fontWeight: typography.heading4?.regular?.fontWeight,
            fontFamily: typography.heading4?.regular?.fontFamily,
          ).merge(style.searchPlaceHolderTextStyle).copyWith(
                color: style.searchPlaceHolderTextColor,
              ),
          searchBoxBackground:
              style.searchBackgroundColor ?? colorPalette.background3,
          borderSide: style.searchBorder,
          searchTextFieldRadius: style.searchBorderRadius ??
              BorderRadius.circular(
                spacing.radiusMax ?? 0,
              ),
          appBarShape: Border(
            bottom: BorderSide(
              color: style.separatorColor ??
                  colorPalette.borderLight ??
                  Colors.transparent,
              width: style.separatorHeight ?? 1,
            ),
          ),
        ),
        container: GetBuilder(
            tag: tag,
            builder: (CometChatUsersController value) => _getList(
                  context,
                  value,
                )),
      ),
    );
  }

  Widget _getList(BuildContext context, CometChatUsersController value) {
    if (value.hasError == true) {
      if (widget.errorStateView != null) {
        return widget.errorStateView!(context);
      }

      return _showError(value, context);
    } else if (value.isLoading == true && (value.list.isEmpty)) {
      return _getLoadingIndicator(context);
    } else if (value.list.isEmpty) {
      //----------- empty list widget-----------
      return _getNoUserIndicator(context);
    } else {
      return ListView.builder(
        controller: widget.controller,
        itemCount:
            value.hasMoreItems ? value.list.length + 1 : value.list.length,
        itemBuilder: (context, index) {
          if (index >= value.list.length) {
            value.loadMoreElements();
            return _getLoadingIndicator(context);
          }

          return Column(
            children: [
              if (widget.hideSectionSeparator != true)
                _getUserListDivider(value, index, context),
              getListItem(value.list[index], value, context),
            ],
          );
        },
      );
    }
  }

  Widget getListItem(
      User user, CometChatUsersController controller, BuildContext context) {
    if (widget.listItemView != null) {
      return widget.listItemView!(user);
    } else {
      return getDefaultItem(user, controller, context);
    }
  }

  Widget getDefaultItem(
      User user, CometChatUsersController controller, BuildContext context) {
    Widget? subtitle;
    Widget? tail;
    Color? backgroundColor;
    Widget? icon;

    if (widget.subtitleView != null) {
      subtitle = widget.subtitleView!(context, user);
    }

    StatusIndicatorUtils statusIndicatorUtils =
        StatusIndicatorUtils.getStatusIndicatorFromParams(
      context: context,
      user: user,
      disableUsersPresence: controller.hideUserPresence(user),
      onlineStatusIndicatorColor:
          statusIndicatorStyle.backgroundColor ?? colorPalette.success,
      isSelected: false,
      selectIcon: widget.selectionIcon,
    );

    backgroundColor = statusIndicatorUtils.statusIndicatorColor;
    icon = statusIndicatorUtils.icon;

    return Container(
      decoration: BoxDecoration(
        color: (controller.selectionMap[user.uid] != null)
            ? (style.listItemSelectedBackgroundColor ??
                colorPalette.background4)
            : colorPalette.transparent,
      ),
      child: GestureDetector(
        onLongPress: () {
          if (widget.activateSelection == ActivateSelection.onLongClick &&
              controller.selectionMap.isEmpty &&
              !(widget.selectionMode == null ||
                  widget.selectionMode == SelectionMode.none)) {
            controller.onTap(user);

            _isSelectionOn.value = true;
          } else if (widget.onItemLongPress != null) {
            widget.onItemLongPress!(context, user);
          }
        },
        onTap: () {
          if (widget.activateSelection == ActivateSelection.onClick ||
              (widget.activateSelection == ActivateSelection.onLongClick &&
                      controller.selectionMap.isNotEmpty) &&
                  !(widget.selectionMode == null ||
                      widget.selectionMode == SelectionMode.none)) {
            controller.onTap(user);
            if (controller.selectionMap.isEmpty) {
              _isSelectionOn.value = false;
            } else if (widget.activateSelection == ActivateSelection.onClick &&
                controller.selectionMap.isNotEmpty &&
                _isSelectionOn.value == false) {
              _isSelectionOn.value = true;
            }
          }
          if (widget.onItemTap != null) {
            widget.onItemTap!(context, user);
          }
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            (controller.selectionMap.isNotEmpty)
                ? Checkbox(
                    fillColor: (controller.selectionMap[user.uid] != null)
                        ? WidgetStateProperty.all(
                            style.checkBoxCheckedBackgroundColor ??
                                colorPalette.iconHighlight)
                        : WidgetStateProperty.all(
                            style.checkBoxBackgroundColor ??
                                colorPalette.transparent),
                    value: controller.selectionMap[user.uid] != null,
                    onChanged: (value) {
                      if (widget.activateSelection ==
                              ActivateSelection.onClick ||
                          (widget.activateSelection ==
                                      ActivateSelection.onLongClick &&
                                  controller.selectionMap.isNotEmpty) &&
                              !(widget.selectionMode == null ||
                                  widget.selectionMode == SelectionMode.none)) {
                        controller.onTap(user);
                        if (controller.selectionMap.isEmpty) {
                          _isSelectionOn.value = false;
                        } else if (widget.activateSelection ==
                                ActivateSelection.onClick &&
                            controller.selectionMap.isNotEmpty &&
                            _isSelectionOn.value == false) {
                          _isSelectionOn.value = true;
                        }
                      }
                    },
                    activeColor: style.checkBoxCheckedBackgroundColor ??
                        colorPalette.iconHighlight,
                    shape: RoundedRectangleBorder(
                      borderRadius: style.checkBoxBorderRadius ??
                          BorderRadius.circular(
                            spacing.radius1 ?? 4,
                          ),
                    ),
                    checkColor:
                        style.checkboxSelectedIconColor ?? colorPalette.white,
                    side: style.checkBoxBorder ??
                        BorderSide(
                          color:
                              colorPalette.borderDefault ?? Colors.transparent,
                          width: 1.25,
                          style: BorderStyle.solid,
                        ),
                  )
                : const SizedBox(),
            Expanded(
              child: CometChatListItem(
                id: user.uid,
                avatarName: user.name,
                avatarURL: user.avatar,
                avatarHeight: 40,
                avatarWidth: 40,
                title: user.name,
                key: UniqueKey(),
                subtitleView: subtitle,
                tailView: tail,
                avatarStyle: avatarStyle,
                statusIndicatorColor: backgroundColor,
                statusIndicatorIcon: icon,
                statusIndicatorStyle: CometChatStatusIndicatorStyle(
                  border: statusIndicatorStyle.border ??
                      Border.all(
                        width: spacing.spacing ?? 0,
                        color: colorPalette.background1 ?? Colors.transparent,
                      ),
                  backgroundColor: statusIndicatorStyle.backgroundColor ??
                      colorPalette.success,
                ),
                hideSeparator: true,
                options: widget.options != null
                    ? widget.options!(user, controller)
                    : [],
                style: ListItemStyle(
                  background: (controller.selectionMap[user.uid] != null)
                      ? (style.listItemSelectedBackgroundColor ??
                          colorPalette.background4)
                      : colorPalette.transparent,
                  titleStyle: TextStyle(
                    overflow: TextOverflow.ellipsis,
                    fontSize: typography.heading4?.medium?.fontSize,
                    fontWeight: typography.heading4?.medium?.fontWeight,
                    fontFamily: typography.heading4?.medium?.fontFamily,
                    color: style.itemTitleTextColor ?? colorPalette.textPrimary,
                  )
                      .merge(
                        style.itemTitleTextStyle,
                      )
                      .copyWith(
                        color: style.itemTitleTextColor,
                      ),
                  padding: EdgeInsets.only(
                    left: (controller.selectionMap.isNotEmpty)
                        ? 0
                        : spacing.padding4 ?? 0,
                    right: spacing.padding4 ?? 0,
                    top: spacing.padding2 ?? 0,
                    bottom: spacing.padding2 ?? 0,
                  ),
                  border: style.itemBorder,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _getLoadingIndicator(BuildContext context) {
    if (widget.loadingStateView != null) {
      return Center(child: widget.loadingStateView!(context));
    } else {
      return CometChatShimmerEffect(
        colorPalette: colorPalette,
        child: ListView.builder(
          itemCount: 30,
          shrinkWrap: true,
          itemBuilder: (context, index) {
            return Padding(
              padding: EdgeInsets.symmetric(
                horizontal: spacing.padding4 ?? 0,
                vertical: spacing.padding3 ?? 0,
              ),
              child: Row(
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                      right: spacing.padding3 ?? 0,
                    ),
                    child: const CircleAvatar(
                      radius: 24,
                      backgroundColor: Colors.grey,
                    ),
                  ),
                  Container(
                    height: 22.0,
                    width: MediaQuery.of(context).size.width * 0.4,
                    decoration: BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.circular(
                        spacing.radius2 ?? 0,
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      );
    }
  }

  Widget _getNoUserIndicator(BuildContext context) {
    if (widget.emptyStateView != null) {
      return Center(child: widget.emptyStateView!(context));
    } else {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.only(
                bottom: spacing.padding5 ?? 0,
              ),
              child: Image.asset(
                AssetConstants(CometChatThemeHelper.getBrightness(context))
                    .emptyUserList,
                package: UIConstants.packageName,
                width: 120,
                height: 120,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                bottom: spacing.padding1 ?? 0,
              ),
              child: Text(
                cc.Translations.of(context).usersUnavailable,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: style.emptyStateTextColor ?? colorPalette.textPrimary,
                  fontSize: typography.heading3?.bold?.fontSize,
                  fontWeight: typography.heading3?.bold?.fontWeight,
                  fontFamily: typography.heading3?.bold?.fontFamily,
                )
                    .merge(style.emptyStateTextStyle)
                    .copyWith(color: style.emptyStateTextColor),
              ),
            ),
            Text(
              cc.Translations.of(context).addContactsToStartConversations,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: style.emptyStateSubTitleTextColor ??
                    colorPalette.textSecondary,
                fontSize: typography.body?.regular?.fontSize,
                fontWeight: typography.body?.regular?.fontWeight,
                fontFamily: typography.body?.regular?.fontFamily,
              )
                  .merge(
                    style.emptyStateSubTitleTextStyle,
                  )
                  .copyWith(
                    color: style.emptyStateSubTitleTextColor,
                  ),
            ),
          ],
        ),
      );
    }
  }

  Widget _getUserListDivider(
      CometChatUsersController controller, int index, BuildContext context) {
    if (index == 0 ||
        controller.list[index].name.substring(0, 1).toLowerCase() !=
            controller.list[index - 1].name.substring(0, 1).toLowerCase()) {
      return Padding(
        padding: EdgeInsets.only(
          left: (controller.selectionMap.isNotEmpty)
              ? (spacing.padding10 ?? 0)
              : spacing.padding5 ?? 0,
          right: spacing.padding5 ?? 0,
          top: spacing.padding2 ?? 0,
          bottom: 0,
        ),
        child: SectionSeparator(
          text: controller.list[index].name.substring(0, 1).toUpperCase(),
          dividerColor: colorPalette.transparent,
          textStyle: TextStyle(
            color: style.stickyTitleColor ?? colorPalette.primary,
            fontSize: typography.heading4?.medium?.fontSize,
            fontWeight: typography.heading4?.medium?.fontWeight,
            fontFamily: typography.heading4?.medium?.fontFamily,
          )
              .merge(
                style.stickyTitleTextStyle,
              )
              .copyWith(
                color: style.stickyTitleColor,
              ),
          height: 0,
        ),
      );
    } else {
      return const SizedBox(
        height: 0,
        width: 0,
      );
    }
  }

  _showError(CometChatUsersController controller, BuildContext context) {
    return UIStateUtils.getDefaultErrorStateView(
      context,
      colorPalette,
      typography,
      spacing,
      () {
        controller.retryUsers();
      },
      errorStateTextColor: style.errorStateTextColor,
      errorStateTextStyle: style.errorStateTextStyle,
      errorStateSubtitleColor: style.errorStateSubTitleTextColor,
      errorStateSubtitleStyle: style.errorStateSubTitleTextStyle,
      buttonBackgroundColor: style.retryButtonBackgroundColor,
      buttonBorderRadius: style.retryButtonBorderRadius,
      buttonBorderSide: style.retryButtonBorder,
      buttonTextColor: style.retryButtonTextColor,
      buttonTextStyle: style.retryButtonTextStyle,
    );
  }

  Widget getSelectionWidget(
      CometChatUsersController usersController, BuildContext context) {
    if (_isSelectionOn.value) {
      return IconButton(
        onPressed: () {
          List<User>? users = usersController.getSelectedList();
          if (widget.onSelection != null) {
            widget.onSelection!(users, context);
          }
        },
        icon: widget.submitIcon ??
            Icon(
              Icons.check,
              color: style.submitIconColor ?? colorPalette.iconPrimary,
              size: 24,
            ),
      );
    } else {
      return const SizedBox(
        height: 0,
        width: 0,
      );
    }
  }
}
