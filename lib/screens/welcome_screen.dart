import 'package:flutter/material.dart';
import 'login_screen.dart';
import 'register_screen.dart';

class WelcomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Replace this with the correct image path
            Image.asset(
              'lib/assets/welcome_image.png', // Update this path if necessary
              height: 400,
              fit: BoxFit.cover,
            ),
            const SizedBox(height: 30), // Adjust space between image and text
            const Text(
              'Discover Your Dream Job here',
              style: TextStyle(
                fontFamily: "Lato",
                fontSize: 34,
                fontWeight: FontWeight.bold,
                color: Color(0xFF1F41BB), // Correct blue color code
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 10),
            const Text(
              'Explore all the existing job roles based on your interest and study major',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14,
                color: Color.fromARGB(255, 0, 0, 0),
              ),
            ),
            const SizedBox(height: 40), // Space between text and buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                // Login Button
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => LoginScreen()),
                    );
                  },
                  child: const Text('Login'),
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white, // White text
                    backgroundColor: const Color(0xFF1F41BB), // Blue button
                    padding: const EdgeInsets.symmetric(
                        horizontal: 40, vertical: 15),
                    textStyle: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8), // Rounded corners
                    ),
                  ),
                ),
                // Register Button
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => RegisterScreen()),
                    );
                  },
                  child: const Text('Register'),
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.black, // Black text
                    backgroundColor: Colors.white, // White background
                    padding: const EdgeInsets.symmetric(
                        horizontal: 40, vertical: 15),
                    textStyle: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                    side: const BorderSide(
                        color: Colors.black, width: 1), // Black outline
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
