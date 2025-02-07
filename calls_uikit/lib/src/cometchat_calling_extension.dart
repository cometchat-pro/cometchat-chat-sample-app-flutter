import 'package:cometchat_calls_uikit/cometchat_calls_uikit.dart';

///[CometChatCallingExtension] is the controller class for enabling and disabling the extension
class CometChatCallingExtension extends ExtensionsDataSource {
  ///[configuration] is used to configure the extension
  CallingConfiguration? configuration;

  ///[CometChatCallingExtension] constructor requires [configuration] while initializing
  CometChatCallingExtension({this.configuration});

  ///[enable] method is used to enable the extension
  @override
  void enable(
      {Function(bool)? onSuccess, Function(CometChatException)? onError}) {
    addExtension();
  }

  @override
  void addExtension() {
    ChatConfigurator.enable((dataSource) =>
        CallingExtensionDecorator(dataSource, configuration: configuration));
  }

  @override
  String getExtensionId() {
    return "calling";
  }
}
