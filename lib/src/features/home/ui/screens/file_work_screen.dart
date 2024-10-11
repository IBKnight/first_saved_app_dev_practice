import 'package:first_praktice_safed_application/src/common/app_config.dart';
import 'package:first_praktice_safed_application/src/common/paddings.dart';
import 'package:first_praktice_safed_application/src/common/strings.dart';
import 'package:first_praktice_safed_application/src/features/home/logic/file_worker.dart';
import 'package:flutter/material.dart';

class FileWorkScreen extends StatefulWidget {
  const FileWorkScreen({super.key});

  @override
  State<FileWorkScreen> createState() => _FileWorkScreenState();
}

class _FileWorkScreenState extends State<FileWorkScreen> {
  late final _textController = TextEditingController();
  late final _futureResult =
      ValueNotifier<Future<String>>(Future<String>(() => ''));

  @override
  void dispose() {
    super.dispose();
    _textController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text(Strings.fileWorkerScreen),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Center(
          child: Column(
            children: [
              SizedBox(
                width: 200,
                child: TextField(
                  controller: _textController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: Strings.enterFileContent,
                  ),
                  maxLines: null,
                ),
              ),
              padding32,
              OutlinedButton(
                  onPressed: () {
                    _futureResult.value = FileWorker.createFile(
                      content: _textController.text,
                      fileName: AppConfig.kDefaultFileName,
                    );
                  },
                  child: const Text(Strings.createFile)),
              padding32,
              OutlinedButton(
                onPressed: () {
                  _futureResult.value = FileWorker.readFile(
                    fileName: AppConfig.kDefaultFileName,
                  );
                },
                child: const Text(Strings.readFile),
              ),
              padding32,
              OutlinedButton(
                onPressed: () {
                  _futureResult.value = FileWorker.deleteFile(
                    fileName: AppConfig.kDefaultFileName,
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
