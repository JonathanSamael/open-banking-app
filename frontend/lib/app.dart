import 'package:flutter/material.dart';
import 'package:open_banking_app/views/login_page.dart';

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "AdCondo",
      theme: ThemeData(useMaterial3: true),
      home: const LoginPage(),
    );
  }
}
