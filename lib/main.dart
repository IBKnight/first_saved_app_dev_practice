import 'dart:async';
import 'dart:developer';

import 'package:first_praktice_safed_application/src/features/home/ui/screens/main_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runZonedGuarded(
    () => runApp(const MainScreen()),
    (e, stackTrace) => log('e: $e, stackTrace: $stackTrace'),
  );
}
