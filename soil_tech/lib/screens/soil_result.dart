import 'dart:io';

import 'package:flutter/material.dart';

class SoilResultScreen extends StatelessWidget {
  const SoilResultScreen({
    super.key,
    required this.soilImage,
  });

  final File soilImage;

  static const Color screenDark = Color(0xFF031006);
  static const Color cardDark = Color(0xFF0A2A09);
  static const Color borderGreen = Color(0xFF1C5D1E);
  static const Color brightGreen = Color(0xFFA8F51F);
  static const Color softText = Color(0xFF8BD57C);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: screenDark,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(38, 48, 38, 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const _ProgressHeader(),

              const SizedBox(height: 26),

              const _SuccessIcon(),

              const SizedBox(height: 16),

              const Text(
                'Soil Scan Complete',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.w900,
                  height: 1.15,
                  letterSpacing: -0.4,
                  shadows: [
                    Shadow(
                      color: Color(0xFF6FD368),
                      offset: Offset(1.2, 1.2),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 14),

              const Text(
                "Here's what we found in your sample.",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: softText,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),

              const SizedBox(height: 34),

              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Container(
                  height: 170,
                  width: double.infinity,
                  color: Colors.white,
                  child: Image.file(
                    soilImage,
                    fit: BoxFit.cover,
                  ),
                ),
              ),

              const SizedBox(height: 16),

              const _ResultTile(
                icon: '▯',
                label: 'Soil Type',
                value: 'Loamy',
                valueColor: Color(0xFFA98A57),
              ),

              const SizedBox(height: 12),

              const _ResultTile(
                icon: '🌿',
                label: 'Organic Matter',
                value: 'Low',
                valueColor: Color(0xFFD29B61),
              ),

              const SizedBox(height: 12),

              const _ResultTile(
                icon: '📊',
                label: 'Confidence',
                value: '87.50%',
                valueColor: brightGreen,
                valueTextColor: Colors.black,
              ),

              const SizedBox(height: 24),

              SizedBox(
                height: 52,
                child: ElevatedButton(
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Next step not added yet.'),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    elevation: 0,
                    backgroundColor: brightGreen,
                    foregroundColor: Colors.black,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(28),
                    ),
                  ),
                  child: const Text(
                    'Continue →',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w900,
                      color: Colors.black,
                    ),
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

class _ProgressHeader extends StatelessWidget {
  const _ProgressHeader();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Step 5 of 7',
          style: TextStyle(
            color: Color(0xFF7ED46F),
            fontSize: 13,
            fontWeight: FontWeight.w800,
          ),
        ),
        const SizedBox(height: 14),
        ClipRRect(
          borderRadius: BorderRadius.circular(100),
          child: const LinearProgressIndicator(
            value: 5 / 7,
            minHeight: 3,
            backgroundColor: Color(0xFF245B24),
            valueColor: AlwaysStoppedAnimation<Color>(
              Color(0xFF9AF20F),
            ),
          ),
        ),
      ],
    );
  }
}

class _SuccessIcon extends StatelessWidget {
  const _SuccessIcon();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 94,
        height: 94,
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: Color(0xFF214F16),
        ),
        child: Center(
          child: Container(
            width: 66,
            height: 66,
            decoration: BoxDecoration(
              color: const Color(0xFF25C523),
              borderRadius: BorderRadius.circular(6),
              border: Border.all(
                color: const Color(0xFF0B2608),
                width: 3,
              ),
            ),
            child: const Icon(
              Icons.check_rounded,
              color: Colors.white,
              size: 48,
            ),
          ),
        ),
      ),
    );
  }
}

class _ResultTile extends StatelessWidget {
  const _ResultTile({
    required this.icon,
    required this.label,
    required this.value,
    required this.valueColor,
    this.valueTextColor = Colors.white,
  });

  final String icon;
  final String label;
  final String value;
  final Color valueColor;
  final Color valueTextColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(
        minHeight: 64,
      ),
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 13,
      ),
      decoration: BoxDecoration(
        color: SoilResultScreen.cardDark,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: SoilResultScreen.borderGreen,
          width: 1,
        ),
      ),
      child: Row(
        children: [
          SizedBox(
            width: 24,
            child: Text(
              icon,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 19,
                height: 1,
              ),
            ),
          ),

          const SizedBox(width: 14),

          Expanded(
            child: Text(
              label,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 14,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),

          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 9,
              vertical: 7,
            ),
            decoration: BoxDecoration(
              color: valueColor,
              borderRadius: BorderRadius.circular(6),
            ),
            child: Text(
              value,
              style: TextStyle(
                color: valueTextColor,
                fontSize: 12,
                fontWeight: FontWeight.w900,
              ),
            ),
          ),
        ],
      ),
    );
  }
}