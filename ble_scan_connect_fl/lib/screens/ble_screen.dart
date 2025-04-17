import 'package:ble_scan_connect_fl/controller/ble_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BleScreen extends StatelessWidget {
  const BleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final model = Get.put(BleController());

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "BLE Scanner",
          style: TextStyle(
              fontWeight: FontWeight.bold, fontSize: 20, color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: Colors.deepOrange,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: Obx(
              () {
                final namedDevices = model.scanResults
                    .where((e) => e.device.platformName.isNotEmpty)
                    .toList();
                if (namedDevices.isNotEmpty) {
                  return ListView.builder(
                    itemCount: namedDevices.length,
                    itemBuilder: (context, index) {
                      final device = namedDevices[index].device;
                      final rssi = namedDevices[index].rssi;
                      print(
                          "named Device ${namedDevices[index].device.platformName}");
                      return Card(
                        elevation: 2,
                        child: ListTile(
                          title: Text(device.platformName.isNotEmpty
                              ? device.platformName
                              : "Unknown"),
                          subtitle: Text(device.remoteId.str),
                          trailing: Text("$rssi dBm"),
                          onTap: () async {
                            model.connectToDevice(namedDevices[index].device);
                          },
                        ),
                      );
                    },
                  );
                } else {
                  return Center(
                    child: Text(
                      "No Device Found",
                      style: TextStyle(fontSize: 15, color: Colors.deepOrange),
                    ),
                  );
                }
              },
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Obx(() {
            return Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    model.scanDevices();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: model.isScanning.value
                        ? Colors.deepOrange
                        : Colors.white,
                  ),
                  child: Text(
                    model.isScanning.value ? "STOP" : "SCAN",
                    style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: model.isScanning.value
                            ? Colors.white
                            : Colors.deepOrange),
                  ),
                ),
                const SizedBox(width: 16),
                if (model.isScanning.value)
                  const SizedBox(
                    height: 24,
                    width: 24,
                    child: CircularProgressIndicator(
                      strokeWidth: 2.5,
                      color: Colors.deepOrange,
                    ),
                  ),
              ],
            );
          })
        ],
      ),
    );
  }
}
