import 'dart:developer';
import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:xml/xml.dart';

class XmlWorker {
  final String xmlFileName;

  XmlWorker({required this.xmlFileName});

  Future<String> createXmlFile({
    required String rootElementName,
    required String nestedElementName,
    required String nestedElementData,
  }) async {
    try {
      final directory = await getApplicationDocumentsDirectory();

      final builder = XmlBuilder();
      builder.processing('xml', 'version="1.0"');
      builder.element(rootElementName, nest: () {
        builder.element(nestedElementName, nest: nestedElementData);
      });
      final xmlDocument = builder.buildDocument();

      final file = File('${directory.path}/$xmlFileName');
      await file.writeAsString(xmlDocument.toXmlString(pretty: true));
      log('XML файл создан: ${directory.path}/$xmlFileName');
      return 'XML файл создан: ${directory.path}/$xmlFileName';
    } catch (e, stackTrace) {
      log('e: $e, stackTrace: $stackTrace');
      rethrow;
    }
  }

  Future<String> readXmlFile() async {
    try {
      final directory = await getApplicationDocumentsDirectory();

      final file = File('${directory.path}/$xmlFileName');

      if (!(await file.exists())) {
        return 'Файл не найден';
      }

      final content = await file.readAsString();
      final xmlDoc = XmlDocument.parse(content);
      log('Содержимое XML файла:\n$xmlDoc');
      return 'Содержимое XML файла:\n$xmlDoc';
    } catch (e, stackTrace) {
      log('e: $e, stackTrace: $stackTrace');
      rethrow;
    }
  }

  Future<String> modifyXmlFile({
    required String oldElementName,
    required String newElementName,
    required String newValue,
  }) async {
    try {
      final directory = await getApplicationDocumentsDirectory();
      final file = File('${directory.path}/$xmlFileName');

      if (!(await file.exists())) {
        return 'Файл не найден';
      }

      final content = await file.readAsString();
      final xmlDoc = XmlDocument.parse(content);

      // Найти элемент по старому имени
      final element = xmlDoc.findAllElements(oldElementName).firstOrNull;
      if (element != null) {
        // Создать новый элемент с новым именем и значением
        final newElement =
            XmlElement(XmlName(newElementName), [], [XmlText(newValue)]);

        // Заменить старый элемент новым
        element.replace(newElement);
      } else {
        // Если элемент не найден, добавляем новый элемент с новым значением
        final rootElement = xmlDoc.rootElement;
        rootElement.children
            .add(XmlElement(XmlName(newElementName), [], [XmlText(newValue)]));
      }

      // Записать обновленный XML обратно в файл
      await file.writeAsString(xmlDoc.toXmlString(pretty: true));
      log('XML файл обновлен: ${directory.path}/$xmlFileName');
      return 'XML файл обновлен: ${directory.path}/$xmlFileName';
    } catch (e, stackTrace) {
      log('Ошибка изменения XML файла: $e, $stackTrace');
      return 'Ошибка изменения XML файла: $e';
    }
  }
}
