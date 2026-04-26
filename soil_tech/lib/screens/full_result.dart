import 'dart:io';

import 'package:flutter/material.dart';
import 'savescreen.dart';

class FullResultsScreen extends StatelessWidget {
  const FullResultsScreen({
    super.key,
    required this.soilImage,
  });

  final File? soilImage;

  static const Color screenDark = Color(0xFF031006);
  static const Color cardDark = Color(0xFF0A2A09);
  static const Color borderGreen = Color(0xFF3AA827);
  static const Color brightGreen = Color(0xFFA8F51F);
  static const Color softText = Color(0xFF8BD57C);

  static const Color warningRed = Color(0xFF2A0707);
  static const Color warningBorder = Color(0xFFE54848);

  static const Color yellowCard = Color(0xFF221707);
  static const Color yellowBorder = Color(0xFFD39B35);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: screenDark,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(34, 20, 34, 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const _ProgressHeader(),

              const SizedBox(height: 24),

              const _CropHeader(),

              const SizedBox(height: 16),

              _SoilImagePreview(
                soilImage: soilImage,
              ),

              const SizedBox(height: 12),

              const _SoilAnalysisCard(),

              const SizedBox(height: 12),

              const _IssuesFoundCard(),

              const SizedBox(height: 12),

              const _AmendmentsCard(),

              const SizedBox(height: 12),

              const _WhyItMattersCard(),

              const SizedBox(height: 18),

              SizedBox(
                height: 52,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const ScanSavedScreen(),
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
                    'Save Scan ✅',
                    style: TextStyle(
                      fontSize: 14,
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
          'Step 6 of 7',
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
            value: 6 / 7,
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

class _CropHeader extends StatelessWidget {
  const _CropHeader();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '🌾',
              style: TextStyle(fontSize: 28),
            ),
            SizedBox(width: 8),
            Text(
              'Rice',
              style: TextStyle(
                color: Colors.white,
                fontSize: 19,
                fontWeight: FontWeight.w900,
                shadows: [
                  Shadow(
                    color: Color(0xFF6FD368),
                    offset: Offset(1.1, 1.1),
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 12,
            vertical: 6,
          ),
          decoration: BoxDecoration(
            color: const Color(0xFF7F622F),
            borderRadius: BorderRadius.circular(5),
            border: Border.all(
              color: const Color(0xFFFFC74F),
              width: 1,
            ),
          ),
          child: const Text(
            'Fair ⚠️',
            style: TextStyle(
              color: Colors.white,
              fontSize: 10,
              fontWeight: FontWeight.w900,
            ),
          ),
        ),
      ],
    );
  }
}

class _SoilImagePreview extends StatelessWidget {
  const _SoilImagePreview({
    required this.soilImage,
  });

  final File? soilImage;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 130,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: FullResultsScreen.borderGreen,
          width: 1,
        ),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: soilImage != null
            ? Image.file(
                soilImage!,
                fit: BoxFit.cover,
                width: double.infinity,
              )
            : const Center(
                child: Text(
                  'No soil photo available',
                  style: TextStyle(
                    color: Colors.black54,
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
      ),
    );
  }
}

class _SoilAnalysisCard extends StatelessWidget {
  const _SoilAnalysisCard();

