
import 'package:cometchat_chat_uikit/cometchat_chat_uikit.dart';
import 'package:flutter/material.dart';

class ThemeTestData {
  static CometChatMediaRecorderStyle mediaRecorderStyle =  CometChatMediaRecorderStyle(
    border: Border.all(color: Colors.red, width: 2),
    borderRadius: BorderRadius.circular(10),
    backgroundColor: Colors.green,
    deleteButtonBackgroundColor: Colors.blue,
    deleteButtonIconColor: Colors.yellow,
    pauseButtonBackgroundColor: Colors.red,
    pauseButtonIconColor: Colors.green,
    textColor: Colors.purple,
    textStyle: TextStyle(
      color: Colors.yellow,
      fontSize: 16,
      fontWeight: FontWeight.bold,
    ),
    audioBubbleStyle: CometChatAudioBubbleStyle(
      backgroundColor: Colors.green,
      border: Border.all(color: Colors.red, width: 2),
    ),
    deleteButtonBorder: Border.all(color: Colors.yellow, width: 2),
    pauseButtonBorder: Border.all(color: Colors.green, width: 2),
    deleteButtonBorderRadius: BorderRadius.circular(10),
    pauseButtonBorderRadius: BorderRadius.circular(10),
    playButtonIconColor: Colors.red,
    recordIndicatorBackgroundColor: Colors.blue,
    recordIndicatorBorder: Border.all(color: Colors.yellow, width: 2),
    recordIndicatorBorderRadius: BorderRadius.circular(10),
    recordIndicatorColor: Colors.green,
    recordIndicatorIconColor: Colors.red,
    sendButtonBackgroundColor: Colors.blue,
    sendButtonBorder: Border.all(color: Colors.yellow, width: 2),
    sendButtonBorderRadius: BorderRadius.circular(10),
    sendButtonIconColor: Colors.red,
    startButtonBackgroundColor: Colors.green,
    startButtonBorder: Border.all(color: Colors.red, width: 2),
    startButtonBorderRadius:  BorderRadius.circular(10),
    startButtonIconColor: Colors.yellow,
    stopButtonBackgroundColor: Colors.red,
    stopButtonBorder: Border.all(color: Colors.green, width: 2),
    stopButtonBorderRadius: BorderRadius.circular(10),
    stopButtonIconColor: Colors.blue,
  );

  static CometChatReactionListStyle reactionListStyle = CometChatReactionListStyle(
    border: Border.all(color: Colors.red, width: 2),
    borderRadius: BorderRadius.circular(10),
    backgroundColor: Colors.green,
    emptyTextStyle: TextStyle(
      color: Colors.yellow,
      fontSize: 16,
      fontWeight: FontWeight.bold,
    ),
    titleTextStyle: TextStyle(
      color: Colors.red,
      fontSize: 16,
      fontWeight: FontWeight.bold,
    ),
    subtitleTextStyle: TextStyle(
      color: Colors.pink,
      fontSize: 16,
      fontWeight: FontWeight.bold,
    ),
    activeTabBackgroundColor: Colors.blue,
    activeTabIndicatorColor: Colors.yellow,
    activeTabTextColor: Colors.red,
    errorSubtitleColor: Colors.green,
    errorSubtitleStyle: TextStyle(
      color: Colors.yellow,
      fontSize: 16,
      fontWeight: FontWeight.bold,
    ),
    errorTextColor: Colors.red,
    errorTextStyle: TextStyle(
      color: Colors.green,
      fontSize: 16,
      fontWeight: FontWeight.bold,
    ),
    subtitleTextColor: Colors.orange,
    titleTextColor: Colors.blue,
    tabTextColor: Colors.yellow,
    tabTextStyle: TextStyle(
      color: Colors.red,
      fontSize: 16,
      fontWeight: FontWeight.bold,
    ),
    tailViewTextStyle: TextStyle(
      color: Colors.green,
      fontSize: 16,
      fontWeight: FontWeight.bold,
    ),
  );

