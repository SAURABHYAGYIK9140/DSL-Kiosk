import 'package:flutter/material.dart';
import 'package:get/get.dart';


import '../../controllers/splash_controller/SplashController.dart';
import '../../utils/Colors.dart';
import '../../utils/Constants.dart';
import '../../utils/route_pages/page_name.dart';
import 'package:permission_handler/permission_handler.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
   // requestPermissions();
    Get.find<SplashController>();
  }
  void requestPermissions() async {
    Map<Permission, PermissionStatus> statuses = await [
      Permission.bluetooth,
      Permission.bluetoothScan,
      Permission.bluetoothConnect,
      Permission.location,
    ].request();

    bool allGranted = statuses.values.every((status) => status.isGranted);
    if (allGranted) {
    } else {
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: CircleAvatar(
          radius: 100,
          backgroundColor: Colors.transparent, // Set background color to transparent
          child: ClipOval( // Use ClipOval to clip the child into a circle
            child: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/logo.jpg'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }


  @override
  void dispose() {
    super.dispose();
  }
}