  @override
  Widget build(BuildContext context) {
    return const _InfoCard(
      borderColor: FullResultsScreen.borderGreen,
      backgroundColor: FullResultsScreen.cardDark,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _CardTitle(
            icon: '🧪',
            title: 'SOIL ANALYSIS',
            titleColor: Colors.white,
          ),
          SizedBox(height: 14),
          _AnalysisRow(
            icon: '▯',
            label: 'Soil Type',
            value: 'Loamy',
            valueColor: Color(0xFFA98A57),
          ),
          SizedBox(height: 8),
          _AnalysisRow(
            icon: '🌿',
            label: 'Organic Matter',
            value: 'Low',
            valueColor: Color(0xFFD29B61),
          ),
          SizedBox(height: 8),
          _AnalysisRow(
            icon: '💧',
            label: 'Drainage',
            value: 'Excessive',
            valueColor: Color(0xFFD29B61),
          ),
          SizedBox(height: 12),
          Text(
            'AI Confidence',
            style: TextStyle(
              color: Color(0xFF6FCB5B),
              fontSize: 10,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 4),
          Row(
            children: [
              Expanded(
                child: ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                  child: LinearProgressIndicator(
                    value: 0.875,
                    minHeight: 5,
                    backgroundColor: Color(0xFF245B24),
                    valueColor: AlwaysStoppedAnimation<Color>(
                      Color(0xFF9AF20F),
                    ),
                  ),
                ),
              ),
              SizedBox(width: 8),
              Text(
                '87.50%',
                style: TextStyle(
                  color: Color(0xFF9AF20F),
                  fontSize: 10,
                  fontWeight: FontWeight.w900,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _IssuesFoundCard extends StatelessWidget {
  const _IssuesFoundCard();

  @override
  Widget build(BuildContext context) {
    return const _InfoCard(
      borderColor: FullResultsScreen.warningBorder,
      backgroundColor: FullResultsScreen.warningRed,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _CardTitle(
            icon: '⚠️',
            title: 'ISSUES FOUND',
            titleColor: Color(0xFFFF5555),
          ),
          SizedBox(height: 12),
          _BulletText(
            text: 'Organic matter is low',
            color: Color(0xFFFF5555),
          ),
          SizedBox(height: 6),
          _BulletText(
            text: 'Drainage is excessive',
            color: Color(0xFFFF5555),
          ),
        ],
      ),
    );
  }
}

class _AmendmentsCard extends StatelessWidget {
  const _AmendmentsCard();

  @override
  Widget build(BuildContext context) {
    return const _InfoCard(
      borderColor: FullResultsScreen.borderGreen,
      backgroundColor: FullResultsScreen.cardDark,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _CardTitle(
            icon: '🛠️',
            title: 'AMENDMENTS',
            titleColor: Colors.white,
          ),
          SizedBox(height: 12),
          _CheckText(text: 'Apply compost (2-3 kg/sq meter)'),
          SizedBox(height: 6),
          _CheckText(text: 'Add rice hull or carbonized rice hull'),
          SizedBox(height: 6),
          _CheckText(text: 'Add clay or silt to slow drainage'),
          SizedBox(height: 6),
          _CheckText(text: 'Apply thick organic mulch'),
        ],
      ),
    );
  }
}

class _WhyItMattersCard extends StatelessWidget {
  const _WhyItMattersCard();

  @override
  Widget build(BuildContext context) {
    return const _InfoCard(
      borderColor: FullResultsScreen.yellowBorder,
      backgroundColor: FullResultsScreen.yellowCard,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _CardTitle(
            icon: '💡',
            title: 'WHY IT MATTERS',
            titleColor: Color(0xFFFFC64F),
          ),
          SizedBox(height: 12),
          Text(
            'If you plant this crop without fixing the drainage and organic matter, your crops will grow weak with poor yields. Fast drainage causes water and fertilizer to wash away before roots absorb them.',
            style: TextStyle(
              color: Color(0xFFFFD98B),
              fontSize: 11,
              height: 1.45,
              fontStyle: FontStyle.italic,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}

class _InfoCard extends StatelessWidget {
  const _InfoCard({
    required this.child,
    required this.borderColor,
    required this.backgroundColor,
  });

  final Widget child;
  final Color borderColor;
  final Color backgroundColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(12, 13, 12, 13),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(9),
        border: Border.all(
          color: borderColor,
          width: 1,
        ),
      ),
      child: child,
    );
  }
}

class _CardTitle extends StatelessWidget {
  const _CardTitle({
    required this.icon,
    required this.title,
    required this.titleColor,
  });

  final String icon;
  final String title;
  final Color titleColor;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          icon,
          style: const TextStyle(fontSize: 15),
        ),
        const SizedBox(width: 8),
        Text(
          title,
          style: TextStyle(
            color: titleColor,
            fontSize: 11,
            fontWeight: FontWeight.w900,
          ),
        ),
      ],
    );
  }
}

class _AnalysisRow extends StatelessWidget {
  const _AnalysisRow({
    required this.icon,
    required this.label,
    required this.value,
    required this.valueColor,
  });

  final String icon;
  final String label;
  final String value;
  final Color valueColor;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: 18,
          child: Text(
            icon,
            style: const TextStyle(fontSize: 12),
          ),
        ),
        Expanded(
          child: Text(
            label,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 11,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 7,
            vertical: 5,
          ),
          decoration: BoxDecoration(
            color: valueColor,
            borderRadius: BorderRadius.circular(4),
          ),
          child: Text(
            value,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 10,
              fontWeight: FontWeight.w900,
            ),
          ),
        ),
      ],
    );
  }
}

class _BulletText extends StatelessWidget {
  const _BulletText({
    required this.text,
    required this.color,
  });

  final String text;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Text(
      '• $text',
      style: TextStyle(
        color: color,
        fontSize: 11,
        fontWeight: FontWeight.w700,
      ),
    );
  }
}

class _CheckText extends StatelessWidget {
  const _CheckText({
    required this.text,
  });

  final String text;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Icon(
          Icons.check_circle_outline_rounded,
          color: FullResultsScreen.brightGreen,
          size: 15,
        ),
        const SizedBox(width: 6),
        Expanded(
          child: Text(
            text,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 11,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ],
    );
  }
}