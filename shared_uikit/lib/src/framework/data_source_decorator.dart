import 'package:flutter/material.dart';
import '../../../cometchat_uikit_shared.dart';

///[DataSourceDecorator] should be extended when creating any extension
abstract class DataSourceDecorator implements DataSource {
  DataSource dataSource;

  DataSourceDecorator(this.dataSource);

  @override
  List<CometChatMessageOption> getAudioMessageOptions(
      User loggedInUser,
      BaseMessage messageObject,
      BuildContext context,
      Group? group,
      AdditionalConfigurations? additionalConfigurations) {
    return dataSource.getAudioMessageOptions(
        loggedInUser, messageObject, context, group, additionalConfigurations);
  }

  @override
  Widget getAuxiliaryOptions(User? user, Group? group, BuildContext context,
      Map<String, dynamic>? id, Color? color) {
    return dataSource.getAuxiliaryOptions(user, group, context, id, color);
  }

  @override
  Widget getBottomView(
      BaseMessage message, BuildContext context, BubbleAlignment alignment) {
    return dataSource.getBottomView(message, context, alignment);
  }

  @override
  List<CometChatMessageOption> getCommonOptions(
      User loggedInUser,
      BaseMessage messageObject,
      BuildContext context,
      Group? group,
      AdditionalConfigurations? additionalConfigurations) {
    return dataSource.getCommonOptions(
        loggedInUser, messageObject, context, group, additionalConfigurations);
  }

  @override
  List<CometChatMessageComposerAction> getAttachmentOptions(
    BuildContext context,
    Map<String, dynamic>? id,
    AdditionalConfigurations? additionalConfigurations,
  ) {
    return dataSource.getAttachmentOptions(
      context,
      id,
      additionalConfigurations,
    );
  }

  @override
  CometChatMessageTemplate getAudioMessageTemplate() {
    return dataSource.getAudioMessageTemplate();
  }

  @override
  CometChatMessageTemplate getFileMessageTemplate(CometChatTheme theme) {
    return dataSource.getFileMessageTemplate(theme);
  }

  @override
  CometChatMessageTemplate getGroupActionTemplate() {
    return dataSource.getGroupActionTemplate();
  }

  @override
  CometChatMessageTemplate getImageMessageTemplate(CometChatTheme theme) {
    return dataSource.getImageMessageTemplate(theme);
  }

  @override
  List<String> getAllMessageCategories() {
    return dataSource.getAllMessageCategories();
  }

  @override
  List<CometChatMessageTemplate> getAllMessageTemplates(
      {CometChatTheme? theme}) {
    return dataSource.getAllMessageTemplates(theme: theme);
  }

  @override
  List<String> getAllMessageTypes() {
    return dataSource.getAllMessageTypes();
  }

  @override
  CometChatMessageTemplate getVideoMessageTemplate(CometChatTheme theme) {
    return dataSource.getVideoMessageTemplate(theme);
  }

  @override
  List<CometChatMessageOption> getFileMessageOptions(
      User loggedInUser,
      BaseMessage messageObject,
      BuildContext context,
      Group? group,
      AdditionalConfigurations? additionalConfigurations) {
    return dataSource.getFileMessageOptions(
        loggedInUser, messageObject, context, group, additionalConfigurations);
  }

  @override
  List<CometChatMessageOption> getImageMessageOptions(
      User loggedInUser,
      BaseMessage messageObject,
      BuildContext context,
      Group? group,
      AdditionalConfigurations? additionalConfigurations) {
    return dataSource.getImageMessageOptions(
        loggedInUser, messageObject, context, group, additionalConfigurations);
  }

  @override
  List<CometChatMessageOption> getMessageOptions(
      User loggedInUser,
      BaseMessage messageObject,
      BuildContext context,
      Group? group,
      AdditionalConfigurations? additionalConfigurations) {
    return dataSource.getMessageOptions(
        loggedInUser, messageObject, context, group, additionalConfigurations);
  }

  @override
  CometChatMessageTemplate? getMessageTemplate(
      {required String messageType,
      required String messageCategory,
      CometChatTheme? theme}) {
    return dataSource.getMessageTemplate(
        messageType: messageType, messageCategory: messageCategory);
  }

  @override
  String getMessageTypeToSubtitle(String messageType, BuildContext context) {
    return dataSource.getMessageTypeToSubtitle(messageType, context);
  }

  @override
  CometChatMessageTemplate getTextMessageTemplate(CometChatTheme theme) {
    return dataSource.getTextMessageTemplate(theme);
  }

