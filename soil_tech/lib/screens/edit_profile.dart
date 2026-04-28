import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({
    super.key,
    this.initialUsername = 'Juan Dela Cruz',
    this.initialFullName = 'Juan Dela Cruz',
    this.initialPhoneNumber = '+63 912 345 6789',
    this.initialEmail = 'juan.delacruz@gmail.com',
    this.initialLocation = 'Davao City, Philippines',
    this.initialImage,
  });

  final String initialUsername;
  final String initialFullName;
  final String initialPhoneNumber;
  final String initialEmail;
  final String initialLocation;
  final File? initialImage;

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  static const Color bgColor = Color(0xFFE2E7B5);
  static const Color darkTeal = Color(0xFF005655);
  static const Color lime = Color(0xFFC9F001);
  static const Color green = Color(0xFF00C71E);
  static const Color cardColor = Color(0xFFF7F8E8);

  static const LinearGradient mainGreenGradient = LinearGradient(
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
    colors: [
      Color(0xFF8DDF7C),
      Color(0xFF00C71E),
      Color(0xFFC9F001),
    ],
  );

  final ImagePicker _picker = ImagePicker();

  late TextEditingController usernameController;
  late TextEditingController fullNameController;
  late TextEditingController phoneController;
  late TextEditingController emailController;
  late TextEditingController locationController;

  File? profileImage;

  @override
  void initState() {
    super.initState();

    usernameController = TextEditingController(text: widget.initialUsername);
    fullNameController = TextEditingController(text: widget.initialFullName);
    phoneController = TextEditingController(text: widget.initialPhoneNumber);
    emailController = TextEditingController(text: widget.initialEmail);
    locationController = TextEditingController(text: widget.initialLocation);
    profileImage = widget.initialImage;
  }

  @override
  void dispose() {
    usernameController.dispose();
    fullNameController.dispose();
    phoneController.dispose();
    emailController.dispose();
    locationController.dispose();
    super.dispose();
  }

  Future<void> _showImageOptions() async {
    showModalBottomSheet(
      context: context,
      backgroundColor: cardColor,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(26),
        ),
      ),
      builder: (context) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(22, 22, 22, 28),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  'Change Profile Photo',
                  style: TextStyle(
                    color: darkTeal,
                    fontSize: 18,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                const SizedBox(height: 14),
                ListTile(
                  leading: const Icon(
                    Icons.camera_alt_rounded,
                    color: darkTeal,
                  ),
                  title: const Text(
                    'Take Photo',
                    style: TextStyle(
                      color: darkTeal,
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
                    color: darkTeal,
                  ),
                  title: const Text(
                    'Choose from Gallery',
                    style: TextStyle(
                      color: darkTeal,
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

  void _saveProfile() {
    Navigator.pop(context, {
      'username': usernameController.text.trim(),
      'fullName': fullNameController.text.trim(),
      'phoneNumber': phoneController.text.trim(),
      'email': emailController.text.trim(),
      'location': locationController.text.trim(),
      'profileImage': profileImage,
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      body: SafeArea(
        bottom: false,
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(26, 18, 26, 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _TopBar(
                onBack: () => Navigator.pop(context),
                onSave: _saveProfile,
              ),

              const SizedBox(height: 42),

              Center(
                child: Column(
                  children: [
                    GestureDetector(
                      onTap: _showImageOptions,
                      child: Stack(
                        clipBehavior: Clip.none,
                        children: [
                          Container(
                            width: 98,
                            height: 98,
                            padding: const EdgeInsets.all(5),
                            decoration: const BoxDecoration(
                              color: lime,
                              shape: BoxShape.circle,
                            ),
                            child: Container(
                              decoration: BoxDecoration(
                                color: darkTeal,
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: Colors.white,
                                  width: 4,
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
                                          fontSize: 27,
                                          fontWeight: FontWeight.w900,
                                        ),
                                      ),
                                    )
                                  : null,
                            ),
                          ),
                          Positioned(
                            right: 1,
                            bottom: 8,
                            child: Container(
                              width: 27,
                              height: 27,
                              decoration: BoxDecoration(
                                color: lime,
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: darkTeal,
                                  width: 2,
                                ),
                              ),
                              child: const Icon(
                                Icons.camera_alt_rounded,
                                color: darkTeal,
                                size: 14,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 12),

                    const Text(
                      'Tap to change photo',
                      style: TextStyle(
                        color: Color(0xFF6D817B),
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                      ),
                    ),

                    const SizedBox(height: 8),

                    SizedBox(
                      width: 230,
                      child: TextField(
                        controller: usernameController,
                        textAlign: TextAlign.center,
                        cursorColor: darkTeal,
                        decoration: const InputDecoration(
                          isDense: true,
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.zero,
                        ),
                        style: const TextStyle(
                          color: darkTeal,
                          fontSize: 20,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 12),

              const _SectionTitle('ACCOUNT INFO'),

              const SizedBox(height: 12),

              Container(
                width: double.infinity,
                padding: const EdgeInsets.fromLTRB(18, 18, 18, 18),
                decoration: BoxDecoration(
                  color: cardColor.withOpacity(0.92),
                  borderRadius: BorderRadius.circular(24),
                ),
                child: Column(
                  children: [
                    _EditableField(
                      emoji: '👨',
                      label: 'FULL NAME',
                      controller: fullNameController,
                    ),
                    const _DividerLine(),
                    _EditableField(
                      emoji: '📱',
                      label: 'PHONE NUMBER',
                      controller: phoneController,
                      keyboardType: TextInputType.phone,
                    ),
                    const _DividerLine(),
                    _EditableField(
                      emoji: '✉️',
                      label: 'EMAIL ADDRESS',
                      controller: emailController,
                      keyboardType: TextInputType.emailAddress,
                      trailing: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 9,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: const Color(0xFFE7FFD8),
                          borderRadius: BorderRadius.circular(999),
                        ),
                        child: const Text(
                          '✓ Verified',
                          style: TextStyle(
                            color: Color(0xFF00A928),
                            fontSize: 9,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                      ),
                    ),
                    const _DividerLine(),
                    _EditableField(
                      emoji: '📍',
                      label: 'LOCATION',
                      controller: locationController,
                    ),
                    const SizedBox(height: 8),
                    const Padding(
                      padding: EdgeInsets.only(left: 60),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        
                          ),
                        ),
                  ],
                ),
              ),

              const SizedBox(height: 46),

              SizedBox(
                width: double.infinity,
                height: 58,
                child: ElevatedButton(
                  onPressed: _saveProfile,
                  style: ElevatedButton.styleFrom(
                    elevation: 0,
                    backgroundColor: lime,
                    foregroundColor: darkTeal,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(999),
                    ),
                  ),
                  child: const Text(
                    'Save Changes ✅',
                    style: TextStyle(
                      fontSize: 16,
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

class _TopBar extends StatelessWidget {
  final VoidCallback onBack;
  final VoidCallback onSave;

  const _TopBar({
    required this.onBack,
    required this.onSave,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _CircleButton(
          icon: Icons.arrow_back_rounded,
          onTap: onBack,
        ),
        const Expanded(
          child: Center(
            child: Text(
              'EDIT PROFILE',
              style: TextStyle(
                color: _EditProfileScreenState.darkTeal,
                fontSize: 13,
                fontWeight: FontWeight.w900,
                letterSpacing: 2.5,
              ),
            ),
          ),
        ),
        GestureDetector(
          onTap: onSave,
          child: Container(
            height: 34,
            padding: const EdgeInsets.symmetric(horizontal: 22),
            decoration: BoxDecoration(
              color: _EditProfileScreenState.lime,
              borderRadius: BorderRadius.circular(999),
            ),
            alignment: Alignment.center,
            child: const Text(
              'Save',
              style: TextStyle(
                color: _EditProfileScreenState.darkTeal,
                fontSize: 12,
                fontWeight: FontWeight.w900,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _EditableField extends StatelessWidget {
  final String emoji;
  final String label;
  final TextEditingController controller;
  final TextInputType? keyboardType;
  final Widget? trailing;

  const _EditableField({
    required this.emoji,
    required this.label,
    required this.controller,
    this.keyboardType,
    this.trailing,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          width: 31,
          height: 31,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: const Color(0xFFE4EED8),
            shape: BoxShape.circle,
          ),
          child: Text(
            emoji,
            style: const TextStyle(fontSize: 14),
          ),
        ),
        const SizedBox(width: 14),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: const TextStyle(
                  color: Color(0xFF4D6661),
                  fontSize: 10,
                  fontWeight: FontWeight.w900,
                  letterSpacing: 0.4,
                ),
              ),
              const SizedBox(height: 8),
              Container(
                height: 43,
                padding: const EdgeInsets.symmetric(horizontal: 13),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(11),
                  border: Border.all(
                    color: _EditProfileScreenState.darkTeal.withOpacity(0.18),
                    width: 1,
                  ),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: controller,
                        keyboardType: keyboardType,
                        cursorColor: _EditProfileScreenState.darkTeal,
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          isDense: true,
                        ),
                        style: const TextStyle(
                          color: _EditProfileScreenState.darkTeal,
                          fontSize: 13,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ),
                    if (trailing != null) ...[
                      const SizedBox(width: 6),
                      trailing!,
                    ],
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
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
      color: Colors.white.withOpacity(0.38),
      shape: const CircleBorder(),
      child: InkWell(
        customBorder: const CircleBorder(),
        onTap: onTap,
        child: SizedBox(
          width: 42,
          height: 42,
          child: Icon(
            icon,
            color: _EditProfileScreenState.darkTeal,
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
      height: 24,
      thickness: 1,
      color: _EditProfileScreenState.darkTeal.withOpacity(0.06),
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
        color: _EditProfileScreenState.darkTeal,
        fontSize: 11,
        fontWeight: FontWeight.w900,
        letterSpacing: 1.5,
      ),
    );
  }
}