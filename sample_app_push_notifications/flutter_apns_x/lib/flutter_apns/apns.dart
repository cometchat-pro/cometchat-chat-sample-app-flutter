import 'dart:io';
import 'src/apns_connector.dart';
import 'src/connector.dart';
import 'src/firebase_connector.dart';

/// Creates either APNS or Firebase connector to manage the push notification registration.
PushConnector createPushConnector() {
  if (Platform.isIOS) {
    return ApnsPushConnector();
  } else {
    return FirebasePushConnector();
  }
}
