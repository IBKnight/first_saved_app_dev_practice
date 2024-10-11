import 'dart:developer';
import 'dart:io';
import 'package:path_provider/path_provider.dart';

class FileWorker {
  static Future<String> createFile({
    required String content,
    required String fileName,
  }) async {
    try {
      final directory = await getApplicationDocumentsDirectory();
      final filePath = '${directory.path}/$fileName';
      final file = File(filePath);
      await file.writeAsString(content);
      log('Файл создан: $filePath');
      return 'Файл создан: $filePath';
    } catch (e, stackTrace) {
      log('Ошибка создания файла: $e, $stackTrace');
      rethrow;
    }
  }

  static Future<String> readFile({required String fileName}) async {
    try {
      final directory = await getApplicationDocumentsDirectory();
      final filePath = '${directory.path}/$fileName';
      final file = File(filePath);
      if (!await file.exists()) {
        return 'Файл не существует';
      }
      final content = await file.readAsString();
      log('Содержимое файла: $content');
      return 'Содержимое файла: $content';
    } catch (e, stackTrace) {
      log('Ошибка чтения файла: $e, $stackTrace');
      rethrow;
    }
  }

  static Future<String> deleteFile({required String fileName}) async {
    try {
      final directory = await getApplicationDocumentsDirectory();
      final filePath = '${directory.path}/$fileName';
      final file = File(filePath);
      if (!await file.exists()) {
        return 'Файл не существует';
      }
      await file.delete();
      log('Файл удален: $filePath');
      return 'Файл удален: $filePath';
    } catch (e, stackTrace) {
      log('Ошибка удаления файла: $e, $stackTrace');
      rethrow;
    }
  }
}
