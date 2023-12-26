import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'Signup.dart'; // Import the SignUpPage
import 'firebase_options.dart';
import 'login_page.dart'; // Import the LoginPage
import 'package:firebase_auth/firebase_auth.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp( MyApp());
}


class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SignUpPage(), // Set the SignUpPage as the initial page
      routes: {
        '/signup': (context) => SignUpPage(),
        '/login': (context) => LoginPage(),
      },
    );
  }
}
