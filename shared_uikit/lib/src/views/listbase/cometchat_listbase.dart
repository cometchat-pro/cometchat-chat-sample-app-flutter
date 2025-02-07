import 'package:flutter/material.dart';
import 'package:cometchat_uikit_shared/cometchat_uikit_shared.dart';

///[CometChatListBase] is a top level container widget
///used internally by components like [CometChatUsers], [CometChatGroups], [CometChatConversations], [CometChatGroupMembers]
/// ```dart
///   CometChatListBase(
///        title: "title",
///        container: Container(),
///        style: ListBaseStyle(),
///    );
/// ```
class CometChatListBase extends StatelessWidget {
  /// Creates a widget that that gives CometChat ListBase UI
  const CometChatListBase({
    super.key,
    this.style = const ListBaseStyle(),
    this.backIcon,
    this.title,
    this.hideSearch = false,
    this.searchBoxIcon,
    required this.container,
    this.showBackButton = false,
    this.onSearch,
    this.menuOptions,
    this.placeholder,
    this.searchText,
    this.onBack,
    this.hideAppBar = false,
    this.searchPadding,
    this.searchBoxHeight,
    this.searchContentPadding,
    this.titleSpacing,
    this.titleView,
  });

  ///[style] styling properties
  final ListBaseStyle style;

  ///[showBackButton] show back button
  final bool? showBackButton;

  ///[placeholder] hint text to be shown in search box
  final String? placeholder;

  ///[backIcon] back button icon
  final Widget? backIcon;

  ///[title] title string
  final String? title;

  ///[hideSearch] show the search box
  final bool? hideSearch;

  ///[searchBoxIcon] search box prefix icon
  final Widget? searchBoxIcon;

  ///[container] listview of users
  final Widget container;

  ///[menuOptions] list of widgets options to be shown
  final List<Widget>? menuOptions;

  ///[onSearch] onSearch callback
  final void Function(String val)? onSearch;

  ///[searchText] initial text to be searched
  final String? searchText;

  ///[onBack] callback triggered on closing a screen
  final VoidCallback? onBack;

  ///[theme] to specify custom theme
  final bool? hideAppBar;

  ///[searchPadding] to specify padding for search box
  final EdgeInsetsGeometry? searchPadding;

  ///[searchBoxHeight] to specify height of search box
  final double? searchBoxHeight;

  ///[searchContentPadding] to specify content padding for search box
  final EdgeInsetsGeometry? searchContentPadding;

  ///[titleSpacing] to specify title spacing
  final double? titleSpacing;

  ///[titleView] to specify title view
  final Widget? titleView;

  /// returns back button to be shown in appbar
  Widget? getBackButton(context) {
    Widget? backButton;
    if (showBackButton != null && showBackButton == true) {
      backButton = IconButton(
        onPressed: onBack ??
            () {
              Navigator.pop(context);
            },
        color: style.backIconTint,
        icon: backIcon ??
            Image.asset(
              AssetConstants.back,
              package: UIConstants.packageName,
              color: style.backIconTint,
              height: 24,
              width: 24,
            ),
      );
    }
    return backButton;
  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: style.borderRadius ?? BorderRadius.zero,
      child: Container(
        decoration: BoxDecoration(
          gradient: style.gradient,
          border: style.border,
          borderRadius: style.borderRadius,
        ),
        child: Scaffold(
          //appbar with back button and menu options

          appBar: hideAppBar == true
              ? null
              : AppBar(
                  elevation: 0,
                  toolbarHeight: 56,
                  title:titleView ?? Text(
                    title ?? "",
                    style: style.titleStyle,
                  ),
                  shape: style.appBarShape,
                  backgroundColor: style.background,
                  leading: getBackButton(context),
                  automaticallyImplyLeading: showBackButton ?? false,
                  actions: menuOptions ?? [],
                  centerTitle: false,
            titleSpacing: titleSpacing,
                ),

          backgroundColor: style.background,
          body: Padding(
            padding: style.padding ?? const EdgeInsets.only(left: 0, right: 0),
            child: SizedBox(
              height: style.height,
              width: style.width,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //-----------------------------------
                  //----------show search box----------
                  if(hideSearch == false)
                    Padding(
                      padding: searchPadding ?? const EdgeInsets.all(0),
                      child: SizedBox(
                        height: searchBoxHeight,
                        child: Center(
                          child: TextField(
                            keyboardAppearance:
                            CometChatThemeHelper.getBrightness(context) ==
                                Brightness.dark
                                ? Brightness.dark
                                : Brightness.light,
                            key: key,
                            //--------------------------------------
                            //----------on search callback----------
                            controller: TextEditingController(text: searchText),
                            onChanged: onSearch,
                            style: style.searchTextStyle,

                            //-----------------------------------------
                            //----------search box decoration----------
                            decoration: InputDecoration(
                              contentPadding: searchContentPadding ??
                                  const EdgeInsets.all(0),
                              hintText: placeholder ??
                                  Translations.of(context).search,
                              prefixIcon: searchBoxIcon ??
                                  Icon(
                                    Icons.search,
                                    color: style.searchIconTint,
                                    size: 24,
                                  ),
                              prefixIconColor: style.searchIconTint,
                              hintStyle: style.searchPlaceholderStyle,

                              //-------------------------------------
                              //----------search box border----------
                              focusedBorder: OutlineInputBorder(
                                borderSide: style.borderSide ?? BorderSide.none,
                                borderRadius: style.searchTextFieldRadius ??
                                    BorderRadius.circular(28),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: style.borderSide ?? BorderSide.none,
                                borderRadius: style.searchTextFieldRadius ??
                                    BorderRadius.circular(
                                      28,
                                    ),
                              ),
                              border: OutlineInputBorder(
                                borderSide: style.borderSide ?? BorderSide.none,
                                borderRadius: style.searchTextFieldRadius ??
                                    BorderRadius.circular(
                                      28,
                                    ),
                              ),

                              //-----------------------------------------
                              //----------search box fill color----------
                              fillColor: style.searchBoxBackground,
                              filled: true,
                            ),
                          ),
                        ),
                      ),
                    ),

                  //--------------------------------
                  //----------showing list----------
                  Expanded(child: container)
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
