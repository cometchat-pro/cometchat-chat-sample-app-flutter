import 'dart:io';

class DemoMetaInfoConstants {
  static String name = "sample_app";
  static String type = "sample-app";
  static String version = "1.0.0";
  static String bundle = Platform.isAndroid
      ? "com.cometchat.sampleapp.flutter.android"
      : "com.cometchat.sampleapp.flutter.ios";
  static String platform = "Flutter";
}
