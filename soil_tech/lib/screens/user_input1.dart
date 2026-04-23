import 'package:flutter/material.dart';
import 'selection.dart';

class UserInput1Screen extends StatefulWidget {
  const UserInput1Screen({super.key});

  @override
  State<UserInput1Screen> createState() => _UserInput1ScreenState();
}

class _UserInput1ScreenState extends State<UserInput1Screen> {
  static const Color softText = Color(0xFFA7C79A);
  static const Color screenDark = Color(0xFF0C4C38);
  static const Color outlineGreen = Color(0xFF2C8B5D);
  static const Color disabledGreen = Color(0xFF2D6E49);

  String? selectedSoilState;

  @override
  Widget build(BuildContext context) {
    final bool canProceed = selectedSoilState != null;

    return Scaffold(
      backgroundColor: screenDark,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(24, 20, 24, 24),
          child: Column(
            children: [
              const SizedBox(height: 6),
              const Text(
                'Step 1 of 8',
                style: TextStyle(
                  color: softText,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 14),
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
                            width: constraints.maxWidth * (1 / 8),
                            color: const Color(0xFF43B56F),
                          ),
                        ],
                      );
                    },
                  ),
                ),
              ),
              const SizedBox(height: 28),
              const Text(
                '🌱',
                style: TextStyle(fontSize: 78),
              ),
              const SizedBox(height: 14),
              const Text(
                'How is your soil right now?',
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
                'This helps us read your soil photo accurately.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: softText,
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                  height: 1.4,
                ),
              ),
              const SizedBox(height: 34),

              _OptionButton(
                label: 'Wet',
                emoji: '💧',
                isSelected: selectedSoilState == 'Wet',
                onTap: () {
                  setState(() {
                    selectedSoilState = 'Wet';
                  });
                },
              ),
              const SizedBox(height: 20),

              _OptionButton(
                label: 'Normal',
                emoji: '🌿',
                isSelected: selectedSoilState == 'Normal',
                onTap: () {
                  setState(() {
                    selectedSoilState = 'Normal';
                  });
                },
              ),
              const SizedBox(height: 20),

              _OptionButton(
                label: 'Dry',
                emoji: '☀️',
                isSelected: selectedSoilState == 'Dry',
                onTap: () {
                  setState(() {
                    selectedSoilState = 'Dry';
                  });
                },
              ),
              const SizedBox(height: 40),

              SizedBox(
                width: double.infinity,
                height: 76,
                child: ElevatedButton(
                  onPressed: canProceed
                      ? () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const SelectScreen(),
                            ),
                          );
                        }
                      : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                        canProceed ? const Color(0xFF2A7347) : disabledGreen,
                    disabledBackgroundColor: disabledGreen,
                    foregroundColor: canProceed ? Colors.white : Colors.white54,
                    disabledForegroundColor: Colors.white54,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(28),
                    ),
                  ),
                  child: Text(
                    'Next →',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w800,
                      color: canProceed ? Colors.white : Colors.white54,
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

class _OptionButton extends StatelessWidget {
  final String label;
  final String emoji;
  final bool isSelected;
  final VoidCallback onTap;

  const _OptionButton({
    required this.label,
    required this.emoji,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    const Color selectedFill = Color(0xFF1C6A48);

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(28),
        child: Ink(
          width: double.infinity,
          height: 82,
          decoration: BoxDecoration(
            color: isSelected ? selectedFill : Colors.transparent,
            borderRadius: BorderRadius.circular(28),
            border: Border.all(
              color: isSelected ? const Color(0xFF57C27D) : _UserInput1ScreenState.outlineGreen,
              width: 2.2,
            ),
          ),
          child: Center(
            child: Text(
              '$emoji  $label',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 22,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
        ),
      ),
    );
  }
}