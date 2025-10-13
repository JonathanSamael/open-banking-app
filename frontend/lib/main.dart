import 'package:flutter/material.dart';
import 'package:open_banking_app/app.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  await dotenv.load(fileName: ".env");
  runApp(const MainApp());
}
