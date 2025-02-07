import 'package:flutter/material.dart';
import 'package:cometchat_calls_uikit/cometchat_calls_uikit.dart';
import 'package:cometchat_chat_uikit/cometchat_chat_uikit.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      localizationsDelegates: [
        Translations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate
      ],
      supportedLocales: [
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
      home: Home(),
    );
  }
}

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final String appId = "APP_ID"; //Replace with your app id
  static const String authKey = "AUTH_KEY"; //Replace with your auth key";
  static const String region = "REGION"; ////Replace with your Region code ";

  bool isLoading = true;

  @override
  void initState() {
    super.initState();

    initializeCometChat();
  }

  initializeCometChat() async {
    //CometChat SDk should be initialized at the start of application. No need to initialize it again
    UIKitSettings uiKitSettings = (UIKitSettingsBuilder()
          ..subscriptionType = CometChatSubscriptionType.allUsers
          ..region = region
          ..autoEstablishSocketConnection = true
          ..appId = appId
          ..authKey = authKey
          ..callingExtension =
              CometChatCallingExtension() // a CometChatCallingExtension must be passed while initializing the UIKit if you want to enable Calling feature in your app.
        )
        .build();

    CometChatUIKit.init(
        uiKitSettings: uiKitSettings,
        onSuccess: (String successMessage) {
          login();
        },
        onError: (CometChatException error) {
          // "Initialization failed with exception: ${error.message}";
        });
  }

  login() async {
    String userId = "superhero1";
    await CometChatUIKit.login(userId, onSuccess: (User loggedInUser) {
      debugPrint("Login Successful : $loggedInUser");
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => CometChatConversations()));
    }, onError: (CometChatException e) {
      debugPrint("Login failed with exception:  ${e.message}");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: CallNavigationContext.navigatorKey,
      body: const Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
