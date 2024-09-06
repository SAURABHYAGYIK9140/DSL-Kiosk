import 'package:dsl_kiosk/models/Timings.dart';
import 'package:get/get.dart';
import '../models/Professional.dart';
import '../services/Api.dart';
import 'ServiceController.dart';


class ProfessionalController extends GetxController {
  var professionals = <Professional>[].obs;
  var timing1 = <Timings>[].obs;
  var timing2 = <Timings>[].obs;
  var isLoading = true.obs;
  var isLoading2 = true.obs;
  String profession_id="";
  String date="";
  String slotid="";
  late Timings selectedtiming;

  var bookAppointment_name = "".obs;

  final ServiceController serviceController = Get.put(ServiceController());

  @override
  void onInit() {
    super.onInit();
  }

  void fetchProfessionals(String id) async {
    print("fetchProfessionals");
    Map<String, dynamic> subbody = {
      'category_id': ''+id,
      'total_service_duration': serviceController.total_service_duration.value,
      'total_addon_duration': serviceController.total_addon_duration.value,

    };
    professionals.clear();
    try {
      isLoading(true);
      var professionalList = await ApiService.postProfessionals(subbody);
      if (professionalList.isNotEmpty) {
        professionals.assignAll(professionalList);
      }
    } finally {
      isLoading(false);
    }

  }

  void get_next_slots(String id,String date) async {
    try {
      isLoading(true);
      var body = {
        'professional_id': ''+id,
        'date': ''+date,
        'total_service_duration': serviceController.total_service_duration.value,
        'total_addon_duration': serviceController.total_addon_duration.value,
      };
      var timing1list = await ApiService.get_latter_slots(body);
      if (timing1list.isNotEmpty) {
        timing1.assignAll(timing1list);
      }
    } finally {
      isLoading(false);
    }
  }
  void get_latter_slots(String id,String date) async {
    try {
      isLoading2(true);
      var body = {
        'professional_id': ''+id,
        'date': ''+date,
        'total_service_duration': serviceController.total_service_duration.value,
        'total_addon_duration': serviceController.total_addon_duration.value,
      };
      var timing1list = await ApiService.postget_next_slots(body);
      if (timing1list.isNotEmpty) {
        timing2.assignAll(timing1list);
      }else{
        timing2.clear();
      }
    } finally {
      isLoading2(false);
    }
  }
}
