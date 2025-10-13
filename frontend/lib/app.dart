import 'package:flutter/material.dart';
import 'package:open_banking_app/core/api_client.dart';
import 'package:open_banking_app/repository/user_repository.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  @override
  Widget build(BuildContext context) {
    //TODO - Teste com token mockado - Funcionamento OK, mudar resultado do client.getAll para list.
   final tokenEnv = dotenv.env['TOKEN']!;
    String token = 'Bearer $tokenEnv';
    
    return MaterialApp(
      home: Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(child: Text('Hello World!')),
            ElevatedButton(
              onPressed: () async {
                final client = ApiClient();
                final users = UserRepository(client);
                final test = await users.getAllUsers(token);
                print(test);
              },
              child: Text("press here"),
            ),
          ],
        ),
      ),
    );
  }
}