  @override
  Widget getTextMessageContentView(TextMessage message, BuildContext context,
      BubbleAlignment alignment, CometChatTheme theme,
      {AdditionalConfigurations? additionalConfigurations}) {
    return dataSource.getTextMessageContentView(
        message, context, alignment, theme,
        additionalConfigurations: additionalConfigurations);
  }

  @override
  List<CometChatMessageOption> getTextMessageOptions(
      User loggedInUser,
      BaseMessage messageObject,
      BuildContext context,
      Group? group,
      AdditionalConfigurations? additionalConfigurations) {
    return dataSource.getTextMessageOptions(
        loggedInUser, messageObject, context, group, additionalConfigurations);
  }

  @override
  List<CometChatMessageOption> getVideoMessageOptions(
      User loggedInUser,
      BaseMessage messageObject,
      BuildContext context,
      Group? group,
      AdditionalConfigurations? additionalConfigurations) {
    return dataSource.getVideoMessageOptions(
        loggedInUser, messageObject, context, group, additionalConfigurations);
  }

  @override
  Widget getAudioMessageContentView(
      MediaMessage message, BuildContext context, BubbleAlignment alignment,
      {AdditionalConfigurations? additionalConfigurations}) {
    return dataSource.getAudioMessageContentView(message, context, alignment,
        additionalConfigurations: additionalConfigurations);
  }

  @override
  Widget getFileMessageContentView(
      MediaMessage message, BuildContext context, BubbleAlignment alignment,
      {AdditionalConfigurations? additionalConfigurations}) {
    return dataSource.getFileMessageContentView(message, context, alignment,
        additionalConfigurations: additionalConfigurations);
  }

  @override
  Widget getImageMessageContentView(MediaMessage message, BuildContext context,
      BubbleAlignment alignment, CometChatTheme theme,
      {AdditionalConfigurations? additionalConfigurations}) {
    return dataSource.getImageMessageContentView(
        message, context, alignment, theme,
        additionalConfigurations: additionalConfigurations);
  }

  @override
  Widget getVideoMessageContentView(MediaMessage message, BuildContext context,
      BubbleAlignment alignment, CometChatTheme theme,
      {AdditionalConfigurations? additionalConfigurations}) {
    return dataSource.getVideoMessageContentView(
        message, context, alignment, theme,
        additionalConfigurations: additionalConfigurations);
  }

  @override
  Widget getDeleteMessageBubble(
      BaseMessage messageObject, BuildContext context, CometChatDeletedBubbleStyle? style) {
    return dataSource.getDeleteMessageBubble(messageObject, context, style);
  }

  @override
  Widget getVideoMessageBubble(
      String? videoUrl,
      String? thumbnailUrl,
      MediaMessage message,
      Function()? onClick,
      BuildContext context,
      CometChatTheme theme,
      CometChatVideoBubbleStyle? style) {
    return dataSource.getVideoMessageBubble(
        videoUrl, thumbnailUrl, message, onClick, context, theme, style);
  }

  @override
  Widget getTextMessageBubble(
      String messageText,
      TextMessage message,
      BuildContext context,
      BubbleAlignment alignment,
      CometChatTheme theme,
      CometChatTextBubbleStyle? style,
      List<CometChatTextFormatter>? formatters) {
    return dataSource.getTextMessageBubble(
        messageText, message, context, alignment, theme, style, formatters);
  }

  @override
  Widget getImageMessageBubble(
      String? imageUrl,
      String? placeholderImage,
      String? caption,
      CometChatImageBubbleStyle? style,
      MediaMessage message,
      Function()? onClick,
      BuildContext context,
      CometChatTheme theme) {
    return dataSource.getImageMessageBubble(imageUrl, placeholderImage, caption,
        style, message, onClick, context, theme);
  }

  @override
  Widget getAudioMessageBubble(
      String? audioUrl,
      String? title,
      CometChatAudioBubbleStyle? style,
      MediaMessage message,
      BuildContext context,
      BubbleAlignment alignment) {
    return dataSource.getAudioMessageBubble(
        audioUrl, title, style, message, context, alignment);
  }

  @override
  Widget getFileMessageBubble(
      String? fileUrl,
      String? fileMimeType,
      String? title,
      int? id,
      CometChatFileBubbleStyle? style,
      MediaMessage message,
      BubbleAlignment alignment) {
    return dataSource.getFileMessageBubble(
        fileUrl, fileMimeType, title, id, style, message, alignment);
  }

  @override
  String getLastConversationMessage(
      Conversation conversation, BuildContext context) {
    return dataSource.getLastConversationMessage(conversation, context);
  }

