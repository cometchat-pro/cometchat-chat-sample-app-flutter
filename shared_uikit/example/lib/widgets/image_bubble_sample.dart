

import 'package:cometchat_uikit_shared/cometchat_uikit_shared.dart';
import 'package:flutter/material.dart';

class ImageBubbleSample extends StatelessWidget {
  const ImageBubbleSample({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('CometChatImageBubble'),
      ),
      body: SingleChildScrollView(

          child:Center(
            // child: CometChatTextBubble(
            //   alignment: BubbleAlignment.right,
            //   width: 216,
            //   text: "I’m really looking forward to catching up with you soon. There’s so much I can’t wait to share and discuss. See you soon, and until then, take care!",
            // ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CometChatMessageBubble(
                  alignment: BubbleAlignment.right,
                  contentView:
                  CometChatImageBubble(
                   imageUrl: "https://images.unsplash.com/photo-1724190500687-52df2556aabf?q=80&w=2075&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
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