  static CometChatMessageHeaderStyle headerStyle =  CometChatMessageHeaderStyle(
    avatarStyle: CometChatAvatarStyle(
        border: Border.all(
          color: Colors.red,
          width: 4,
        )
    ),
    backgroundColor: Colors.green,
    border: Border.all(color: Colors.blue, width: 2),
    backIconColor: Colors.red,
    groupIconBackgroundColor: Colors.yellow,
    passwordProtectedGroupBadgeIcon: Icon(
      Icons.lock,
      color: Colors.green,
      size: 7,
    ),
    passwordProtectedGroupBadgeIconColor: Colors.red,
    privateGroupBadgeIcon: Icon(
      Icons.shield,
      color: Colors.green,
      size: 7,
    ),
    privateGroupBadgeIconColor: Colors.red,
    subtitleTextColor: Colors.blue,
    titleTextColor: Colors.green,
    typingIndicatorTextStyle: TextStyle(
      color: Colors.yellow,
      fontSize: 16,
      fontWeight: FontWeight.bold,
    ),
    subtitleTextStyle: TextStyle(
      color: Colors.red,
      fontSize: 16,
      fontWeight: FontWeight.bold,
    ),
    onlineStatusColor: Colors.blue,
    titleTextStyle: TextStyle(
      color: Colors.purple,
      fontSize: 16,
      fontWeight: FontWeight.bold,
    ),
    borderRadius: BorderRadius.circular(10),
    backIcon: Icon(Icons.arrow_back),
  );

  static CometChatReactionsStyle reactionsStyle = CometChatReactionsStyle(
    countTextColor: Colors.red,
    border: Border.all(color: Colors.red, width: 2),
    borderRadius: BorderRadius.circular(10),
    backgroundColor: Colors.green,
    activeReactionBackgroundColor: Colors.blue,
    activeReactionBorder: Border.all(color: Colors.blue, width: 2),
    countTextStyle: TextStyle(
      color: Colors.purple,
      fontSize: 16,
      fontWeight: FontWeight.bold,
    ),
    emojiTextStyle: TextStyle(
      color: Colors.yellow,
      fontSize: 16,
      fontWeight: FontWeight.bold,
    ),
  );

