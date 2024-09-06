import 'package:get/get.dart';

import '../models/Service.dart';
import '../services/Api.dart';
import '../utils/route_pages/page_name.dart';

class ServiceController extends GetxController {
  var services = <Service>[].obs;
  var subservices = <Service>[].obs;
  var addon = <Service>[].obs;
  var isLoading = true.obs;
  var total_service_duration = "".obs;
  var total_service_price = 0.0.obs;
  var total_addon_duration = "".obs;
  var total_addon_price = 0.0.obs;
  var selectedcatis = "".obs;
   String addon_id="";
  var service_id="";
  final RxList<Service> selectedServices =
      <Service>[].obs;

  var selected_servicesid = <int>[].obs;
  var selected_addonsid = <int>[].obs;

  String addTimes() {

    int a=int.parse(total_service_duration.toString());
    int b=0;
    if(total_addon_duration.toString()=="")
      {
        b=0;
      }else{
      b=int.parse(total_addon_duration.toString());
    }
        int totalMinutes = a + b;

    // Convert total minutes to hours and remaining minutes
    int hours = totalMinutes ~/ 60;
    int minutes = totalMinutes % 60;

    return 'Total time : $hours h $minutes m';
  }

  @override
  void onInit() {
    super.onInit();
  }

  void fetchServices(String id,String subcatid) async {
    try {
      isLoading(true);

      //remove sattic
      // isLoading(false);
      // List<Service> exampleList = Service.exampleList;
      // services.assignAll(exampleList);

      var body = {
        'category_id': '$id',
        'sub_category_id': ''+subcatid,
      };

      print("catdidddd"+body.toString());
      var serviceList = await ApiService.postServices(body);
      if (serviceList.isNotEmpty) {

        services.assignAll(serviceList);

      }else{
        services.clear();
      }
    } finally {
      isLoading(false);
    }
  }
  void fetchSubServices(String id) async {
    try {
      isLoading(true);
      //remove sattic
      isLoading(false);

      var body = {
        'service_id': '$id',
      };
      var serviceList = await ApiService.postSubServices(body);
      if (serviceList.isNotEmpty) {
        subservices.assignAll(serviceList);
      }
    } finally {
      isLoading(false);
    }
  }
  void fetchAddon(String id) async {
    try {
      isLoading(true);

      var body = {
        'service_id': '$id',
      };
      var serviceList = await ApiService.postaddon(body);
      if (serviceList.isNotEmpty) {
        addon.assignAll(serviceList);
      }else
        {
          Get.offNamed(MyPagesName.ProfessionalSelectionScreen);

          // Get.toNamed(MyPagesName.ProfessionalSelectionScreen);

          // Get.toNamed(MyPagesName.ProfessionalSelectionScreen);

        }

    } finally {
      isLoading(false);
    }
  }
}
