import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../authentication.dart'; // Import your AuthenticationService class
import 'package:font_awesome_flutter/font_awesome_flutter.dart'; // For social media icons

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final AuthenticationService _authService =
      AuthenticationService(FirebaseAuth.instance);

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Login here',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Color(0xFF1F41BB), // Updated to match the blue shade
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 10),
            Text(
              'Welcome back you\'ve                                                  been missed!',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            SizedBox(height: 30),
            TextField(
              controller: _emailController,
              decoration: InputDecoration(
                labelText: 'Email',
                labelStyle: TextStyle(color: Colors.black),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(color: Colors.grey),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(color: Color(0xFF1A73E8)),
                ),
              ),
            ),
            SizedBox(height: 20),
            TextField(
              controller: _passwordController,
              decoration: InputDecoration(
                labelText: 'Password',
                labelStyle: TextStyle(color: Colors.black),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(color: Colors.grey),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(color: Color(0xFF1A73E8)),
                ),
              ),
              obscureText: true,
            ),
            SizedBox(height: 10),
            Align(
              alignment: Alignment.centerRight,
              child: Text(
                'Forgot your password?',
                style: TextStyle(
                  color: Color.fromARGB(255, 82, 20, 197), // Updated blue color
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                // Firebase Authentication login logic
                try {
                  // If login is successful, show a success message
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Login successful!')),
                  );
                } on FirebaseAuthException catch (e) {
                  // Handle login errors
                  String message;
                  if (e.code == 'user-not-found') {
                    message = 'No user found for that email.';
                  } else if (e.code == 'wrong-password') {
                    message = 'Wrong password provided for that user.';
                  } else {
                    message = 'Error logging in: ${e.message}';
                  }
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(message)),
                  );
                }
              },
              child: Text('Sign in'),
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: Color(0xFF1F41BB), // Updated button color
                padding: EdgeInsets.symmetric(horizontal: 120, vertical: 15),
                textStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
            SizedBox(height: 10),
            Text(
              'Create new account',
              style: TextStyle(
                color: Colors.grey,
                fontSize: 14,
              ),
            ),
            SizedBox(height: 20),
            Text(
              'Or continue with',
              style: TextStyle(
                  fontSize: 14, color: Color(0xFF1F41BB)), // Updated color
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  icon: FaIcon(FontAwesomeIcons.google),
                  color: Colors.black, // Google icon color (remains same)
                  onPressed: () {},
                ),
                SizedBox(width: 10),
                IconButton(
                  icon: FaIcon(FontAwesomeIcons.facebookF),
                  color: Colors.black, // Facebook icon color (remains same)
                  onPressed: () {},
                ),
                SizedBox(width: 10),
                IconButton(
                  icon: FaIcon(FontAwesomeIcons.apple),
                  color: Colors.black, // Apple icon color (remains same)
                  onPressed: () {},
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