  static CometChatMessageComposerStyle messageComposerStyle = CometChatMessageComposerStyle(
    //            backgroundColor: Colors.yellow,
    //          auxiliaryButtonIconColor: Colors.red,
    //           sendButtonIconColor: Colors.blue,
    // borderRadius: BorderRadius.circular(20),
    // border: Border.all(color: Colors.red, width: 3),
    // sendButtonIcon: Icon(Icons.send),
    // sendButtonBorderRadius: BorderRadius.circular(10),
   // textColor: Colors.green,
   //  textStyle: TextStyle(
   //    color: Colors.yellow,
   //    fontSize: 16,
   //    fontWeight: FontWeight.bold,
   //  ),
   // auxiliaryButtonBorderRadius: BorderRadius.circular(10),

    // auxiliaryButtonIconBackgroundColor: Colors.blue,
    // closeIconTint: Colors.red,
    // dividerColor: Colors.green,
    // dividerHeight: 2,
    // placeHolderTextColor: Colors.yellow,
    placeHolderTextStyle: TextStyle(
      color: Colors.red,
      fontSize: 16,
      fontWeight: FontWeight.bold,
    ),
    // secondaryButtonIconColor: Colors.red,
    // secondaryButtonIconBackgroundColor: Colors.blue,

    // sendButtonIconBackgroundColor: Colors.green,
    // auxiliaryButtonBorderRadius: BorderRadius.circular(10),
    attachmentOptionSheetStyle: CometChatAttachmentOptionSheetStyle(
       backgroundColor: Colors.green,
        border: Border.all(color: Colors.red, width: 2),
        borderRadius: BorderRadius.circular(10),
        iconColor: Colors.yellow,
        titleTextStyle: TextStyle(
          color: Colors.red,
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
       titleColor: Colors.blue,
    ),
    // sendButtonBorderRadius: BorderRadius.circular(10),
    // secondaryButtonBorderRadius: BorderRadius.circular(10),

            );

  static CometChatMentionsStyle  mentionsStyle = CometChatMentionsStyle(
              mentionSelfTextBackgroundColor: Colors.black,
              mentionSelfTextColor: Colors.white,
              mentionTextColor: Colors.yellow,
              mentionTextBackgroundColor: Colors.green,
    mentionSelfTextStyle: TextStyle(
      color: Colors.red,
      fontSize: 16,
      fontWeight: FontWeight.bold,
    ),
    mentionTextStyle: TextStyle(
      color: Colors.blue,
      fontSize: 16,
      fontWeight: FontWeight.bold,
    ),


            );

  static CometChatMessageListStyle messageListStyle = CometChatMessageListStyle(
    border: Border.all(color: Colors.red, width: 2),
    borderRadius: BorderRadius.circular(10),
    backgroundColor: Colors.green,
    errorStateSubtitleColor: Colors.blue,
    errorStateSubtitleStyle: TextStyle(
      color: Colors.red,
      fontSize: 16,
      fontWeight: FontWeight.bold,
    ),
    errorStateTextColor: Colors.yellow,
    errorStateTextStyle: TextStyle(
      color: Colors.green,
      fontSize: 16,
      fontWeight: FontWeight.bold,
    ),

    outgoingMessageBubbleStyle: CometChatOutgoingMessageBubbleStyle(
      backgroundColor: Colors.blue,
      border: Border.all(color: Colors.red, width: 2),
    ),
    emptyStateSubtitleColor: Colors.purple,
    emptyStateSubtitleStyle: TextStyle(
      color: Colors.yellow,
      fontSize: 16,
      fontWeight: FontWeight.bold,
    ),
    emptyStateTextColor: Colors.red,
    emptyStateTextStyle: TextStyle(
      color: Colors.green,
      fontSize: 16,
      fontWeight: FontWeight.bold,
    ),
    incomingMessageBubbleStyle: CometChatIncomingMessageBubbleStyle(
      backgroundColor: Colors.green,
      border: Border.all(color: Colors.red, width: 2),
    ),
    messageInformationStyle: CometChatMessageInformationStyle(
      backgroundColor: Colors.green,
      border: Border.all(color: Colors.red, width: 2),
      borderRadius: BorderRadius.circular(10),
    ),
     messageOptionSheetStyle: CometChatMessageOptionSheetStyle(
      backgroundColor: Colors.green,
      border: Border.all(color: Colors.red, width: 2),
      borderRadius: BorderRadius.circular(10),
   ),
reactionListStyle: reactionListStyle,
    reactionsStyle: reactionsStyle,
    mentionsStyle: mentionsStyle,
    avatarStyle: CometChatAvatarStyle(
      border: Border.all(color: Colors.red, width: 3),
      borderRadius: BorderRadius.circular(10),
      placeHolderTextColor: Colors.green,
      backgroundColor: Colors.blue,
      placeHolderTextStyle: TextStyle(
        color: Colors.yellow,
        fontSize: 16,
        fontWeight: FontWeight.bold,
      ),
    ),
    actionBubbleStyle: actionBubbleStyle,

  );

static CometChatActionBubbleStyle actionBubbleStyle = CometChatActionBubbleStyle(
  backgroundColor: Colors.green,
  border: Border.all(color: Colors.red, width: 2),
  borderRadius: BorderRadius.circular(10),
  textStyle: TextStyle(
  color: Colors.yellow,
  fontSize: 16,
  fontWeight: FontWeight.bold,
  ));

static CometChatMessageInputStyle messageInputStyle = CometChatMessageInputStyle(
  backgroundColor: Colors.green,
  border: Border.all(color: Colors.red, width: 2),
  borderRadius: BorderRadius.circular(10),
  textStyle: TextStyle(
    color: Colors.yellow,
    fontSize: 16,
    fontWeight: FontWeight.bold,
  ),
  dividerHeight: 10,
  dividerTint: Colors.blue,
  placeholderColor: Colors.red,
  placeholderTextStyle: TextStyle(
    color: Colors.white,
    fontSize: 16,
    fontWeight: FontWeight.bold,
  ),
  textColor: Colors.purple,
  );

static CometChatDeletedBubbleStyle deletedBubbleStyle = CometChatDeletedBubbleStyle(
  // backgroundColor: Colors.pink,
  border: Border.all(color: Colors.red, width: 2),
  borderRadius: BorderRadius.circular(10),
  iconColor: Colors.yellow,
  textStyle: TextStyle(
    color: Colors.red,
    fontSize: 17,
    fontWeight: FontWeight.bold,
  ),
  textColor: Colors.blue,
  );

static CometChatTextBubbleStyle textBubbleStyle = CometChatTextBubbleStyle(
  backgroundColor: Colors.yellow,
  border: Border.all(color: Colors.red, width: 2),
  borderRadius: BorderRadius.circular(10),
  textStyle: TextStyle(
    color: Colors.yellow,
    fontSize: 20,
    fontWeight: FontWeight.bold,
  ),
  textColor: Colors.pink,
  );

static CometChatAudioBubbleStyle audioBubbleStyle = CometChatAudioBubbleStyle(
  backgroundColor: Colors.green,
  border: Border.all(color: Colors.red, width: 2),
  borderRadius: BorderRadius.circular(10),
  playIconBackgroundColor: Colors.blue,
  playIconColor: Colors.yellow,
  audioBarColor: Colors.red,
  downloadIconColor: Colors.green,
  );

static CometChatImageBubbleStyle imageBubbleStyle = CometChatImageBubbleStyle(
  backgroundColor: Colors.green,
  border: Border.all(color: Colors.red, width: 2),
  borderRadius: BorderRadius.circular(10),
  );

static CometChatVideoBubbleStyle videoBubbleStyle = CometChatVideoBubbleStyle(
  backgroundColor: Colors.green,
  border: Border.all(color: Colors.red, width: 2),
  borderRadius: BorderRadius.circular(10),
  playIconBackgroundColor: Colors.blue,
  playIconColor: Colors.yellow,
  );

static CometChatFileBubbleStyle fileBubbleStyle = CometChatFileBubbleStyle(
  backgroundColor: Colors.green,
  border: Border.all(color: Colors.red, width: 2),
  borderRadius: BorderRadius.circular(10),
  titleColor: Colors.blue,
  titleTextStyle: TextStyle(
    color: Colors.red,
    fontSize: 16,
    fontWeight: FontWeight.bold,
  ),
  subtitleTextStyle: TextStyle(
    color: Colors.green,
    fontSize: 16,
    fontWeight: FontWeight.bold,
  ),
  // downloadIconTint: Colors.yellow,
  subtitleColor: Colors.pink,
  );

static CometChatCollaborativeBubbleStyle collaborativeBubbleStyle = CometChatCollaborativeBubbleStyle(
  backgroundColor: Colors.green,
  border: Border.all(color: Colors.red, width: 2),
  borderRadius: BorderRadius.circular(10),
  dividerColor: Colors.blue,
  buttonTextStyle: TextStyle(
    color: Colors.red,
    fontSize: 16,
    fontWeight: FontWeight.bold,
  ),
  iconTint: Colors.yellow,
  subtitleStyle: TextStyle(
    color: Colors.green,
    fontSize: 16,
    fontWeight: FontWeight.bold,
  ),
  titleStyle: TextStyle(
    color: Colors.blue,
    fontSize: 16,
    fontWeight: FontWeight.bold,
  ),
  webViewAppBarColor: Colors.red,
  webViewBackIconColor: Colors.yellow,
  webViewTitleStyle: TextStyle(
    color: Colors.green,
    fontSize: 16,
    fontWeight: FontWeight.bold,
  ),

  );

static CometChatPollsBubbleStyle pollsBubbleStyle = CometChatPollsBubbleStyle(
  backgroundColor: Colors.green,
  border: Border.all(color: Colors.red, width: 2),
  borderRadius: BorderRadius.circular(10),
  voteCountTextStyle: TextStyle(
    color: Colors.yellow,
    fontSize: 16,
    fontWeight: FontWeight.bold,
  ),
  pollOptionsTextStyle: TextStyle(
    color: Colors.red,
    fontSize: 16,
    fontWeight: FontWeight.bold,
  ),
  questionTextStyle: TextStyle(
    color: Colors.blue,
    fontSize: 16,
    fontWeight: FontWeight.bold,
  ),
  progressBackgroundColor: Colors.yellow,
  progressColor: Colors.green,
  iconColor: Colors.yellow,
  pollOptionsBackgroundColor: Colors.red,
  radioButtonColor: Colors.blue,
  selectedOptionColor: Colors.green,
  unSelectedOptionColor: Colors.yellow,
  messageBubbleAvatarStyle: CometChatAvatarStyle(
    borderRadius: BorderRadius.circular(10),
    border: Border.all(color: Colors.red, width: 2),
    backgroundColor: Colors.pink,
  )
  );

static CometChatMessageBubbleStyle messageBubbleStyle = CometChatMessageBubbleStyle(
  backgroundColor: Colors.green,
  border: Border.all(color: Colors.red, width: 2),
  borderRadius: BorderRadius.circular(25),
  backgroundImage: DecorationImage(image: AssetImage('assets/pattern-2.jpg'),
      fit: BoxFit.cover),
  );


static CometChatSuggestionListStyle suggestionListStyle = CometChatSuggestionListStyle(
  backgroundColor: Colors.green,
  border: Border.all(color: Colors.red, width: 2),
  borderRadius: BorderRadius.circular(10),
  avatarStyle: CometChatAvatarStyle(
    border: Border.all(color: Colors.red, width: 2),
    borderRadius: BorderRadius.circular(10),
    backgroundColor: Colors.blue,
  ),
  textStyle: TextStyle(
    color: Colors.yellow,
    fontSize: 16,
    fontWeight: FontWeight.bold,
  ),
  textColor: Colors.red,
  );

static CometChatLinkPreviewBubbleStyle linkPreviewBubbleStyle = CometChatLinkPreviewBubbleStyle(
  // backgroundColor: Colors.green,
  border: Border.all(color: Colors.red, width: 2),
  borderRadius: BorderRadius.circular(10),
  descriptionStyle: TextStyle(
    color: Colors.yellow,
    fontSize: 16,
    fontWeight: FontWeight.bold,
  ),
  titleStyle: TextStyle(
    color: Colors.red,
    fontSize: 16,
    fontWeight: FontWeight.bold,
  ),
  urlStyle: TextStyle(
    color: Colors.blue,
    fontSize: 16,
    fontWeight: FontWeight.bold,
  ),
  tileColor: Colors.orange.shade200,
  );

static CometChatMessageTranslationBubbleStyle messageTranslationBubbleStyle = CometChatMessageTranslationBubbleStyle(
  dividerColor: Colors.green,
  infoTextStyle: TextStyle(
    color: Colors.yellow,
    fontSize: 16,
    fontWeight: FontWeight.bold,
  ),
  translatedTextStyle: TextStyle(
    color: Colors.red,
    fontSize: 16,
    fontWeight: FontWeight.bold,
  ),
  );

static CometChatOutgoingMessageBubbleStyle outgoingMessageBubbleStyle = CometChatOutgoingMessageBubbleStyle(
  backgroundColor: Colors.pink,
  border: Border.all(color: Colors.red, width: 2),
  borderRadius: BorderRadius.circular(10),
  audioBubbleStyle: audioBubbleStyle,
  deletedBubbleStyle: deletedBubbleStyle,
  pollsBubbleStyle: pollsBubbleStyle,
  collaborativeDocumentBubbleStyle: collaborativeBubbleStyle,
  messageBubbleReactionStyle: reactionsStyle,
  textBubbleStyle: textBubbleStyle,
  fileBubbleStyle: fileBubbleStyle,
  imageBubbleStyle: imageBubbleStyle,
  messageReceiptStyle:messageReceiptStyle,
  videoBubbleStyle: videoBubbleStyle,
  // messageBubbleDateStyle: CometChatDateStyle(
  //   border: Border.all(color: Colors.red, width: 2),
  //   textColor: Colors.blue,
  // ),
  messageBubbleAvatarStyle: CometChatAvatarStyle(
    borderRadius: BorderRadius.circular(10),
  ),
stickerBubbleStyle: CometChatStickerBubbleStyle(
border: Border.all(color: Colors.red, width: 2),
borderRadius: BorderRadius.circular(10),
threadedMessageIndicatorIconColor: Colors.yellow,
threadedMessageIndicatorTextStyle: TextStyle(
color: Colors.red,
),
backgroundColor: Colors.greenAccent,

),
linkPreviewBubbleStyle: linkPreviewBubbleStyle,
  threadedMessageIndicatorIconColor: Colors.yellow,
  messageTranslationBubbleStyle: messageTranslationBubbleStyle,
messageBubbleBackgroundImage: DecorationImage(image: AssetImage('assets/pattern-2.jpg'),repeat: ImageRepeat.repeat),

  );

static CometChatIncomingMessageBubbleStyle incomingMessageBubbleStyle = CometChatIncomingMessageBubbleStyle(
  backgroundColor: Colors.yellow,
  border: Border.all(color: Colors.red, width: 2),
  borderRadius: BorderRadius.circular(10),
  senderNameTextStyle: const TextStyle(
    color: Colors.red,
    fontSize: 16,
    fontWeight: FontWeight.bold,
  ),
  messageBubbleAvatarStyle: CometChatAvatarStyle(
    borderRadius: BorderRadius.circular(10),
    border: Border.all(color: Colors.red, width: 2),
    backgroundColor: Colors.blue,
  ),
  imageBubbleStyle: imageBubbleStyle,
  );

static CometChatMessageReceiptStyle messageReceiptStyle =  CometChatMessageReceiptStyle(
  waitIconColor: Colors.red,
  sentIconColor: Colors.green,
  readIconColor: Colors.yellow,
  deliveredIconColor: Colors.blue,errorIconColor: Colors.pink,
);

static CometChatGroupMembersStyle membersStyle = CometChatGroupMembersStyle(
  // backgroundColor: Colors.green,
  // border: Border.all(color: Colors.red, width: 2),
  // borderRadius: BorderRadius.circular(10),
  // errorStateTextStyle: TextStyle(
  //   color: Colors.yellow,
  //   fontSize: 16,
  //   fontWeight: FontWeight.bold,
  // ),
  //TODO: empty state will be visible on search only and test this when empty state design is provided and implemented
  // emptyStateTextStyle: TextStyle(
  //   color: Colors.red,
  //   fontSize: 16,
  //   fontWeight: FontWeight.bold,
  // ),
  // errorStateSubtitleStyle: TextStyle(
  //   color: Colors.blue,
  //   fontSize: 16,
  //   fontWeight: FontWeight.bold,
  // ),
  // avatarStyle: CometChatAvatarStyle(
  //   border: Border.all(color: Colors.red, width: 2),
  //   borderRadius: BorderRadius.circular(10),
  //   backgroundColor: Colors.blue,
  // ),
  // titleStyle: TextStyle(
  //   color: Colors.yellow,
  //   fontSize: 16,
  //   fontWeight: FontWeight.bold,
  // ),
  // backIconColor: Colors.red,
  // checkboxBackgroundColor: Colors.green,
  // checkboxBorderRadius: BorderRadius.circular(10),
  // checkboxCheckedBackgroundColor: Colors.blue,
  // checkboxSelectedIconColor: Colors.yellow,
  // checkboxBorder: BorderSide(color: Colors.red, width: 2),
  // listItemSelectedBackgroundColor: Colors.green,
  // loadingIconColor: Colors.red,
  // onlineStatusColor: Colors.yellow,
  // searchBackground: Colors.blue,
  // searchBorderRadius: BorderRadius.circular(10),
  // searchIconColor: Colors.red,
  // searchPlaceholderStyle: TextStyle(
  //   color: Colors.yellow,
  //   fontSize: 16,
  //   fontWeight: FontWeight.bold,
  // ),
  // searchTextStyle: TextStyle(
  //   color: Colors.red,
  //   fontSize: 16,
  //   fontWeight: FontWeight.bold,
  // ),
  // confirmDialogStyle: CometChatConfirmDialogStyle(
  //   backgroundColor: Colors.green,
  //   border: BorderSide(color: Colors.red, width: 2),
  //   borderRadius: BorderRadius.circular(30),
  //   titleTextStyle: TextStyle(
  //     color: Colors.pink,
  //     fontSize: 16,
  //     fontWeight: FontWeight.bold,
  //   ),
  //   cancelButtonTextStyle: TextStyle(
  //     color: Colors.orange,
  //     fontSize: 16,
  //     fontWeight: FontWeight.bold,
  //   ),
  //   messageTextStyle: TextStyle(
  //     color: Colors.blue,
  //     fontSize: 16,
  //     fontWeight: FontWeight.bold,
  //   ),
  //   confirmButtonTextColor: Colors.purple,
  //   messageTextColor: Colors.green,
  //   iconColor: Colors.orange,
  //   titleTextColor: Colors.yellow,
  //   cancelButtonBackground: Colors.red,
  //   cancelButtonTextColor: Colors.green,
  //   confirmButtonBackground: Colors.blue,
  //   confirmButtonTextStyle: TextStyle(
  //     color: Colors.yellow,
  //     fontSize: 10,
  //     fontWeight: FontWeight.bold,
  //   ),
  //   shadow: Colors.orange.withOpacity(.3),
  //   iconBackgroundColor: Colors.red,
  // ),
  // groupScopeStyle: GroupScopeStyle(
  //   background: Colors.tealAccent,
  //   border: Border.all(color: Colors.red, width: 2),
  //   borderRadius: BorderRadius.circular(10),
  //   scopeTextStyle: TextStyle(
  //     color: Colors.blue,
  //     fontSize: 16,
  //     fontWeight: FontWeight.bold,
  //   ),
  //
  // ),
  // listItemStyle: ListItemStyle(
  //   background: Colors.green,
  //   border: Border.all(color: Colors.red, width: 2),
  //   borderRadius: BorderRadius.circular(30),
  //   titleStyle: TextStyle(
  //     color: Colors.yellow,
  //     fontSize: 16,
  //     fontWeight: FontWeight.bold,
  //   ),
  //   separatorColor: Colors.red,
  // ),
  // separatorHeight: 2,
  // retryButtonTextStyle: TextStyle(
  //   color: Colors.red,
  //   fontSize: 16,
  //   fontWeight: FontWeight.bold,
  // ),
  // retryButtonBorderRadius: BorderRadius.circular(10),
  // retryButtonBackgroundColor: Colors.blue,
  // retryButtonBorder: BorderSide(color: Colors.red, width: 2),
  // separatorColor: Colors.green,
  // retryButtonTextColor: Colors.yellow,
// emptyStateTextColor: Colors.red,
// emptyStateTextStyle: TextStyle(
//   color: Colors.green,
//   fontSize: 16,
//   fontWeight: FontWeight.bold,
// ),
// emptyStateSubtitleTextColor: Colors.blue,
// emptyStateSubtitleTextStyle: TextStyle(
//   color: Colors.red,
//   fontSize: 16,
//   fontWeight: FontWeight.bold,
// ),
// ownerMemberScopeBorder: Border.all(color: Colors.red, width: 2),
// ownerMemberScopeBackgroundColor: Colors.green,
ownerMemberScopeTextStyle: TextStyle(
  color: Colors.yellow,
  fontSize: 16,
  fontWeight: FontWeight.bold,
),
// adminMemberScopeBorder: Border.all(color: Colors.red, width: 2),
// adminMemberScopeBackgroundColor: Colors.tealAccent,
adminMemberScopeTextStyle: TextStyle(
  color: Colors.orange,
  fontSize: 16,
  fontWeight: FontWeight.bold,
),
// moderatorMemberScopeBorder: Border.all(color: Colors.red, width: 2),
// moderatorMemberScopeBackgroundColor: Colors.lightBlueAccent,
moderatorMemberScopeTextStyle: TextStyle(
  color: Colors.red,
  fontSize: 16,
  fontWeight: FontWeight.bold,
),
  // moderatorMemberScopeTextColor: Colors.red,
// ownerMemberScopeTextColor: Colors.pinkAccent.withOpacity(.2),
// adminMemberScopeTextColor: Colors.purple,
optionsBackgroundColor: Colors.green,
  optionsIconColor: Colors.red,
  optionsTextStyle: TextStyle(
    color: Colors.yellow,
    fontSize: 16,
    fontWeight: FontWeight.bold,
  ),
changeScopeStyle: changeScopeStyle,
  );

static CometChatChangeScopeStyle changeScopeStyle = CometChatChangeScopeStyle(
  border: Border.all(color: Colors.red, width: 2),
  borderRadius: BorderRadius.circular(10),
  iconBackgroundColor: Colors.green,
  backgroundColor: Colors.yellow,
  radioButtonColor: Colors.blue,
  radioButtonSelectedColor: Colors.red,
  scopeTextStyle: TextStyle(
    color: Colors.yellow,
    fontSize: 16,
    fontWeight: FontWeight.bold,
  ),
  iconColor: Colors.red,
  subtitleTextStyle: TextStyle(
    color: Colors.green,
    fontSize: 16,
    fontWeight: FontWeight.bold,
  ),
  titleTextStyle: TextStyle(
    color: Colors.blue,
    fontSize: 16,
    fontWeight: FontWeight.bold,
  ),
  cancelButtonBackgroundColor: Colors.red,
  cancelButtonBorder: BorderSide(color: Colors.green, width: 2),
  cancelButtonBorderRadius: BorderRadius.circular(10),
  cancelButtonTextStyle: TextStyle(
    color: Colors.yellow,
    fontSize: 16,
    fontWeight: FontWeight.bold,
  ),
  saveButtonBackgroundColor: Colors.blue,
  saveButtonBorder: BorderSide(color: Colors.red, width: 2),
  saveButtonBorderRadius: BorderRadius.circular(10),
  saveButtonTextStyle: TextStyle(
    color: Colors.yellow,
    fontSize: 16,
    fontWeight: FontWeight.bold,
  ),
  scopeSectionBorder: Border.all(color: Colors.red, width: 2),
  selectedScopeTextStyle: TextStyle(
    color: Colors.green,
    fontSize: 16,
    fontWeight: FontWeight.bold,
  ),
  selectedTileColor: Colors.red,
  tileColor: Colors.green,

);

static CometChatAIConversationStarterStyle conversationStarterStyle = CometChatAIConversationStarterStyle(
  backgroundColor: Colors.green,
  border: Border.all(color: Colors.red, width: 2),
  borderRadius: BorderRadius.circular(10),
  emptyIconTint: Colors.yellow,
  errorTextStyle: TextStyle(
    color: Colors.red,
    fontSize: 16,
    fontWeight: FontWeight.bold,
  ),
  errorIconTint: Colors.blue,
  emptyTextStyle: TextStyle(
    color: Colors.green,
    fontSize: 16,
    fontWeight: FontWeight.bold,
  ),
  itemTextStyle: TextStyle(
    color: Colors.pink,
    fontSize: 16,
    fontWeight: FontWeight.bold,
  ),
  shadowColor: Colors.yellow,
  );

static CometChatAIConversationSummaryStyle summaryStyle = CometChatAIConversationSummaryStyle(
  backgroundColor: Colors.green,
  border: Border.all(color: Colors.red, width: 2),
  borderRadius: BorderRadius.circular(10),
  // decoratedContainerStyle: decoratedContainerStyle,
  emptyIconTint: Colors.yellow,
  emptyTextStyle: TextStyle(
    color: Colors.red,
    fontSize: 16,
    fontWeight: FontWeight.bold,
  ),
  errorTextStyle: TextStyle(
    color: Colors.blue,
    fontSize: 16,
    fontWeight: FontWeight.bold,
  ),
  shadowColor: Colors.pink,
closeIconColor: Colors.yellow,
  summaryTextStyle: TextStyle(
    color: Colors.yellow,
    fontSize: 16,
    fontWeight: FontWeight.bold,
  ),
  titleStyle: TextStyle(
    color: Colors.red,
    fontSize: 16,
    fontWeight: FontWeight.bold,
  ),
  );

static DecoratedContainerStyle decoratedContainerStyle =DecoratedContainerStyle(
  backgroundColor: Colors.green,
  border: Border.all(color: Colors.red, width: 2),
  borderRadius: BorderRadius.circular(10),
  titleStyle: TextStyle(
    color: Colors.yellow,
    fontSize: 16,
    fontWeight: FontWeight.bold,
  ),
);

static CometChatAISmartRepliesStyle smartRepliesStyle = CometChatAISmartRepliesStyle(
    closeIconColor: Colors.red,
    backgroundColor: Colors.green,
    border: Border.all(color: Colors.red, width: 2),
    borderRadius: BorderRadius.circular(10),
    emptyIconTint: Colors.yellow,
    emptyTextStyle: TextStyle(
      color: Colors.red,
      fontSize: 16,
      fontWeight: FontWeight.bold,
    ),
  titleStyle: TextStyle(
    color: Colors.yellow,
    fontSize: 16,
    fontWeight: FontWeight.bold,
  ),
  itemBackgroundColor: Colors.red,
  itemBorderRadius: BorderRadius.circular(10),
  itemBorder: Border.all(color: Colors.red, width: 2),
  errorTextStyle: TextStyle(
    color: Colors.green,
    fontSize: 16,
    fontWeight: FontWeight.bold,
  ),
  itemTextStyle: TextStyle(
    color: Colors.yellow,
    fontSize: 16,
    fontWeight: FontWeight.bold,
  ),

);

}