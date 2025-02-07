// import 'package:flutter/material.dart';
// import 'package:cometchat_chat_uikit/cometchat_chat_uikit.dart';
// import 'package:flutter_chat_ui_kit_example/utils/constants.dart';
// import 'package:flutter_test/flutter_test.dart';
// import 'package:integration_test/integration_test.dart';
//
// // import 'package:flutter_chat_ui_kit_example/main.dart' as app;
//
// void main() {
//   IntegrationTestWidgetsFlutterBinding.ensureInitialized();
//   Duration buffer = const Duration(seconds: 5);
//   group(
//     'tests for CometChatUsers',
//     () {
//       test('initializing CometChat and logging in', () async {
//         //populating auth settings
//         UIKitSettings uiKitSettings = (UIKitSettingsBuilder()
//               ..subscriptionType = CometChatSubscriptionType.allUsers
//               ..region = CometChatConstants.region
//               ..autoEstablishSocketConnection = true
//               ..appId = CometChatConstants.appId
//               ..authKey = CometChatConstants.authKey)
//             .build();
//         debugPrint('auth settings populated');
//
//         //initializing CometChat
//         await CometChatUIKit.init(
//             uiKitSettings: uiKitSettings,
//             onSuccess: (String successMessage) {
//               debugPrint(
//                   "Initialization completed successfully  $successMessage");
//             },
//             onError: (CometChatException e) {
//               debugPrint("Initialization failed with exception: ${e.message}");
//             });
//
//         //user login
//         await CometChatUIKit.login('superhero1');
//         // await tester.pumpAndSettle(buffer);
//         debugPrint('went to dashboard?');
//
//         //check if the user has been logged in
//         expect((await CometChatUIKit.getLoggedInUser())?.uid, 'superhero1');
//         debugPrint('logged in supehero1');
//       });
//
//       // testWidgets(
//       //   'default title',
//       //   (widgetTester) async {
//       //     await widgetTester.pumpWidget(MaterialApp(
//       //       home: CometChatUsers(),
//       //     ));
//       //     await widgetTester.pumpAndSettle(Duration(seconds: 10));
//       //     final usersTitle = find.widgetWithText(AppBar, "Users");
//       //     expect(usersTitle, findsOneWidget);
//       //   },
//       // );
//
//       // testWidgets(
//       //   'passing a custom title',
//       //   (widgetTester) async {
//       //     String title = "CometChatUsers";
//       //     await widgetTester.pumpWidget(MaterialApp(
//       //       home: CometChatUsers(
//       //         title: title,
//       //       ),
//       //     ));
//       //     await widgetTester.pumpAndSettle(buffer);
//       //     final usersTitle = find.widgetWithText(AppBar, title);
//       //     expect(usersTitle, findsOneWidget);
//       //   },
//       // );
//
//       // testWidgets(
//       //   'test users request builder',
//       //   (widgetTester) async {
//       //     await widgetTester.pumpWidget(MaterialApp(
//       //       home: CometChatUsers(
//       //         usersProtocol: UIUsersBuilder(
//       //             UsersRequestBuilder()..searchKeyword = 'superhero'),
//       //       ),
//       //     ));
//       //     await widgetTester.pumpAndSettle(buffer);
//       //     final userItems = find.byType(CometChatListItem);
//       //     expect(userItems, findsNWidgets(5));
//       //     print('${userItems.evaluate().length} items found');
//       //   },
//       // );
//
//       // testWidgets(
//       //   'test selection on tap and only one item can be selected at a time',
//       //   (widgetTester) async {
//       //     await widgetTester.pumpWidget(MaterialApp(
//       //       home: CometChatUsers(
//       //         activateSelection: ActivateSelection.onClick,
//       //         selectionMode: SelectionMode.single,
//       //       ),
//       //     ));
//       //     await widgetTester.pumpAndSettle(Duration(seconds: 10));
//       //     final userItems = find.byType(CometChatListItem);
//       //     await widgetTester.tap(userItems.first);
//       //     await widgetTester.pumpAndSettle(buffer);
//
//       //     final checkIcon =
//       //         find.widgetWithIcon(CometChatStatusIndicator, Icons.check);
//       //     expect(checkIcon, findsOneWidget);
//       //     print('1 item has been selected');
//       //     final getSelectionWidget = find.widgetWithImage(
//       //         IconButton,
//       //         AssetImage(AssetConstants.checkmark,
//       //             package: UIConstants.packageName));
//       //     expect(getSelectionWidget, findsOneWidget);
//       //     print('get selection widget is visible');
//
//       //     await widgetTester.tap(userItems.at(1));
//       //     await widgetTester.pumpAndSettle(buffer);
//       //     expect(checkIcon, findsOneWidget);
//       //     print('still only 1 item has been selected');
//
//       //     await widgetTester.tap(userItems.at(1));
//       //     await widgetTester.pumpAndSettle(buffer);
//       //     expect(checkIcon, findsNothing);
//       //     print('item has been unselected');
//       //     expect(getSelectionWidget, findsNothing);
//       //     print('get selection widget hidden');
//       //   },
//       // );
//
//       // testWidgets(
//       //   'test selection on long press and only one item can be selected at a time',
//       //   (widgetTester) async {
//       //     await widgetTester.pumpWidget(MaterialApp(
//       //       home: CometChatUsers(
//       //         activateSelection: ActivateSelection.onLongClick,
//       //         selectionMode: SelectionMode.single,
//       //       ),
//       //     ));
//       //     await widgetTester.pumpAndSettle(Duration(seconds: 10));
//       //     final userItems = find.byType(CometChatListItem);
//       //     await widgetTester.longPress(userItems.first);
//       //     await widgetTester.pumpAndSettle(Duration(seconds: 10));
//
//       //     final checkIcon =
//       //         find.widgetWithIcon(CometChatStatusIndicator, Icons.check);
//       //     expect(checkIcon, findsOneWidget);
//       //     print('1 item has been selected');
//       //     final getSelectionWidget = find.widgetWithImage(
//       //         IconButton,
//       //         AssetImage(AssetConstants.checkmark,
//       //             package: UIConstants.packageName));
//       //     expect(getSelectionWidget, findsOneWidget);
//       //     print('get selection widget is visible');
//
//       //     await widgetTester.tap(userItems.at(1));
//       //     await widgetTester.pumpAndSettle(Duration(seconds: 10));
//       //     expect(checkIcon, findsOneWidget);
//       //     print('still only 1 item has been selected');
//
//       //     await widgetTester.tap(userItems.at(1));
//       //     await widgetTester.pumpAndSettle(Duration(seconds: 20));
//       //     expect(checkIcon, findsNothing);
//       //     print('item has been unselected');
//       //     expect(getSelectionWidget, findsNothing);
//       //     print('get selection widget hidden');
//       //   },
//       // );
//
//       // testWidgets(
//       //   'test selection on item tap and multiple items can be selected',
//       //   (widgetTester) async {
//       //     await widgetTester.pumpWidget(MaterialApp(
//       //       home: CometChatUsers(
//       //         activateSelection: ActivateSelection.onClick,
//       //         // selectionMode: SelectionMode.multiple,
//       //       ),
//       //     ));
//       //     await widgetTester.pumpAndSettle(Duration(seconds: 10));
//       //     final userItems = find.byType(CometChatListItem);
//       //     await widgetTester.tap(userItems.first);
//       //     await widgetTester.pumpAndSettle(buffer);
//
//       //     final checkIcon =
//       //         find.widgetWithIcon(CometChatStatusIndicator, Icons.check);
//
//       //     expect(checkIcon, findsOneWidget);
//       //     print('1 item has been selected');
//
//       //     final getSelectionWidget = find.widgetWithImage(
//       //         IconButton,
//       //         AssetImage(AssetConstants.checkmark,
//       //             package: UIConstants.packageName));
//       //     expect(getSelectionWidget, findsOneWidget);
//       //     print('get selection widget is visible');
//
//       //     await widgetTester.tap(userItems.at(1));
//       //     await widgetTester.pumpAndSettle(buffer);
//       //     expect(checkIcon, findsNWidgets(2));
//       //     print('2 items has been selected');
//
//       //     await widgetTester.tap(userItems.at(1));
//       //     await widgetTester.pumpAndSettle(buffer);
//       //     expect(checkIcon, findsOneWidget);
//       //     print('1 item has been unselected');
//
//       //     await widgetTester.tap(userItems.first);
//       //     await widgetTester.pumpAndSettle(buffer);
//       //     expect(getSelectionWidget, findsNothing);
//       //     print('get selection widget hidden');
//       //   },
//       // );
//
//       // testWidgets(
//       //   'test selection on item long press and multiple items can be selected',
//       //   (widgetTester) async {
//       //     await widgetTester.pumpWidget(MaterialApp(
//       //       home: CometChatUsers(
//       //         activateSelection: ActivateSelection.onLongClick,
//       //         // selectionMode: SelectionMode.multiple,
//       //       ),
//       //     ));
//       //     await widgetTester.pumpAndSettle(Duration(seconds: 10));
//       //     final userItems = find.byType(CometChatListItem);
//       //     await widgetTester.longPress(userItems.first);
//       //     await widgetTester.pumpAndSettle(Duration(seconds: 10));
//
//       //     final checkIcon =
//       //         find.widgetWithIcon(CometChatStatusIndicator, Icons.check);
//
//       //     expect(checkIcon, findsOneWidget);
//       //     print('1 item has been selected');
//
//       //     final getSelectionWidget = find.widgetWithImage(
//       //         IconButton,
//       //         AssetImage(AssetConstants.checkmark,
//       //             package: UIConstants.packageName));
//       //     expect(getSelectionWidget, findsOneWidget);
//       //     print('get selection widget is visible');
//
//       //     await widgetTester.tap(userItems.at(1));
//       //     await widgetTester.pumpAndSettle(buffer);
//       //     expect(checkIcon, findsNWidgets(2));
//       //     print('2 items has been selected');
//
//       //     await widgetTester.tap(userItems.at(1));
//       //     await widgetTester.pumpAndSettle(buffer);
//       //     expect(checkIcon, findsOneWidget);
//       //     print('1 item has been unselected');
//
//       //     await widgetTester.tap(userItems.first);
//       //     await widgetTester.pumpAndSettle(buffer);
//       //     expect(getSelectionWidget, findsNothing);
//       //     print('get selection widget hidden');
//       //   },
//       // );
//       // testWidgets(
//       //   "default hideSearch",
//       //   (widgetTester) async {
//       //     await widgetTester.pumpWidget(MaterialApp(
//       //       home: CometChatUsers(),
//       //     ));
//       //     await widgetTester.pumpAndSettle(Duration(seconds: 10));
//       //     final searchBar = find.byType(TextField);
//       //     expect(searchBar, findsOneWidget);
//       //   },
//       // );
//       // testWidgets(
//       //   "setting hideSearch to true",
//       //   (widgetTester) async {
//       //     await widgetTester.pumpWidget(MaterialApp(
//       //       home: CometChatUsers(
//       //         hideSearch: true,
//       //       ),
//       //     ));
//       //     await widgetTester.pumpAndSettle(Duration(seconds: 10));
//       //     final searchBar = find.byType(TextField);
//       //     expect(searchBar, findsNothing);
//       //   },
//       // );
//
//       //!TEST FOR OPTIONS
//       // testWidgets(
//       //   'options',
//       //   (widgetTester) async {
//       //     final option = CometChatOption(
//       //         id: 'test',
//       //         icon: AssetConstants.info,
//       //         packageName: UIConstants.packageName,
//       //         backgroundColor: Colors.lightBlue);
//       //     await widgetTester.pumpWidget(MaterialApp(
//       //       home: CometChatUsers(
//       //         options: (p0, controller) {
//       //           return [];
//       //         },
//       //       ),
//       //     ));
//       //     await widgetTester.pumpAndSettle(Duration(seconds: 10));
//       //     final userItems = find.byType(CometChatListItem);
//       //     await widgetTester.drag(userItems.first, const Offset(-400, 0));
//       //     await widgetTester.pumpAndSettle(Duration(seconds: 10));
//       //     expect(
//       //         find.widgetWithImage(Container,AssetImage(AssetConstants.info,package: UIConstants.packageName)),
//       //         findsOneWidget);
//       //   },
//       // );
//
//       // testWidgets(
//       //   'app bar options',
//       //   (widgetTester) async {
//       //     final option = IconButton(
//       //       icon: const Icon(Icons.more_vert),
//       //       color: Colors.lightBlue,
//       //       onPressed: (() {}),
//       //     );
//       //     await widgetTester.pumpWidget(MaterialApp(
//       //       home: CometChatUsers(
//       //         appBarOptions: (context) {
//       //           return [option];
//       //         },
//       //       ),
//       //     ));
//       //     await widgetTester.pumpAndSettle(Duration(seconds: 10));
//
//       //     expect(
//       //         find.widgetWithIcon(IconButton, Icons.more_vert), findsOneWidget);
//       //   },
//       // );
//
//       // testWidgets(
//       //   'default show back button',
//       //   (widgetTester) async {
//       //     await widgetTester.pumpWidget(MaterialApp(
//       //       home: CometChatUsers(),
//       //     ));
//       //     await widgetTester.pumpAndSettle(Duration(seconds: 10));
//
//       //     expect(
//       //         find.widgetWithImage(
//       //             IconButton,
//       //             const AssetImage(AssetConstants.back,
//       //                 package: UIConstants.packageName)),
//       //         findsOneWidget);
//       //   },
//       // );
//
//       // testWidgets(
//       //   'custom show back button',
//       //   (widgetTester) async {
//       //     await widgetTester.pumpWidget(MaterialApp(
//       //       home: CometChatUsers(
//       //         showBackButton: false,
//       //       ),
//       //     ));
//       //     await widgetTester.pumpAndSettle(Duration(seconds: 10));
//
//       //     expect(
//       //         find.widgetWithImage(
//       //             IconButton,
//       //             const AssetImage(AssetConstants.back,
//       //                 package: UIConstants.packageName)),
//       //         findsNothing);
//       //   },
//       // );
//
//       //  testWidgets(
//       //   'custom back button',
//       //   (widgetTester) async {
//       //     final customBackButton=IconButton(onPressed: (){}, icon: const Icon(Icons.arrow_back_ios_rounded));
//
//       //     await widgetTester.pumpWidget(MaterialApp(
//       //       home: CometChatUsers(
//       //         backButton:customBackButton ,
//       //       ),
//       //     ));
//       //     await widgetTester.pumpAndSettle(buffer);
//
//       //     expect(
//       //         find.byWidget(customBackButton),
//       //         findsOneWidget);
//       //   },
//       // );
//
//       // testWidgets(
//       //   'default on tap back button',
//       //   (widgetTester) async {
//       //     await widgetTester.pumpWidget(MaterialApp(
//       //       home: CometChatUsers(
//       //         onBack: () {
//
//       //         },
//       //       ),
//       //     ));
//       //     await widgetTester.pumpAndSettle(buffer);
//       //     expect(
//       //       find.byType(CometChatUsers),
//       //       findsOneWidget
//       //     );
//       //     final backButton = find.widgetWithImage(
//       //         IconButton,
//       //         const AssetImage(AssetConstants.back,
//       //             package: UIConstants.packageName));
//       //     expect(backButton, findsOneWidget);
//       //     await widgetTester.tap(backButton);
//       //     await widgetTester.pumpAndSettle(buffer);
//       //     expect(
//       //       find.byType(CometChatUsers),findsOneWidget
//       //     );
//       //   },
//       // );
//
//       // testWidgets(
//       //   'custom on tap back button',
//       //   (widgetTester) async {
//       //     await widgetTester.pumpWidget(MaterialApp(
//       //       home: CometChatUsers(),
//       //     ));
//       //     await widgetTester.pumpAndSettle(buffer);
//       //     expect(
//       //       find.byType(CometChatUsers),
//       //       findsOneWidget
//       //     );
//       //     final backButton = find.widgetWithImage(
//       //         IconButton,
//       //         const AssetImage(AssetConstants.back,
//       //             package: UIConstants.packageName));
//       //     expect(backButton, findsOneWidget);
//       //     await widgetTester.tap(backButton);
//       //     await widgetTester.pumpAndSettle(buffer);
//       //     expect(
//       //       find.byType(CometChatUsers),findsNothing
//       //     );
//       //   },
//       // );
//
//       // testWidgets(
//       //   'default list Item style',
//       //   (widgetTester) async {
//       //     await widgetTester.pumpWidget(MaterialApp(
//       //       home: CometChatUsers(),
//       //     ));
//
//       //     await widgetTester.pumpAndSettle(buffer);
//       //     final userItems = find.byType(CometChatListItem);
//       //     expect(userItems, findsWidgets);
//       //     final userItem =
//       //         (userItems.evaluate().first.widget as CometChatListItem);
//       //     expect(userItem.style.background, Colors.transparent);
//       //     expect(
//       //         userItem.style.titleStyle,
//       //         TextStyle(
//       //             fontSize: cometChatTheme.typography.name.fontSize,
//       //             fontWeight: cometChatTheme.typography.name.fontWeight,
//       //             fontFamily: cometChatTheme.typography.name.fontFamily,
//       //             color: cometChatTheme.palette.getAccent()));
//       //   },
//       // );
//
//       // testWidgets(
//       //   'custom list item style',
//       //   (widgetTester) async {
//       //     ListItemStyle style = ListItemStyle(
//       //         background: Colors.red,
//       //         border: Border.all(color: Colors.blue, width: 2),
//       //         borderRadius: 16,
//       //         separatorColor: Colors.amber,
//       //         titleStyle: const TextStyle(
//       //             fontSize: 16,
//       //             backgroundColor: Colors.deepPurple,
//       //             color: Colors.white,
//       //             fontWeight: FontWeight.bold));
//       //     await widgetTester.pumpWidget(MaterialApp(
//       //       home: CometChatUsers(
//       //         listItemStyle: style,
//       //       ),
//       //     ));
//
//       //     await widgetTester.pumpAndSettle(buffer);
//       //     final userItems = find.byType(CometChatListItem);
//       //     expect(userItems, findsWidgets);
//       //     final userItem =
//       //         (userItems.evaluate().first.widget as CometChatListItem);
//       //     expect(userItem.style.background, style.background);
//       //     expect(userItem.style.titleStyle, style.titleStyle);
//       //     expect(userItem.style.border, style.border);
//       //     expect(userItem.style.borderRadius, style.borderRadius);
//       //     expect(userItem.style.separatorColor, style.separatorColor);
//       //   },
//       // );
//       // testWidgets(
//       //   'default avatar style',
//       //   (widgetTester) async {
//       //     await widgetTester.pumpWidget(MaterialApp(
//       //       home: CometChatUsers(),
//       //     ));
//
//       //     await widgetTester.pumpAndSettle(buffer);
//       //     final userAvatars = find.byType(CometChatAvatar);
//       //     expect(userAvatars, findsWidgets);
//       //     final userAvatar =
//       //         (userAvatars.evaluate().first.widget as CometChatAvatar);
//       //     expect(userAvatar.style?.background,
//       //         cometChatTheme.palette.getAccent700());
//       //     expect(
//       //         userAvatar.style?.nameTextStyle,
//       //         TextStyle(
//       //             fontSize: cometChatTheme.typography.name.fontSize,
//       //             fontWeight: cometChatTheme.typography.name.fontWeight,
//       //             fontFamily: cometChatTheme.typography.name.fontFamily,
//       //             color: cometChatTheme.palette.getBackground()));
//       //   },
//       // );
//
//       //     testWidgets(
//       //       'custom avatar style',
//       //       (widgetTester) async {
//       //         AvatarStyle style = AvatarStyle(
//       //             background: Colors.red,
//       //             border: Border.all(color: Colors.blue, width: 2),
//       //             borderRadius: 24,
//       //             outerBorderRadius: 24,
//       //             outerViewBackgroundColor: Colors.amber,
//       //             nameTextStyle: const TextStyle(
//       //                 fontSize: 16,
//       //                 backgroundColor: Colors.deepPurple,
//       //                 color: Colors.white,
//       //                 fontWeight: FontWeight.bold));
//
//       //         await widgetTester.pumpWidget(MaterialApp(
//       //           home: CometChatUsers(
//       //             avatarStyle: style,
//       //           ),
//       //         ));
//
//       //         await widgetTester.pumpAndSettle(buffer);
//       //         final userAvatars = find.byType(CometChatAvatar);
//       //         expect(userAvatars, findsWidgets);
//       //         final userAvatar =
//       //             (userAvatars.evaluate().first.widget as CometChatAvatar);
//       //         expect(userAvatar.style?.background, style.background);
//       //         expect(userAvatar.style?.nameTextStyle, style.nameTextStyle);
//       //         expect(userAvatar.style?.border, style.border);
//       //         expect(userAvatar.style?.borderRadius, style.borderRadius);
//       //         expect(userAvatar.style?.outerBorderRadius, style.outerBorderRadius);
//       //         expect(userAvatar.style?.outerViewBackgroundColor,
//       //             style.outerViewBackgroundColor);
//       //       },
//       //     );
//
//       // testWidgets(
//       //   'default status indicator style',
//       //   (widgetTester) async {
//       //     await widgetTester.pumpWidget(MaterialApp(
//       //       home: CometChatUsers(
//       //         usersRequestBuilder: UsersRequestBuilder()
//       //           ..userStatus = CometChatUserStatus.online,
//       //       ),
//       //     ));
//
//       //     await widgetTester.pumpAndSettle(buffer);
//       //     final allStatus = find.byType(CometChatStatusIndicator);
//       //     expect(allStatus, findsWidgets);
//       //     final stats =
//       //         (allStatus.evaluate().first.widget as CometChatStatusIndicator);
//       //     expect(stats.backgroundColor, cometChatTheme.palette.getSuccess());
//       //     // expect((allStatus.evaluate().first.renderObject as RenderBox).getClipPath(Offset.zero).getOuterPath(Offset.zero).getBounds().toRRect().brRadius, 7);
//       //   },
//       // );
//
//       //   testWidgets(
//       //   'default disable user presence',
//       //   (widgetTester) async {
//       //     //first login with superhero2 or any uid other than superhero1 from another device
//       //     await widgetTester.pumpWidget(MaterialApp(
//       //       home: CometChatUsers(
//       //         usersRequestBuilder: UsersRequestBuilder()
//       //           ..userStatus = CometChatUserStatus.online,
//       //       ),
//       //     ));
//
//       //     await widgetTester.pumpAndSettle(buffer);
//       //     final allStatus = find.byType(CometChatStatusIndicator);
//       //     expect(allStatus, findsWidgets);
//       //   },
//       // );
//
//       //  testWidgets(
//       //   'custom disable user presence',
//       //   (widgetTester) async {
//       //     //first login with superhero2 or any uid other than superhero1 from another device
//       //     await widgetTester.pumpWidget(MaterialApp(
//       //       home: CometChatUsers(
//       //         usersRequestBuilder: UsersRequestBuilder()
//       //           ..userStatus = CometChatUserStatus.online,
//       //           disableUsersPresence: true,
//       //       ),
//       //     ));
//
//       //     await widgetTester.pumpAndSettle(buffer);
//       //     final allStatus = find.byType(CometChatStatusIndicator);
//       //     expect(allStatus, findsNothing);
//       //   },
//       // );
//
//       // testWidgets(
//       //   'list item view',
//       //   (widgetTester) async {
//       //     await widgetTester.pumpWidget(MaterialApp(
//       //       home: CometChatUsers(
//       //         listItemView: (user) => ListTile(
//       //           leading: CometChatAvatar(
//       //             image: user.avatar,
//       //             name: user.name,
//       //             style: AvatarStyle(
//       //               background: Colors.deepOrange.shade900,
//       //               height: 56,
//       //               width: 56,
//       //             ),
//       //           ),
//       //           title: Text(user.name),
//       //           subtitle: const Text('customized listView'),
//       //         ),
//       //       ),
//       //     ));
//
//       //     await widgetTester.pumpAndSettle(buffer);
//       //     expect(find.widgetWithText(ListTile, 'customized listView'),
//       //         findsWidgets);
//       //   },
//       // );
//
//       // testWidgets(
//       //   'custom subtitle view',
//       //   (widgetTester) async {
//       //     await widgetTester.pumpWidget(MaterialApp(
//       //       home: CometChatUsers(
//       //         subtitleView: (context, user) =>
//       //             const Text('customized subtitleView'),
//       //       ),
//       //     ));
//
//       //     await widgetTester.pumpAndSettle(buffer);
//       //     expect(
//       //         find.widgetWithText(CometChatListItem, 'customized subtitleView'),
//       //         findsWidgets);
//       //   },
//       // );
//
//       // testWidgets(
//       //   'default subtitle view',
//       //   (widgetTester) async {
//       //     await widgetTester.pumpWidget(MaterialApp(
//       //       home: CometChatUsers(
//       //       ),
//       //     ));
//
//       //     await widgetTester.pumpAndSettle(buffer);
//
//       //     final userItem = find.byType(CometChatListItem).evaluate().first.widget as CometChatListItem;
//       //     expect(userItem.subtitleView,
//       //         null);
//       //   },
//       // );
//
//       // testWidgets(
//       //   'default hide separator',
//       //   (widgetTester) async {
//       //     await widgetTester.pumpWidget(MaterialApp(
//       //       home: CometChatUsers(),
//       //     ));
//
//       //     await widgetTester.pumpAndSettle(buffer);
//
//       //     final divider = Flexible(
//       //       child: Divider(
//       //         thickness: 1,
//       //         indent: 40,
//       //         height: 1,
//       //       ),
//       //     );
//
//       //     final userItemSeparators = find.byWidget(divider);
//       //     expect(userItemSeparators, findsNothing);
//       //   },
//       // );
//
//       // //!not working as expected
//       // testWidgets(
//       //   'custom hide separator',
//       //   (widgetTester) async {
//       //     await widgetTester.pumpWidget(MaterialApp(
//       //       home: CometChatUsers(
//       //         hideSeparator: false,
//       //       ),
//       //     ));
//
//       //     await widgetTester.pumpAndSettle(buffer);
//
//       //     const divider = Divider(
//       //       thickness: 1,
//       //       indent: 40,
//       //       height: 1,
//       //     );
//
//       //     final userItemSeparators = find.byWidget(divider);
//       //     expect(userItemSeparators, findsWidgets);
//       //   },
//       // );
//
//       // testWidgets(
//       //   'custom onSelection',
//       //   (widgetTester) async {
//       //     await widgetTester.pumpWidget(MaterialApp(
//       //       home: CometChatUsers(
//       //         activateSelection: ActivateSelection.onClick,
//       //         selectionMode: SelectionMode.multiple,
//       //         onSelection: (users, context) {
//       //           popUpDialog(
//       //               context: context,
//       //               title: "Custom onSelection",
//       //               body: "${users?.length ?? 0} users have been selected");
//       //         },
//       //       ),
//       //     ));
//
//       //     await widgetTester.pumpAndSettle(buffer);
//       //     final userItems = find.byType(CometChatListItem);
//       //     await widgetTester.tap(userItems.at(0));
//       //     await widgetTester.pumpAndSettle(buffer);
//       //     await widgetTester.tap(userItems.at(1));
//       //     await widgetTester.pumpAndSettle(buffer);
//
//       //     final getSelectionWidget = find.widgetWithImage(
//       //         IconButton,
//       //         const AssetImage(AssetConstants.checkmark,
//       //             package: UIConstants.packageName));
//       //     expect(getSelectionWidget, findsOneWidget);
//       //     print('get selection widget is visible');
//       //     await widgetTester.tap(getSelectionWidget);
//       //     await widgetTester.pumpAndSettle(buffer);
//
//       //     expect(find.widgetWithText(AlertDialog, "Custom onSelection"),
//       //         findsOneWidget);
//       //   },
//       // );
//
//       // testWidgets(
//       //   'custom onItemTap',
//       //   (widgetTester) async {
//       //     await widgetTester.pumpWidget(MaterialApp(
//       //       home: CometChatUsers(
//       //         onItemTap: (user) {
//       //            NavigatorState navigator = widgetTester.state(find.byType(Navigator));
//       //           popUpDialog(
//       //               context: navigator.context,
//       //               title: "Custom onItemTap",
//       //               body: "${user.name} has been tapped");
//       //         },
//       //       ),
//       //     ));
//
//       //     await widgetTester.pumpAndSettle(buffer);
//       //     final userItems = find.byType(CometChatListItem);
//       //     await widgetTester.tap(userItems.at(0));
//       //     await widgetTester.pumpAndSettle(buffer);
//
//       //     expect(find.widgetWithText(AlertDialog, "Custom onItemTap"),
//       //         findsOneWidget);
//       //   },
//       // );
//
//       //  testWidgets(
//       //   'custom onItemLongPress',
//       //   (widgetTester) async {
//       //     await widgetTester.pumpWidget(MaterialApp(
//       //       home: CometChatUsers(
//       //         onItemLongPress: (user) {
//       //            NavigatorState navigator = widgetTester.state(find.byType(Navigator));
//       //           popUpDialog(
//       //               context: navigator.context,
//       //               title: "Custom onItemLongPress",
//       //               body: "${user.name} has been long pressed");
//       //         },
//       //       ),
//       //     ));
//
//       //     await widgetTester.pumpAndSettle(buffer);
//       //     final userItems = find.byType(CometChatListItem);
//       //     await widgetTester.longPress(userItems.at(0));
//       //     await widgetTester.pumpAndSettle(buffer);
//
//       //     expect(find.widgetWithText(AlertDialog, "Custom onItemLongPress"),
//       //         findsOneWidget);
//       //   },
//       // );
//
//       //  testWidgets(
//       //   'default empty state text',
//       //   (widgetTester) async {
//       //     await widgetTester.pumpWidget(MaterialApp(
//       //       home: CometChatUsers(
//       //         usersRequestBuilder: UsersRequestBuilder()..searchKeyword='_____',
//       //       ),
//       //     ));
//
//       //     await widgetTester.pumpAndSettle(buffer);
//
//       //     expect(find.text('No users found'), findsOneWidget);
//       //   },
//       // );
//
//       // testWidgets(
//       //   'custom empty state text',
//       //   (widgetTester) async {
//       //     await widgetTester.pumpWidget(MaterialApp(
//       //       home: CometChatUsers(
//       //         usersRequestBuilder: UsersRequestBuilder()..searchKeyword='_____',
//       //         emptyStateText: 'users not found',
//       //       ),
//       //     ));
//
//       //     await widgetTester.pumpAndSettle(buffer);
//
//       //     expect(find.text('users not found'), findsOneWidget);
//       //   },
//       // );
//
//       // testWidgets(
//       //   'custom empty state view',
//       //   (widgetTester) async {
//       //     await widgetTester.pumpWidget(MaterialApp(
//       //       home: CometChatUsers(
//       //         usersRequestBuilder: UsersRequestBuilder()..searchKeyword='_____',
//       //         emptyStateView:(context) => Container(
//       //           color: Colors.lime.shade300,
//       //           height: 100,
//
//       //           child: const Text('custom empty state view')),
//       //       ),
//       //     ));
//
//       //     await widgetTester.pumpAndSettle(buffer);
//
//       //     expect(find.widgetWithText(Container,'custom empty state view'), findsOneWidget);
//       //   },
//       // );
//
// /*
// //! ERROR HANDLING TESTCASES
// //! WE NEED TO SKIP CometChat.init & login to test these
//       testWidgets(
//         'default error state text',
//         (widgetTester) async {
//           await widgetTester.pumpWidget(MaterialApp(
//             home: CometChatUsers(
//             ),
//           ));
//
//           await widgetTester.pumpAndSettle(buffer);
//
//           expect(find.widgetWithText(AlertDialog,'Something went wrong'), findsOneWidget);
//         },
//       );
//
//       testWidgets(
//         'custom error state text',
//         (widgetTester) async {
//           await widgetTester.pumpWidget(MaterialApp(
//             home: CometChatUsers(
//               errorStateText: 'error occurred',
//             ),
//           ));
//
//           await widgetTester.pumpAndSettle(buffer);
//
//           expect(find.widgetWithText(AlertDialog,'error occurred'), findsOneWidget);
//         },
//       );
//
//       testWidgets(
//         'custom error state view',
//         (widgetTester) async {
//           await widgetTester.pumpWidget(MaterialApp(
//             home: CometChatUsers(
//               errorStateView:(context) => Container(
//                 color: Colors.lightBlue.shade300,
//                 height: 100,
//
//                 child: const Text('custom error state view')),
//             ),
//           ));
//
//           await widgetTester.pumpAndSettle(buffer);
//
//           expect(find.widgetWithText(Container,'custom error state view'), findsOneWidget);
//         },
//       );
//       */
//
//       testWidgets(
//         'default loading icon',
//         (widgetTester) async {
//           await widgetTester.pumpWidget(const MaterialApp(
//             home: CometChatUsers(),
//           ));
//
//           expect(
//               find.widgetWithImage(
//                   CometChatListBase,
//                   const AssetImage(AssetConstants.spinner,
//                       package: UIConstants.packageName)),
//               findsOneWidget);
//         },
//       );
//
//       testWidgets(
//         'custom loadingstateview',
//         (widgetTester) async {
//           Widget loadingStateView = Container(
//             color: Colors.lime.shade300,
//             height: 100,
//             child: const Text('LOADING...'),
//           );
//           await widgetTester.pumpWidget(MaterialApp(
//             home: CometChatUsers(
//               loadingStateView: (context) => loadingStateView,
//             ),
//           ));
//
//           expect(find.byWidget(loadingStateView), findsOneWidget);
//         },
//       );
//
//       testWidgets(
//         'default searchBoxIcon',
//         (widgetTester) async {
//           await widgetTester.pumpWidget(const MaterialApp(
//             home: CometChatUsers(),
//           ));
//
//           await widgetTester.pumpAndSettle(buffer);
//
//           expect(find.widgetWithIcon(TextField, Icons.search), findsOneWidget);
//         },
//       );
//
//       testWidgets(
//         'custom searchBoxIcon',
//         (widgetTester) async {
//           const searchBoxIcon = Icon(
//             Icons.abc,
//             color: Colors.red,
//           );
//           await widgetTester.pumpWidget(const MaterialApp(
//             home: CometChatUsers(
//               searchBoxIcon: searchBoxIcon,
//             ),
//           ));
//
//           await widgetTester.pumpAndSettle(buffer);
//
//           expect(find.widgetWithIcon(TextField, Icons.abc), findsOneWidget);
//         },
//       );
//
//       testWidgets(
//         'default searchPlaceholder',
//         (widgetTester) async {
//           await widgetTester.pumpWidget(const MaterialApp(
//             home: CometChatUsers(),
//           ));
//
//           await widgetTester.pumpAndSettle(buffer);
//
//           expect(find.widgetWithText(TextField, 'Search'), findsOneWidget);
//         },
//       );
//
//       testWidgets(
//         'custom searchPlaceholder',
//         (widgetTester) async {
//           await widgetTester.pumpWidget(const MaterialApp(
//             home: CometChatUsers(searchPlaceholder: "search for a user"),
//           ));
//
//           await widgetTester.pumpAndSettle(buffer);
//
//           expect(find.widgetWithText(TextField, "search for a user"),
//               findsOneWidget);
//         },
//       );
//
//       testWidgets(
//         'default selection icon',
//         (widgetTester) async {
//           await widgetTester.pumpWidget(const MaterialApp(
//             home: CometChatUsers(
//               activateSelection: ActivateSelection.onClick,
//               selectionMode: SelectionMode.single,
//             ),
//           ));
//
//           await widgetTester.pumpAndSettle(buffer);
//
//           final userItems = find.byType(CometChatListItem);
//           await widgetTester.tap(userItems.first);
//           await widgetTester.pumpAndSettle(buffer);
//
//           final checkIcon =
//               find.widgetWithIcon(CometChatStatusIndicator, Icons.check);
//           expect(checkIcon, findsOneWidget);
//
//           expect(
//               find.widgetWithImage(
//                   IconButton,
//                   const AssetImage(
//                     AssetConstants.checkmark,
//                     package: UIConstants.packageName,
//                   )),
//               findsOneWidget);
//         },
//       );
//
//       testWidgets(
//         'custom selection icon',
//         (widgetTester) async {
//           Widget selectionIcon = const Icon(Icons.abc);
//           await widgetTester.pumpWidget(MaterialApp(
//             home: CometChatUsers(
//               activateSelection: ActivateSelection.onClick,
//               selectionMode: SelectionMode.single,
//               selectionIcon: selectionIcon,
//             ),
//           ));
//
//           await widgetTester.pumpAndSettle(buffer);
//
//           final userItems = find.byType(CometChatListItem);
//           await widgetTester.tap(userItems.first);
//           await widgetTester.pumpAndSettle(buffer);
//
//           final checkIcon =
//               find.widgetWithIcon(CometChatStatusIndicator, Icons.check);
//           expect(checkIcon, findsOneWidget);
//
//           expect(find.widgetWithIcon(IconButton, Icons.abc), findsOneWidget);
//         },
//       );
//     },
//   );
// }
//
// popUpDialog(
//     {required BuildContext context,
//     required String title,
//     required String body}) {
//   Widget closeButton = TextButton(
//     child: const Text("close"),
//     onPressed: () {
//       Navigator.of(context).pop();
//     },
//   );
//
//   AlertDialog alertDialog = AlertDialog(
//     title: Text(title),
//     content: Text(body),
//     actions: [
//       closeButton,
//     ],
//   );
//   showDialog(
//     context: context,
//     builder: (context) => alertDialog,
//   );
// }
