import 'package:flutter/material.dart';
import 'soil_scan.dart';

class SelectScreen extends StatelessWidget {
  const SelectScreen({super.key});

  static const Color softText = Color(0xFFA7C79A);
  static const Color screenDark = Color(0xFF0C4C38);
  static const Color optionBorder = Color(0xFF1B6B49);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: screenDark,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(22, 20, 22, 24),
          child: Column(
            children: [
              Row(
                children: [
                  IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(
                      Icons.arrow_back,
                      color: Colors.white,
                      size: 34,
                    ),
                  ),
                  const Expanded(
                    child: Center(
                      child: Text(
                        'Step 2 of 8',
                        style: TextStyle(
                          color: softText,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 48),
                ],
              ),
              const SizedBox(height: 6),
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Container(
                  height: 6,
                  width: double.infinity,
                  color: Colors.white.withOpacity(0.10),
                  child: LayoutBuilder(
                    builder: (context, constraints) {
                      return Row(
                        children: [
                          Container(
                            width: constraints.maxWidth * 0.25,
                            color: const Color(0xFF43B56F),
                          ),
                        ],
                      );
                    },
                  ),
                ),
              ),
              const SizedBox(height: 26),
              const Text(
                '🌍',
                style: TextStyle(fontSize: 82),
              ),
              const SizedBox(height: 18),
              const Text(
                'How would you like to start?',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 28,
                  fontWeight: FontWeight.w800,
                  height: 1.2,
                ),
              ),
              const SizedBox(height: 14),
              const Text(
                'Choose the method that works best for you.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: softText,
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                  height: 1.4,
                ),
              ),
              const SizedBox(height: 34),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: _StartOptionCard(
                      emoji: '📷',
                      title: 'Scan my soil first',
                      subtitle: 'Take a photo and we analyze it',
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const ScanSoilScreen(),
                          ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(width: 20),
                  Expanded(
                    child: _StartOptionCard(
                      emoji: '🌽',
                      title: 'Pick a crop first',
                      subtitle: 'Choose a crop then scan your soil',
                      onTap: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Crop selection flow not added yet.'),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _StartOptionCard extends StatelessWidget {
  final String emoji;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  const _StartOptionCard({
    required this.emoji,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(20),
        child: Ink(
          height: 240,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: SelectScreen.optionBorder,
              width: 2,
            ),
            color: Colors.transparent,
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  emoji,
                  style: const TextStyle(fontSize: 52),
                ),
                const SizedBox(height: 16),
                Text(
                  title,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 17,
                    fontWeight: FontWeight.w800,
                    height: 1.25,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  subtitle,
                  textAlign: TextAlign.center,
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: SelectScreen.softText,
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    height: 1.35,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}