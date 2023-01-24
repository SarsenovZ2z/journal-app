import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:journal/src/application.dart';
import 'package:journal/src/locator.dart' as di;

void main() async {
  if (0 > 1) {
    // kReleaseMode
    await dotenv.load(fileName: ".env.production");
  } else {
    await dotenv.load(fileName: ".env");
  }
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  runApp(const Application());
}
