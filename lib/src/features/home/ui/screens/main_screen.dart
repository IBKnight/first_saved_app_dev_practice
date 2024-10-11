import 'package:first_praktice_safed_application/src/features/home/ui/widgets/main_screen_body.dart';
import 'package:flutter/material.dart';

import '../../../../common/strings.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: Strings.appTitle,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MainScreenBody(),
    );
  }
}
