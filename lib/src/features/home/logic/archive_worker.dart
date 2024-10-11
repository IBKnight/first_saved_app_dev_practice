import 'dart:io';
import 'package:archive/archive.dart';
import 'package:archive/archive_io.dart';

class ZipWorker {
  Future<String> createZipArchive(String zipPath, String filePath) async {
    try {
      final archive = Archive();
      final file = File(filePath);

      if (!await file.exists()) {
        return 'Файл для архивации не найден: $filePath';
      }

      final fileBytes = await file.readAsBytes();
      final archiveFile = ArchiveFile(filePath, fileBytes.length, fileBytes);
      archive.addFile(archiveFile);

      final zipData = ZipEncoder().encode(archive);
      final zipFile = File(zipPath);
      await zipFile.writeAsBytes(zipData!);
      return 'ZIP архив создан: $zipPath';
    } catch (e) {
      return 'Ошибка создания ZIP архива: $e';
    }
  }

  Future<String> extractZipArchive(String zipPath, String extractPath) async {
    try {
      final zipFile = File(zipPath);
      if (await zipFile.exists()) {
        final bytes = await zipFile.readAsBytes();
        final archive = ZipDecoder().decodeBytes(bytes);

        for (final file in archive) {
          final filePath = '$extractPath/${file.name}';
          final outFile = File(filePath);
          await outFile.create(recursive: true);
          await outFile.writeAsBytes(file.content as List<int>);
        }
        return 'Файлы успешно разархивированы в: $extractPath';
      } else {
        return 'ZIP архив не найден: $zipPath';
      }
    } catch (e) {
      return 'Ошибка разархивации: $e';
    }
  }
}
