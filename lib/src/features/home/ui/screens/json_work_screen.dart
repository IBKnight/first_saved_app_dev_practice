import 'package:first_praktice_safed_application/src/common/app_config.dart';
import 'package:first_praktice_safed_application/src/common/paddings.dart';
import 'package:first_praktice_safed_application/src/common/strings.dart';
import 'package:first_praktice_safed_application/src/features/home/logic/file_worker.dart';
import 'package:first_praktice_safed_application/src/features/home/logic/json_worker.dart';
import 'package:flutter/material.dart';

class JsonWorkScreen extends StatefulWidget {
  const JsonWorkScreen({super.key});

  @override
  State<JsonWorkScreen> createState() => _JsonWorkScreenState();
}

class _JsonWorkScreenState extends State<JsonWorkScreen> {
  late final _nameController = TextEditingController();
  late final _ageController = TextEditingController();
  late final _futureResult =
      ValueNotifier<Future<String>>(Future<String>(() => ''));

  @override
  void dispose() {
    super.dispose();
    _nameController.dispose();
    _ageController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text(Strings.jsonWorkerScreen),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Center(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(Strings.name),
                  SizedBox(
                    height: 30,
                    width: 100,
                    child: TextField(
                      controller: _nameController,
                      decoration: const InputDecoration(
                        contentPadding: EdgeInsets.only(left: 8),
                        border: OutlineInputBorder(),
                        hintText: Strings.name,
                      ),
                      maxLines: null,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(Strings.age),
                  SizedBox(
                    height: 30,
                    width: 100,
                    child: TextField(
                      controller: _ageController,
                      decoration: const InputDecoration(
                        contentPadding: EdgeInsets.only(left: 8),
                        border: OutlineInputBorder(),
                        hintText: Strings.age,
                      ),
                      maxLines: null,
                    ),
                  ),
                ],
              ),
              padding32,
              OutlinedButton(
                  onPressed: () {
                    _futureResult.value = JsonWorker.createJsonFile(
                      jsonData: {
                        Strings.name: _nameController.text,
                        Strings.age: _ageController.text
                      },
                      fileName: AppConfig.kDefaultJSONFileName,
                    );
                  },
                  child: const Text(Strings.createFile)),
              padding32,
              OutlinedButton(
                onPressed: () {
                  _futureResult.value = FileWorker.readFile(
                    fileName: AppConfig.kDefaultJSONFileName,
                  );
                },
                child: const Text(Strings.readFile),
              ),
              padding32,
              OutlinedButton(
                onPressed: () {
                  _futureResult.value = FileWorker.deleteFile(
                    fileName: AppConfig.kDefaultJSONFileName,
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
