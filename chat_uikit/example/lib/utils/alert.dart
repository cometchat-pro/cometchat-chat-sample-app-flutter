import 'package:cometchat_calls_uikit/cometchat_calls_uikit.dart';
import 'package:flutter/material.dart';

class Alert {
  static showLoadingIndicatorDialog(BuildContext context) {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          final colorPalette = CometChatThemeHelper.getColorPalette(context);
          return Dialog(
            insetPadding: const EdgeInsets.symmetric(horizontal: 20),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            elevation: 0,
            backgroundColor: Colors.transparent,
            child: Container(
              height: 220,
              width: 100,
              decoration: BoxDecoration(
                shape: BoxShape.rectangle,
                color: colorPalette.background1,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  CircleAvatar(
                    backgroundColor: Colors.transparent,
                    radius: 45,
                    child: Image.asset("assets/cometchat_logo.png"),
                  ),
                  Center(
                    child: CircularProgressIndicator(
                      color: colorPalette.textPrimary,
                    ),
                  )
                ],
              ),
            ),
          );
        });
  }
}
