import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../utils/Constants.dart';
import '../../utils/route_pages/page_name.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

class SplashController extends GetxController {
  var seconds = 3.obs;

  @override
  void onInit() {
    _startTimer();
    super.onInit();
  }
  Future<void> _startTimer() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile) {
      // Connected to mobile network
      print('Connected to a mobile network');
    } else if (connectivityResult == ConnectivityResult.wifi) {
      // Connected to WiFi
      print('Connected to a WiFi network');
    } else {
      Get.snackbar("No Internet connected", "Please check your internet connection",
          duration: null,
          mainButton: TextButton(
            onPressed: () {
              Get.closeCurrentSnackbar();
              _startTimer();
            },
            child: Text(
              "Retry",
              style: TextStyle(color: Colors.black),
            ),
          ),
          snackPosition: SnackPosition.BOTTOM);

      return;
    }
    // Delay navigation to ensure it occurs after the build process
    Future.delayed(Duration(seconds: seconds.value), () {
      final String? token = Constants.pref?.getString('token');
      // if (token == null) {
      //   Get.offNamed(MyPagesName.login);
      // } else {
        Get.offNamed(MyPagesName.home);
      // }
    });
  }

}
