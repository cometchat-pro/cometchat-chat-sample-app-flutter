
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_apns_x/flutter_apns/flutter_apns_x.dart';
import 'storage.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await storage.setup();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final ApnsPushConnectorOnly connector = ApnsPushConnectorOnly();
  final _messengerKey = GlobalKey<ScaffoldMessengerState>();
  final mySnackbar = SnackBar(
    content: Text("the token was added to the clipboard"),
    duration: Duration(seconds: 3),
  );
  String _token = "";

  Future<void> _register() async {
    final connector = this.connector;
    connector.configureApns(
      onLaunch: (data) => onPush('onResume', data.payload.values.single),
      onResume: (data) => onPush('onResume', data.payload.values.single),
      onMessage: (data) => onPush('onMessage', data.payload.values.single,),
      onBackgroundMessage: (data) =>
          onPush('onBackgroundMessage', data.payload.values.single,),
    );
    connector.token.addListener(() {
      print('Token ${connector.token.value}');
    });

    connector.requestNotificationPermissions();

    connector.shouldPresent = (x) async {
      final remote = RemoteMessage.fromMap(x.payload);
      return remote.category == 'MEETING_INVITATION';
    };

    connector.setNotificationCategories([
      UNNotificationCategory(
        identifier: 'MEETING_INVITATION',
        actions: [
          UNNotificationAction(
            identifier: 'ACCEPT_ACTION',
            title: 'Accept',
            options: UNNotificationActionOptions.values,
          ),
          UNNotificationAction(
            identifier: 'DECLINE_ACTION',
            title: 'Decline',
            options: [],
          ),
        ],
        intentIdentifiers: [],
        options: UNNotificationCategoryOptions.values,
      ),
    ]);
  }

  @override
  void initState() {
    storage.append('restart');
    _register();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      scaffoldMessengerKey: _messengerKey,
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Column(
          children: [
            Expanded(
                flex: 2,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      'Token:',
                      style: TextStyle(fontSize: 20),
                    ),
                    ValueListenableBuilder(
                      valueListenable: connector.token,
                      builder: (context, dynamic data, __) {
                        if (data == null) {
                          _token = "";
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: SelectableText(
                                "Status: Currently unregistered"),
                          );
                        } else {
                          _token = data;
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: SelectableText('$_token'),
                          );
                        }
                      },
                    ),
                    TextButton.icon(
                        onPressed: () {
                          Clipboard.setData(ClipboardData(text: _token))
                              .then((value) {
                            _messengerKey.currentState
                                ?.showSnackBar(mySnackbar);
                          });
                        },
                        icon: Icon(Icons.content_paste),
                        label: Text("Add token to clipboard")),
                    ValueListenableBuilder(
                        valueListenable: connector.isDisabledByUser,
                        builder: (context, dynamic data, __) {
                          if (data == null) {
                            return Text("Push notifications are not defined");
                          } else {
                            return TextButton.icon(
                                onPressed: () {
                                  connector.requestNotificationPermissions();
                                },
                                icon: Icon(Icons.replay_outlined),
                                label: Text(data
                                    ? "The push notifications are rejected \n please enable them in the settings"
                                    : "Push notifications are authorized"));
                          }
                        }),
                    ElevatedButton.icon(
                      icon: Icon(Icons.app_registration),
                      label: Text('Reset token'),
                      onPressed: () {
                        connector.unregister().then((_) => _register());
                      },
                    ),
                  ],
                )),
            Expanded(
              child: AnimatedBuilder(
                animation: storage,
                builder: (context, _) {
                  return Container(
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(border: Border.all()),
                      child:
                          SingleChildScrollView(child: Text(storage.content)));
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}

Future<dynamic> onPush(String name, RemoteMessage payload) {
  storage.append('$name: ${payload.notification?.title}');

  final action = UNNotificationAction.getIdentifier(payload.data);

  if (action != null && action != UNNotificationAction.defaultIdentifier) {
    storage.append('Action: $action');
  }

  return Future.value(true);
}