import 'package:master_app/message_composer/message_composer_module.dart';
import 'package:master_app/message_header/message_header_module.dart';
import 'package:master_app/message_information/message_information_module.dart';
import 'package:master_app/message_list/message_list_module.dart';
import 'package:flutter/material.dart';
import 'package:master_app/messages.dart';
import 'package:master_app/utils/module_card.dart';

class MessagesDashboard extends StatelessWidget {
  const MessagesDashboard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 2, 10, 2),
                child: Row(
                  children: [
                    IconButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      icon: const Icon(
                        Icons.arrow_back_ios_new_rounded,
                        color: Colors.black,
                      ),
                    ),
                    const Text(
                      "Messages",
                      style:
                          TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              const MessageHeaderModule(),
              const MessageListModule(),
              const MessageComposerModule(),
              const MessageInformationModule(),
    ModuleCard(
    leading: Image.asset(
    'assets/icons/info.png',
    height: 48,
    width: 48,
    ),
    title: "Messages",
    description:
    "Messages sample component is a combination of CometChatMessageHeader, CometChatMessageList, and CometChatMessageComposer. This component is used to display the header, list of messages, and message composer in a single view.",
    onTap: () {
    Navigator.push(
    context,
    MaterialPageRoute(
    builder: (context) =>
    Scaffold(
    body: Center(
    child: MessagesSample(),
    ),
    ),
    ),
    );

    })
            ],
          ),
        ),
      ),
    );
  }
}
