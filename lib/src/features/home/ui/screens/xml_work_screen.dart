import 'package:first_praktice_safed_application/src/common/app_config.dart';
import 'package:first_praktice_safed_application/src/common/paddings.dart';
import 'package:first_praktice_safed_application/src/common/strings.dart';
import 'package:first_praktice_safed_application/src/features/home/logic/file_worker.dart';
import 'package:first_praktice_safed_application/src/features/home/logic/xml_worker.dart';
import 'package:first_praktice_safed_application/src/features/home/ui/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';

class XmlWorkScreen extends StatefulWidget {
  const XmlWorkScreen({super.key});

  @override
  State<XmlWorkScreen> createState() => _XmlWorkScreenState();
}

class _XmlWorkScreenState extends State<XmlWorkScreen> {
  late final _elementNameController = TextEditingController();
  late final _valueController = TextEditingController();
  late final _newElementNameController = TextEditingController();
  late final _newValue = TextEditingController();
  late final _futureResult =
      ValueNotifier<Future<String>>(Future<String>(() => ''));

  String oldName = '';

  @override
  void dispose() {
    super.dispose();
    _elementNameController.dispose();
    _valueController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text(Strings.xmlWorkerScreen),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Center(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(Strings.elementName),
                  const SizedBox(width: 8),
                  CustomTextField(
                    textController: _elementNameController,
                    hintText: Strings.elementName,
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(Strings.value),
                  const SizedBox(width: 8),
                  CustomTextField(
                    textController: _valueController,
                    hintText: Strings.value,
                  ),
                ],
              ),
              padding32,
              OutlinedButton(
                  onPressed: () {
                    _futureResult.value = XmlWorker.createXmlFile(
                        fileName: AppConfig.kDefaultXMLFileName,
                        rootElementName: AppConfig.kDefaultRootElement,
                        nestedElementName: _elementNameController.text,
                        nestedElementData: _valueController.text);
                    oldName = _elementNameController.text;
                  },
                  child: const Text(Strings.createFile)),
              padding32,
              OutlinedButton(
                onPressed: () {
                  _futureResult.value = XmlWorker.readXmlFile(
                    fileName: AppConfig.kDefaultXMLFileName,
                  );
                },
                child: const Text(Strings.readFile),
              ),
              padding32,
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(Strings.newNestedKeyValue),
                  const SizedBox(width: 8),
                  CustomTextField(
                      textController: _newElementNameController, hintText: Strings.newNestedKeyValue),
                ],
              ),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(Strings.newNestedElementValue),
                  const SizedBox(width: 8),
                  CustomTextField(
                      textController: _newValue, hintText: Strings.newValue),
                ],
              ),
              const SizedBox(height: 8),
              OutlinedButton(
                onPressed: () {
                  _futureResult.value = XmlWorker.modifyXmlFile(
                    oldElementName: oldName,
                    newElementName: _newElementNameController.text,
                    fileName: AppConfig.kDefaultXMLFileName,
                    newValue: _newValue.text,
                  );
                },
                child: const Text(Strings.changeXmlValue),
              ),
              padding32,
              OutlinedButton(
                onPressed: () {
                  _futureResult.value = FileWorker.deleteFile(
                    fileName: AppConfig.kDefaultXMLFileName,
                  );
                },
                child: const Text(Strings.deleteFile),
              ),
              padding32,
              ValueListenableBuilder(
                valueListenable: _futureResult,
                builder: (context, value, child) {
                  return FutureBuilder(
                    future: value,
                    builder: (context, snapshot) {
                      return Text('${snapshot.data}');
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
