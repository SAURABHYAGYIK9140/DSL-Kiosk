import 'package:get/get.dart';

import '../models/Category.dart';
import '../services/Api.dart';
import 'ServiceController.dart';


class CategoryController extends GetxController {
  var categories = <Category>[].obs;
  var subcategories = <Category>[].obs;
  var isLoading = true.obs;
  var isLoadingforsub = true.obs;
  var isSubcatLoading = false.obs;
  final ServiceController serviceController = Get.put(ServiceController());

  @override
  void onInit() {
    fetchCategories();
    super.onInit();
  }

  void fetchCategories() async {
    print("fetchCategories");
    try {
      isLoading(true);
      //
      // List<Category> exapcategories = Category.exampleList;
      // categories.assignAll(exapcategories);


      var categoryList = await ApiService.postCategories();
      if (categoryList.isNotEmpty) {
        categories.assignAll(categoryList);
        // /fetchSubCategories(categories[0].id.toString());

        serviceController.fetchServices("","");
        isLoading(false);
        serviceController.selectedcatis.value=categories[0].id.toString();
      }else{

      }
    } finally {
      isLoading(false);
    }
  }
  void fetchSubCategories(String id) async {
    print("fetchCategories");
    try {
      isSubcatLoading(true);
      //
      // List<Category> exapcategories = Category.exampleList;
      // categories.assignAll(exapcategories);
      Map<String, dynamic> subbody = {
        'parent_id': ''+id
      };

      var categoryList = await ApiService.postSubCategories(subbody);
      if (categoryList.isNotEmpty) {
        subcategories.assignAll(categoryList);
        // serviceController.fetchServices(subcategories[0].id.toString());
        isSubcatLoading(false);

      }else{
        subcategories.clear();
      }
    } finally {
      isSubcatLoading(false);
    }
  }
}
