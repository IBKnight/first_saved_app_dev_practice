import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:path_provider/path_provider.dart';

class JsonWorker {
  static Future<String> createJsonFile({
    required String fileName,
    required Map<String, Object?> jsonData,
  }) async {
    final directory = await getApplicationDocumentsDirectory();
    final path = '${directory.path}/$fileName';
    final file = File(path);
    await file.writeAsString(jsonEncode(jsonData));
    log('JSON файл создан: $path');
    return 'JSON файл создан: $path';
  }

  static Future<String> readJsonFile({required String fileName}) async {
    try {
      final directory = await getApplicationDocumentsDirectory();
      final path = '${directory.path}/$fileName';
      final file = File(path);
      if (!(await file.exists())) {
        return 'JSON файл не найден: $path';
      }
      final content = await file.readAsString();
      final jsonData = jsonDecode(content);
      log('Содержимое JSON файла: $jsonData');
      return 'Содержимое JSON файла: $jsonData';
    } catch (e, stackTrace) {
      log('e: $e, stackTrace: $stackTrace');
      rethrow;
    }
  }
}
