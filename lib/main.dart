import 'package:flutter/material.dart';

import 'myTheme.dart';
import 'presentation/screens/splash_screen.dart';

void main() {
  runApp(const NewsApp());
}

class NewsApp extends StatelessWidget {
  const NewsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Briefly',
      debugShowCheckedModeBanner: false,
      theme: myAppTheme(),
      home: const SplashScreen(),
    );
  }
}