  @override
  Widget getLastConversationWidget(
    Conversation conversation,
    BuildContext context,
    Color? iconColor,
  ) {
    return dataSource.getLastConversationWidget(
      conversation,
      context,
      iconColor,
    );
  }

  ///override this to change the widget shown for subtitle in conversations
  @override
  Widget getConversationSubtitle(Conversation conversation,
      BuildContext context, TextStyle? subtitleStyle, Color? iconColor,
      {AdditionalConfigurations? additionalConfigurations}) {
    return dataSource.getConversationSubtitle(
        conversation, context, subtitleStyle, iconColor,
        additionalConfigurations: additionalConfigurations);
  }

  @override
  Widget? getAuxiliaryHeaderMenu(
      BuildContext context, User? user, Group? group, AdditionalConfigurations? additionalConfigurations) {
    return dataSource.getAuxiliaryHeaderMenu(context, user, group, additionalConfigurations);
  }

  @override
  Widget getFormMessageBubble({
    String? title,
    FormBubbleStyle? formBubbleStyle,
    required FormMessage message,
    required CometChatTheme theme,
  }) {
    return dataSource.getFormMessageBubble(
        title: title,
        formBubbleStyle: formBubbleStyle,
        message: message,
        theme: theme);
  }

  @override
  Widget getFormMessageContentView(FormMessage message, BuildContext context,
      BubbleAlignment alignment, CometChatTheme theme) {
    return dataSource.getFormMessageContentView(
        message, context, alignment, theme);
  }

  @override
  CometChatMessageTemplate getFormMessageTemplate(CometChatTheme theme) {
    return dataSource.getFormMessageTemplate(theme);
  }

  @override
  CometChatMessageTemplate getSchedulerMessageTemplate(CometChatTheme theme) {
    return dataSource.getSchedulerMessageTemplate(theme);
  }

  @override
  CometChatMessageTemplate getCardMessageTemplate(CometChatTheme theme) {
    return dataSource.getCardMessageTemplate(theme);
  }

  @override
  Widget getCardMessageContentView(CardMessage message, BuildContext context,
      BubbleAlignment alignment, CometChatTheme theme) {
    return dataSource.getCardMessageContentView(
        message, context, alignment, theme);
  }

  @override
  Widget getSchedulerMessageContentView(SchedulerMessage message,
      BuildContext context, BubbleAlignment alignment, CometChatTheme theme) {
    return dataSource.getSchedulerMessageContentView(
        message, context, alignment, theme);
  }

  @override
  Widget getCardMessageBubble({
    CardBubbleStyle? cardBubbleStyle,
    required CardMessage message,
    required CometChatTheme theme,
  }) {
    return dataSource.getCardMessageBubble(
        message: message, theme: theme, cardBubbleStyle: cardBubbleStyle);
  }

  @override
  Widget getSchedulerMessageBubble({
    SchedulerBubbleStyle? schedulerBubbleStyle,
    required SchedulerMessage message,
    required CometChatTheme theme,
  }) {
    return dataSource.getSchedulerMessageBubble(
        message: message,
        theme: theme,
        schedulerBubbleStyle: schedulerBubbleStyle);
  }

  @override
  List<CometChatMessageOption> getFormMessageOptions(
      User loggedInUser,
      BaseMessage messageObject,
      BuildContext context,
      Group? group,
      AdditionalConfigurations? additionalConfigurations) {
    return dataSource.getFormMessageOptions(
        loggedInUser, messageObject, context, group, additionalConfigurations);
  }

  @override
  List<CometChatMessageOption> getCardMessageOptions(
      User loggedInUser,
      BaseMessage messageObject,
      BuildContext context,
      Group? group,
      AdditionalConfigurations? additionalConfigurations) {
    return dataSource.getCardMessageOptions(
        loggedInUser, messageObject, context, group, additionalConfigurations);
  }

  @override
  List<CometChatMessageOption> getSchedulerMessageOptions(User loggedInUser,
      BaseMessage messageObject, BuildContext context, Group? group, AdditionalConfigurations? additionalConfigurations) {
    return dataSource.getSchedulerMessageOptions(
        loggedInUser, messageObject, context, group, additionalConfigurations);
  }

  @override
  List<CometChatMessageComposerAction> getAIOptions(
      User? user,
      Group? group,
      BuildContext context,
      Map<String, dynamic>? id,
      AIOptionsStyle? aiOptionStyle,
      ) {
    return dataSource.getAIOptions(
        user, group, context, id, aiOptionStyle);
  }

  @override
  List<CometChatTextFormatter> getDefaultTextFormatters() {
    return dataSource.getDefaultTextFormatters();
  }
}
