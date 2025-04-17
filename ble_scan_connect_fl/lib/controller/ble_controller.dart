import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';

class BleController extends GetxController {
  final scanResults = <ScanResult>[].obs;
  var isScanning = false.obs;

  Future<void> scanDevices() async {
// Ask permissions
    await Permission.bluetoothScan.request();
    await Permission.bluetoothConnect.request();
    await Permission.locationWhenInUse.request();

    if (isScanning.value) {
      await FlutterBluePlus.stopScan();
      isScanning.value = false;
    } else {
      // Clear previous results
      scanResults.clear();
      isScanning.value = true;
      // Start scanning
      FlutterBluePlus.startScan(timeout: Duration(seconds: 60));

      // Listen and update list
      FlutterBluePlus.scanResults.listen((results) {
        scanResults.assignAll(results);
      });

      // Stop scanning after timeout
      FlutterBluePlus.isScanning.listen((status) {
        isScanning.value = status;
      });
    }
  }

  Future<void> connectToDevice(BluetoothDevice device) async {
    print("device Data $device");
    await device.connect(timeout: Duration(seconds: 10));
    device.connectionState.listen((isConnected) {
      if (isConnected == BluetoothConnectionState.connected) {
        print("Device connected ${device.platformName}");
      } else {
        print("Device Disconnected");
      }
    });
  }
}
