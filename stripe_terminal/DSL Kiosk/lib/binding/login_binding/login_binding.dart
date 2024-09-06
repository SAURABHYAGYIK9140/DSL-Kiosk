import 'package:get/get.dart';


class LoginBinding extends Bindings
{
  var status = false.obs;
  var message = "".obs;
  var isLoading = false.obs;


  @override
  void dependencies() {
    // Get.lazyPut<LoginController>(()=> LoginController());
  }

}