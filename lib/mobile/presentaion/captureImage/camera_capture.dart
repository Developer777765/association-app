import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:permission_handler/permission_handler.dart';

class CameraCapture extends ConsumerStatefulWidget {
  const CameraCapture({super.key});

  @override
  createState() => CameraCaptureState();
}

class CameraCaptureState extends ConsumerState<CameraCapture> {
  late CameraController cameraController;
  List<CameraDescription>? listOfAvailableCameras;
  bool isCameraInitialized = false;

  @override
  initState() {
    super.initState();
    requestCameraPermission();
  }

  @override
  build(context) {
    return Scaffold(
      body: isCameraInitialized
          ? CameraPreview(cameraController)
          : const Center(
              child: CircularProgressIndicator(),
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: captureImage,
        child: const Icon(Icons.camera),
      ),
    );
  }

  requestCameraPermission() async {
    PermissionStatus cameraPermission = await Permission.camera.status;
    if (cameraPermission.isGranted) {
      initializeCamera();
    } else {
      PermissionStatus status = await Permission.camera.request();
      if (status.isGranted) {
        initializeCamera();
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
              content:
                  Text("Camera permission is required to use this feature.")),
        );
      }
    }
  }

  initializeCamera() async {
    listOfAvailableCameras = await availableCameras();
    cameraController =
        CameraController(listOfAvailableCameras![0], ResolutionPreset.medium);
    await cameraController.initialize();
    if (mounted) {
      setState(() {
        isCameraInitialized = true;
      });
    }
  }

  captureImage() async {
    if (!cameraController.value.isInitialized) {
      return;
    }
    try {
      final XFile image = await cameraController.takePicture();
      debugPrint('path of the image is ${image.path}');
    } catch (ex) {
      rethrow;
    }
  }

  @override
  void dispose() {
    cameraController.dispose();
    super.dispose();
  }
}
