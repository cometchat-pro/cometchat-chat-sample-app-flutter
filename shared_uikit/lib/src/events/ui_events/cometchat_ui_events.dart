import 'package:flutter/material.dart';
import 'package:cometchat_uikit_shared/cometchat_uikit_shared.dart';

class CometChatUIEvents {
  static Map<String, CometChatUIEventListener> uiListener = {};

  static addUiListener(
      String listenerId, CometChatUIEventListener listenerClass) {
    uiListener[listenerId] = listenerClass;
  }

  static removeUiListener(String listenerId) {
    uiListener.remove(listenerId);
  }

  static showPanel(Map<String, dynamic>? id, CustomUIPosition uiPosition,
      WidgetBuilder child) {
    uiListener.forEach((key, value) {
      value.showPanel(id, uiPosition, child);
    });
  }

  static hidePanel(Map<String, dynamic>? id, CustomUIPosition uiPosition) {
    uiListener.forEach((key, value) {
      value.hidePanel(id, uiPosition);
    });
  }

  static ccActiveChatChanged(Map<String, dynamic>? id, BaseMessage? lastMessage,
      User? user, Group? group, int unreadMessageCount) {
    uiListener.forEach((key, value) {
      value.ccActiveChatChanged(
          id, lastMessage, user, group, unreadMessageCount);
    });
  }

  static openChat(User? user, Group? group) {
    uiListener.forEach((key, value) {
      value.openChat(user, group);
    });
  }

  static ccComposeMessage(String text, MessageEditStatus status) {
    uiListener.forEach((key, value) {
      value.ccComposeMessage(text, status);
    });
  }

  static onAiFeatureTapped(User? user, Group? group) {
    uiListener.forEach((key, value) {
      value.onAiFeatureTapped(user, group);
    });
  }
}
