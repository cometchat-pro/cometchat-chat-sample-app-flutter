import 'package:cometchat_uikit_shared/cometchat_uikit_shared.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
      themeMode: ThemeMode.system,
      theme: ThemeData(brightness: Brightness.light, extensions: [
        // CometChatTextBubbleStyle(
        //     backgroundColor: Colors.red,
        //   border: Border.all(color: Colors.blue, width: 2),
        // ),
        // CometChatVideoBubbleStyle(
        //     backgroundColor: Colors.green,
        //     border: Border.all(color: Colors.blue, width: 2),
        //   playIconColor: Colors.red,
        //   playIconBackgroundColor: Colors.blue
        //
        // ),
        // CometChatAudioBubbleStyle(
        //     backgroundColor: Colors.yellow,
        //     border: Border.all(color: Colors.blue, width: 2),
        //     playIconColor: Colors.red,
        //     playIconBackgroundColor: Colors.blue,
        // ),
        // FileBubbleStyle(
        //   border: Border.all(color: Colors.blue, width: 2),
        //   backgroundColor: Colors.pinkAccent.shade100,
        //   titleColor: Colors.red,
        //   subtitleColor: Colors.blue,
        //   downloadIconTint: Colors.red,
        //   subtitleTextStyle: TextStyle(
        //     color: Colors.red
        //   ),
        //   titleTextStyle: TextStyle(
        //     color: Colors.blue
        //   )
        // ),
        // CometChatImageBubbleStyle(
        //   backgroundColor: Colors.orange,
        //   border: Border.all(color: Colors.blue, width: 2),
        // ),
        // CometChatMessageBubbleStyle(
        //   backgroundColor: Colors.green,
        //   border: Border.all(color: Colors.pink, width: 2),
        // ),
      ]),
      darkTheme: ThemeData(brightness: Brightness.dark, extensions: []),
      home: MyApp()));
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // Define a boolean to track the theme mode
  bool isDarkMode = false;

  // Method to toggle the theme
  void _toggleTheme() {
    setState(() {
      isDarkMode = !isDarkMode;
      CometChatThemeMode.mode = isDarkMode ? ThemeMode.dark : ThemeMode.light;
    });
  }

  @override
  Widget build(BuildContext context) {
    final colorPalette = CometChatThemeHelper.getColorPalette(context);
    return MaterialApp(
      themeMode:
          isDarkMode ? ThemeMode.dark : ThemeMode.light, // Set the theme mode
      // You can pass the Avatar style in the dark theme and light theme below
      theme: ThemeData(
        brightness: Brightness.light,
        extensions: const [
          CometChatAttachmentOptionSheetStyle(iconColor: Colors.yellow),
        ],
      ),
      // darkTheme: ThemeData(
      //   brightness: Brightness.dark,
      //   extensions: const [
      //     CometChatAvatarStyle(
      //       placeHolderTextColor: Colors.black,
      //     ),
      //   ],
      // ),
      home: Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          backgroundColor: colorPalette.background2,
          title: Text(
            'Shared test',
            style: TextStyle(
              color: colorPalette.textPrimary,
            ),
          ),
          actions: [
            Switch(
              value: isDarkMode,
              onChanged: (value) {
                _toggleTheme();
              },
            ),
          ],
        ),
        body: Column(
          children: [
            Container(
              height: 600,
              child: CometChatAttachmentOptionSheet(
                style: CometChatAttachmentOptionSheetStyle(
                    border: Border.all(
                      color: Colors.blue,
                      width: 1,
                    ),
                    titleTextStyle: TextStyle(
                      color: Colors.yellow,
                    ),
                    iconColor: Colors.blue),
                actionItems: [
                  ActionItem(
                      id: "Munikiran",
                      title: "MK",
                      icon: Icon(Icons.face),
                      onItemClick: () {
                        print("Hello");
                      }),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

//   void openMessages({bool isUser = true}) async{
// User? user;
// Group? group;
//
// if(isUser){
//   user = User(uid: "superhero3", name: "Peter Parker", avatar: "https://w0.peakpx.com/wallpaper/922/880/HD-wallpaper-spiderman-8k-spiderman-superheroes.jpg");
//
// }else{
//   group = Group(guid: "supergroup", type: "public", name: "Avengers", icon: "https://w0.peakpx.com/wallpaper/55/926/HD-wallpaper-thanos-crown-infinity-war-marvel-movie.jpg");
// }
//     Navigator.push(
//       context,
//       MaterialPageRoute(builder: (context) => CometChatMessages(
//         user: user,
//         group: group,
//         messageComposerConfiguration: MessageComposerConfiguration(
//           textFormatters: [
//           CometChatMentionsFormatter(
//             visibleIn: MentionsVisibility.both
//           )
//           ]
//         ),
//       )),
//     );
//
//   }
}
