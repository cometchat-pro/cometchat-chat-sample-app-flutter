import 'package:cometchat_calls_uikit/cometchat_calls_uikit.dart';
import 'package:cometchat_calls_uikit_example/testing_overlay.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:cometchat_chat_uikit/cometchat_chat_uikit.dart';

import 'call_log_detail/cometchat_calllog_detail.dart';

class DashBoard extends StatefulWidget {
  const DashBoard({Key? key}) : super(key: key);

  @override
  State<DashBoard> createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard>
    with
        CometChatUserEventListener,
        CometChatMessageEventListener,
        CometChatGroupEventListener,
        CometChatConversationEventListener {
  late User? loggedInUser;

  // ValueNotifier<String?> initialText = ValueNotifier(null);

  @override
  void initState() {
    super.initState();
    initializeLoggedInUser();
  }

  List<CallLog> callLogsList = [];

  initializeLoggedInUser() async {
    loggedInUser = await CometChat.getLoggedInUser();
    userAuthToken = await CometChatUIKitCalls.getUserAuthToken();
    setState(() {});
  }

  RegExp messageShortcutPattern = RegExp(r'![a-zA-Z0-9]{1,}');

  @override
  void dispose() {
    // TODO: implement dispose
    CometChatUserEvents.removeUsersListener("dashboard_user_listener");
    CometChatGroupEvents.removeGroupsListener("group_listener");
    CometChatConversationEvents.removeConversationListListener(
        "dashboard_conversation_listener");
    CometChatMessageEvents.removeMessagesListener("dashboard_message_listener");

    super.dispose();
  }

  CometChatMessageComposerController? composerState;

  composerStateCallBack(CometChatMessageComposerController composerState) {
    this.composerState = composerState;
  }

  String? userAuthToken;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        await CometChatUIKit.logout(
            onSuccess: (String msg) {
              if (kDebugMode) {
                debugPrint("user logged out successfully");
              }
            },
            onError: (_) {});
        return true;
      },
      child: Scaffold(
        backgroundColor: cometChatTheme.palette.getBackground(),
        appBar: AppBar(
          backgroundColor: cometChatTheme.palette.getPrimary(),
          title: const Text("CometChatConversationsWithMessages"),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 16.0),
              child: GestureDetector(
                  onTap: () {
                    if (cometChatTheme.palette.mode == PaletteThemeModes.dark) {
                      cometChatTheme.palette =
                      const Palette(mode: PaletteThemeModes.light);
                    } else {
                      cometChatTheme.palette =
                      const Palette(mode: PaletteThemeModes.dark);
                    }

                    setState(() {});
                  },
                  child: cometChatTheme.palette.mode == PaletteThemeModes.dark
                      ? const Icon(Icons.light_mode)
                      : const Icon(Icons.dark_mode)),
            )
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Card(
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(6.18),
                      side: BorderSide(
                          color: Colors.blueGrey.shade800, width: 3)),
                  elevation: 0,
                  child: ListTile(
                      title: Text(
                        "Conversations",
                        style: TextStyle(
                            fontSize: 21,
                            fontWeight: FontWeight.w600,
                            color: cometChatTheme.palette.getAccent()),
                      ),
                      subtitle: Text(
                        'This will take you to CometChat Conversations',
                        style: TextStyle(
                            fontSize: 18,
                            color: cometChatTheme.palette.mode ==
                                PaletteThemeModes.dark
                                ? Colors.white.withOpacity(.8)
                                : Colors.grey.shade700),
                      ),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => CometChatConversations(
                              showBackButton: false,
                              onItemTap: (conversation) {
                                User? user;
                                Group? group;
                                if (conversation.conversationWith is User) {
                                  user = conversation.conversationWith as User;
                                } else {
                                  group =
                                  conversation.conversationWith as Group;
                                }
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) {
                                      return Scaffold(
                                        appBar: CometChatMessageHeader(
                                          user: user,
                                          group: group,
                                          appBarOptions:
                                              (user, group, context) {
                                            if (group != null) {
                                              return [
                                                IconButton(
                                                  onPressed: () {},
                                                  icon: Icon(
                                                    Icons.info_outline,
                                                  ),
                                                ),
                                              ];
                                            }
                                          },
                                        ),
                                        resizeToAvoidBottomInset:
                                        true, // Ensures layout adjusts when keyboard appears
                                        body: SingleChildScrollView(
                                          reverse: true,
                                          child: SizedBox(
                                            height: MediaQuery.of(context)
                                                .size
                                                .height,
                                            child: Column(
                                              children: [
                                                Expanded(
                                                  child: CometChatMessageList(
                                                    user: user,
                                                    group: group,
                                                    showAvatar: true,
                                                  ),
                                                ),
                                                CometChatMessageComposer(
                                                  user: user,
                                                  group: group,
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      );

                                      // return MyScrollTestWidget();
                                    },
                                  ),
                                );
                              },
                            ),
                          ),
                        );
                      })),
              Card(
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(6.18),
                      side: BorderSide(
                          color: Colors.blueGrey.shade800, width: 3)),
                  elevation: 0,
                  child: ListTile(
                      title: Text(
                        "Outgoing Call",
                        style: TextStyle(
                            fontSize: 21,
                            fontWeight: FontWeight.w600,
                            color: cometChatTheme.palette.getAccent()),
                      ),
                      subtitle: Text(
                        'This will take you to Outgoing Call component',
                        style: TextStyle(
                            fontSize: 18,
                            color: cometChatTheme.palette.mode ==
                                PaletteThemeModes.dark
                                ? Colors.white.withOpacity(.8)
                                : Colors.grey.shade700),
                      ),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => CometChatOutgoingCall(
                              user: User(
                                name: "Muni Kiran",
                                uid: "Muni",
                              ),
                              call: Call(
                                receiverUid: "receiverUid",
                                type: CallTypeConstants.audioCall,
                                receiverType: "user",
                              ),
                              // declineButtonIcon: Icon(Icons.add_a_photo),
                              // onDecline: (p0, call) {
                              //   Navigator.of(context).pop();
                              // },
                              // width: 400,
                              // height: 400,
                              // subtitle: Text("MMMMM"),
                              // style: CometChatOutgoingCallStyle(
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
                              //   iconColor: Colors.black,
                              //   titleColor: Colors.yellow,
                              //   declineButtonColor: Colors.yellow,
                              //   subtitleColor: Colors.black,
                              //   subtitleTextStyle: TextStyle(
                              //     color: Colors.red,
                              //     fontSize: 40,
                              //     fontWeight: FontWeight.bold,
                              //   ),
                              // ),
                            ),
                          ),
                        );
                      })),
              Card(
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(6.18),
                      side: BorderSide(
                          color: Colors.blueGrey.shade800, width: 3)),
                  elevation: 0,
                  child: ListTile(
                      title: Text(
                        "Incoming Call",
                        style: TextStyle(
                            fontSize: 21,
                            fontWeight: FontWeight.w600,
                            color: cometChatTheme.palette.getAccent()),
                      ),
                      subtitle: Text(
                        'This will take you to Incoming Call component',
                        style: TextStyle(
                            fontSize: 18,
                            color: cometChatTheme.palette.mode ==
                                PaletteThemeModes.dark
                                ? Colors.white.withOpacity(.8)
                                : Colors.grey.shade700),
                      ),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => CometChatIncomingCall(
                              user: User(
                                name: "Muni Kiran",
                                uid: "Muni",
                              ),
                              call: Call(
                                receiverUid: "receiverUid",
                                type: CallTypeConstants.audioCall,
                                receiverType: "user",
                              ),
                              onDecline: (p0, call) {
                                Navigator.of(context).pop();
                              },
                              onAccept: (p0, p1) {
                                Navigator.of(context).pop();
                              },
                              width: 400,
                              height: 400,
                              subtitle: Text("MMMMM"),
                              // style: CometChatIncomingCallStyle(
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
                            ),
                          ),
                        );
                      })),

              Card(
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(6.18),
                      side: BorderSide(
                          color: Colors.blueGrey.shade800, width: 3)),
                  elevation: 0,
                  child: ListTile(
                      title: Text(
                        "Call Buttons",
                        style: TextStyle(
                            fontSize: 21,
                            fontWeight: FontWeight.w600,
                            color: cometChatTheme.palette.getAccent()),
                      ),
                      subtitle: Text(
                        'This will take you to Call Buttons',
                        style: TextStyle(
                            fontSize: 18,
                            color: cometChatTheme.palette.mode ==
                                PaletteThemeModes.dark
                                ? Colors.white.withOpacity(.8)
                                : Colors.grey.shade700),
                      ),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Scaffold(
                              body: Center(
                                child: CometChatCallButtons(
                                  user: User(
                                    name: "MuniKiran",
                                    uid: "superhero2",
                                  ),
                                  // hideVideoCall: true,
                                  // hideVoiceCall: true,
                                  style:  CometChatCallButtonsStyle(
                                    videoCallIconColor: Colors.blue,
                                    voiceCallIconColor: Colors.blue,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        );
                      })),

              Card(
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(6.18),
                      side: BorderSide(
                          color: Colors.blueGrey.shade800, width: 3)),
                  elevation: 0,
                  child: ListTile(
                      title: Text(
                        "Over lay Widget ",
                        style: TextStyle(
                            fontSize: 21,
                            fontWeight: FontWeight.w600,
                            color: cometChatTheme.palette.getAccent()),
                      ),
                      subtitle: Text(
                        'This will take you to Overlay Widget',
                        style: TextStyle(
                            fontSize: 18,
                            color: cometChatTheme.palette.mode ==
                                PaletteThemeModes.dark
                                ? Colors.white.withOpacity(.8)
                                : Colors.grey.shade700),
                      ),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => HomeScreen(),
                          ),
                        );
                      })),
              Card(
                color: cometChatTheme.palette.mode == PaletteThemeModes.dark
                    ? cometChatTheme.palette.getAccent100()
                    : Colors.white,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(6.18),
                    side:
                    BorderSide(color: Colors.blueGrey.shade800, width: 3)),
                elevation: 0,
                child: ListTile(
                  title: Text(
                    "Call Logs With Detail",
                    style: TextStyle(
                        fontSize: 21,
                        fontWeight: FontWeight.w600,
                        color: cometChatTheme.palette.getAccent()),
                  ),
                  subtitle: Text(
                    '',
                    style: TextStyle(
                        fontSize: 18,
                        color: cometChatTheme.palette.mode ==
                            PaletteThemeModes.dark
                            ? Colors.white.withOpacity(.8)
                            : Colors.grey.shade700),
                  ),
                  onTap: () async {
                    // getCallLogs();
                    // await UIConstants.channel.invokeMethod(
                    //   "download",
                    //   {
                    //     // "fileUrl": "https://drive.google.com/file/d/1OKgVDWEHQrQzfhvisg6eIN5Q4cbSgkna/view",
                    //     "fileUrl": "https://drive.google.com/file/d/1qx0Q_nuV6c0We9hiDeX_9sdmR45gQevP/view?usp=sharing",
                    //   },
                    // );
                  },
                ),
              ),
              Card(
                color: cometChatTheme.palette.mode == PaletteThemeModes.dark
                    ? cometChatTheme.palette.getAccent100()
                    : Colors.white,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(6.18),
                    side:
                    BorderSide(color: Colors.blueGrey.shade800, width: 3)),
                elevation: 0,
                child: ListTile(
                  title: Text(
                    "Call Logs",
                    style: TextStyle(
                        fontSize: 21,
                        fontWeight: FontWeight.w600,
                        color: cometChatTheme.palette.getAccent()),
                  ),
                  subtitle: Text(
                    '',
                    style: TextStyle(
                        fontSize: 18,
                        color: cometChatTheme.palette.mode ==
                            PaletteThemeModes.dark
                            ? Colors.white.withOpacity(.8)
                            : Colors.grey.shade700),
                  ),
                  onTap: () {
                    // getCallLogs();
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CometChatCallLogs(
                          onItemClick: (callLog) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => CometchatCallLogDetail(
                                  callLog: callLog,
                                ),
                              ),
                            );
                          },
                        ),
                        // CallLogList(),
                      ),
                    );
                  },
                ),
              ),
              Card(
                color: cometChatTheme.palette.mode == PaletteThemeModes.dark
                    ? cometChatTheme.palette.getAccent100()
                    : Colors.white,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(6.18),
                    side:
                    BorderSide(color: Colors.blueGrey.shade800, width: 3)),
                elevation: 0,
                child: ListTile(
                  title: Text(
                    "Live reaction issue with users",
                    style: TextStyle(
                        fontSize: 21,
                        fontWeight: FontWeight.w600,
                        color: cometChatTheme.palette.getAccent()),
                  ),
                  subtitle: Text(
                    'this will take you to UsersWithMessages component\n'
                        'you will need 2 devices to test this\n'
                        'open messages component for any particular user\n'
                        'try sending live reactions and another device login using the user the live reaction is being sent to and open the messages component of the sender and see if the live reaction is received only in that conversation only and not in the messages component for some other user\n',
                    style: TextStyle(
                        fontSize: 18,
                        color: cometChatTheme.palette.mode ==
                            PaletteThemeModes.dark
                            ? Colors.white.withOpacity(.8)
                            : Colors.grey.shade700),
                  ),
                  onTap: () {},
                ),
              ),

              Card(
                color: cometChatTheme.palette.mode == PaletteThemeModes.dark
                    ? cometChatTheme.palette.getAccent100()
                    : Colors.white,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(6.18),
                    side:
                    BorderSide(color: Colors.blueGrey.shade800, width: 3)),
                elevation: 0,
                child: ListTile(
                  title: Text(
                    "DIY Test",
                    style: TextStyle(
                        fontSize: 21,
                        fontWeight: FontWeight.w600,
                        color: cometChatTheme.palette.getAccent()),
                  ),
                  subtitle: Text(
                    'Start the below extensions extensions by simply clicking on them once and then open this tab',
                    style: TextStyle(
                        fontSize: 18,
                        color: cometChatTheme.palette.mode ==
                            PaletteThemeModes.dark
                            ? Colors.white.withOpacity(.8)
                            : Colors.grey.shade700),
                  ),
                  onTap: () {
                    List<CometChatMessageTemplate> templateList =
                    ChatConfigurator.getDataSource()
                        .getAllMessageTemplates();

//Looping through template list to get text template
                    for (int i = 0; i < templateList.length; i++) {
                      if (templateList[i].category ==
                          MessageCategoryConstants.message) {
                        //Alter option for text message template and add a star option
                        // List<CometChatMessageOption> optionList;

                        // //Alter template's option property ,  template's option property is a call back
                        // templateList[i].options = (User loggedInUser,
                        //     BaseMessage messageObject,
                        //     BuildContext context,
                        //     Group? group) {
                        //   List<CometChatMessageOption> optionList;
                        //
                        //   //fetch the default options for the respective message
                        //   optionList = ChatConfigurator.getDataSource()
                        //       .getMessageOptions(
                        //           loggedInUser, messageObject, context, group);
                        //
                        //   //add star option to already fetched option list
                        //   optionList.add(CometChatMessageOption(
                        //       id: 'star',
                        //       title: "Star",
                        //       icon: 'assets/star.png',
                        //       onClick: (BaseMessage message,
                        //           CometChatMessageListControllerProtocol
                        //               state) {
                        //         message.metadata ??= {"": ""};
                        //         message.metadata?.addAll({
                        //           'starred': 'true'
                        //         }); //edited meta data to be visible in UI
                        //
                        //         //call to cometchat's edit message , on sucess of which we will trigger UI update
                        //         CometChat.editMessage(message,
                        //             onSuccess: (BaseMessage returnedMessage) {
                        //           //event to trigger view update for that perticalar message, This is a global trigger and be triggered from anywhere in the application
                        //           CometChatMessageEvents.ccMessageEdited(
                        //               returnedMessage,
                        //               MessageEditStatus
                        //                   .success); //trigger internal event for message update
                        //         }, onError: (_) {
                        //           if (kDebugMode) {
                        //             print("messageEdited error");
                        //           }
                        //         });
                        //       }));
                        //
                        //   //Returned option list will be visible on long press of respective tyep & category message
                        //   return optionList;
                        // }; //addition of option end

                        //updating text message content view with condition on metadata
                        //Update content view according to message type,
                        templateList[i].contentView = (BaseMessage message,
                            BuildContext context, BubbleAlignment alignment,
                            {AdditionalConfigurations?
                            additionalConfigurations}) {
                          Widget contentView = const Text("No Match");

                          //get the content view for each message type

                          if (templateList[i].type ==
                              MessageTypeConstants.text) {
                            //get content view for text message
                            contentView = ChatConfigurator.getDataSource()
                                .getTextMessageContentView(
                                message as TextMessage,
                                context,
                                alignment,
                                cometChatTheme);
                          } else if (templateList[i].type ==
                              MessageTypeConstants.image) {
                            //get content view for image message
                            contentView = ChatConfigurator.getDataSource()
                                .getImageMessageContentView(
                                message as MediaMessage,
                                context,
                                alignment,
                                cometChatTheme);
                          } else if (templateList[i].type ==
                              MessageTypeConstants.video) {
                            //get content view for video message
                            contentView = ChatConfigurator.getDataSource()
                                .getVideoMessageContentView(
                                message as MediaMessage,
                                context,
                                alignment,
                                cometChatTheme);
                          } else if (templateList[i].type ==
                              MessageTypeConstants.audio) {
                            //get content view for audio message
                            contentView = ChatConfigurator.getDataSource()
                                .getAudioMessageContentView(
                              message as MediaMessage,
                              context,
                              alignment,
                            );
                          } else if (templateList[i].type ==
                              MessageTypeConstants.file) {
                            //get content view for file message
                            contentView = ChatConfigurator.getDataSource()
                                .getFileMessageContentView(
                              message as MediaMessage,
                              context,
                              alignment,
                            );
                          }

                          //return view with orignal content view and star mark
                          return Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              contentView,
                              if (message.metadata?['starred'] == "true")
                                const Icon(
                                  Icons.star_border,
                                  color: Colors.black45,
                                )
                            ],
                          );
                        }; //content view update end
                      }
                    }
                  },
                ),
              ),
              Card(
                color: cometChatTheme.palette.mode == PaletteThemeModes.dark
                    ? cometChatTheme.palette.getAccent100()
                    : Colors.white,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(6.18),
                    side:
                    BorderSide(color: Colors.blueGrey.shade800, width: 3)),
                elevation: 0,
                child: ListTile(
                  title: Text(
                    "Custom message test",
                    style: TextStyle(
                        fontSize: 21,
                        fontWeight: FontWeight.w600,
                        color: cometChatTheme.palette.getAccent()),
                  ),
                  subtitle: Text(
                    'Start the below extensions extensions by simply clicking on them once and then open this tab',
                    style: TextStyle(
                        fontSize: 18,
                        color: cometChatTheme.palette.mode ==
                            PaletteThemeModes.dark
                            ? Colors.white.withOpacity(.8)
                            : Colors.grey.shade700),
                  ),
                  onTap: () {},
                ),
              ),
              //
              Card(
                  color: cometChatTheme.palette.mode == PaletteThemeModes.dark
                      ? cometChatTheme.palette.getAccent100()
                      : Colors.white,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(6.18),
                      side: BorderSide(
                          color: Colors.blueGrey.shade800, width: 3)),
                  elevation: 0,
                  child: ListTile(
                      title: Text(
                        "Reinitiate Extensions",
                        style: TextStyle(
                            fontSize: 21,
                            fontWeight: FontWeight.w600,
                            color: cometChatTheme.palette.getAccent()),
                      ),
                      subtitle: Text(
                        'This will disable all the extensions',
                        style: TextStyle(
                            fontSize: 18,
                            color: cometChatTheme.palette.mode ==
                                PaletteThemeModes.dark
                                ? Colors.white.withOpacity(.8)
                                : Colors.grey.shade700),
                      ),
                      onTap: () {}))
            ],
          ),
        ),
      ),
    );
  }
}
