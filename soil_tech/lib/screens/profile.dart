import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'edit_profile.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  static const Color bgColor = Color(0xFFE2E7B5);
  static const Color darkTeal = Color(0xFF005655);
  static const Color lime = Color(0xFFC9F001);
  static const Color green = Color(0xFF00C71E);
  static const Color lightGreen = Color(0xFF8DDF7C);
  static const Color cardColor = Color(0xFFF7F8E8);
  static const Color orange = Color(0xFFE57A00);

  static const LinearGradient headerGradient = LinearGradient(
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
    colors: [
      Color(0xFF8DDF7C),
      Color(0xFF00C71E),
      Color(0xFFC9F001),
    ],
  );

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final ImagePicker _picker = ImagePicker();

  String username = 'Juan Dela Cruz';
  String fullName = 'Juan Dela Cruz';
  String phoneNumber = '+63 912 345 6789';
  String email = 'juan.delacruz@gmail.com';
  String location = 'Davao City, Philippines';

  File? profileImage;

  Future<void> _openEditProfile() async {
    final result = await Navigator.push<Map<String, dynamic>>(
      context,
      MaterialPageRoute(
        builder: (context) => EditProfileScreen(
          initialUsername: username,
          initialFullName: fullName,
          initialPhoneNumber: phoneNumber,
          initialEmail: email,
          initialLocation: location,
          initialImage: profileImage,
        ),
      ),
    );

    if (result == null) return;

    setState(() {
      username = result['username'] ?? username;
      fullName = result['fullName'] ?? fullName;
      phoneNumber = result['phoneNumber'] ?? phoneNumber;
      email = result['email'] ?? email;
      location = result['location'] ?? location;
      profileImage = result['profileImage'] ?? profileImage;
    });
  }

  Future<void> _showImageSourceOptions() async {
    showModalBottomSheet(
      context: context,
      backgroundColor: ProfileScreen.cardColor,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(24),
        ),
      ),
      builder: (context) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 20, 20, 28),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  'Upload Profile Photo',
                  style: TextStyle(
                    color: ProfileScreen.darkTeal,
                    fontSize: 18,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                const SizedBox(height: 18),
                ListTile(
                  leading: const Icon(
                    Icons.camera_alt_rounded,
                    color: ProfileScreen.darkTeal,
                  ),
                  title: const Text(
                    'Take Photo',
                    style: TextStyle(
                      color: ProfileScreen.darkTeal,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  onTap: () async {
                    Navigator.pop(context);
                    await _pickImage(ImageSource.camera);
                  },
                ),
                ListTile(
                  leading: const Icon(
                    Icons.photo_library_rounded,
                    color: ProfileScreen.darkTeal,
                  ),
                  title: const Text(
                    'Choose from Gallery',
                    style: TextStyle(
                      color: ProfileScreen.darkTeal,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  onTap: () async {
                    Navigator.pop(context);
                    await _pickImage(ImageSource.gallery);
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Future<void> _pickImage(ImageSource source) async {
    final XFile? pickedFile = await _picker.pickImage(
      source: source,
      imageQuality: 85,
    );

    if (pickedFile == null) return;

    setState(() {
      profileImage = File(pickedFile.path);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ProfileScreen.bgColor,
      body: SafeArea(
        bottom: false,
        child: SingleChildScrollView(
          padding: const EdgeInsets.only(bottom: 28),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _ProfileHeader(
                profileImage: profileImage,
                onBack: () => Navigator.pop(context),
                onCameraTap: _showImageSourceOptions,
                onEdit: _openEditProfile,
              ),

              const SizedBox(height: 8),

              Center(
                child: Text(
                  username,
                  style: const TextStyle(
                    color: ProfileScreen.darkTeal,
                    fontSize: 18,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ),

              const SizedBox(height: 14),

              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 8),
                child: _SectionTitle('ACCOUNT INFO'),
              ),

              const SizedBox(height: 10),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 6),
                child: _AccountInfoCard(
                  fullName: fullName,
                  phoneNumber: phoneNumber,
                  email: email,
                  location: location,
                ),
              ),

              const SizedBox(height: 18),

              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 8),
                child: _SectionTitle('FARMING PROFILE'),
              ),

              const SizedBox(height: 10),

              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 6),
                child: _FarmingProfileCard(),
              ),

              const SizedBox(height: 18),

              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 8),
                child: _SectionTitle('SECURITY'),
              ),

              const SizedBox(height: 10),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 6),
                child: _ActionCard(
                  icon: Icons.lock_outline_rounded,
                  title: 'Change Password',
                  titleColor: ProfileScreen.darkTeal,
                  arrowBg: const Color(0xFFDCEBD5),
                  arrowColor: ProfileScreen.darkTeal,
                  onTap: () {},
                ),
              ),

              const SizedBox(height: 10),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 6),
                child: _ActionCard(
                  icon: Icons.logout_rounded,
                  title: 'Sign Out',
                  titleColor: ProfileScreen.orange,
                  arrowBg: const Color(0xFFF8E7C8),
                  arrowColor: ProfileScreen.orange,
                  onTap: () {},
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ProfileHeader extends StatelessWidget {
  final VoidCallback onBack;
  final VoidCallback onCameraTap;
  final VoidCallback onEdit;
  final File? profileImage;

  const _ProfileHeader({
    required this.onBack,
    required this.onCameraTap,
    required this.onEdit,
    required this.profileImage,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 218,
      width: double.infinity,
      child: Stack(
        clipBehavior: Clip.none,
        alignment: Alignment.topCenter,
        children: [
          Container(
            height: 158,
            width: double.infinity,
            decoration: const BoxDecoration(
              gradient: ProfileScreen.headerGradient,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.elliptical(220, 44),
                bottomRight: Radius.elliptical(220, 44),
              ),
            ),
            child: Stack(
              children: [
                Positioned(
                  left: -58,
                  top: -52,
                  child: Container(
                    width: 132,
                    height: 132,
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.15),
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
                Positioned(
                  right: -28,
                  top: -42,
                  child: Container(
                    width: 150,
                    height: 150,
                    decoration: BoxDecoration(
                      color: ProfileScreen.lime.withOpacity(0.35),
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
                Positioned(
                  left: 16,
                  top: 14,
                  child: _CircleButton(
                    icon: Icons.arrow_back_rounded,
                    onTap: onBack,
                  ),
                ),
                const Positioned(
                  top: 27,
                  left: 0,
                  right: 0,
                  child: Center(
                    child: Text(
                      'PROFILE',
                      style: TextStyle(
                        color: ProfileScreen.darkTeal,
                        fontSize: 11,
                        fontWeight: FontWeight.w900,
                        letterSpacing: 2.4,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  right: 14,
                  top: 18,
                  child: GestureDetector(
                    onTap: onEdit,
                    child: Container(
                      height: 34,
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.36),
                        borderRadius: BorderRadius.circular(999),
                      ),
                      child: const Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            'Edit',
                            style: TextStyle(
                              color: ProfileScreen.darkTeal,
                              fontSize: 14,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                          SizedBox(width: 5),
                          Icon(
                            Icons.edit_rounded,
                            size: 15,
                            color: ProfileScreen.darkTeal,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          Positioned(
            top: 112,
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                Container(
                  width: 92,
                  height: 92,
                  padding: const EdgeInsets.all(5),
                  decoration: const BoxDecoration(
                    color: ProfileScreen.lime,
                    shape: BoxShape.circle,
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                      color: ProfileScreen.darkTeal,
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: Colors.white,
                        width: 3,
                      ),
                      image: profileImage != null
                          ? DecorationImage(
                              image: FileImage(profileImage!),
                              fit: BoxFit.cover,
                            )
                          : null,
                    ),
                    child: profileImage == null
                        ? const Center(
                            child: Text(
                              'JD',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 26,
                                fontWeight: FontWeight.w900,
                              ),
                            ),
                          )
                        : null,
                  ),
                ),
                Positioned(
                  right: 2,
                  bottom: 4,
                  child: GestureDetector(
                    onTap: onCameraTap,
                    child: Container(
                      width: 28,
                      height: 28,
                      decoration: BoxDecoration(
                        color: ProfileScreen.lime,
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: ProfileScreen.darkTeal,
                          width: 2,
                        ),
                      ),
                      child: const Icon(
                        Icons.camera_alt_rounded,
                        color: ProfileScreen.darkTeal,
                        size: 15,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _AccountInfoCard extends StatelessWidget {
  final String fullName;
  final String phoneNumber;
  final String email;
  final String location;

  const _AccountInfoCard({
    required this.fullName,
    required this.phoneNumber,
    required this.email,
    required this.location,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(18, 18, 18, 14),
      decoration: BoxDecoration(
        color: ProfileScreen.cardColor.withOpacity(0.92),
        borderRadius: BorderRadius.circular(22),
      ),
      child: Column(
        children: [
          _InfoRow(
            emoji: '👨',
            label: 'Full Name',
            value: fullName,
          ),
          const _DividerLine(),
          _InfoRow(
            emoji: '📱',
            label: 'Phone Number',
            value: phoneNumber,
          ),
          const _DividerLine(),
          _InfoRow(
            emoji: '✉️',
            label: 'Email Address',
            value: email,
          ),
          const _DividerLine(),
          _InfoRow(
            emoji: '📍',
            label: 'Location',
            value: location,
          ),
        ],
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  final String emoji;
  final String label;
  final String value;

  const _InfoRow({
    required this.emoji,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 9,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            emoji,
            style: const TextStyle(fontSize: 15),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: const TextStyle(
                    color: Color(0xFF4D6661),
                    fontSize: 10,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  value,
                  style: const TextStyle(
                    color: ProfileScreen.darkTeal,
                    fontSize: 13,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _FarmingProfileCard extends StatelessWidget {
  const _FarmingProfileCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(20, 22, 20, 14),
      decoration: BoxDecoration(
        color: ProfileScreen.cardColor.withOpacity(0.92),
        borderRadius: BorderRadius.circular(22),
      ),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                '🌾',
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(width: 10),
              Text(
                'Current Crops',
                style: TextStyle(
                  color: Color(0xFF4D6661),
                  fontSize: 10,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ],
          ),
          SizedBox(height: 14),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              _CropChip(
                text: '🌾 Rice',
                filled: true,
              ),
              _CropChip(
                text: '🌽 Corn',
                filled: true,
              ),
              _CropChip(
                text: '+ Add Crop',
                filled: false,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _CropChip extends StatelessWidget {
  final String text;
  final bool filled;

  const _CropChip({
    required this.text,
    required this.filled,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 28,
      padding: const EdgeInsets.symmetric(horizontal: 13),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: filled ? const Color(0xFFC8F5BA) : Colors.transparent,
        borderRadius: BorderRadius.circular(999),
        border: Border.all(
          color: filled
              ? const Color(0xFF8EDB82)
              : ProfileScreen.darkTeal.withOpacity(0.25),
          width: 1,
        ),
      ),
      child: Text(
        text,
        style: const TextStyle(
          color: ProfileScreen.darkTeal,
          fontSize: 10.5,
          fontWeight: FontWeight.w900,
        ),
      ),
    );
  }
}

class _ActionCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final Color titleColor;
  final Color arrowBg;
  final Color arrowColor;
  final VoidCallback onTap;

  const _ActionCard({
    required this.icon,
    required this.title,
    required this.titleColor,
    required this.arrowBg,
    required this.arrowColor,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: ProfileScreen.cardColor.withOpacity(0.92),
      borderRadius: BorderRadius.circular(18),
      child: InkWell(
        borderRadius: BorderRadius.circular(18),
        onTap: onTap,
        child: Container(
          height: 66,
          padding: const EdgeInsets.symmetric(horizontal: 18),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(18),
          ),
          child: Row(
            children: [
              Icon(
                icon,
                color: titleColor,
                size: 17,
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  title,
                  style: TextStyle(
                    color: titleColor,
                    fontSize: 13.5,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ),
              Container(
                width: 28,
                height: 28,
                decoration: BoxDecoration(
                  color: arrowBg,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.chevron_right_rounded,
                  color: arrowColor,
                  size: 20,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _CircleButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;

  const _CircleButton({
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white.withOpacity(0.32),
      shape: const CircleBorder(),
      child: InkWell(
        customBorder: const CircleBorder(),
        onTap: onTap,
        child: SizedBox(
          width: 40,
          height: 40,
          child: Icon(
            icon,
            color: ProfileScreen.darkTeal,
            size: 22,
          ),
        ),
      ),
    );
  }
}

class _DividerLine extends StatelessWidget {
  const _DividerLine();

  @override
  Widget build(BuildContext context) {
    return Divider(
      height: 18,
      thickness: 1,
      color: ProfileScreen.darkTeal.withOpacity(0.06),
    );
  }
}

class _SectionTitle extends StatelessWidget {
  final String title;

  const _SectionTitle(this.title);

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: const TextStyle(
        color: ProfileScreen.darkTeal,
        fontSize: 10,
        fontWeight: FontWeight.w900,
        letterSpacing: 1.3,
      ),
    );
  }
}