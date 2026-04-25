import 'package:flutter/material.dart';
import 'soil_scan.dart';

class UserInput2Screen extends StatefulWidget {
  const UserInput2Screen({super.key});

  @override
  State<UserInput2Screen> createState() => _UserInput2ScreenState();
}

class _UserInput2ScreenState extends State<UserInput2Screen> {
  static const Color screenDark = Color(0xFF031006);
  static const Color cardDark = Color(0xFF0A2A09);
  static const Color borderGreen = Color(0xFF1C5D1E);
  static const Color selectedGreen = Color(0xFF8EEB16);
  static const Color softText = Color(0xFF8BD57C);
  static const Color disabledButton = Color(0xFF0D330C);

  String? selectedWaterBehavior;

  final List<_WaterOption> waterOptions = const [
    _WaterOption(
      title: 'Water pools and stays',
      subtitle: 'Poor drainage',
      icon: '▯',
    ),
    _WaterOption(
      title: 'Normal absorption',
      subtitle: 'Moderate',
      icon: '✓',
    ),
    _WaterOption(
      title: 'Drains very fast',
      subtitle: 'Excessive',
      icon: '⚡',
    ),
  ];

  void _goNext() {
    if (selectedWaterBehavior == null) return;

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const ScanSoilScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final bool canProceed = selectedWaterBehavior != null;

    return Scaffold(
      backgroundColor: screenDark,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(21, 36, 21, 28),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const _ProgressHeader(),

              const SizedBox(height: 40),

              const _WaterIcon(),

              const SizedBox(height: 28),

              const Text(
                'How does water behave in your\nsoil?',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.w900,
                  height: 1.35,
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
                'Observe after a heavy rain or watering.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: softText,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),

              const SizedBox(height: 34),

              ...waterOptions.map((option) {
                final bool isSelected =
                    selectedWaterBehavior == option.title;

                return Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: _WaterOptionCard(
                    option: option,
                    isSelected: isSelected,
                    onTap: () {
                      setState(() {
                        selectedWaterBehavior = option.title;
                      });
                    },
                  ),
                );
              }),

              const SizedBox(height: 12),

              SizedBox(
                height: 53,
                child: ElevatedButton(
                  onPressed: canProceed ? _goNext : null,
                  style: ElevatedButton.styleFrom(
                    elevation: 0,
                    backgroundColor: canProceed
                        ? const Color(0xFFA8F51F)
                        : disabledButton,
                    disabledBackgroundColor: disabledButton,
                    foregroundColor:
                        canProceed ? Colors.black : const Color(0xFF5D8355),
                    disabledForegroundColor: const Color(0xFF5D8355),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(28),
                    ),
                  ),
                  child: Text(
                    'Next →',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w900,
                      color: canProceed
                          ? Colors.black
                          : const Color(0xFF5D8355),
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
          'Step 3 of 7',
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
            value: 3 / 7,
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

class _WaterIcon extends StatelessWidget {
  const _WaterIcon();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: 78,
        height: 78,
        child: Stack(
          alignment: Alignment.center,
          children: [
            Text(
              '💧',
              style: TextStyle(
                fontSize: 58,
                foreground: Paint()
                  ..style = PaintingStyle.stroke
                  ..strokeWidth = 4
                  ..color = Colors.black,
              ),
            ),
            const Text(
              '💧',
              style: TextStyle(
                fontSize: 58,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _WaterOptionCard extends StatelessWidget {
  const _WaterOptionCard({
    required this.option,
    required this.isSelected,
    required this.onTap,
  });

  final _WaterOption option;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final bool isNormalAbsorption = option.title == 'Normal absorption';

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(10),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 180),
          curve: Curves.easeOut,
          width: double.infinity,
          constraints: const BoxConstraints(
            minHeight: 73,
          ),
          padding: const EdgeInsets.symmetric(
            horizontal: 18,
            vertical: 14,
          ),
          decoration: BoxDecoration(
            color: _UserInput2ScreenState.cardDark,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: isSelected
                  ? _UserInput2ScreenState.selectedGreen
                  : _UserInput2ScreenState.borderGreen,
              width: isSelected ? 1.4 : 1,
            ),
          ),
          child: Row(
            children: [
              _WaterOptionIcon(
                icon: option.icon,
                selectedGreen: _UserInput2ScreenState.selectedGreen,
                isSelected: isSelected,
                isNormalAbsorption: isNormalAbsorption,
              ),

              const SizedBox(width: 16),

              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      option.title,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      option.subtitle,
                      style: const TextStyle(
                        color: Color(0xFF83D56A),
                        fontSize: 12.5,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _WaterOptionIcon extends StatelessWidget {
  const _WaterOptionIcon({
    required this.icon,
    required this.selectedGreen,
    required this.isSelected,
    required this.isNormalAbsorption,
  });

  final String icon;
  final Color selectedGreen;
  final bool isSelected;
  final bool isNormalAbsorption;

  @override
  Widget build(BuildContext context) {
    if (isNormalAbsorption) {
      return Container(
        width: 25,
        height: 25,
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFF20C737) : Colors.transparent,
          border: Border.all(
            color: isSelected ? const Color(0xFF20C737) : selectedGreen,
            width: 2,
          ),
        ),
        child: Icon(
          Icons.check_rounded,
          color: isSelected ? Colors.white : selectedGreen,
          size: 21,
        ),
      );
    }

    if (icon == '▯') {
      return const SizedBox(
        width: 25,
        height: 25,
        child: Center(
          child: Text(
            '▯',
            style: TextStyle(
              color: Colors.white,
              fontSize: 25,
              fontWeight: FontWeight.w900,
              height: 1,
            ),
          ),
        ),
      );
    }

    return const SizedBox(
      width: 25,
      height: 25,
      child: Center(
        child: Text(
          '⚡',
          style: TextStyle(
            fontSize: 25,
            height: 1,
          ),
        ),
      ),
    );
  }
}

class _WaterOption {
  const _WaterOption({
    required this.title,
    required this.subtitle,
    required this.icon,
  });

  final String title;
  final String subtitle;
  final String icon;
}