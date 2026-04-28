import 'package:flutter/material.dart';
import 'profile.dart';
import 'result.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  static const Color bgColor = Color(0xFFE2E7B5);
  static const Color darkTeal = Color(0xFF005655);
  static const Color lime = Color(0xFFC9F001);
  static const Color cardColor = Color(0xFFF7F8E8);
  static const Color plotBrown = Color(0xFF7A5708);
  static const Color orange = Color(0xFFE99A16);
  static const Color chipBg = Color(0xFFEAF0D8);

  DateTime selectedMonth = DateTime(2025, 4);

  final List<HistoryItem> historyItems = const [
    HistoryItem(
      title: 'Corn Soil Scan',
      plot: 'Plot A',
      dateText: 'Apr 24, 2025 · 2:30 PM',
      status: ScanStatus.fair,
      soilType: 'Loamy',
      organicMatter: 'Low OM',
      drainage: 'Excessive',
    ),
    HistoryItem(
      title: 'Wheat Analysis',
      plot: 'Plot B',
      dateText: 'Apr 23, 2025 · 10:15 AM',
      status: ScanStatus.fair,
      soilType: 'Loamy',
      organicMatter: 'Low OM',
      drainage: 'Excessive',
    ),
    HistoryItem(
      title: 'Barley Check',
      plot: 'Plot C',
      dateText: 'Apr 22, 2025 · 3:45 PM',
      status: ScanStatus.fair,
      soilType: 'Loamy',
      organicMatter: 'Low OM',
      drainage: 'Excessive',
    ),
  ];

  Future<void> _pickMonthYear() async {
    final int? pickedYear = await showDialog<int>(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: cardColor,
          title: const Text(
            'Choose year',
            style: TextStyle(
              color: darkTeal,
              fontWeight: FontWeight.w900,
            ),
          ),
          content: SizedBox(
            width: double.maxFinite,
            height: 260,
            child: YearPicker(
              firstDate: DateTime(2020),
              lastDate: DateTime(2035),
              selectedDate: selectedMonth,
              onChanged: (date) {
                Navigator.pop(context, date.year);
              },
            ),
          ),
        );
      },
    );

    if (pickedYear == null) return;

    final int? pickedMonth = await showModalBottomSheet<int>(
      context: context,
      backgroundColor: cardColor,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
      ),
      builder: (context) {
        const months = [
          'January',
          'February',
          'March',
          'April',
          'May',
          'June',
          'July',
          'August',
          'September',
          'October',
          'November',
          'December',
        ];

        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(18, 18, 18, 24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  'Choose month',
                  style: TextStyle(
                    color: darkTeal,
                    fontSize: 18,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                const SizedBox(height: 18),
                GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: months.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    childAspectRatio: 2.4,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                  ),
                  itemBuilder: (context, index) {
                    final isSelected =
                        selectedMonth.month == index + 1 &&
                        selectedMonth.year == pickedYear;

                    return InkWell(
                      borderRadius: BorderRadius.circular(999),
                      onTap: () => Navigator.pop(context, index + 1),
                      child: Container(
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: isSelected ? lime : Colors.white,
                          borderRadius: BorderRadius.circular(999),
                          border: Border.all(
                            color: isSelected
                                ? lime
                                : darkTeal.withOpacity(0.12),
                          ),
                        ),
                        child: Text(
                          months[index].substring(0, 3),
                          style: const TextStyle(
                            color: darkTeal,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        );
      },
    );

    if (pickedMonth == null) return;

    setState(() {
      selectedMonth = DateTime(pickedYear, pickedMonth);
    });
  }

  String get _monthLabel {
    const months = [
      'January',
      'February',
      'March',
      'April',
      'May',
      'June',
      'July',
      'August',
      'September',
      'October',
      'November',
      'December',
    ];

    return '${months[selectedMonth.month - 1]} ${selectedMonth.year}';
  }

  void _openScanner() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const SoilTechResultsScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(18, 16, 18, 0),
              child: Row(
                children: [
                  _TopCircleButton(
                    icon: Icons.arrow_back_rounded,
                    onTap: () => Navigator.pop(context),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  const Expanded(
                    child: Text(
                      'History',
                      style: TextStyle(
                        fontSize: 32,
                        height: 1,
                        fontWeight: FontWeight.w900,
                        color: darkTeal,
                        letterSpacing: -1,
                      ),
                    ),
                  ),
                  InkWell(
                    borderRadius: BorderRadius.circular(999),
                    onTap: _pickMonthYear,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 9,
                      ),
                      decoration: BoxDecoration(
                        color: lime,
                        borderRadius: BorderRadius.circular(999),
                      ),
                      child: Text(
                        _monthLabel,
                        style: const TextStyle(
                          color: darkTeal,
                          fontSize: 11,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 14),

            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 18),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  '3 scans recorded',
                  style: TextStyle(
                    color: Color(0xFF4B6562),
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 20),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18),
              child: Container(
                height: 52,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.58),
                  borderRadius: BorderRadius.circular(22),
                  border: Border.all(color: Colors.white, width: 1.2),
                ),
                child: Row(
                  children: [
                    const Icon(
                      Icons.search_rounded,
                      color: darkTeal,
                      size: 24,
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: TextField(
                        cursorColor: darkTeal,
                        decoration: InputDecoration(
                          hintText: 'Search scans...',
                          hintStyle: TextStyle(
                            color: darkTeal.withOpacity(0.48),
                            fontSize: 13,
                            fontWeight: FontWeight.w500,
                          ),
                          border: InputBorder.none,
                        ),
                        style: const TextStyle(
                          color: darkTeal,
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    Icon(
                      Icons.settings_outlined,
                      color: darkTeal.withOpacity(0.85),
                      size: 22,
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 20),

            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 18),
              child: _FilterChipsRow(),
            ),

            const SizedBox(height: 16),

            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 18),
              child: Row(
                children: [
                  Expanded(
                    child: _SummaryCard(
                      value: '12',
                      label: 'Total',
                      labelColor: darkTeal,
                    ),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: _SummaryCard(
                      value: '8',
                      label: 'Suitable',
                      labelColor: Color(0xFF00C71E),
                    ),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: _SummaryCard(
                      value: '4',
                      label: 'Fair',
                      labelColor: orange,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 18),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'RECENT SCANS',
                  style: TextStyle(
                    color: darkTeal,
                    fontSize: 10,
                    fontWeight: FontWeight.w900,
                    letterSpacing: 1.4,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 12),

            Expanded(
              child: ListView.separated(
                padding: const EdgeInsets.fromLTRB(18, 0, 18, 112),
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
              onPressed: _openScanner,
              child: const Icon(
                Icons.qr_code_scanner_rounded,
                size: 30,
                color: darkTeal,
              ),
            ),
          ),
        ),
      ),
      bottomNavigationBar: const _HistoryBottomNav(),
    );
  }
}

enum ScanStatus { suitable, fair, poor }

class HistoryItem {
  final String title;
  final String plot;
  final String dateText;
  final ScanStatus status;
  final String soilType;
  final String organicMatter;
  final String drainage;

  const HistoryItem({
    required this.title,
    required this.plot,
    required this.dateText,
    required this.status,
    required this.soilType,
    required this.organicMatter,
    required this.drainage,
  });
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
      color: Colors.white.withOpacity(0.38),
      shape: const CircleBorder(),
      child: InkWell(
        customBorder: const CircleBorder(),
        onTap: onTap,
        child: const SizedBox(
          width: 52,
          height: 52,
          child: Icon(
            Icons.arrow_back_rounded,
            color: _HistoryScreenState.darkTeal,
            size: 24,
          ),
        ),
      ),
    );
  }
}

class _FilterChipsRow extends StatelessWidget {
  const _FilterChipsRow();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: const [
        _FilterChipPill(
          text: 'All',
          selected: true,
        ),
        SizedBox(width: 8),
        _FilterChipPill(
          text: 'Suitable ✅',
        ),
        SizedBox(width: 8),
        _FilterChipPill(
          text: 'Fair ⚠️',
        ),
        SizedBox(width: 8),
        _FilterChipPill(
          text: 'Poor ❌',
        ),
      ],
    );
  }
}

