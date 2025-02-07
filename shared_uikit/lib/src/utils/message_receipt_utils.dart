import 'package:cometchat_uikit_shared/cometchat_uikit_shared.dart';

///[MessageReceiptUtils] is a utility class to determine receipt status
class MessageReceiptUtils {
  static ReceiptStatus getReceiptStatus(BaseMessage message) {
    ReceiptStatus receiptStatus = ReceiptStatus.waiting;

    if (message.metadata != null &&
        message.metadata!.containsKey("error") &&
        message.metadata?["error"] is Exception) {
      receiptStatus = ReceiptStatus.error;
    } else if (message.readAt != null) {
      receiptStatus = ReceiptStatus.read;
    } else if (message.deliveredAt != null) {
      receiptStatus = ReceiptStatus.delivered;
    } else if (message.sentAt != null && message.id != 0) {
      receiptStatus = ReceiptStatus.sent;
    } else {
      receiptStatus = ReceiptStatus.waiting;
    }

    return receiptStatus;
  }
}