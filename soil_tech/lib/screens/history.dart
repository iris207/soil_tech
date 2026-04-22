import 'dart:ui';
import 'package:flutter/material.dart';
import 'profile.dart';
import 'result.dart';

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final historyItems = [
      const HistoryItem(
        title: 'Corn Soil Scan',
        status: 'Fair Compatibility ⚠️',
        soilType: 'Loamy',
        summary:
            'Low organic matter and excessive drainage were found. Soil improvements are needed to support better corn growth and prevent low yield.',
        recommendation:
            'Add compost, rice hull, clay or silt, and organic mulch.',
      ),
      const HistoryItem(
        title: 'Corn Soil Scan',
        status: 'Fair Compatibility ⚠️',
        soilType: 'Loamy',
        summary:
            'Low organic matter and excessive drainage were found. Soil improvements are needed to support better corn growth and prevent low yield.',
        recommendation:
            'Add compost, rice hull, clay or silt, and organic mulch.',
      ),
      const HistoryItem(
        title: 'Corn Soil Scan',
        status: 'Fair Compatibility ⚠️',
        soilType: 'Loamy',
        summary:
            'Low organic matter and excessive drainage were found. Soil improvements are needed to support better corn growth and prevent low yield.',
        recommendation:
            'Add compost, rice hull, clay or silt, and organic mulch.',
      ),
    ];

    return Scaffold(
      backgroundColor: const Color(0xFFE2E7B5),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(18, 14, 18, 0),
              child: Row(
                children: [
                  _TopCircleButton(
                    icon: Icons.arrow_back_ios_new_rounded,
                    onTap: () => Navigator.pop(context),
                  ),
                  const Spacer(),
                  _TopCircleButton(
                    icon: Icons.history_toggle_off_rounded,
                    onTap: () {},
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      'History',
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.w800,
                        color: Color(0xFF005655),
                        letterSpacing: -0.5,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 8),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Recent soil scans and recommendations',
                  style: TextStyle(
                    fontSize: 14,
                    color: Color(0xFF4C6662),
                    height: 1.4,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 18),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
                  child: Container(
                    height: 54,
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.28),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: Colors.white.withOpacity(0.45),
                        width: 1.2,
                      ),
                    ),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.search_rounded,
                          color: Color(0xFF005655),
                          size: 22,
                        ),
                        const SizedBox(width: 10),
                        Text(
                          'Search history',
                          style: TextStyle(
                            fontSize: 14,
                            color: const Color(0xFF005655).withOpacity(0.55),
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 18),
            Expanded(
              child: ListView.separated(
                padding: const EdgeInsets.fromLTRB(20, 0, 20, 110),
                itemCount: historyItems.length,
                separatorBuilder: (_, __) => const SizedBox(height: 14),
                itemBuilder: (context, index) {
                  return _HistoryCard(item: historyItems[index]);
                },
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: const _HistoryBottomNav(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Container(
        width: 78,
        height: 78,
        decoration: const BoxDecoration(
          color: Color(0xFFE2E7B5),
          shape: BoxShape.circle,
        ),
        child: Padding(
          padding: const EdgeInsets.all(6),
          child: Container(
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Color(0xFFC9F001),
            ),
            child: FloatingActionButton(
              elevation: 0,
              backgroundColor: Colors.transparent,
              shape: const CircleBorder(),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const SoilTechResultsScreen(),
                  ),
                );
              },
              child: const Icon(
                Icons.qr_code_scanner_rounded,
                size: 30,
                color: Color(0xFF005655),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class HistoryItem {
  final String title;
  final String status;
  final String soilType;
  final String summary;
  final String recommendation;

  const HistoryItem({
    required this.title,
    required this.status,
    required this.soilType,
    required this.summary,
    required this.recommendation,
  });
}

class _HistoryCard extends StatelessWidget {
  final HistoryItem item;

  const _HistoryCard({required this.item});

  @override
  Widget build(BuildContext context) {
    final statusIsFair = item.status.toLowerCase().contains('fair');

    return ClipRRect(
      borderRadius: BorderRadius.circular(26),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.fromLTRB(18, 18, 14, 18),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.26),
            borderRadius: BorderRadius.circular(26),
            border: Border.all(
              color: Colors.white.withOpacity(0.42),
              width: 1.2,
            ),
            boxShadow: [
              BoxShadow(
                color: const Color(0xFF005655).withOpacity(0.06),
                blurRadius: 12,
                offset: const Offset(0, 6),
              ),
            ],
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item.title,
                      style: const TextStyle(
                        fontSize: 21,
                        fontWeight: FontWeight.w800,
                        color: Color(0xFF005655),
                        letterSpacing: -0.3,
                      ),
                    ),
                    const SizedBox(height: 12),
                    _TagLine(
                      label: 'Status',
                      value: item.status,
                      background: statusIsFair
                          ? const Color(0xFFC9F001).withOpacity(0.30)
                          : const Color(0xFF00C71E).withOpacity(0.18),
                      color: const Color(0xFF005655),
                    ),
                    const SizedBox(height: 10),
                    _TagLine(
                      label: 'Soil Type',
                      value: item.soilType,
                      background: const Color(0xFF005655).withOpacity(0.12),
                      color: const Color(0xFF005655),
                    ),
                    const SizedBox(height: 14),
                    const Text(
                      'Summary',
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w800,
                        color: Color(0xFF005655),
                        letterSpacing: 0.2,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      item.summary,
                      style: const TextStyle(
                        fontSize: 13.5,
                        height: 1.55,
                        color: Color(0xFF46605D),
                      ),
                    ),
                    const SizedBox(height: 14),
                    const Text(
                      'Recommendation',
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w800,
                        color: Color(0xFF005655),
                        letterSpacing: 0.2,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      item.recommendation,
                      style: const TextStyle(
                        fontSize: 13.5,
                        height: 1.55,
                        color: Color(0xFF46605D),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 14),
              Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  color: const Color(0xFF005655).withOpacity(0.92),
                  shape: BoxShape.circle,
                ),
                child: IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.arrow_forward_ios_rounded,
                    size: 18,
                    color: Colors.white,
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

class _TagLine extends StatelessWidget {
  final String label;
  final String value;
  final Color background;
  final Color color;

  const _TagLine({
    required this.label,
    required this.value,
    required this.background,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Wrap(
      crossAxisAlignment: WrapCrossAlignment.center,
      spacing: 8,
      runSpacing: 6,
      children: [
        Text(
          '$label:',
          style: const TextStyle(
            fontSize: 13.5,
            fontWeight: FontWeight.w700,
            color: Color(0xFF46605D),
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
          decoration: BoxDecoration(
            color: background,
            borderRadius: BorderRadius.circular(999),
          ),
          child: Text(
            value,
            style: TextStyle(
              fontSize: 12.5,
              fontWeight: FontWeight.w700,
              color: color,
            ),
          ),
        ),
      ],
    );
  }
}

class _TopCircleButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;

  const _TopCircleButton({
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white.withOpacity(0.32),
      shape: const CircleBorder(),
      child: InkWell(
        onTap: onTap,
        customBorder: const CircleBorder(),
        child: SizedBox(
          width: 52,
          height: 52,
          child: Icon(
            icon,
            size: 22,
            color: const Color(0xFF005655),
          ),
        ),
      ),
    );
  }
}

class _HistoryBottomNav extends StatelessWidget {
  const _HistoryBottomNav();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(6, 0, 6, 14),
      child: Container(
        height: 72,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(36),
          gradient: const LinearGradient(
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
            colors: [
              Color(0xFF8DDF7C),
              Color(0xFF00C71E),
              Color(0xFFC9F001),
            ],
          ),
        ),
        child: Row(
          children: [
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(
                      Icons.home_rounded,
                      size: 36,
                      color: Color(0xFF005655),
                    ),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.chat_bubble_rounded,
                      size: 32,
                      color: Color(0xFF005655),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 70),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    width: 44,
                    height: 44,
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.22),
                      shape: BoxShape.circle,
                    ),
                    child: IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.history_rounded,
                        size: 26,
                        color: Color(0xFF005655),
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const ProfileScreen(),
                        ),
                      );
                    },
                    icon: const Icon(
                      Icons.person_rounded,
                      size: 34,
                      color: Color(0xFF005655),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}