import 'package:cometchat_calls_uikit/cometchat_calls_uikit.dart';
import 'package:flutter/material.dart';
// import 'package:cometchat_chat_uikit/cometchat_chat_uikit.dart';
import 'package:cometchat_calls_uikit_example/login.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      localizationsDelegates: const [
        Translations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate
      ],
      supportedLocales: const [
        Locale('en', ''),
        Locale('hi', ''),
        Locale('ar', ''),
        Locale('de', ''),
        Locale('es', ''),
        Locale('fr', ''),
        Locale('ms', ''),
        Locale('pt', ''),
        Locale('ru', ''),
        Locale('sv', ''),
        Locale('zh', ''),
      ],
      title: 'Flutter Demo',
      theme: ThemeData(
        extensions: [
          // CometChatIncomingCallStyle(
          //   acceptButtonColor: Colors.white,
          //   avatarStyle: CometChatAvatarStyle(
          //     backgroundColor: Colors.white,
          //     borderRadius: BorderRadius.circular(20),
          //   ),
          //   backgroundColor: Colors.yellow,
          //   border: Border.all(
          //     color: Colors.blue,
          //     width: 10,
          //   ),
          //   borderRadius: BorderRadius.circular(20),
          //   titleTextStyle: TextStyle(
          //     color: Colors.red,
          //     fontSize: 40,
          //     fontWeight: FontWeight.bold,
          //   ),
          //   acceptIconColor: Colors.black,
          //   declineIconColor: Colors.black,
          //   titleColor: Colors.red,
          //   declineButtonColor: Colors.yellow,
          //   subtitleColor: Colors.black,
          //   subtitleTextStyle: TextStyle(
          //     color: Colors.red,
          //     fontSize: 40,
          //     fontWeight: FontWeight.bold,
          //   ),
          // ),
      //     CometChatOutgoingCallStyle(
      //       avatarStyle: CometChatAvatarStyle(
      //         backgroundColor: Colors.red,
      //         borderRadius: BorderRadius.circular(20),
      //       ),
      //       backgroundColor: Colors.blue,
      //       border: Border.all(
      //         color: Colors.red,
      //         width: 10,
      //       ),
      //       borderRadius: BorderRadius.circular(20),
      //       titleTextStyle: TextStyle(
      //         color: Colors.red,
      //         fontSize: 40,
      //         fontWeight: FontWeight.bold,
      //       ),
      //       iconColor: Colors.black,
      //       titleColor: Colors.yellow,
      //       declineButtonColor: Colors.yellow,
      //       subtitleColor: Colors.black,
      //       subtitleTextStyle: TextStyle(
      //         color: Colors.red,
      //         fontSize: 40,
      //         fontWeight: FontWeight.bold,
      //       ),
      //     ),
      //   ],
      // ),
      // darkTheme: ThemeData(extensions: [
      //   CometChatOutgoingCallStyle(
      //     avatarStyle: CometChatAvatarStyle(
      //       backgroundColor: Colors.white,
      //       borderRadius: BorderRadius.circular(20),
      //     ),
      //     backgroundColor: Colors.yellow,
      //     border: Border.all(
      //       color: Colors.blue,
      //     ),
      //     borderRadius: BorderRadius.circular(20),
      //     titleTextStyle: TextStyle(
      //       color: Colors.red,
      //       fontSize: 40,
      //       fontWeight: FontWeight.bold,
      //     ),
      //     iconColor: Colors.black,
      //     titleColor: Colors.yellow,
      //     declineButtonColor: Colors.yellow,
      //     subtitleColor: Colors.black,
      //     subtitleTextStyle: TextStyle(
      //       color: Colors.red,
      //       fontSize: 40,
      //       fontWeight: FontWeight.bold,
      //     ),
      //   )
          CometChatCallButtonsStyle(
            videoCallIconColor: Colors.yellow,
            voiceCallIconColor: Colors.yellow,
          )
      ]),
      darkTheme: ThemeData(
        extensions: [
          // CometChatIncomingCallStyle(
          //   acceptButtonColor: Colors.blue,
          //   avatarStyle: CometChatAvatarStyle(
          //     backgroundColor: Colors.white,
          //     borderRadius: BorderRadius.circular(20),
          //   ),
          //   backgroundColor: Colors.white10,
          //   border: Border.all(
          //     color: Colors.blue,
          //     width: 10,
          //   ),
          //   borderRadius: BorderRadius.circular(20),
          //   titleTextStyle: TextStyle(
          //     color: Colors.red,
          //     fontSize: 40,
          //     fontWeight: FontWeight.bold,
          //   ),
          //   acceptIconColor: Colors.black,
          //   declineIconColor: Colors.black,
          //   titleColor: Colors.red,
          //   declineButtonColor: Colors.yellow,
          //   subtitleColor: Colors.black,
          //   subtitleTextStyle: TextStyle(
          //     color: Colors.red,
          //     fontSize: 40,
          //     fontWeight: FontWeight.bold,
          //   ),
          // ),
          CometChatCallButtonsStyle(
            videoCallIconColor: Colors.red,
            voiceCallIconColor: Colors.red,
          )
        ]
      ),
      home: Login(
        key: CallNavigationContext.navigatorKey,
      ),
    );
  }
}
