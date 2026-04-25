import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import 'soil_result.dart';

class ScanSoilScreen extends StatefulWidget {
  const ScanSoilScreen({super.key});

  @override
  State<ScanSoilScreen> createState() => _ScanSoilScreenState();
}

class _ScanSoilScreenState extends State<ScanSoilScreen> {
  static const Color screenDark = Color(0xFF031006);
  static const Color cardDark = Color(0xFF0A2A09);
  static const Color borderGreen = Color(0xFF1C5D1E);
  static const Color brightGreen = Color(0xFFA8F51F);
  static const Color softText = Color(0xFF8BD57C);
  static const Color disabledButton = Color(0xFF0D330C);

  final ImagePicker _picker = ImagePicker();

  CameraController? _cameraController;
  Future<void>? _initializeCameraFuture;

  File? _selectedImage;
  bool _isLoadingImage = false;
  bool _cameraUnavailable = false;

  @override
  void initState() {
    super.initState();
    _setupCamera();
  }

  Future<void> _setupCamera() async {
    try {
      final List<CameraDescription> cameras = await availableCameras();

      if (cameras.isEmpty) {
        if (!mounted) return;

        setState(() {
          _cameraUnavailable = true;
        });

        return;
      }

      final CameraDescription backCamera = cameras.firstWhere(
        (camera) => camera.lensDirection == CameraLensDirection.back,
        orElse: () => cameras.first,
      );

      final CameraController controller = CameraController(
        backCamera,
        ResolutionPreset.medium,
        enableAudio: false,
      );

      _cameraController = controller;
      _initializeCameraFuture = controller.initialize();

      if (mounted) {
        setState(() {});
      }
    } catch (e) {
      if (!mounted) return;

      setState(() {
        _cameraUnavailable = true;
      });
    }
  }

  Future<void> _takePhoto() async {
    final CameraController? controller = _cameraController;

    if (controller == null || !controller.value.isInitialized) {
      _showMessage('Camera is not ready yet.');
      return;
    }

    try {
      setState(() {
        _isLoadingImage = true;
      });

      final XFile photo = await controller.takePicture();

      if (!mounted) return;

      setState(() {
        _selectedImage = File(photo.path);
      });
    } catch (e) {
      _showMessage('Could not take photo.');
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

  void _removeImage() {
    setState(() {
      _selectedImage = null;
    });
  }

  void _scanSoil() {
    if (_selectedImage == null) return;

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => SoilResultScreen(
          soilImage: _selectedImage!,
        ),
      ),
    );
  }

