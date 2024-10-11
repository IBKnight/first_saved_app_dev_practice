import 'package:first_praktice_safed_application/src/common/strings.dart';
import 'package:first_praktice_safed_application/src/features/home/ui/screens/file_system_info_screen.dart';
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
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
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
              buttonTitle: Strings.fileSystemScreen,
              screen: FileSystemInfoScreen(),
            ),
            SizedBox(height: 32),
          ],
        ),
      ),
    );
  }
}

class NavigateButton extends StatelessWidget {
  const NavigateButton({
    required this.screen,
    required this.buttonTitle,
    super.key,
  });

  final Widget screen;
  final String buttonTitle;

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: () => Navigator.of(context).push(
        MaterialPageRoute(
          builder: (ctx) => screen,
        ),
      ),
      child: Text(buttonTitle),
    );
  }
}
