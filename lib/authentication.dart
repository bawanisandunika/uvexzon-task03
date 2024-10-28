import 'package:firebase_auth/firebase_auth.dart'; // Import Firebase Auth
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart'; // Import Google Sign-In

// Class to handle authentication logic
class AuthenticationService {
  final FirebaseAuth _firebaseAuth;
  final GoogleSignIn _googleSignIn;

  // GoogleSignIn instance with clientId
  AuthenticationService(this._firebaseAuth)
      : _googleSignIn = GoogleSignIn(
          clientId:
              "1037630242103-1mveci0899eafq2lsji0fpu62j961d02.apps.googleusercontent.com",
        );

  // Stream to notify when the authentication state changes
  Stream<User?> get authStateChanges => _firebaseAuth.authStateChanges();

  // Sign-in with email and password
  Future<UserCredential> signInWithEmail(String email, String password) async {
    try {
      return await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
    } on FirebaseAuthException catch (e) {
      throw Exception(e.message);
    }
  }

  // Sign-up with email and password
  Future<UserCredential> signUpWithEmail(String email, String password) async {
    try {
      return await _firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);
    } on FirebaseAuthException catch (e) {
      throw Exception(e.message);
    }
  }

  // Sign out
  Future<void> signOut() async {
    await _firebaseAuth.signOut();
    await _googleSignIn.signOut(); // Sign out from Google as well
  }

  // Sign in with Google
  Future<UserCredential> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();

      if (googleUser == null) {
        throw Exception("Google sign-in was canceled");
      }

      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      return await _firebaseAuth.signInWithCredential(credential);
    } catch (e) {
      throw Exception("Failed to sign in with Google: $e");
    }
  }

  // Get the current user
  User? get currentUser => _firebaseAuth.currentUser;
}

// Example usage in a Flutter widget
class AuthenticationWidget extends StatefulWidget {
  @override
  _AuthenticationWidgetState createState() => _AuthenticationWidgetState();
}

class _AuthenticationWidgetState extends State<AuthenticationWidget> {
  final AuthenticationService _authService =
      AuthenticationService(FirebaseAuth.instance);
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Firebase Auth Example'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _emailController,
              decoration: const InputDecoration(labelText: 'Email'),
            ),
            TextField(
              controller: _passwordController,
              decoration: const InputDecoration(labelText: 'Password'),
              obscureText: true,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                try {
                  final userCredential = await _authService.signInWithEmail(
                      _emailController.text, _passwordController.text);
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content:
                        Text("Signed in as: ${userCredential.user!.email}"),
                  ));
                } catch (e) {
                  ScaffoldMessenger.of(context)
                      .showSnackBar(SnackBar(content: Text(e.toString())));
                }
              },
              child: const Text('Sign In'),
            ),
            ElevatedButton(
              onPressed: () async {
                try {
                  final userCredential = await _authService.signUpWithEmail(
                      _emailController.text, _passwordController.text);
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content:
                        Text("Signed up as: ${userCredential.user!.email}"),
                  ));
                } catch (e) {
                  ScaffoldMessenger.of(context)
                      .showSnackBar(SnackBar(content: Text(e.toString())));
                }
              },
              child: const Text('Sign Up'),
            ),
            ElevatedButton(
              onPressed: () async {
                await _authService.signOut();
                ScaffoldMessenger.of(context)
                    .showSnackBar(const SnackBar(content: Text('Signed Out')));
              },
              child: const Text('Sign Out'),
            ),
            const SizedBox(height: 20),
            ElevatedButton.icon(
              onPressed: () async {
                try {
                  final userCredential = await _authService.signInWithGoogle();
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text(
                        "Signed in with Google: ${userCredential.user!.email}"),
                  ));
                } catch (e) {
                  ScaffoldMessenger.of(context)
                      .showSnackBar(SnackBar(content: Text(e.toString())));
                }
              },
              icon: const Icon(Icons.login),
              label: const Text('Sign In with Google'),
            ),
          ],
        ),
      ),
    );
  }
}
