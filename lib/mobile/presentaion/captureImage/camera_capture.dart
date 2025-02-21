import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:temple_app/mobile/presentaion/captureImage/preview_image.dart';

final cameraSelectionProvider = StateProvider<bool>((ref) {
  return false;
});

class CameraCapture extends ConsumerStatefulWidget {
  const CameraCapture({super.key});

  @override
  createState() => CameraCaptureState();
}

class CameraCaptureState extends ConsumerState<CameraCapture> {
  late CameraController cameraController;
  List<CameraDescription>? listOfAvailableCameras;
  bool isCameraInitialized = false;
  bool isItRearCamera = false;

  @override
  initState() {
    super.initState();
    requestCameraPermission();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        fit: StackFit.expand,
        children: [
          if (isCameraInitialized)
            CameraPreview(cameraController)
          else
            const Center(child: CircularProgressIndicator()),
          Align(
            alignment: Alignment.bottomCenter,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  icon: const Icon(
                    size: 40,
                    Icons.cameraswitch_outlined,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    isItRearCamera = !isItRearCamera;
                    initializeCamera(isItRearCamera);
                  },
                ),
                SizedBox(width: MediaQuery.of(context).size.width / 2.5),
                IconButton(
                  icon: const Icon(
                    size: 40,
                    Icons.camera,
                    color: Colors.white,
                  ),
                  onPressed: captureImage,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  requestCameraPermission() async {
    PermissionStatus cameraPermission = await Permission.camera.status;
    if (cameraPermission.isGranted) {
      initializeCamera(false);
    } else {
      PermissionStatus status = await Permission.camera.request();
      if (status.isGranted) {
        initializeCamera(false);
      } else {
        // ignore: use_build_context_synchronously
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
              content:
                  Text("Camera permission is required to use this feature.")),
        );
      }
    }
  }

  initializeCamera(bool hasCameraChanged) async {
    listOfAvailableCameras = await availableCameras();
    cameraController = CameraController(
        hasCameraChanged
            ? listOfAvailableCameras![1]
            : listOfAvailableCameras![0],
        ResolutionPreset.medium);
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
      if (mounted) {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => PreviewImage(
                      imagePath: image.path,
                    )));
      }
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
