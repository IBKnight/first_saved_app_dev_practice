import 'dart:developer';
import 'dart:io';

class FileSystemChecker {
  static Future<String> getDiskInfo() async {
    if (Platform.isWindows) {
      return await _getWindowsDiskInfo();
    } else if (Platform.isLinux || Platform.isMacOS) {
      return await _getUnixDiskInfo();
    } else {
      throw Exception('Операционная система не поддерживается');
    }
  }

  static Future<String> _getWindowsDiskInfo() async {
    try {
      final result = await Process.run(
          'wmic', ['logicaldisk', 'get', 'name,filesystem,size,volumename']);
      return 'Информация о дисках (Windows):\n${result.stdout}';
    } catch (e) {
      log('Ошибка при получении информации о дисках: $e');
      rethrow;
    }
  }

  static Future<String> _getUnixDiskInfo() async {
    try {
      final result = await Process.run('df', ['-h']);
      return 'Информация о дисках (Unix):\n${result.stdout}';
    } catch (e) {
      log('Ошибка при получении информации о дисках: $e');
      rethrow;
    }
  }
}
