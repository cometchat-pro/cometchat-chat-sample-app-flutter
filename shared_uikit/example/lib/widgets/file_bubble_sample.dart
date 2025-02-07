

import 'package:cometchat_uikit_shared/cometchat_uikit_shared.dart';
import 'package:flutter/material.dart';

class FileBubbleSample extends StatelessWidget {
  const FileBubbleSample({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('CometChatFileBubble'),
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
                  CometChatFileBubble(
                    fileUrl: "https://www2.cs.uic.edu/~i101/SoundFiles/PinkPanther60.wav",
                    title: "File.wav",
                    subtitle:"15 Oct, 2024 • 200 KB • WAV",
                    alignment: BubbleAlignment.right,
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
