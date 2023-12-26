import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'login_page.dart'; // Import the LoginPage

class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

enum UserType { admin, user }

class _SignUpPageState extends State<SignUpPage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();

  UserType _userType = UserType.user; // Default to user

  Future<void> _signUp() async {
    try {
      // Basic form validation
      if (_emailController.text.isEmpty ||
          _usernameController.text.isEmpty ||
          _passwordController.text.isEmpty ||
          _phoneController.text.isEmpty) {
        // Display an error message or handle invalid input
        print('All fields must be filled');
        return;
      }

      UserCredential userCredential = await _auth
          .createUserWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );

      // Store additional user information in Firestore
      await _firestore.collection('users').doc(userCredential.user!.uid).set({
        'email': _emailController.text.trim(),
        'username': _usernameController.text.trim(),
        'phone': _phoneController.text.trim(),
        'userType': _userType == UserType.admin ? 'admin' : 'user',
      });

      // Navigate to the login page
      Navigator.pushNamed(context, '/login');
    } catch (e) {
      print('Error during sign up: $e');
      // Handle sign-up errors
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlueAccent,
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text('Nursery Care',style:TextStyle(fontSize: 20.0,fontWeight:FontWeight.bold,color:Colors.black)),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            children: [
               Image.network(
                'https://www.myotspot.com/wp-content/uploads/2020/04/occupational-therapy-settings-nicu-768x433.jpg', // Replace with the actual URL of your image
                width: 200.0, // Adjust the width as needed
                height: 200.0, // Adjust the height as needed
                fit: BoxFit.cover, // Choose the BoxFit as needed (cover, contain, fill, etc.)
              ),
              Text(
                'Sign Up',
                style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
              ),
              TextField(
                controller: _usernameController,
                decoration: InputDecoration(labelText: 'Username', prefixIcon: Icon(Icons.person)),
              ),
              TextField(
                controller: _emailController,
                decoration: InputDecoration(labelText: 'Email', prefixIcon: Icon(Icons.email)),
                keyboardType: TextInputType.emailAddress,
              ),
              TextField(
                controller: _passwordController,
                decoration: InputDecoration(labelText: 'Password', prefixIcon: Icon(Icons.password)),
                obscureText: true,
              ),
              TextField(
                controller: _phoneController,
                decoration: InputDecoration(labelText: 'Phone Number', prefixIcon: Icon(Icons.call)),
                keyboardType: TextInputType.phone,
              ),
              SizedBox(height: 16.0),
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

                onPressed: _signUp,
                style: ElevatedButton.styleFrom(
                  primary: Colors.white, // Change this to the desired background color
                ),
                child: Text('Sign Up',style:TextStyle(color:Colors.black),),
              ),
              SizedBox(height: 8.0),
              TextButton(
                onPressed: () {
                  // Navigate to the login page
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) => LoginPage()));
                },
                child: Text('Already have an account? Log In'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
