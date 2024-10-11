import 'dart:io';

class FileWorker {
  Future<void> createFile(String path, String content) async {
    final file = File(path);
    await file.writeAsString(content);
    print('Файл создан: $path');
  }

  Future<void> readFile(String path) async {
    final file = File(path);
    if (await file.exists()) {
      final content = await file.readAsString();
      print('Содержимое файла: $content');
    } else {
      print('Файл не найден: $path');
    }
  }

  Future<void> deleteFile(String path) async {
    final file = File(path);
    if (await file.exists()) {
      await file.delete();
      print('Файл удален: $path');
    } else {
      print('Файл не найден: $path');
    }
  }
}
