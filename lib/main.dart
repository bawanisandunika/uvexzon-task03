import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:device_preview/device_preview.dart'; // Import DevicePreview
import 'package:flutter/foundation.dart'; // For checking if the app is in debug mode
import './screens/welcome_screen.dart'; // Your WelcomeScreen

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Firebase
  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: "AIzaSyB7E4IfIKKdBwZagQGrs2nSM9LlPOO9uyA",
      authDomain: "login-9794a.firebaseapp.com",
      projectId: "login-9794a",
      storageBucket: "login-9794a.appspot.com",
      messagingSenderId: "1037630242103",
      appId: "1:1037630242103:web:1a7a68287c9bfa05cceeb2",
    ),
  );

  // Wrap with DevicePreview
  runApp(
    DevicePreview(
      enabled: !kReleaseMode, // Enable DevicePreview only in debug mode
      builder: (context) => const MyApp(), // Wrap your app with DevicePreview
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      builder: DevicePreview.appBuilder,
      useInheritedMediaQuery: true, // Use media queries from DevicePreview
      locale:
          DevicePreview.locale(context), // Preview the app in different locales
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: WelcomeScreen(),
    );
  }
}
