import 'dart:async';
import 'package:flutter/material.dart';
import 'opening.dart';

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({super.key});

  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  int activeIndex = 0;
  Timer? dotTimer;
  Timer? nextScreenTimer;

  @override
  void initState() {
    super.initState();

    dotTimer = Timer.periodic(const Duration(milliseconds: 300), (timer) {
      if (!mounted) return;
      setState(() {
        activeIndex = (activeIndex + 1) % 5;
      });
    });

    nextScreenTimer = Timer(const Duration(seconds: 4), () {
      if (!mounted) return;
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const OpeningScreen(),
        ),
      );
    });
  }

  @override
  void dispose() {
    dotTimer?.cancel();
    nextScreenTimer?.cancel();
    super.dispose();
  }

  Widget buildDot(int index) {
    final isActive = index == activeIndex;

    return AnimatedContainer(
      duration: const Duration(milliseconds: 250),
      margin: const EdgeInsets.symmetric(horizontal: 7),
      width: isActive ? 14 : 10,
      height: isActive ? 14 : 10,
      decoration: BoxDecoration(
        color: isActive ? Colors.black87 : Colors.black26,
        shape: BoxShape.circle,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF97E86D),
              Color(0xFFA7F07A),
            ],
          ),
        ),
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(5, (index) => buildDot(index)),
          ),
        ),
      ),
    );
  }
}