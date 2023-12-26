// UserHomePage.dart

import 'package:flutter/material.dart';
import 'ShowBabyInfoPage.dart';  // Import the new page

class UserHomePage extends StatefulWidget {
  @override
  _UserHomePageState createState() => _UserHomePageState();
}

class _UserHomePageState extends State<UserHomePage> {
  final TextEditingController _babyIdController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlueAccent,
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text('User Home Page'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _babyIdController,
              decoration: InputDecoration(labelText: 'Enter Baby ID'),
            ),
            ElevatedButton(
              onPressed: () {
                String babyId = _babyIdController.text.trim();
                if (babyId.isNotEmpty) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ShowBabyInfoPage(babyId: babyId),
                    ),
                  );
                }
              },
              child: Text('Show Baby Information'),
            ),
          ],
        ),
      ),
    );
  }
}