  void _showMessage(String text) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(text),
      ),
    );
  }

  @override
  void dispose() {
    _cameraController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bool canScan = _selectedImage != null && !_isLoadingImage;

    return Scaffold(
      backgroundColor: screenDark,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(22, 36, 22, 28),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const _ProgressHeader(),

              const SizedBox(height: 30),

              const Text(
                'Scan your soil',
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

              const SizedBox(height: 14),

              const Text(
                'Take a clear close-up photo of your soil surface.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: softText,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),

              const SizedBox(height: 28),

              _CameraBox(
                selectedImage: _selectedImage,
                isLoadingImage: _isLoadingImage,
                cameraUnavailable: _cameraUnavailable,
                initializeCameraFuture: _initializeCameraFuture,
                cameraController: _cameraController,
                onTapCamera: _takePhoto,
                onRemoveImage: _removeImage,
              ),

              const SizedBox(height: 22),

              const Text(
                'or',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: softText,
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
              ),

              const SizedBox(height: 18),

              SizedBox(
                height: 47,
                child: OutlinedButton(
                  onPressed: _isLoadingImage ? null : _pickFromGallery,
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(
                      color: brightGreen,
                      width: 1,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(28),
                    ),
                    foregroundColor: brightGreen,
                  ),
                  child: const Text(
                    'Upload from gallery',
                    style: TextStyle(
                      color: brightGreen,
                      fontSize: 14,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 24),

              SizedBox(
                height: 52,
                child: ElevatedButton(
                  onPressed: canScan ? _scanSoil : null,
                  style: ElevatedButton.styleFrom(
                    elevation: 0,
                    backgroundColor: canScan ? brightGreen : disabledButton,
                    disabledBackgroundColor: disabledButton,
                    foregroundColor:
                        canScan ? Colors.black : const Color(0xFF5D8355),
                    disabledForegroundColor: const Color(0xFF5D8355),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(28),
                    ),
                  ),
                  child: Text(
                    'Scan Soil →',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w900,
                      color: canScan
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
          'Step 4 of 7',
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
            value: 4 / 7,
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

class _CameraBox extends StatelessWidget {
  const _CameraBox({
    required this.selectedImage,
    required this.isLoadingImage,
    required this.cameraUnavailable,
    required this.initializeCameraFuture,
    required this.cameraController,
    required this.onTapCamera,
    required this.onRemoveImage,
  });

  final File? selectedImage;
  final bool isLoadingImage;
  final bool cameraUnavailable;
  final Future<void>? initializeCameraFuture;
  final CameraController? cameraController;
  final VoidCallback onTapCamera;
  final VoidCallback onRemoveImage;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: isLoadingImage ? null : onTapCamera,
      child: Container(
        width: double.infinity,
        height: 390,
        decoration: BoxDecoration(
          color: _ScanSoilScreenState.cardDark,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: const Color(0xFF309023),
            width: 1.4,
          ),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: selectedImage != null
              ? Stack(
                  fit: StackFit.expand,
                  children: [
                    Image.file(
                      selectedImage!,
                      fit: BoxFit.cover,
                    ),
                    Positioned(
                      top: 12,
                      right: 12,
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.50),
                          shape: BoxShape.circle,
                        ),
                        child: IconButton(
                          onPressed: onRemoveImage,
                          icon: const Icon(
                            Icons.close_rounded,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                )
              : _CameraPreviewContent(
                  isLoadingImage: isLoadingImage,
                  cameraUnavailable: cameraUnavailable,
                  initializeCameraFuture: initializeCameraFuture,
                  cameraController: cameraController,
                ),
        ),
      ),
    );
  }
}

class _CameraPreviewContent extends StatelessWidget {
  const _CameraPreviewContent({
    required this.isLoadingImage,
    required this.cameraUnavailable,
    required this.initializeCameraFuture,
    required this.cameraController,
  });

  final bool isLoadingImage;
  final bool cameraUnavailable;
  final Future<void>? initializeCameraFuture;
  final CameraController? cameraController;

  @override
  Widget build(BuildContext context) {
    if (isLoadingImage) {
      return const Center(
        child: CircularProgressIndicator(
          color: Color(0xFFA8F51F),
        ),
      );
    }

    if (cameraUnavailable ||
        initializeCameraFuture == null ||
        cameraController == null) {
      return const _CameraPlaceholder(
        title: 'Camera unavailable',
        subtitle: 'Use gallery upload instead',
      );
    }

    return FutureBuilder<void>(
      future: initializeCameraFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done &&
            cameraController!.value.isInitialized) {
          final Size? previewSize = cameraController!.value.previewSize;

          if (previewSize == null) {
            return const _CameraPlaceholder(
              title: 'Camera unavailable',
              subtitle: 'Use gallery upload instead',
            );
          }

          return Stack(
            fit: StackFit.expand,
            children: [
              FittedBox(
                fit: BoxFit.cover,
                child: SizedBox(
                  width: previewSize.height,
                  height: previewSize.width,
                  child: CameraPreview(cameraController!),
                ),
              ),
              Container(
                color: Colors.black.withOpacity(0.15),
              ),
              const Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      '📷',
                      style: TextStyle(
                        fontSize: 28,
                      ),
                    ),
                    SizedBox(height: 14),
                    Text(
                      'Tap to take a photo',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                        fontWeight: FontWeight.w900,
                        shadows: [
                          Shadow(
                            color: Colors.black,
                            offset: Offset(1, 1),
                            blurRadius: 2,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      'JPG or PNG · up to 10MB',
                      style: TextStyle(
                        color: Color(0xFF8BD57C),
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        shadows: [
                          Shadow(
                            color: Colors.black,
                            offset: Offset(1, 1),
                            blurRadius: 2,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        }

        return const Center(
          child: CircularProgressIndicator(
            color: Color(0xFFA8F51F),
          ),
        );
      },
    );
  }
}

class _CameraPlaceholder extends StatelessWidget {
  const _CameraPlaceholder({
    required this.title,
    required this.subtitle,
  });

  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            '📷',
            style: TextStyle(
              fontSize: 28,
            ),
          ),
          const SizedBox(height: 14),
          Text(
            title,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 15,
              fontWeight: FontWeight.w900,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            subtitle,
            style: const TextStyle(
              color: Color(0xFF8BD57C),
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}