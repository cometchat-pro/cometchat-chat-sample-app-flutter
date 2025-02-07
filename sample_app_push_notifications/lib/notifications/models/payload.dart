

import 'call_action.dart';
import 'call_type.dart';

class PayloadData{
  ///[title] The title of the notification
  String? title;
  ///[body] The body of the notification
  String? body;
  ///[tag] The tag of the notification
  String? tag;
  ///[sender] The sender of the notification
  String? sender;
  ///[senderName] The sender name of the notification
  String? senderName;
  ///[senderAvatar] The sender avatar of the notification
  String? senderAvatar;

  ///[receiver] The receiver of the notification
  String? receiver;

  ///[receiverName] The receiver name of the notification
  String? receiverName;

  ///[receiverAvatar] The receiver avatar of the notification
  String? receiverAvatar;

  ///[receiverType] The receiver type of the notification
  String? receiverType;

  ///[conversationId] The conversation id of the notification
  String? conversationId;

  ///[type] The type of the notification
  String? type;

  ///[sessionId] The session id of the notification
  String? sessionId;

  ///[callAction] The call action of the notification
  CallAction? callAction;

  ///[callType] The call status of the notification
  CallType? callType;

  ///[sentAt] The time when the notification was sent
  DateTime? sentAt;

  PayloadData({
    this.title,
    this.body,
    this.tag,
    this.sender,
    this.senderName,
    this.senderAvatar,
    this.receiver,
    this.receiverName,
    this.receiverAvatar,
    this.receiverType,
    this.conversationId,
    this.type,
    this.sessionId,
    this.callAction,
    this.callType,
    this.sentAt,
  });

  static PayloadData fromJson(Map<String, dynamic> json) {

    return PayloadData(title : json['title'],
      body : json['body'],
      tag : json['tag'],
      sender : json['sender'],
      senderName : json['senderName'],
      senderAvatar : json['senderAvatar'],
      receiver : json['receiver'],
      receiverName : json['receiverName'],
      receiverAvatar : json['receiverAvatar'],
      receiverType : json['receiverType'],
      conversationId : json['conversationId'],
      type : json['type'],
      sessionId : json['sessionId'],
      callAction: CallAction.fromValue(json['callAction']),
      callType: CallType.fromValue(json['callType']),
      sentAt: json['sentAt']!=null?DateTime.fromMillisecondsSinceEpoch(int.parse(json['sentAt'])):null,
    );
  }

  @override
  String toString() {

    return """
    PayloadData{
      title: $title,
      body: $body,
      tag: $tag,
      sender: $sender,
      senderName: $senderName,
      senderAvatar: $senderAvatar,
      receiver: $receiver,
      receiverName: $receiverName,
      receiverAvatar: $receiverAvatar,
      receiverType: $receiverType,
      conversationId: $conversationId,
      type: $type,
      sessionId: $sessionId,
      callAction: $callAction,
      callType: $callType,
      sentAt: $sentAt
    }
    """;
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is PayloadData &&
              runtimeType == other.runtimeType &&
              sessionId == other.sessionId &&
              callAction == other.callAction &&
              title == other.title &&
              body == other.body &&
              tag == other.tag &&
              sender == other.sender &&
              senderName == other.senderName &&
              senderAvatar == other.senderAvatar &&
              receiver == other.receiver &&
              receiverName == other.receiverName &&
              receiverAvatar == other.receiverAvatar &&
              receiverType == other.receiverType &&
              conversationId == other.conversationId &&
              type == other.type &&
              callType == other.callType &&
              sentAt == other.sentAt;

}