import 'package:get/get.dart';

// Singleton Controller Class
class CallStateController extends GetxController {
  // Private constructor for singleton
  CallStateController._();

  // Singleton instance
  static final CallStateController instance = CallStateController._();

  // Observable variable to store the state of the ongoing call
  var isActiveCall = false.obs;

  // Observable variable to store the state of the incoming call
  var isActiveIncomingCall = false.obs;

  // Observable variable to store the state of the outgoing call
  var isActiveOutgoingCall = false.obs;

  // Method to set the value of the active call
  void setActiveCallValue(bool value) {
    isActiveCall.value = value;
  }

  // Method to set the value of the incoming call
  void setActiveIncomingValue(bool value) {
    isActiveIncomingCall.value = value;
  }

  // Method to set the value of the outgoing call
  void setActiveOutgoingValue(bool value) {
    isActiveOutgoingCall.value = value;
  }
}
