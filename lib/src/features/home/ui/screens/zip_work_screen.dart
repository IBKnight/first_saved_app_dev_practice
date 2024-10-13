import 'package:first_praktice_safed_application/src/common/app_config.dart';
import 'package:first_praktice_safed_application/src/common/paddings.dart';
import 'package:first_praktice_safed_application/src/common/strings.dart';
import 'package:first_praktice_safed_application/src/features/home/logic/zip_worker.dart';
import 'package:first_praktice_safed_application/src/features/home/ui/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';

class ZipWorkScreen extends StatefulWidget {
  const ZipWorkScreen({super.key});

  @override
  State<ZipWorkScreen> createState() => _ZipWorkScreenState();
}

class _ZipWorkScreenState extends State<ZipWorkScreen> {
  late final _fileNameController = TextEditingController();
  late final _futureResult =
      ValueNotifier<Future<String>>(Future<String>(() => ''));

  late final zipWorker = ZipWorker(zipName: AppConfig.kDefaultZipFileName);

  @override
  void dispose() {
    super.dispose();
    _fileNameController.dispose();
    _futureResult.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(Strings.zipWorkerScreen),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Center(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(Strings.fileName),
                  const SizedBox(width: 8),
                  CustomTextField(
                    textController: _fileNameController,
                    hintText: Strings.fileNameHint,
                  ),
                ],
              ),
              padding32,
              OutlinedButton(
                onPressed: () {
                  _futureResult.value = zipWorker.createZipArchive();
                },
                child: const Text(Strings.createZipArchive),
              ),
              padding32,
              OutlinedButton(
                onPressed: () {
                  _futureResult.value =
                      zipWorker.addFileToZipArchive(_fileNameController.text);
                },
                child: const Text(Strings.addFileToZip),
              ),
              padding32,
              OutlinedButton(
                onPressed: () {
                  _futureResult.value = zipWorker.extractZipArchive();
                },
                child: const Text(Strings.extractZipArchive),
              ),
              padding32,
              OutlinedButton(
                onPressed: () {
                  _futureResult.value =
                      zipWorker.deleteZipAndFile(_fileNameController.text);
                },
                child: const Text(Strings.deleteFileAndZip),
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
