import 'package:cometchat_uikit_shared/cometchat_uikit_shared.dart';
import 'package:flutter/foundation.dart';

abstract class AIExtension extends ExtensionsDataSource {
  @override
  void enable(
      {Function(bool success)? onSuccess,
      Function(CometChatException exception)? onError}) {
    CometChat.isAIFeatureEnabled(getExtensionId(), onSuccess: (bool success) {
      if (kDebugMode) {
        print("enabling extension id ${getExtensionId()} status $success");
      }

      if (success) {
        addExtension();
      }
      if (onSuccess != null) {
        onSuccess(success);
      }
    }, onError: (CometChatException exception) {
      if (onError != null) {
        onError(exception);
      }
      if (kDebugMode) {
        debugPrint(
            "Exception occurred while enabling ${getExtensionId()} extension: ${exception.details}");
      }
    });
  }

  @override
  void addExtension() {}
}
