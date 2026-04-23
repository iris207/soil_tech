import 'package:flutter/material.dart';
import 'profile.dart';
import 'selection.dart';
import 'history.dart';

class Menu extends StatelessWidget {
  const Menu({super.key});

  static const Color bgColor = Color(0xFFE2E7B5);
  static const Color darkTeal = Color(0xFF005655);
  static const Color lime = Color(0xFFC9F001);
  static const Color green = Color(0xFF00C71E);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(18, 18, 18, 110),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const _HeaderSection(),
              const SizedBox(height: 20),

              _ScanNowCard(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const SelectScreen(),
                    ),
                  );
                },
              ),
              const SizedBox(height: 16),

              const _LatestScanCard(),
              const SizedBox(height: 16),

              const _IssuesCard(),
              const SizedBox(height: 16),

              const _FixesCard(),
              const SizedBox(height: 16),

              const _MeaningCard(),
              const SizedBox(height: 16),

              _QuickActionsRow(
                onHistoryTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const HistoryScreen(),
                    ),
                  );
                },
                onProfileTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const ProfileScreen(),
                    ),
                  );
                },
                onScanTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const SelectScreen(),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Container(
        width: 78,
        height: 78,
        decoration: const BoxDecoration(
          color: bgColor,
          shape: BoxShape.circle,
        ),
        child: Padding(
          padding: const EdgeInsets.all(6),
          child: Container(
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: lime,
            ),
            child: FloatingActionButton(
              elevation: 0,
              backgroundColor: Colors.transparent,
              shape: const CircleBorder(),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const SelectScreen(),
                  ),
                );
              },
              child: const Icon(
                Icons.qr_code_scanner_rounded,
                size: 30,
                color: darkTeal,
              ),
            ),
          ),
        ),
      ),
      bottomNavigationBar: Padding(
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
                    // Active Home button
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 8,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.20),
                        borderRadius: BorderRadius.circular(22),
                      ),
                      child: const Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.home_rounded,
                            size: 22,
                            color: darkTeal,
                          ),
                          SizedBox(width: 6),
                        ],
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Advice screen not added yet.'),
                          ),
                        );
                      },
                      icon: const Icon(
                        Icons.chat_bubble_rounded,
                        size: 30,
                        color: darkTeal,
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
                    IconButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const HistoryScreen(),
                          ),
                        );
                      },
                      icon: const Icon(
                        Icons.history_rounded,
                        size: 30,
                        color: darkTeal,
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
                        size: 32,
                        color: darkTeal,
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

class _HeaderSection extends StatelessWidget {
  const _HeaderSection();

  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Good morning, Farmer',
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.w800,
            color: Menu.darkTeal,
            height: 1.1,
          ),
        ),
        SizedBox(height: 8),
        Text(
          'Scan your soil and get crop advice instantly.',
          style: TextStyle(
            fontSize: 15,
            color: Color(0xFF2B5E54),
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}

class _ScanNowCard extends StatelessWidget {
  final VoidCallback onTap;

  const _ScanNowCard({required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Menu.darkTeal,
        borderRadius: BorderRadius.circular(24),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 10,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            children: [
              CircleAvatar(
                radius: 24,
                backgroundColor: Menu.lime,
                child: Icon(
                  Icons.qr_code_scanner_rounded,
                  color: Menu.darkTeal,
                  size: 26,
                ),
              ),
              SizedBox(width: 12),
              Expanded(
                child: Text(
                  'Start Soil Scan',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          const Text(
            'Take a photo of your soil to identify soil type, organic matter, and field recommendations.',
            style: TextStyle(
              color: Colors.white,
              fontSize: 14,
              height: 1.4,
            ),
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: onTap,
            style: ElevatedButton.styleFrom(
              backgroundColor: Menu.lime,
              foregroundColor: Menu.darkTeal,
              elevation: 0,
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 14,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
            ),
            child: const Text(
              'Scan Now',
              style: TextStyle(
                fontWeight: FontWeight.w800,
                fontSize: 15,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _LatestScanCard extends StatelessWidget {
  const _LatestScanCard();

  @override
  Widget build(BuildContext context) {
    return _CardShell(
      title: 'Latest Scan',
      child: Column(
        children: [
          const Row(
            children: [
              Expanded(
                child: _InfoTile(
                  label: 'Soil Type',
                  value: 'Loamy',
                ),
              ),
              SizedBox(width: 10),
              Expanded(
                child: _InfoTile(
                  label: 'Organic Matter',
                  value: 'Low',
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          const Row(
            children: [
              Expanded(
                child: _InfoTile(
                  label: 'Drainage',
                  value: 'Excessive',
                ),
              ),
              SizedBox(width: 10),
              Expanded(
                child: _InfoTile(
                  label: 'Compatibility',
                  value: 'Fair',
                  valueColor: Colors.orange,
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: () {},
                  style: OutlinedButton.styleFrom(
                    foregroundColor: Menu.darkTeal,
                    side: const BorderSide(color: Menu.darkTeal),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                  child: const Text('View Result'),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const SelectScreen(),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Menu.green,
                    foregroundColor: Colors.white,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                  child: const Text('Scan Again'),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _IssuesCard extends StatelessWidget {
  const _IssuesCard();

  @override
  Widget build(BuildContext context) {
    return const _CardShell(
      title: 'Issues Found',
      child: Column(
        children: [
          _BulletItem(text: 'Organic matter is low'),
          SizedBox(height: 10),
          _BulletItem(text: 'Drainage is excessive'),
        ],
      ),
    );
  }
}

class _FixesCard extends StatelessWidget {
  const _FixesCard();

  @override
  Widget build(BuildContext context) {
    return const _CardShell(
      title: 'Suggested Fixes',
      child: Column(
        children: [
          _BulletItem(text: 'Apply compost'),
          SizedBox(height: 10),
          _BulletItem(text: 'Add rice hull'),
          SizedBox(height: 10),
          _BulletItem(text: 'Add clay or silt'),
          SizedBox(height: 10),
          _BulletItem(text: 'Apply thick organic mulch'),
        ],
      ),
    );
  }
}

class _MeaningCard extends StatelessWidget {
  const _MeaningCard();

  @override
  Widget build(BuildContext context) {
    return const _CardShell(
      title: 'What This Means',
      child: Text(
        'If you plant corn in this soil without fixing the drainage and organic matter, your crops may grow weak and produce lower yield.',
        style: TextStyle(
          fontSize: 14,
          height: 1.5,
          color: Menu.darkTeal,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}

class _QuickActionsRow extends StatelessWidget {
  final VoidCallback onHistoryTap;
  final VoidCallback onProfileTap;
  final VoidCallback onScanTap;

  const _QuickActionsRow({
    required this.onHistoryTap,
    required this.onProfileTap,
    required this.onScanTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Quick Actions',
          style: TextStyle(
            color: Menu.darkTeal,
            fontSize: 18,
            fontWeight: FontWeight.w800,
          ),
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: _QuickActionButton(
                icon: Icons.history_rounded,
                label: 'History',
                onTap: onHistoryTap,
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: _QuickActionButton(
                icon: Icons.qr_code_scanner_rounded,
                label: 'Scan',
                onTap: onScanTap,
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: _QuickActionButton(
                icon: Icons.person_rounded,
                label: 'Profile',
                onTap: onProfileTap,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _QuickActionButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const _QuickActionButton({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white.withOpacity(0.55),
      borderRadius: BorderRadius.circular(18),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(18),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16),
          child: Column(
            children: [
              Icon(icon, color: Menu.darkTeal, size: 26),
              const SizedBox(height: 8),
              Text(
                label,
                style: const TextStyle(
                  color: Menu.darkTeal,
                  fontWeight: FontWeight.w700,
                  fontSize: 13,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _CardShell extends StatelessWidget {
  final String title;
  final Widget child;

  const _CardShell({
    required this.title,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.62),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: Colors.white.withOpacity(0.55),
        ),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 8,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              color: Menu.darkTeal,
              fontSize: 18,
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(height: 14),
          child,
        ],
      ),
    );
  }
}

class _InfoTile extends StatelessWidget {
  final String label;
  final String value;
  final Color? valueColor;

  const _InfoTile({
    required this.label,
    required this.value,
    this.valueColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.75),
        borderRadius: BorderRadius.circular(18),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(
              color: Color(0xFF4F6F69),
              fontSize: 12,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            value,
            style: TextStyle(
              color: valueColor ?? Menu.darkTeal,
              fontSize: 16,
              fontWeight: FontWeight.w800,
            ),
          ),
        ],
      ),
    );
  }
}

class _BulletItem extends StatelessWidget {
  final String text;

  const _BulletItem({required this.text});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: const EdgeInsets.only(top: 6),
          width: 8,
          height: 8,
          decoration: const BoxDecoration(
            color: Menu.green,
            shape: BoxShape.circle,
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Text(
            text,
            style: const TextStyle(
              color: Menu.darkTeal,
              fontSize: 14,
              height: 1.4,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }
}