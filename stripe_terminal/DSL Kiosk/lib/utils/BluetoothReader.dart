// import 'package:flutter/services.dart';
//
// class BluetoothReader {
//   static const platform = MethodChannel('com.example.yourapp/bluetooth');
//
//   Future<void> connectBluetoothReader(String locationId) async {
//     try {
//       final result = await platform.invokeMethod('connectBluetoothReader', {"locationId": locationId});
//       print(result);
//     } on PlatformException catch (e) {
//       print("Failed to connect: '${e.message}'.");
//     }
//   }
// }
