import 'package:flutter/material.dart';
import 'package:reddit_clone_flutter/features/auth/screens/login_screen.dart';
import 'package:reddit_clone_flutter/theme/pallete.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Reddit',
      theme: Pallete.darkModeAppTheme,
      home: const LoginScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}