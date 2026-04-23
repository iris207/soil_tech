import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ScanSoilScreen extends StatefulWidget {
  const ScanSoilScreen({super.key});

  @override
  State<ScanSoilScreen> createState() => _ScanSoilScreenState();
}

class _ScanSoilScreenState extends State<ScanSoilScreen> {
  static const Color softText = Color(0xFFA7C79A);
  static const Color screenDark = Color(0xFF0C4C38);
  static const Color outlineGreen = Color(0xFF2C8B5D);
  static const Color disabledGreen = Color(0xFF2D6E49);
  static const Color activeButtonGreen = Color(0xFF2A7347);

  final ImagePicker _picker = ImagePicker();
  File? _selectedImage;
  bool _isLoadingImage = false;

  Future<void> _pickFromCamera() async {
    try {
      setState(() {
        _isLoadingImage = true;
      });

      final XFile? pickedFile = await _picker.pickImage(
        source: ImageSource.camera,
        imageQuality: 85,
      );

      if (pickedFile != null) {
        setState(() {
          _selectedImage = File(pickedFile.path);
        });
      }
    } catch (e) {
      _showMessage('Could not open camera.');
    } finally {
      if (mounted) {
        setState(() {
          _isLoadingImage = false;
        });
      }
    }
  }

  Future<void> _pickFromGallery() async {
    try {
      setState(() {
        _isLoadingImage = true;
      });

      final XFile? pickedFile = await _picker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 85,
      );

      if (pickedFile != null) {
        setState(() {
          _selectedImage = File(pickedFile.path);
        });
      }
    } catch (e) {
      _showMessage('Could not open gallery.');
    } finally {
      if (mounted) {
        setState(() {
          _isLoadingImage = false;
        });
      }
    }
  }

  void _showMessage(String text) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(text)),
    );
  }

  @override
  Widget build(BuildContext context) {
    final bool canScan = _selectedImage != null && !_isLoadingImage;

    return Scaffold(
      backgroundColor: screenDark,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(20, 12, 20, 24),
          child: Column(
            children: [
              Row(
                children: [
                  IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(
                      Icons.arrow_back,
                      color: Colors.white,
                      size: 32,
                    ),
                  ),
                  const Expanded(
                    child: Center(
                      child: Text(
                        'Step 3 of 8',
                        style: TextStyle(
                          color: softText,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 48),
                ],
              ),
              const SizedBox(height: 4),
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Container(
                  height: 5,
                  width: double.infinity,
                  color: Colors.white.withOpacity(0.10),
                  child: LayoutBuilder(
                    builder: (context, constraints) {
                      return Align(
                        alignment: Alignment.centerLeft,
                        child: Container(
                          width: constraints.maxWidth * (3 / 8),
                          color: const Color(0xFF43B56F),
                        ),
                      );
                    },
                  ),
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                '📷',
                style: TextStyle(fontSize: 64),
              ),
              const SizedBox(height: 10),
              const Text(
                'Scan your soil',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 26,
                  fontWeight: FontWeight.w800,
                  height: 1.2,
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                'Take a clear close-up photo of your soil surface.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: softText,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  height: 1.4,
                ),
              ),
              const SizedBox(height: 24),
              GestureDetector(
                onTap: _isLoadingImage ? null : _pickFromCamera,
                child: Container(
                  width: double.infinity,
                  height: 390,
                  decoration: BoxDecoration(
                    color: const Color(0xFF114A37),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: outlineGreen,
                      width: 1.6,
                      style: BorderStyle.solid,
                    ),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: _selectedImage != null
                        ? Stack(
                            fit: StackFit.expand,
                            children: [
                              Image.file(
                                _selectedImage!,
                                fit: BoxFit.cover,
                              ),
                              Positioned(
                                top: 12,
                                right: 12,
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Colors.black.withOpacity(0.45),
                                    shape: BoxShape.circle,
                                  ),
                                  child: IconButton(
                                    onPressed: () {
                                      setState(() {
                                        _selectedImage = null;
                                      });
                                    },
                                    icon: const Icon(
                                      Icons.close,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          )
                        : Center(
                            child: _isLoadingImage
                                ? const CircularProgressIndicator(
                                    color: Colors.white70,
                                  )
                                : const Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Icon(
                                        Icons.camera_alt_outlined,
                                        size: 54,
                                        color: Color(0xFF97C2A6),
                                      ),
                                      SizedBox(height: 12),
                                      Text(
                                        'Tap to take a photo',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                    ],
                                  ),
                          ),
                  ),
                ),
              ),
              const SizedBox(height: 22),
              const Text(
                'or',
                style: TextStyle(
                  color: softText,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 22),
              SizedBox(
                width: double.infinity,
                height: 56,
                child: OutlinedButton.icon(
                  onPressed: _isLoadingImage ? null : _pickFromGallery,
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(
                      color: outlineGreen,
                      width: 2,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(28),
                    ),
                    foregroundColor: Colors.white,
                  ),
                  icon: const Icon(Icons.upload_outlined, size: 20),
                  label: const Text(
                    'Upload from gallery',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                height: 62,
                child: ElevatedButton(
                  onPressed: canScan
                      ? () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Soil scan step not added yet.'),
                            ),
                          );
                        }
                      : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                        canScan ? activeButtonGreen : disabledGreen,
                    disabledBackgroundColor: disabledGreen,
                    foregroundColor:
                        canScan ? Colors.white : Colors.white54,
                    disabledForegroundColor: Colors.white54,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(28),
                    ),
                  ),
                  child: const Text(
                    'Scan Soil →',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w800,
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