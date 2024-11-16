import 'package:camera/camera.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';

class QRCodeController extends GetxController {
  CameraController? cameraController;

  @override
  void onInit() {
    super.onInit();
    requestCameraPermission();
  }

  Future<void> requestCameraPermission() async {
    var status = await Permission.camera.status;
    if (status.isDenied || status.isRestricted) {
      // Request permission
      status = await Permission.camera.request();
    }

    if (status.isGranted) {
      initializeCamera();
    } else {
      Get.snackbar(
        "Permission Denied",
        "Camera access is required for scanning QR codes.",
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  Future<void> initializeCamera() async {
    try {
      final cameras = await availableCameras();
      if (cameras.isNotEmpty) {
        cameraController = CameraController(
          cameras[0], // Use the first available camera
          ResolutionPreset.high,
        );
        await cameraController!.initialize();
        update(); // Update UI
      }
    } catch (e) {
      print("Error initializing camera: $e");
    }
  }

  @override
  void onClose() {
    cameraController?.dispose();
    super.onClose();
  }
}
