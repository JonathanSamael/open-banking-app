import 'package:flutter/material.dart';
import 'package:open_banking_app/core/api_client.dart';
import 'package:open_banking_app/repository/user_repository.dart';

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  @override
  Widget build(BuildContext context) {
    //TODO - Teste com token mockado - Funcionamento OK, mudar resultado do client.getAll para list.
    String token =
        "Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6Ikt0aFlyc09tWFdhYzdmWlRibFZ2bCIsImVtYWlsIjoiZW1haWxAdGVzdC5jb20iLCJpYXQiOjE3NjAzNjk3MTcsImV4cCI6MTc2MDM3MzMxN30.NNlHTlvLIEux9RC-0sHniCiaHldtXglxGMtZwZW5zz8";

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