class _FilterChipPill extends StatelessWidget {
  final String text;
  final bool selected;

  const _FilterChipPill({
    required this.text,
    this.selected = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 36,
      padding: const EdgeInsets.symmetric(horizontal: 15),
      decoration: BoxDecoration(
        color: selected ? _HistoryScreenState.darkTeal : Colors.white.withOpacity(0.62),
        borderRadius: BorderRadius.circular(999),
      ),
      alignment: Alignment.center,
      child: Text(
        text,
        style: TextStyle(
          color: selected ? Colors.white : _HistoryScreenState.darkTeal,
          fontSize: 11,
          fontWeight: FontWeight.w900,
        ),
      ),
    );
  }
}

class _SummaryCard extends StatelessWidget {
  final String value;
  final String label;
  final Color labelColor;

  const _SummaryCard({
    required this.value,
    required this.label,
    required this.labelColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.62),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: Colors.white, width: 1),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            value,
            style: const TextStyle(
              color: _HistoryScreenState.darkTeal,
              fontSize: 23,
              fontWeight: FontWeight.w900,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            label,
            style: TextStyle(
              color: labelColor,
              fontSize: 10,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}

class _HistoryCard extends StatelessWidget {
  final HistoryItem item;

  const _HistoryCard({
    required this.item,
  });

  String get _statusText {
    switch (item.status) {
      case ScanStatus.suitable:
        return 'Suitable ✅';
      case ScanStatus.fair:
        return 'Fair ⚠️';
      case ScanStatus.poor:
        return 'Poor ❌';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: _HistoryScreenState.cardColor.withOpacity(0.86),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: Colors.white, width: 1),
        boxShadow: [
          BoxShadow(
            color: _HistoryScreenState.darkTeal.withOpacity(0.04),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: IntrinsicHeight(
        child: Row(
          children: [
            Container(
              width: 2.2,
              margin: const EdgeInsets.symmetric(vertical: 18),
              decoration: BoxDecoration(
                color: _HistoryScreenState.orange,
                borderRadius: BorderRadius.circular(999),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(22, 16, 16, 16),
                child: Column(
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: 52,
                          height: 52,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: _HistoryScreenState.plotBrown,
                            borderRadius: BorderRadius.circular(13),
                          ),
                          child: Text(
                            item.plot,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 9,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(top: 2),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  item.title,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                    color: _HistoryScreenState.darkTeal,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w900,
                                    letterSpacing: -0.2,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  item.dateText,
                                  style: const TextStyle(
                                    color: Color(0xFF4D6661),
                                    fontSize: 10,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 11,
                            vertical: 7,
                          ),
                          decoration: BoxDecoration(
                            color: const Color(0xFFFFF1CF),
                            borderRadius: BorderRadius.circular(999),
                          ),
                          child: Text(
                            _statusText,
                            style: const TextStyle(
                              color: _HistoryScreenState.orange,
                              fontSize: 10,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 18),
                    Divider(
                      height: 1,
                      color: _HistoryScreenState.darkTeal.withOpacity(0.08),
                    ),
                    const SizedBox(height: 14),
                    Row(
                      children: [
                        _InfoPill(
                          icon: Icons.crop_square_rounded,
                          text: item.soilType,
                        ),
                        const SizedBox(width: 8),
                        _InfoPill(
                          icon: Icons.energy_savings_leaf_rounded,
                          text: item.organicMatter,
                        ),
                        const SizedBox(width: 8),
                        _InfoPill(
                          icon: Icons.water_drop_rounded,
                          text: item.drainage,
                        ),
                        const Spacer(),
                        Material(
                          color: const Color(0xFFDDE9D0),
                          shape: const CircleBorder(),
                          child: InkWell(
                            customBorder: const CircleBorder(),
                            onTap: () {},
                            child: const SizedBox(
                              width: 38,
                              height: 38,
                              child: Icon(
                                Icons.arrow_forward_rounded,
                                color: _HistoryScreenState.darkTeal,
                                size: 18,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _InfoPill extends StatelessWidget {
  final IconData icon;
  final String text;

  const _InfoPill({
    required this.icon,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 7),
        decoration: BoxDecoration(
          color: _HistoryScreenState.chipBg,
          borderRadius: BorderRadius.circular(999),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              color: _HistoryScreenState.darkTeal,
              size: 11,
            ),
            const SizedBox(width: 4),
            Flexible(
              child: Text(
                text,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  color: _HistoryScreenState.darkTeal,
                  fontSize: 10,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _HistoryBottomNav extends StatelessWidget {
  const _HistoryBottomNav();

  static const LinearGradient mainGreenGradient = LinearGradient(
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
    colors: [
      Color(0xFF8DDF7C),
      Color(0xFF00C71E),
      Color(0xFFC9F001),
    ],
  );

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(6, 0, 6, 14),
      child: Container(
        height: 72,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(36),
          gradient: mainGreenGradient,
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
                      color: _HistoryScreenState.darkTeal,
                    ),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.chat_bubble_rounded,
                      size: 32,
                      color: _HistoryScreenState.darkTeal,
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
                        color: _HistoryScreenState.darkTeal,
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
                      color: _HistoryScreenState.darkTeal,
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