// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:cometchat_chat_uikit/cometchat_chat_uikit.dart';
// import 'package:master_app/utils/constants.dart';
// import 'package:flutter_test/flutter_test.dart';
// import 'package:integration_test/integration_test.dart';
//
// void main() {
//   IntegrationTestWidgetsFlutterBinding.ensureInitialized();
//
//   group('end-to-end test', () {
//     test('initializing CometChat and logging in', () async {
//       //populating auth settings
//       UIKitSettings uiKitSettings = (UIKitSettingsBuilder()
//             ..subscriptionType = CometChatSubscriptionType.allUsers
//             ..region = CometChatConstants.region
//             ..autoEstablishSocketConnection = true
//             ..appId = CometChatConstants.appId
//             ..authKey = CometChatConstants.authKey)
//           .build();
//       if (kDebugMode) {
//         print('auth settings populated');
//       }
//
//       //initializing CometChat
//       await CometChatUIKit.init(
//           uiKitSettings: uiKitSettings,
//           onSuccess: (String successMessage) {
//             debugPrint(
//                 "Initialization completed successfully  $successMessage");
//           },
//           onError: (CometChatException e) {
//             debugPrint("Initialization failed with exception: ${e.message}");
//           });
//
//       ///user login
//       await CometChatUIKit.login('superhero1');
//
//       ///check if the user has been logged in
//       expect((await CometChatUIKit.getLoggedInUser())?.uid, 'superhero1');
//     });
//   });
// }
