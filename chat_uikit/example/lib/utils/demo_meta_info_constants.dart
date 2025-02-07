import 'dart:io';

class DemoMetaInfoConstants {
  static String name = "cometchat_flutter_master_app";
  static String type = "sample-app";
  static String version = "1.0.13";
  static String bundle = Platform.isAndroid
      ? "com.cometchat.cometchat_flutter_master_app"
      : "com.cometchat.cometchatFlutterSampleApp";
  static String platform = "Flutter";
}
