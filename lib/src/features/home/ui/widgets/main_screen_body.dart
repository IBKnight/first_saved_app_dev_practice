import 'package:first_praktice_safed_application/src/common/strings.dart';
import 'package:first_praktice_safed_application/src/features/home/ui/screens/file_system_info_screen.dart';
import 'package:first_praktice_safed_application/src/features/home/ui/screens/file_work_screen.dart';
import 'package:first_praktice_safed_application/src/features/home/ui/screens/json_work_screen.dart';
import 'package:first_praktice_safed_application/src/features/home/ui/screens/xml_work_screen.dart';
import 'package:first_praktice_safed_application/src/features/home/ui/screens/zip_work_screen.dart';
import 'package:first_praktice_safed_application/src/features/home/ui/widgets/navigation_button.dart';
import 'package:flutter/material.dart';

class MainScreenBody extends StatefulWidget {
  const MainScreenBody({super.key});

  @override
  State<MainScreenBody> createState() => _MainScreenBodyState();
}

class _MainScreenBodyState extends State<MainScreenBody> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(Strings.appTitle),
      ),
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            NavigateButton(
              buttonTitle: Strings.fileSystemScreen,
              screen: FileSystemInfoScreen(),
            ),
            SizedBox(height: 32),
            NavigateButton(
              buttonTitle: Strings.fileWorkerScreen,
              screen: FileWorkScreen(),
            ),
            SizedBox(height: 32),
            NavigateButton(
              buttonTitle: Strings.jsonWorkerScreen,
              screen: JsonWorkScreen(),
            ),
            SizedBox(height: 32),
            NavigateButton(
              buttonTitle: Strings.xmlWorkerScreen,
              screen: XmlWorkScreen(),
            ),
            SizedBox(height: 32),
            NavigateButton(
              buttonTitle: Strings.zipWorkerScreen,
              screen: ZipWorkScreen(),
            ),
            SizedBox(height: 32),
          ],
        ),
      ),
    );
  }
}
