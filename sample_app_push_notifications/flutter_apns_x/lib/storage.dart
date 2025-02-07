import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:path_provider/path_provider.dart';

class Storage extends ChangeNotifier {
  late File storage;

  String content = 'not initialized';

  Future<void> setup() async {
    final path = await getApplicationDocumentsDirectory();
    final file = File(path.path + '/storage.json');

    if (!file.existsSync()) {
      await file.create();
    }

    storage = file;
    content = await storage.readAsString();
  }

  Future<void> append(String data) async {
    final entry = '${DateTime.now()}: $data\n';
    await storage.writeAsString(entry, mode: FileMode.append);
    content = await storage.readAsString();
    notifyListeners();
    print(data);
  }
}

final storage = Storage();
