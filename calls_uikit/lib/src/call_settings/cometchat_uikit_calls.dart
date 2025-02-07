import 'package:cometchat_calls_uikit/cometchat_calls_uikit.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

///[CometChatUIKitCalls] is a class that initializes the CometChat Calls SDK. And contains methods to initiate a call, accept a call, reject a call, end a call
class CometChatUIKitCalls {
  ///[init] is the method to initialize the CometChat Calls SDK. It takes [appId] and [region] as input. And an optional [onSuccess] and [onError] callback.
  static init(
    String appId,
    String region, {
    dynamic Function(String)? onSuccess,
    dynamic Function(CometChatCallsException)? onError,
  }) {
    CallAppSettings callAppSettings = (CallAppSettingBuilder()
          ..appId = appId
          ..region = region)
        .build();

    CometChatCalls.init(callAppSettings, onSuccess: (String successMessage) {
      //execute custom onSuccess callback
      try {
        if (onSuccess != null) {
          onSuccess(successMessage);
        }
      } catch (e) {
        if (kDebugMode) {
          debugPrint('unable to execute custom onSuccess callback $e');
        }
      }
      debugPrint(
          "CometChatCalls initialization completed successfully  $successMessage");
    }, onError: (CometChatCallsException e) {
      //execute custom onError callback
      try {
        if (onError != null) {
          onError(e);
        }
      } catch (e) {
        if (kDebugMode) {
          debugPrint('unable to execute custom onError callback $e');
        }
      }
      debugPrint(
          "CometChatCalls initialization failed with exception: ${e.message}");
    });
  }

  ///[initiateCall] is the method to initiate a call. It takes [Call] as input. And an optional [onSuccess] and [onError] callback.
  static void initiateCall(Call call,
      {dynamic Function(Call)? onSuccess,
      dynamic Function(CometChatException)? onError}) {
    CometChat.initiateCall(call, onSuccess: (Call call) {
      //execute custom onSuccess callback
      try {
        if (onSuccess != null) {
          onSuccess(call);
        }
      } catch (e) {
        if (kDebugMode) {
          debugPrint('unable to execute custom onSuccess callback');
        }
      }
      if (kDebugMode) {
        debugPrint('call initiated successfully');
      }
    }, onError: (CometChatException e) {
      //execute custom onError callback
      try {
        if (onError != null) {
          onError(e);
        }
      } catch (e) {
        if (kDebugMode) {
          debugPrint('unable to execute custom onError callback');
        }
      }
      if (kDebugMode) {
        debugPrint(
            'call could not be initiated ${e.message} ${e.details} ${e.code}');
      }
    });
  }

  ///[acceptCall] is the method to accept a call. It takes [sessionId] as input. And an optional [onSuccess] and [onError] callback.
  static void acceptCall(String sessionId,
      {dynamic Function(Call)? onSuccess,
      dynamic Function(CometChatException)? onError}) {
    CometChat.acceptCall(sessionId, onSuccess: (Call call) {
//execute custom onSuccess callback
      try {
        if (onSuccess != null) {
          onSuccess(call);
        }
      } catch (e) {
        if (kDebugMode) {
          debugPrint('unable to execute custom onSuccess callback');
        }
      }
      if (kDebugMode) {
        debugPrint('call initiated successfully');
      }
    }, onError: (CometChatException e) {
//execute custom onError callback
      try {
        if (onError != null) {
          onError(e);
        }
      } catch (e) {
        if (kDebugMode) {
          debugPrint('unable to execute custom onError callback');
        }
      }
      if (kDebugMode) {
        debugPrint('call could not be initiated ${e.message}');
      }
    });
  }

