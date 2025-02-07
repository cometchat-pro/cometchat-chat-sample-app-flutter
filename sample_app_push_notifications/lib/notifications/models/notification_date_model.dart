class NotificationDataModel {
  NotificationDataModel(Map<String, String> bodyData, {
    required this.senderName,
    required this.receiver,
    required this.sender,
    required this.conversationId,
    required this.receiverName,
    required this.receiverType,
    required this.senderAvatar,
    required this.tag,
    required this.body,
    required this.type,
    required this.title,
  });
  late final String senderName;
  late final String receiver;
  late final String sender;
  late final String conversationId;
  late final String receiverName;
  late final String receiverType;
  late final String senderAvatar;
  late final String tag;
  late final String body;
  late final String type;
  late final String title;

  NotificationDataModel.fromJson(Map<String, dynamic> json){
    senderName = json['senderName'] ?? "";
    receiver = json['receiver'] ?? "";
    sender = json['sender'] ?? "";
    conversationId = json['conversationId'] ?? "";
    receiverName = json['receiverName'] ?? "";
    receiverType = json['receiverType'] ?? "";
    senderAvatar = json['senderAvatar'] ?? "";
    tag = json['tag'] ?? "";
    body = json['body'] ?? "";
    type = json['type'] ?? "";
    title = json['title'] ?? "";
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['senderName'] = senderName;
    _data['receiver'] = receiver;
    _data['sender'] = sender;
    _data['conversationId'] = conversationId;
    _data['receiverName'] = receiverName;
    _data['receiverType'] = receiverType;
    _data['senderAvatar'] = senderAvatar;
    _data['tag'] = tag;
    _data['body'] = body;
    _data['type'] = type;
    _data['title'] = title;
    return _data;
  }
}