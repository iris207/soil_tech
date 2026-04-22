import 'dart:ui';
import 'package:flutter/material.dart';

class SelectScreen extends StatelessWidget {
  const SelectScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const bgColor = Color(0xFFE2E7B5);
    const darkTeal = Color(0xFF005655);

    return Scaffold(
      backgroundColor: bgColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 18, 20, 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Material(
                color: Colors.white.withOpacity(0.32),
                shape: const CircleBorder(),
                child: InkWell(
                  onTap: () => Navigator.pop(context),
                  customBorder: const CircleBorder(),
                  child: const SizedBox(
                    width: 52,
                    height: 52,
                    child: Icon(
                      Icons.arrow_back_ios_new_rounded,
                      size: 22,
                      color: darkTeal,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 28),
              const Text(
                'Get Started',
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.w800,
                  color: darkTeal,
                  letterSpacing: -0.4,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'Choose how you want to begin your soil scan process.',
                style: TextStyle(
                  fontSize: 14,
                  height: 1.5,
                  color: Color(0xFF4C6662),
                ),
              ),
              const SizedBox(height: 28),
              Expanded(
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    final isSmall = constraints.maxWidth < 700;

                    if (isSmall) {
                      return Column(
                        children: [
                          Expanded(
                            child: _SelectCard(
                              title: 'SCAN YOUR SOIL',
                              subtitle:
                                  'Capture your soil data and begin analysis.',
                              assetPath: 'assets/icons/2.png',
                              gradientColors: const [
                                Color(0xFFBDF58C),
                                Color(0xFF95E86C),
                              ],
                              iconColor: darkTeal,
                              onTap: () {
                                // TODO: navigate to scan page
                              },
                            ),
                          ),
                          const SizedBox(height: 18),
                          Expanded(
                            child: _SelectCard(
                              title: 'CHOOSE CROP',
                              subtitle:
                                  'Select a crop to match with your soil result.',
                              assetPath: 'assets/icons/1.png',
                              gradientColors: const [
                                Color(0xFFD8F77D),
                                Color(0xFFC9F001),
                              ],
                              iconColor: darkTeal,
                              onTap: () {
                                // TODO: navigate to crop page
                              },
                            ),
                          ),
                        ],
                      );
                    }

                    return Row(
                      children: [
                        Expanded(
                          child: _SelectCard(
                            title: 'SCAN YOUR SOIL',
                            subtitle:
                                'Capture your soil data and begin analysis.',
                            assetPath: 'assets/icons/2.png',
                            gradientColors: const [
                              Color(0xFFBDF58C),
                              Color(0xFF95E86C),
                            ],
                            iconColor: darkTeal,
                            onTap: () {
                              // TODO: navigate to scan page
                            },
                          ),
                        ),
                        const SizedBox(width: 18),
                        Expanded(
                          child: _SelectCard(
                            title: 'CHOOSE CROP',
                            subtitle:
                                'Select a crop to match with your soil result.',
                            assetPath: 'assets/icons/1.png',
                            gradientColors: const [
                              Color(0xFFD8F77D),
                              Color(0xFFC9F001),
                            ],
                            iconColor: darkTeal,
                            onTap: () {
                              // TODO: navigate to crop page
                            },
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _SelectCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final String assetPath;
  final List<Color> gradientColors;
  final Color iconColor;
  final VoidCallback onTap;

  const _SelectCard({
    required this.title,
    required this.subtitle,
    required this.assetPath,
    required this.gradientColors,
    required this.iconColor,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(30),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            borderRadius: BorderRadius.circular(30),
            onTap: onTap,
            child: Ink(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: gradientColors,
                ),
                borderRadius: BorderRadius.circular(30),
                border: Border.all(
                  color: Colors.white.withOpacity(0.30),
                  width: 1.2,
                ),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFF005655).withOpacity(0.08),
                    blurRadius: 14,
                    offset: const Offset(0, 8),
                  ),
                ],
              ),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  color: Colors.white.withOpacity(0.08),
                ),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20, 22, 20, 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Align(
                        alignment: Alignment.topRight,
                        child: Container(
                          width: 42,
                          height: 42,
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.24),
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: Colors.white.withOpacity(0.25),
                            ),
                          ),
                          child: const Icon(
                            Icons.arrow_forward_rounded,
                            color: Color(0xFF005655),
                            size: 22,
                          ),
                        ),
                      ),
                      const Spacer(),
                      Center(
                        child: Image.asset(
                          assetPath,
                          height: 150,
                          fit: BoxFit.contain,
                          errorBuilder: (context, error, stackTrace) {
                            return Icon(
                              Icons.image_outlined,
                              size: 120,
                              color: iconColor.withOpacity(0.7),
                            );
                          },
                        ),
                      ),
                      const Spacer(),
                      Text(
                        title,
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w800,
                          color: iconColor,
                          letterSpacing: -0.3,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        subtitle,
                        style: TextStyle(
                          fontSize: 13.5,
                          height: 1.45,
                          color: iconColor.withOpacity(0.75),
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}