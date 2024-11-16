import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/qr_code_controller.dart';

class QRCodeScannerPage extends StatelessWidget {
  final QRCodeController controller = Get.put(QRCodeController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("QR Code Scanner")),
      body: GetBuilder<QRCodeController>(
        builder: (controller) {
          if (controller.cameraController == null) {
            return Center(
              child: Text(
                "Camera permission not granted or camera not initialized.",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 18),
              ),
            );
          }

          if (!controller.cameraController!.value.isInitialized) {
            return Center(child: CircularProgressIndicator());
          }

          return Stack(
            children: [
              CameraPreview(controller.cameraController!),
              Align(
                alignment: Alignment.center,
                child: Container(
                  width: 200,
                  height: 200,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.blue, width: 2),
                  ),
                ),
              ),
              Positioned(
                bottom: 50,
                left: 0,
                right: 0,
                child: Center(
                  child: ElevatedButton(
                    onPressed: () {
                      // Capture QR code logic
                      print("Capture QR Code button pressed");
                    },
                    child: Text("Capture QR Code"),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
