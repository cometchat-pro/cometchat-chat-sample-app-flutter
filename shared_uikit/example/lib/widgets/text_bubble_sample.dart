

import 'package:cometchat_uikit_shared/cometchat_uikit_shared.dart';
import 'package:flutter/material.dart';

class TextBubbleSample extends StatelessWidget {
  const TextBubbleSample({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
          appBar: AppBar(
            title: const Text('CometChatTextBubble'),
          ),
          body: SingleChildScrollView(

              child:Center(

                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CometChatMessageBubble(
                      alignment: BubbleAlignment.right,
                      // height: 400,
                      // width: 300,
                      contentView:
                       CometChatTextBubble(
                        alignment: BubbleAlignment.right,
                        text: "I’m really looking forward to catching up with you soon. There’s so much I can’t wait to share and discuss. See you soon, and until then, take care!",
                      ),
                      // statusInfoView: CometChatReceipt(status: ReceiptStatus.delivered),
                      // statusInfoView: CometChatDate(
                      //   date: DateTime.now(),
                      // ),
                    ),
                  ],
                ),
              )
          ),
        );
  }
}
