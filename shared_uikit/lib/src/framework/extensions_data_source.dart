import 'package:cometchat_uikit_shared/cometchat_uikit_shared.dart';
import 'package:flutter/foundation.dart';

///Protocol class every Extension enabler should extend,
abstract class ExtensionsDataSource {
  ///Method to populate data source
  void enable(
      {Function(bool success)? onSuccess,
      Function(CometChatException exception)? onError}) {
    CometChat.isExtensionEnabled(getExtensionId(), onSuccess: (bool success) {
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

  ///[addExtension] method to add extension
  void addExtension();

  ///[getExtensionId] returns the id of the extension
  String getExtensionId();
}
