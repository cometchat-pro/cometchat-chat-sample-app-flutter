import 'package:flutter/material.dart';

class ThemeListenerWidget extends StatefulWidget {
  const ThemeListenerWidget({Key? key}) : super(key: key);

  @override
  _ThemeListenerWidgetState createState() => _ThemeListenerWidgetState();
}

class _ThemeListenerWidgetState extends State<ThemeListenerWidget>
    with WidgetsBindingObserver {
  late Brightness _brightness;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _brightness = WidgetsBinding.instance.window.platformBrightness;
  }

  @override
  void didChangePlatformBrightness() {
    setState(() {
      _brightness = WidgetsBinding.instance.window.platformBrightness;
    });
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Theme Change Listener')),
      body: Center(
        child: Text(
          'Current Theme: ${_brightness == Brightness.dark ? 'Dark' : 'Light'}',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
