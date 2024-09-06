import 'package:dsl_kiosk/models/BookingModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../services/Api.dart';
import '../../utils/route_pages/page_name.dart';
class Homecontroller extends GetxController{

  var isLoading = true.obs;
  var searchedtext = "".obs;
  var categories = <BookingModel>[].obs;
@override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }
  void fetchbookings(BuildContext context) async {
    print("fetchCategories");
    if(searchedtext.value=="")
      {
        Get.snackbar("No text found", "Please enter your first name to search",snackPosition: SnackPosition.BOTTOM,backgroundColor: CupertinoColors.white);
        return;
      }
    Navigator.of(context).pop();

    Get.toNamed(MyPagesName.nobookingfound);
    try {

      isLoading(true);
      //
      // List<Category> exapcategories = Category.exampleList;
      // categories.assignAll(exapcategories);

      var body = {
        'search_text': ''+searchedtext.value
      };
      print("searchedtext"+body.toString());
      var categoryList = await ApiService.search_ki_booking(body);
      if (categoryList.isNotEmpty) {
        categories.assignAll(categoryList);
        isLoading(false);
      }else{
        categories.clear();
      }
      searchedtext.value="";
    } finally {
      isLoading(false);
    }
  }
}