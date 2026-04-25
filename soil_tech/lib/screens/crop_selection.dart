import 'package:flutter/material.dart';
import 'user_input1.dart';

class CropSelectionPage extends StatefulWidget {
  const CropSelectionPage({super.key});

  @override
  State<CropSelectionPage> createState() => _CropSelectionPageState();
}

class _CropSelectionPageState extends State<CropSelectionPage> {
  final TextEditingController _searchController = TextEditingController();

  String? _selectedCrop;
  String _query = '';

  final List<_CropOption> _crops = const [
    _CropOption(name: 'Rice', icon: '🌾'),
    _CropOption(name: 'Corn', icon: '🌽'),
    _CropOption(name: 'Kamote', icon: '🍠'),
    _CropOption(name: 'Sitaw', icon: '🫘'),
    _CropOption(name: 'Ampalaya', icon: '🥒'),
    _CropOption(name: 'Other', icon: '🖊️'),
  ];

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  List<_CropOption> get _filteredCrops {
    if (_query.trim().isEmpty) return _crops;

    final q = _query.toLowerCase().trim();

    return _crops.where((crop) {
      return crop.name.toLowerCase().contains(q);
    }).toList();
  }

  void _selectCrop(String crop) {
    setState(() {
      _selectedCrop = crop;
    });
  }

  void _goNext() {
  if (_selectedCrop == null) return;

  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => const UserInput1Screen(),
    ),
  );
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF031006),
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              padding: const EdgeInsets.symmetric(
                horizontal: 32,
                vertical: 28,
              ),
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: constraints.maxHeight - 56,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const _ProgressHeader(),

                    const SizedBox(height: 42),

                    const _CropLogo(),

                    const SizedBox(height: 26),

                    const Text(
                      'What crop do you want to plant?',
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

                    const SizedBox(height: 12),

                    const Text(
                      "We'll check if your soil is ready for it.",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Color(0xFF8BD57C),
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),

                    const SizedBox(height: 34),

                    _SearchRow(
                      controller: _searchController,
                      onChanged: (value) {
                        setState(() {
                          _query = value;
                        });
                      },
                      onSearch: () {
                        FocusScope.of(context).unfocus();
                      },
                    ),

                    const SizedBox(height: 20),

                    _CropGrid(
                      crops: _filteredCrops,
                      selectedCrop: _selectedCrop,
                      onSelected: _selectCrop,
                    ),

                    const SizedBox(height: 24),

                    _NextButton(
                      enabled: _selectedCrop != null,
                      onPressed: _goNext,
                    ),
                  ],
                ),
              ),
            );
          },
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
          'Step 1 of 7',
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
            value: 1 / 7,
            minHeight: 3,
            backgroundColor: Color(0xFF245B24),
            valueColor: AlwaysStoppedAnimation<Color>(
              Color(0xFF73CF43),
            ),
          ),
        ),
      ],
    );
  }
}

class _CropLogo extends StatelessWidget {
  const _CropLogo();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: 72,
        height: 72,
        child: Stack(
          alignment: Alignment.center,
          children: [
            Text(
              '🌾',
              style: TextStyle(
                fontSize: 56,
                foreground: Paint()
                  ..style = PaintingStyle.stroke
                  ..strokeWidth = 4
                  ..color = Colors.black,
              ),
            ),
            const Text(
              '🌾',
              style: TextStyle(
                fontSize: 56,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SearchRow extends StatelessWidget {
  const _SearchRow({
    required this.controller,
    required this.onChanged,
    required this.onSearch,
  });

  final TextEditingController controller;
  final ValueChanged<String> onChanged;
  final VoidCallback onSearch;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: SizedBox(
            height: 48,
            child: TextField(
              controller: controller,
              onChanged: onChanged,
              cursorColor: const Color(0xFF8AD673),
              style: const TextStyle(
                color: Colors.white,
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
              decoration: InputDecoration(
                hintText: 'Search a crop...',
                hintStyle: const TextStyle(
                  color: Color(0xFF7AB16E),
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
                filled: true,
                fillColor: const Color(0xFF0A2A09),
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 16,
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(28),
                  borderSide: const BorderSide(
                    color: Color(0xFF1C5D1E),
                    width: 1,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(28),
                  borderSide: const BorderSide(
                    color: Color(0xFF5EBD4B),
                    width: 1.4,
                  ),
                ),
              ),
            ),
          ),
        ),
        const SizedBox(width: 10),
        SizedBox(
          width: 58,
          height: 48,
          child: ElevatedButton(
            onPressed: onSearch,
            style: ElevatedButton.styleFrom(
              padding: EdgeInsets.zero,
              elevation: 0,
              backgroundColor: const Color(0xFF1A551B),
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(28),
              ),
            ),
            child: const Text(
              '🔍',
              style: TextStyle(
                fontSize: 18,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _CropGrid extends StatelessWidget {
  const _CropGrid({
    required this.crops,
    required this.selectedCrop,
    required this.onSelected,
  });

  final List<_CropOption> crops;
  final String? selectedCrop;
  final ValueChanged<String> onSelected;

  @override
  Widget build(BuildContext context) {
    if (crops.isEmpty) {
      return Container(
        height: 120,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: const Color(0xFF0A2A09),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: const Color(0xFF1C5D1E),
          ),
        ),
        child: const Text(
          'No crops found',
          style: TextStyle(
            color: Color(0xFF7ED46F),
            fontWeight: FontWeight.w700,
          ),
        ),
      );
    }

    return GridView.builder(
      itemCount: crops.length,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
        childAspectRatio: 1.9,
      ),
      itemBuilder: (context, index) {
        final crop = crops[index];
        final isSelected = selectedCrop == crop.name;

        return _CropCard(
          crop: crop,
          isSelected: isSelected,
          onTap: () => onSelected(crop.name),
        );
      },
    );
  }
}

class _CropCard extends StatelessWidget {
  const _CropCard({
    required this.crop,
    required this.isSelected,
    required this.onTap,
  });

  final _CropOption crop;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(10),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 180),
          curve: Curves.easeOut,
          decoration: BoxDecoration(
            color: isSelected
                ? const Color(0xFF123F10)
                : const Color(0xFF0A2A09),
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: isSelected
                  ? const Color(0xFF83D56A)
                  : const Color(0xFF1C5D1E),
              width: isSelected ? 1.6 : 1,
            ),
            boxShadow: isSelected
                ? const [
                    BoxShadow(
                      color: Color(0x552C8F29),
                      blurRadius: 12,
                      offset: Offset(0, 4),
                    ),
                  ]
                : null,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                crop.icon,
                style: const TextStyle(
                  fontSize: 25,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                crop.name,
                style: const TextStyle(
                  color: Color(0xFF75C768),
                  fontSize: 14,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _NextButton extends StatelessWidget {
  const _NextButton({
    required this.enabled,
    required this.onPressed,
  });

  final bool enabled;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 52,
      child: ElevatedButton(
        onPressed: enabled ? onPressed : null,
        style: ElevatedButton.styleFrom(
          elevation: 0,
          disabledBackgroundColor: const Color(0xFF0D330C),
          backgroundColor: const Color(0xFF1D611B),
          foregroundColor: Colors.white,
          disabledForegroundColor: const Color(0xFF5D8355),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(28),
          ),
        ),
        child: const Text(
          'Next →',
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w900,
          ),
        ),
      ),
    );
  }
}

class _CropOption {
  const _CropOption({
    required this.name,
    required this.icon,
  });

  final String name;
  final String icon;
}