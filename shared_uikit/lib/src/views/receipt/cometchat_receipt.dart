import 'package:flutter/material.dart';
import 'package:cometchat_uikit_shared/cometchat_uikit_shared.dart';

enum ReceiptStatus { error, waiting, sent, read, delivered }

///[CometChatReceipt] is a widget that indicates the delivery status of a message
///by default, a single tick mark indicates a message has been sent
///a double tick mark indicates a message has been delivered
///a double tick mark of color `cometChatTheme.palette.primary` indicates a message has been read
/// ```dart
///
///     CometChatReceipt(
///       status: ReceiptStatus.read,
///       waitIcon: Icon(Icons.schedule),
///       sentIcon: Icon(Icons.check),
///       deliveredIcon: Icon(Icons.done_all),
///       errorIcon: Icon(Icons.error_outline),
///      );
///
/// ```
class CometChatReceipt extends StatelessWidget {
  const CometChatReceipt({
    super.key,
    this.waitIcon,
    this.sentIcon,
    this.deliveredIcon,
    this.errorIcon,
    this.readIcon,
    this.style,
    required this.status,
    this.size
  });

  ///[waitIcon] widget visible while sentAt and deliveredAt is null in [BaseMessage]. If blank will load default waitIcon
  final Widget? waitIcon;

  ///[sentIcon] widget visible while sentAt != null and deliveredAt is null in [BaseMessage]. If blank will load default sentIcon
  final Widget? sentIcon;

  ///[deliveredIcon] widget visible while  deliveredAt != null  in [BaseMessage]. If blank will load default deliveredIcon
  final Widget? deliveredIcon;

  ///[errorIcon] widget visible while sentAt and deliveredAt is null in [BaseMessage]. If blank will load default errorIcon
  final Widget? errorIcon;

  ///[readIcon] widget visible when readAt != null in [BaseMessage]. If blank will load default readIcon
  final Widget? readIcon;

  ///[style] to customize the appearance of [CometChatReceipt]
  final CometChatMessageReceiptStyle? style;

  ///receipt status from which sentAt and readAt will be read to get the receipts
  final ReceiptStatus status;

  ///[size] size of the receipt icon
  final double? size;

  @override
  Widget build(BuildContext context) {
    final receiptsStyle =
        CometChatThemeHelper.getTheme<CometChatMessageReceiptStyle>(
                context: context, defaultTheme: CometChatMessageReceiptStyle.of)
            .merge(style);

    final colorPalette = CometChatThemeHelper.getColorPalette(context);

    late Widget receiptWidget;
    receiptWidget = waitIcon ??
        Icon(
          Icons.schedule,
          color: receiptsStyle.waitIconColor ?? colorPalette.iconSecondary,
          size: size,
        );
    if (status == ReceiptStatus.error) {
      receiptWidget = errorIcon ??
          Icon(
            Icons.error_outline_outlined,
            color: receiptsStyle.errorIconColor ?? colorPalette.error,
            size: size,
          );
    } else if (status == ReceiptStatus.read) {
      receiptWidget = readIcon ??
          Icon(
            Icons.done_all,
            color: receiptsStyle.readIconColor ?? colorPalette.messageSeen,
            size: size,
          );
    } else if (status == ReceiptStatus.delivered) {
      receiptWidget = deliveredIcon ??
          Icon(
            Icons.done_all,
            color:
                receiptsStyle.deliveredIconColor ?? colorPalette.iconSecondary,
            size: size,
          );
    } else if (status == ReceiptStatus.sent) {
      receiptWidget = sentIcon ??
          Icon(
            Icons.check,
            color: receiptsStyle.sentIconColor ?? colorPalette.iconSecondary,
            size: size,
          );
    } else if (status == ReceiptStatus.waiting) {
      receiptWidget = waitIcon ??
          Icon(
            Icons.schedule,
            color: receiptsStyle.waitIconColor ?? colorPalette.iconSecondary,
            size: size,
          );
    } else {
      receiptWidget = const SizedBox();
    }

    return receiptWidget;
  }
}
