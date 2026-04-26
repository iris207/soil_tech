import 'package:flutter/material.dart';

import 'menu.dart';
import 'crop_selection.dart';

class ScanSavedScreen extends StatelessWidget {
  const ScanSavedScreen({super.key});

  static const Color screenDark = Color(0xFF031006);
  static const Color brightGreen = Color(0xFFA8F51F);
  static const Color softText = Color(0xFF8BD57C);
  static const Color borderGreen = Color(0xFF3AA827);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: screenDark,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(26, 40, 26, 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const _ProgressHeader(),

              const SizedBox(height: 24),

              const _SavedIcon(),

              const SizedBox(height: 28),

              const Text(
                'Scan Saved!',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.w900,
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
                'Your result has been saved to your history.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: softText,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),

              const SizedBox(height: 36),

              SizedBox(
                height: 52,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const Menu(),
                      ),
                      (route) => false,
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
                    'View History',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 15,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 14),

              SizedBox(
                height: 50,
                child: OutlinedButton(
                  onPressed: () {
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const CropSelectionPage(),
                      ),
                      (route) => false,
                    );
                  },
                  style: OutlinedButton.styleFrom(
                    foregroundColor: brightGreen,
                    side: const BorderSide(
                      color: borderGreen,
                      width: 1,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(28),
                    ),
                  ),
                  child: const Text(
                    'Scan Again',
                    style: TextStyle(
                      color: brightGreen,
                      fontSize: 15,
                      fontWeight: FontWeight.w900,
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
          'Step 7 of 7',
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
            value: 7 / 7,
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

class _SavedIcon extends StatelessWidget {
  const _SavedIcon();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 88,
        height: 88,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(
            color: ScanSavedScreen.brightGreen,
            width: 3,
          ),
        ),
        child: Center(
          child: Container(
            width: 52,
            height: 52,
            decoration: BoxDecoration(
              color: const Color(0xFF20C737),
              border: Border.all(
                color: const Color(0xFF0B2608),
                width: 3,
              ),
            ),
            child: const Icon(
              Icons.check_rounded,
              color: Colors.white,
              size: 40,
            ),
          ),
        ),
      ),
    );
  }
}