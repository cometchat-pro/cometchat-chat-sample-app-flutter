import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:cometchat_chat_uikit/cometchat_chat_uikit.dart';
import 'package:get/get.dart';

class CometChatTransferOwnershipController extends GetxController {
  CometChatTransferOwnershipController({required this.group});

  ///[group] provide group to add members to
  final Group group;

  Conversation? _conversation;

  String? _conversationId;

  // final RxList<User> selectedUsers = <User>[].obs;

  bool isLoading = false;

  // Update the list of selected users
  // void updateSelectedUsers(List<User> users) {
  //   selectedUsers.value = users;
  //   update(); // Notify the UI about the changes
  // }

  @override
  void onInit() {
    initializeLoggedInUser();
    super.onInit();
  }

  initializeLoggedInUser() async {
    _conversation ??= (await CometChat.getConversation(
        group.guid, ConversationType.group, onSuccess: (conversation) {
      if (conversation.lastMessage != null) {}
    }, onError: (_) {}));
    _conversationId ??= _conversation?.conversationId;
  }

  var isActionRunning=false.obs;

  showConfirmDialog(BuildContext context,String guid, GroupMember member, CometChatColorPalette colorPalette,
      CometChatTypography typography, CometChatSpacing spacing,
      ) {
    CometChatConfirmDialog(
      context: context,
      confirmButtonText: "Transfer",
      cancelButtonText: "Cancel",
      // icon: const SizedBox(),
      title: const Text(
        "Ownership Transfer",
        textAlign: TextAlign.center,
      ),
      messageText: const Text(
        "Are you sure you want to transfer ownership? This can't be undone, and the new owner will take full control.",
        textAlign: TextAlign.center,
      ),
      onCancel: () {
        isActionRunning.value=false;
        Navigator.pop(context);
      },
      showIcon: false,
      onConfirm: () {
        isActionRunning.value=true;
        CometChat.transferGroupOwnership(
            guid: guid,
            uid: member.uid,
            onSuccess: (String result) {
              group.owner = member.uid;
              CometChatGroupEvents.ccOwnershipChanged(group, member);
              Navigator.of(context).pop(); // Close the dialog
              Navigator.of(context).pop("LeaveGroup"); // Close the screen
            },
            onError: (excep) {
              if(kDebugMode){
                debugPrint("Ownership Transfer failed with exception: ${excep.message}");
              }
            },);

      },
      style: CometChatConfirmDialogStyle(
        iconColor: colorPalette.error,
        cancelButtonBackground:
            colorPalette.background1,
        confirmButtonBackground: colorPalette.primary,
        titleTextStyle: TextStyle(
          color:
          colorPalette.textPrimary,
          fontSize: typography.heading2?.medium?.fontSize,
          fontWeight: typography.heading2?.medium?.fontWeight,
          fontFamily: typography.heading2?.medium?.fontFamily,
        )
          ,
        messageTextStyle: TextStyle(
          color: colorPalette.textSecondary,
          fontSize: typography.body?.regular?.fontSize,
          fontWeight: typography.body?.regular?.fontWeight,
          fontFamily: typography.body?.regular?.fontFamily,
        ),
        confirmButtonTextStyle: TextStyle(
          color:
          colorPalette.white,
          fontSize: typography.button?.medium?.fontSize,
          fontWeight: typography.button?.medium?.fontWeight,
          fontFamily: typography.button?.medium?.fontFamily,
        ),
        cancelButtonTextStyle: TextStyle(
          color: colorPalette.textPrimary,
          fontSize: typography.button?.medium?.fontSize,
          fontWeight: typography.button?.medium?.fontWeight,
          fontFamily: typography.button?.medium?.fontFamily,
        ),
      ),
      confirmButtonTextWidget: Obx(
            () => isActionRunning.value
            ? SizedBox(
          height: 25,
          width: 25,
          child: CircularProgressIndicator(
            color: colorPalette.white,
          ),
        )
            : Text(
          "Transfer",
          style: TextStyle(
            color:  colorPalette.white,
            fontSize: typography.button?.medium?.fontSize,
            fontWeight: typography.button?.medium?.fontWeight,
            fontFamily: typography.button?.medium?.fontFamily,
          ),
        ),
      ),

    ).show();
  }
}