  ///[rejectCall] is the method to reject or cancel a call. It takes [sessionId] and [status] as input. And an optional [onSuccess] and [onError] callback.
  static void rejectCall(String sessionId, String status,
      {dynamic Function(Call)? onSuccess,
      dynamic Function(CometChatException)? onError}) {
    CometChat.rejectCall(sessionId, status, onSuccess: (Call call) {
      //execute custom onSuccess callback
      try {
        if (onSuccess != null) {
          onSuccess(call);
        }
      } catch (e) {
        if (kDebugMode) {
          debugPrint('unable to execute custom onSuccess callback');
        }
      }
      if (kDebugMode) {
        debugPrint('call rejected successfully');
      }
    }, onError: (CometChatException e) {
      //execute custom onError callback
      try {
        if (onError != null) {
          onError(e);
        }
      } catch (e) {
        if (kDebugMode) {
          debugPrint('unable to execute custom onError callback: $e}');
        }
      }
      if (kDebugMode) {
        debugPrint('call could not be rejected ${e.message}');
      }
    });
  }

  ///[generateToken] is the method to generate a token. It takes [uid] and [role] as input. And an optional [onSuccess] and [onError] callback.
  static void generateToken(
    String sessionId,
    String userAuthToken, {
    dynamic Function(GenerateToken)? onSuccess,
    dynamic Function(CometChatCallsException)? onError,
  }) {
    CometChatCalls.generateToken(sessionId, userAuthToken,
        onSuccess: (GenerateToken generateToken) {
      //execute custom onSuccess callback
      try {
        if (onSuccess != null) {
          onSuccess(generateToken);
        }
      } catch (e) {
        if (kDebugMode) {
          debugPrint("unable to execute custom onSuccess callback");
        }
      }
      debugPrint("token was generated successfully: ${generateToken.token}");
    }, onError: (CometChatCallsException e) {
      //execute custom onError callback
      try {
        if (onError != null) {
          onError(e);
        }
      } catch (e) {
        if (kDebugMode) {
          debugPrint('unable to execute custom onError callback');
        }
      }
      if (kDebugMode) {
        debugPrint('token could not be generated: ${e.message}');
      }
    });
  }

  ///[startSession] is the method to start a call session. It takes [callToken] and [callSettings] as input. And an optional [onSuccess] and [onError] callback.
  static void startSession(
    String callToken,
    CallSettings callSettings, {
    dynamic Function(Widget?)? onSuccess,
    dynamic Function(CometChatCallsException)? onError,
  }) {
    CometChatCalls.startSession(callToken, callSettings,
        onSuccess: (Widget? callingWidget) {
      //execute custom onSuccess callback
      try {
        if (onSuccess != null) {
          onSuccess(callingWidget);
        }
      } catch (e) {
        if (kDebugMode) {
          debugPrint("unable to execute custom onSuccess callback");
        }
      }
      if (kDebugMode) {
        debugPrint("startCallSession was successful");
      }
    }, onError: (CometChatCallsException e) {
      //execute custom onError callback
      try {
        if (onError != null) {
          onError(e);
        }
      } catch (e) {
        if (kDebugMode) {
          debugPrint('unable to execute custom onError callback');
        }
      }
      if (kDebugMode) {
        debugPrint('startCallSession failed: ${e.message}');
      }
    });
  }

  ///[endSession] is the method to end a call session. It takes an optional [onSuccess] and [onError] callback.
  static void endSession(
      {dynamic Function(String)? onSuccess,
      dynamic Function(CometChatCallsException)? onError}) {
    CometChatCalls.endSession(onSuccess: (successMessage) {
      //execute custom onSuccess callback
      try {
        if (onSuccess != null) {
          onSuccess(successMessage);
        }
      } catch (e) {
        if (kDebugMode) {
          debugPrint("unable to execute custom onSuccess callback");
        }
      }
      debugPrint("session ended successfully");
    }, onError: (error) {
      //execute custom onError callback
      try {
        if (onError != null) {
          onError(error);
        }
      } catch (e) {
        if (kDebugMode) {
          debugPrint("unable to execute custom onError callback");
        }
      }
      debugPrint("session could not be ended: ${error.message}");
    });
  }

  static Future<String?> getUserAuthToken() async {
    return await CometChat.getUserAuthToken();
  }
}
