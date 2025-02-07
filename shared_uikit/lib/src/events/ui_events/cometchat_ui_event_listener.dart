import 'package:flutter/cupertino.dart';
import 'package:cometchat_uikit_shared/cometchat_uikit_shared.dart';

enum CustomUIPosition {
  composerTop,
  composerBottom,
  messageListTop,
  messageListBottom,
  composerPreview
}

///Listener class for [CometChatConversations]
mixin CometChatUIEventListener implements UIEventHandler {
  void showPanel(Map<String, dynamic>? id, CustomUIPosition uiPosition,
      WidgetBuilder child) {}
  void hidePanel(Map<String, dynamic>? id, CustomUIPosition uiPosition) {}

  void ccActiveChatChanged(Map<String, dynamic>? id, BaseMessage? lastMessage,
      User? user, Group? group, int unreadMessageCount) {}

  void openChat(User? user, Group? group) {}

  void ccComposeMessage(String text, MessageEditStatus status) {}

  void onAiFeatureTapped(User? user, Group? group) {}
}
