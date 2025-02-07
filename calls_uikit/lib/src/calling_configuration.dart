import 'package:cometchat_calls_uikit/cometchat_calls_uikit.dart';

class CallingConfiguration {
  CallingConfiguration({
    this.outgoingCallConfiguration,
    this.incomingCallConfiguration,
    this.callButtonsConfiguration,
    this.groupCallSettingsBuilder,
  });

  ///[outgoingCallConfiguration] is a object of [OutgoingCallConfiguration] which sets the configuration for outgoing call
  final CometChatOutgoingCallConfiguration? outgoingCallConfiguration;

  ///[incomingCallConfiguration] is a object of [CometChatIncomingCallConfiguration] which sets the configuration for incoming call
  final CometChatIncomingCallConfiguration? incomingCallConfiguration;

  ///[callButtonsConfiguration] is a object of [CallButtonsConfiguration] which sets the configuration for call buttons
  final CallButtonsConfiguration? callButtonsConfiguration;

  ///[groupCallSettingBuilder] is used to configure the meet settings builder
  final CallSettingsBuilder? groupCallSettingsBuilder;
}
