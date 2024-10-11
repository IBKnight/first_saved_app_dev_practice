import 'package:first_praktice_safed_application/src/common/strings.dart';
import 'package:first_praktice_safed_application/src/features/home/logic/file_system_checker.dart';
import 'package:flutter/material.dart';

class FileSystemInfoScreen extends StatelessWidget {
  const FileSystemInfoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text(Strings.fileSystemScreen),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Center(
          child: FutureBuilder(
            future: FileSystemChecker.getDiskInfo(),
            builder: (context, snapshot) {
              return Text('${snapshot.data}');
            },
          ),
        ),
      ),
    );
  }
}
