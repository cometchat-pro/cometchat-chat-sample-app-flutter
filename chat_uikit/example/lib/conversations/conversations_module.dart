import 'package:flutter/material.dart';
import 'package:master_app/messages.dart';
import 'package:master_app/utils/module_card.dart';
import 'package:cometchat_chat_uikit/cometchat_chat_uikit.dart';

class ConversationModule extends StatefulWidget {
  const ConversationModule({Key? key}) : super(key: key);

  @override
  State<ConversationModule> createState() => _ConversationModuleState();
}

class _ConversationModuleState extends State<ConversationModule>
    with CometChatUIEventListener {
  String conversationEventListenerId = "ConversationListener";

  late String _dateString;

  @override
  void initState() {
    _dateString = DateTime.now().millisecondsSinceEpoch.toString();

    conversationEventListenerId = "${_dateString}ConversationListener";

    CometChatUIEvents.addUiListener(
        _dateString + conversationEventListenerId, this);
    super.initState();
  }

  @override
  void dispose() {
    CometChatUIEvents.removeUiListener(
        _dateString + conversationEventListenerId);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ModuleCard(
      leading: Image.asset(
        'assets/icons/conversations.png',
        height: 48,
        width: 48,
      ),
      title: "Conversations",
      description:
          "Conversations module helps you to view list of conversations that the logged in user is part of. To learn more about this component, tap here.",
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => CometChatConversations(
              onItemTap: (conversation) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      User? user;
                      Group? group;
                      if (conversation.conversationWith is User) {
                        user = conversation.conversationWith as User;
                      } else {
                        group = conversation.conversationWith as Group;
                      }
                      return MessagesSample(
                        user: user,
                        group: group,
                      );
                    },
                  ),
                );
              },
            ),
          ),
        );
      },
    );
  }
}
