import 'dart:async';
import 'dart:developer';

import 'package:first_praktice_safed_application/src/app.dart';
import 'package:flutter/material.dart';

void main() {
  runZonedGuarded(
    () => runApp(const App()),
    (e, stackTrace) => log('e: $e, stackTrace: $stackTrace'),
  );
}
