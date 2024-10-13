import 'dart:developer';
import 'dart:io';
import 'package:archive/archive.dart';
import 'package:archive/archive_io.dart';
import 'package:path_provider/path_provider.dart';

class ZipWorker {
  final String zipName;

  ZipWorker({required this.zipName});

  /// Создает ZIP архив и возвращает путь к архиву
  Future<String> createZipArchive() async {
    try {
      final directory = await getApplicationDocumentsDirectory();
      final zipPath = '${directory.path}/$zipName';

      // Создаем пустой архив
      final archive = Archive();
      final zipData = ZipEncoder().encode(archive);

      final zipFile = File(zipPath);
      await zipFile.writeAsBytes(zipData!);

      log('ZIP архив создан: $zipPath');
      return 'ZIP архив создан: $zipPath';
    } catch (e) {
      return 'Ошибка создания ZIP архива: $e';
    }
  }

  /// Добавляет файл в существующий ZIP архив
  Future<String> addFileToZipArchive(String fileName) async {
    try {
      final directory = await getApplicationDocumentsDirectory();
      final file = File("${directory.path}/$fileName");
      final zipPath = '${directory.path}/$zipName';

      if (!await file.exists()) {
        return 'Файл для архивации не найден: ${file.path}';
      }

      final zipFile = File(zipPath);
      if (!await zipFile.exists()) {
        return 'ZIP архив не найден: $zipPath';
      }

      final zipBytes = await zipFile.readAsBytes();
      final archive = ZipDecoder().decodeBytes(zipBytes);

      final fileBytes = await file.readAsBytes();
      final archiveFile = ArchiveFile(fileName, fileBytes.length, fileBytes);
      archive.addFile(archiveFile);

      final updatedZipData = ZipEncoder().encode(archive);
      await zipFile.writeAsBytes(updatedZipData!);

      final zipFileSize = await zipFile.length();

      log('Файл добавлен в ZIP архив: $zipPath, размер архива: $zipFileSize байт');
      return 'Файл добавлен в ZIP архив: $zipPath, размер архива: $zipFileSize байт';
    } catch (e) {
      log('Ошибка добавления файла в ZIP архив: $e');
      return 'Ошибка добавления файла в ZIP архив: $e';
    }
  }

  /// Извлекает файлы из ZIP архива и выводит данные о них
  Future<String> extractZipArchive() async {
    try {
      final directory = await getApplicationDocumentsDirectory();
      final zipPath = '${directory.path}/$zipName';

      final zipFile = File(zipPath);
      if (await zipFile.exists()) {
        final bytes = await zipFile.readAsBytes();
        final archive = ZipDecoder().decodeBytes(bytes);

        for (final file in archive) {
          final filePath = '${directory.path}/${file.name}';
          final outFile = File(filePath);
          await outFile.create(recursive: true);
          await outFile.writeAsBytes(file.content as List<int>);
          log('Извлеченный файл: $filePath');
        }

        log('Файлы успешно разархивированы в: ${directory.path}');
        return 'Файлы успешно разархивированы в: ${directory.path}';
      } else {
        log('ZIP архив не найден: $zipPath');
        return 'ZIP архив не найден: $zipPath';
      }
    } catch (e) {
      return 'Ошибка разархивации: $e';
    }
  }

  /// Удаляет ZIP архив и файл
  Future<String> deleteZipAndFile(String fileName) async {
    try {
      final directory = await getApplicationDocumentsDirectory();
      final zipPath = '${directory.path}/$zipName';
      final filePath = '${directory.path}/$fileName';
      final file = File(filePath);
      if (await file.exists()) {
        await file.delete();
        log('Файл удален: $filePath');
      } else {
        log('Файл не найден: $filePath');
      }

      final zipFile = File(zipPath);
      if (await zipFile.exists()) {
        await zipFile.delete();
        log('ZIP архив удален: $zipPath');
      } else {
        log('ZIP архив не найден: $zipPath');
      }

      log('Файл и архив успешно удалены');
      return 'Файл и архив успешно удалены';
    } catch (e) {
      log('Ошибка удаления файла и архива: $e');
      return 'Ошибка удаления файла и архива: $e';
    }
  }
}
