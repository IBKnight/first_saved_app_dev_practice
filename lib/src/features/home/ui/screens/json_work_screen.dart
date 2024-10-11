import 'package:first_praktice_safed_application/src/common/app_config.dart';
import 'package:first_praktice_safed_application/src/common/paddings.dart';
import 'package:first_praktice_safed_application/src/common/strings.dart';
import 'package:first_praktice_safed_application/src/features/home/logic/file_worker.dart';
import 'package:first_praktice_safed_application/src/features/home/logic/json_worker.dart';
import 'package:first_praktice_safed_application/src/features/home/ui/widgets/custom_text_field.dart';
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
              const Text(Strings.jsonFields),
             const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(Strings.name),
                  const SizedBox(width: 8),
                  CustomTextField(
                    textController: _nameController,
                    hintText: Strings.name,
                  )
                ],
              ),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(Strings.age),
                  const SizedBox(width: 8),
                  CustomTextField(
                    textController: _ageController,
                    hintText: Strings.age,
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
                  _futureResult.value = JsonWorker.readJsonFile(
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
