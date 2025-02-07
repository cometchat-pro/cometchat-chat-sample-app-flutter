import 'package:cometchat_chat_uikit/cometchat_chat_uikit.dart';
import 'package:flutter/material.dart';

// class AppConstants {
//   static const String appId = "24050270d836e79c";
//   static const String authKey = "8be05055ec19ae53c3d05dd2d4342a6e059c03d7";
//   static const String region = "us";
// }
//
// class AppConstants {
//   static const String appId = "239314a25d5dac5e";
//   static const String authKey = "4c2a8cf0afcbe7d1706bcd333863e1613645596d";
//   static const String region = "us";
// }

class AppConstants {
  static const String appId = "2630589d6e70a91f";
  static const String authKey = "63689bcdd8e849c98d1a35ee777dd8ce148852c1";
  static const String region = "in";
}


// class AppConstants {
//   static const String appId = "2557282266f46056";
//   static const String authKey = "58b03b7a8ebe6d1eb1e653c4f1a6c3b7bcc9ff00";
//   static const String region = "us";
// }

bool isDarkMode = false;

// Method to toggle the theme
void toggleTheme() {
    CometChatThemeMode.mode = isDarkMode ? ThemeMode.dark : ThemeMode.light;
}