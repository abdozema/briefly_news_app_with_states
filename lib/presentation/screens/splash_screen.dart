import 'dart:async';
import 'package:flutter/material.dart';

import 'news_list_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fade;
  double _progress = 0.0;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 3000),
    );

    _fade = CurvedAnimation(parent: _controller, curve: Curves.easeIn);

    _controller.forward();
    _startFakeLoading();
  }

  void _startFakeLoading() {
    Timer.periodic(const Duration(milliseconds: 120), (timer) {
      setState(() {
        _progress += 0.05;
      });

      if (_progress >= 1) {
        timer.cancel();
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const NewsListScreen()),
        );
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: const Color(0xFF0F172A), // Dark elegant background
      body: FadeTransition(
        opacity: _fade,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              /// Logo
              Container(
                width: 90,
                height: 90,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(
                    colors: [scheme.primary, scheme.primary.withAlpha(204)],
                  ),
                ),
                child: const Icon(
                  Icons.bolt_rounded,
                  size: 42,
                  color: Colors.white,
                ),
              ),

              const SizedBox(height: 24),

              /// App Name
              const Text(
                'Briefly',
                style: TextStyle(
                  fontSize: 34,
                  fontWeight: FontWeight.w800,
                  color: Colors.white,
                  letterSpacing: 0.5,
                ),
              ),

              const SizedBox(height: 6),

              Text(
                'News, simplified.',
                style: TextStyle(color: Colors.white70, fontSize: 14),
              ),

              const SizedBox(height: 40),

              /// Loading Bar
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 60),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: LinearProgressIndicator(
                    value: _progress,
                    minHeight: 6,
                    backgroundColor: Colors.white12,
                    valueColor: AlwaysStoppedAnimation(scheme.primary),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
