import 'package:get/get.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'dart:async';

class InternetController extends GetxController {

  var isLoading = true.obs;
  var isConnected = true.obs;


  @override
  void onInit() {
    super.onInit();
  }





  Future<bool> checkConnectivity() async {
    bool status=true;
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {
      isConnected.value = false;
      status = false;
      Get.snackbar('No Internet', 'Please check your internet connection.');
    } else {
      isConnected.value = true;
      status= true;
    }

    return status;
  }


}
