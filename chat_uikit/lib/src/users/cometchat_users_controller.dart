import '../../../cometchat_chat_uikit.dart';

///[CometChatUsersController] is the view model for [CometChatUsers]
class CometChatUsersController
    extends CometChatSearchListController<User, String>
    with
        CometChatSelectable,
        UserListener,
        CometChatUserEventListener,
        ConnectionListener {
  //--------------------Constructor-----------------------
  CometChatUsersController(
      {required this.usersBuilderProtocol, SelectionMode? mode, super.onError, this.disableUsersPresence})
      : super(builderProtocol: usersBuilderProtocol) {
    selectionMode = mode ?? SelectionMode.none;
    dateStamp = DateTime.now().microsecondsSinceEpoch.toString();
    userListenerID = "${dateStamp}user_listener";
    _uiUserListener = "${dateStamp}UI_user_listener";
  }

  //-------------------------Variable Declaration-----------------------------
  late UsersBuilderProtocol usersBuilderProtocol;
  late String dateStamp;
  late String userListenerID;
  late String _uiUserListener;
  bool? disableUsersPresence;

  // TODO: Implement the retry logic later.
  // Retry configuration
  final int maxRetries = 3;
  final Duration retryDelay = const Duration(seconds: 3);
  int _currentRetryCount = 0;

  //-------------------------LifeCycle Methods-----------------------------
  @override
  void onInit() {
    CometChat.addUserListener(userListenerID, this);
    CometChatUserEvents.addUsersListener(_uiUserListener, this);
    CometChat.addConnectionListener(userListenerID, this);
    super.onInit();
  }

  @override
  void onClose() {
    CometChat.removeUserListener(userListenerID);
    CometChatUserEvents.removeUsersListener(_uiUserListener);
    CometChat.removeConnectionListener(userListenerID);
    super.onClose();
  }

  //-------------------------Parent List overriding Methods-----------------------------
  @override
  bool match(User elementA, User elementB) {
    return elementA.uid == elementB.uid;
  }

  @override
  String getKey(User element) {
    return element.uid;
  }

  //------------------------SDK User Event Listeners------------------------------
  @override
  void onUserOffline(User user) {
    updateElement(user);
  }

  @override
  void onUserOnline(User user) {
    updateElement(user);
  }

  //------------------------UI User Event Listeners-----------------------------
  @override
  void ccUserBlocked(User user) {
    updateElement(user);
  }

  @override
  void ccUserUnblocked(User user) {
    updateElement(user);
  }

  @override
  void onConnected() {
    if (!isLoading) {
      request = usersBuilderProtocol.getRequest();
      list = [];
      loadMoreElements();
    }
  }

  bool hideUserPresence(User user) {
    return disableUsersPresence == true || !userIsNotBlocked(user);
  }
  bool userIsNotBlocked(User user){
    return user.blockedByMe!=true && user.hasBlockedMe!=true;
  }

  void clearSelection() {
    selectionMap.clear();
    update();
  }

  // TODO: Implement the retry logic later.
  // Method to load groups
  void retryUsers() async {
    try {
      request = usersBuilderProtocol.getRequest();
      list = [];
      isLoading = true;
      await loadMoreElements();
      isLoading = false;
      _currentRetryCount = 0; // Reset retries on success
    } catch (e) {
      isLoading = false;
      _handleError(e);
    }
  }

  // TODO: Implement the retry logic later.
  // Retry logic on error
  void _handleError(dynamic error) {
    if (_currentRetryCount < maxRetries) {
      _currentRetryCount++;
      Future.delayed(retryDelay, () {
        retryUsers();
      });
    } else {
      if (onError != null) {
        onError!(error);
      }
    }
  }
}
