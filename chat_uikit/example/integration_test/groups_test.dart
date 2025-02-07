// import 'package:flutter/material.dart';
// import 'package:cometchat_chat_uikit/cometchat_chat_uikit.dart';
// import 'package:flutter_chat_ui_kit_example/utils/constants.dart';
// import 'package:flutter_test/flutter_test.dart';
// import 'package:integration_test/integration_test.dart';
//
// void main() {
//   IntegrationTestWidgetsFlutterBinding.ensureInitialized();
//   Duration buffer = const Duration(seconds: 5);
//   group(
//     'tests for CometChatGroups',
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
//         debugPrint('went to dashboard?');
//
//         //check if the user has been logged in
//         expect((await CometChatUIKit.getLoggedInUser())?.uid, 'superhero1');
//         debugPrint('logged in supehero1');
//       });
//
//       testWidgets(
//         'test groups request builder',
//         (widgetTester) async {
//           await widgetTester.pumpWidget(MaterialApp(
//             home: CometChatGroups(
//               groupsProtocol: UIGroupsBuilder(
//                   GroupsRequestBuilder()..searchKeyword = 'supergroup'),
//             ),
//           ));
//           await widgetTester.pumpAndSettle(buffer);
//           final groupItems = find.byType(CometChatListItem);
//           expect(groupItems, findsOneWidget);
//           debugPrint('${groupItems.evaluate().length} items found');
//         },
//       );
//
//       testWidgets(
//         'default status indicator style',
//         (widgetTester) async {
//           await widgetTester.pumpWidget(const MaterialApp(
//             home: CometChatGroups(),
//           ));
//
//           await widgetTester.pumpAndSettle(buffer);
//           final allStatus = find.byType(CometChatStatusIndicator);
//           expect(allStatus, findsWidgets);
//           final stats =
//               (allStatus.evaluate().first.widget as CometChatStatusIndicator);
//           expect(stats.backgroundColor, cometChatTheme.palette.getSuccess());
//           // expect((allStatus.evaluate().first.renderObject as RenderBox).getClipPath(Offset.zero).getOuterPath(Offset.zero).getBounds().toRRect().brRadius, 7);
//         },
//       );
//
//       testWidgets(
//         'list item view',
//         (widgetTester) async {
//           await widgetTester.pumpWidget(MaterialApp(
//             home: CometChatGroups(
//               listItemView: (group) => ListTile(
//                 leading: CometChatAvatar(
//                   image: group.icon,
//                   name: group.name,
//                   style: AvatarStyle(
//                     background: Colors.deepOrange.shade900,
//                     height: 56,
//                     width: 56,
//                   ),
//                 ),
//                 title: Text(group.name),
//                 subtitle: const Text('customized listView'),
//               ),
//             ),
//           ));
//
//           await widgetTester.pumpAndSettle(buffer);
//           expect(find.widgetWithText(ListTile, 'customized listView'),
//               findsWidgets);
//         },
//       );
//
//       testWidgets(
//         'custom subtitle view',
//         (widgetTester) async {
//           await widgetTester.pumpWidget(MaterialApp(
//             home: CometChatGroups(
//               subtitleView: (context, group) =>
//                   const Text('customized subtitleView'),
//             ),
//           ));
//
//           await widgetTester.pumpAndSettle(buffer);
//           expect(
//               find.widgetWithText(CometChatListItem, 'customized subtitleView'),
//               findsWidgets);
//         },
//       );
//
//       testWidgets(
//         'custom onSelection',
//         (widgetTester) async {
//           await widgetTester.pumpWidget(MaterialApp(
//             home: CometChatGroups(
//               activateSelection: ActivateSelection.onClick,
//               selectionMode: SelectionMode.multiple,
//               onSelection: (groups) {
//                 NavigatorState navigator =
//                     widgetTester.state(find.byType(Navigator));
//                 popUpDialog(
//                     context: navigator.context,
//                     title: "Custom onSelection",
//                     body: "${groups?.length ?? 0} groups have been selected");
//               },
//             ),
//           ));
//
//           await widgetTester.pumpAndSettle(buffer);
//           final groupItems = find.byType(CometChatListItem);
//           await widgetTester.tap(groupItems.at(0));
//           await widgetTester.pumpAndSettle(buffer);
//           await widgetTester.tap(groupItems.at(1));
//           await widgetTester.pumpAndSettle(buffer);
//
//           final getSelectionWidget = find.widgetWithImage(
//               IconButton,
//               const AssetImage(AssetConstants.checkmark,
//                   package: UIConstants.packageName));
//           expect(getSelectionWidget, findsOneWidget);
//           debugPrint('get selection widget is visible');
//           await widgetTester.tap(getSelectionWidget);
//           await widgetTester.pumpAndSettle(buffer);
//
//           expect(find.widgetWithText(AlertDialog, "Custom onSelection"),
//               findsOneWidget);
//         },
//       );
//
//       testWidgets(
//         'custom onItemTap',
//         (widgetTester) async {
//           await widgetTester.pumpWidget(MaterialApp(
//             home: CometChatGroups(
//               onItemTap: (BuildContext context, group) {
//                 NavigatorState navigator =
//                     widgetTester.state(find.byType(Navigator));
//                 popUpDialog(
//                     context: navigator.context,
//                     title: "Custom onItemTap",
//                     body: "${group.name} has been tapped");
//               },
//             ),
//           ));
//
//           await widgetTester.pumpAndSettle(buffer);
//           final groupItems = find.byType(CometChatListItem);
//           await widgetTester.tap(groupItems.at(0));
//           await widgetTester.pumpAndSettle(buffer);
//
//           expect(find.widgetWithText(AlertDialog, "Custom onItemTap"),
//               findsOneWidget);
//         },
//       );
//
//       testWidgets(
//         'default loading icon',
//         (widgetTester) async {
//           await widgetTester.pumpWidget(const MaterialApp(
//             home: CometChatGroups(),
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
//             home: CometChatGroups(
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
//             home: CometChatGroups(),
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
//             home: CometChatGroups(
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
//             home: CometChatGroups(),
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
//             home: CometChatGroups(searchPlaceholder: "search for a user"),
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
//             home: CometChatGroups(
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
//         'default private group icon',
//         (widgetTester) async {
//           await widgetTester.pumpWidget(MaterialApp(
//             home: CometChatGroups(
//               groupsRequestBuilder: GroupsRequestBuilder()
//                 ..searchKeyword = "private group",
//             ),
//           ));
//           await widgetTester.pumpAndSettle(buffer);
//           expect(find.widgetWithIcon(CometChatStatusIndicator, Icons.back_hand),
//               findsWidgets);
//         },
//       );
//
//       testWidgets(
//         'custom private group icon',
//         (widgetTester) async {
//           await widgetTester.pumpWidget(MaterialApp(
//             home: CometChatGroups(
//               groupsRequestBuilder: GroupsRequestBuilder()
//                 ..searchKeyword = "private group",
//               //privateGroupIcon: Icon(Icons.safety_check),
//             ),
//           ));
//           await widgetTester.pumpAndSettle(buffer);
//         },
//       );
//
//       testWidgets(
//         'default password group icon',
//         (widgetTester) async {
//           await widgetTester.pumpWidget(MaterialApp(
//             home: CometChatGroups(
//               groupsRequestBuilder: GroupsRequestBuilder()
//                 ..searchKeyword = "password group",
//             ),
//           ));
//
//           await widgetTester.pumpAndSettle(buffer);
//
//           expect(find.widgetWithIcon(CometChatStatusIndicator, Icons.lock),
//               findsWidgets);
//         },
//       );
//
//       testWidgets(
//         'custom password group icon',
//         (widgetTester) async {
//           await widgetTester.pumpWidget(MaterialApp(
//             home: CometChatGroups(
//               groupsRequestBuilder: GroupsRequestBuilder()
//                 ..searchKeyword = "password group",
//               passwordGroupIcon: const Icon(Icons.key),
//             ),
//           ));
//
//           await widgetTester.pumpAndSettle(buffer);
//
//           expect(find.widgetWithIcon(CometChatStatusIndicator, Icons.key),
//               findsWidgets);
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
