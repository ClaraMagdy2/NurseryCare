import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'Signup.dart';
import 'admin_home_page.dart'; // Import the AdminHomePage
import 'user_home_page.dart'; // Import the UserHomePage

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final TextEditingController _email = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  UserType _userType = UserType.user; // Default to user

  Future<void> _signIn() async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: _email.text.trim(),
        password: _passwordController.text.trim(),
      );

      // Retrieve user information from Firestore
      DocumentSnapshot userDoc = await FirebaseFirestore.instance
          .collection('users')
          .doc(userCredential.user!.uid)
          .get();

      String userType = userDoc['userType'];

      // Navigate based on user type
      if (userType == 'admin' && _userType == UserType.admin) {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => AdminHomePage()));
      } else if (userType == 'user' && _userType == UserType.user) {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => UserHomePage()));
      } else {
        // Handle unauthorized access or show an error message
        print('Unauthorized access');
      }
    } catch (e) {
      print('Error during sign in: $e');
      // Handle sign-in errors
    }
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlueAccent,
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text('Login',style:TextStyle( color:Colors.black)),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            children: [
              TextField(
                controller: _email,
                decoration: InputDecoration(labelText: 'Email',prefixIcon: Icon(Icons.email)),
              ),
              TextField(
                controller: _passwordController,
                decoration: InputDecoration(labelText: 'Password',prefixIcon: Icon(Icons.password)),
                obscureText: true,
              ),
              Row(
                children: [
                  Text('User Type:'),
                  Radio(
                    value: UserType.admin,
                    groupValue: _userType,
                    onChanged: (value) {
                      setState(() {
                        _userType = value as UserType;
                      });
                    },
                  ),
                  Text('Admin'),
                  Radio(
                    value: UserType.user,
                    groupValue: _userType,
                    onChanged: (value) {
                      setState(() {
                        _userType = value as UserType;
                      });
                    },
                  ),
                  Text('User'),
                ],
              ),
              SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: _signIn,
                style: ElevatedButton.styleFrom(
                  primary: Colors.white, // Change this to the desired background color
                ),
                child: Text('Sign In',style:TextStyle(color: Colors.black),),

              ),
              SizedBox(height: 8.0),
              TextButton(
                onPressed: () {
                  // Navigate to the sign-up page
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) => SignUpPage()));
                },
                child: Text("Don't have an account? Sign Up"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
