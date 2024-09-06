import 'package:dsl_kiosk/ui/widgets/ServiceWidget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/ServiceController.dart';
import '../../utils/route_pages/page_name.dart';

class Selectsubservice extends StatefulWidget {
  @override
  _SelectsubserviceState createState() => _SelectsubserviceState();
}

class _SelectsubserviceState extends State<Selectsubservice> {
  final ServiceController serviceController = Get.put(ServiceController());
  final RxList<int> selectedSubservices =
      <int>[].obs;

  @override
  Widget build(BuildContext context) {
    return SafeArea(

      child: Scaffold(
        bottomNavigationBar: BottomAppBar(
          child: Container(
            height: MediaQuery.of(context).size.height * 0.08, // Adjusts height based on screen size
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                //     Align(
                //       alignment: AlignmentDirectional.centerStart,
                //       child: Text(
                //         "£${calculateTotalPrice().toStringAsFixed(2)}",
                //         textAlign: TextAlign.left,
                //         style: TextStyle(
                //           color: Colors.black,
                //           fontSize: MediaQuery.of(context).size.width * 0.06, // Dynamic font size
                //           fontWeight: FontWeight.w500,
                //         ),
                //       ),
                //     ),
                //     Text(
                //       selectedServices.length.toString()+" services "
                //           "- "+      " ${calculateTotalDuration()}",
                //
                //       style: TextStyle(
                //         color: Colors.black,
                //         fontSize: MediaQuery.of(context).size.width * 0.042, // Dynamic font size
                //         fontWeight: FontWeight.w500,
                //       ),
                //     ),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.only(right: MediaQuery.of(context).size.width * 0.04), // Dynamic padding
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(9)),
                      ),
                      backgroundColor: Colors.black,
                      shadowColor: Colors.transparent,
                      elevation: 0,
                    ),
                    onPressed: () {
                      // serviceController.fetchAddon();
                      Get.toNamed(MyPagesName.Chooseadons);
                    },
                    child: Text(
                      "Continue",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: MediaQuery.of(context).size.width * 0.045, // Dynamic font size
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),

        appBar: AppBar(
          backgroundColor: Colors.white,
          title: Text("Choose your sub service"),
        ),
        backgroundColor: Colors.white,
        body: Column(
          children: [
            Obx(
              () {
                if (serviceController.isLoading.value) {
                  return Center(child: CircularProgressIndicator());
                } else {
                  return Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SingleChildScrollView(
                        child: GridView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2, // Number of items per row
                            mainAxisSpacing: 10.0,
                            crossAxisSpacing: 10.0,
                            mainAxisExtent: 210,
                          ),
                          itemCount: serviceController.subservices.length,
                          // Number of items in the grid
                          itemBuilder: (context, index) {
                            final subservice =
                                serviceController.subservices[index];
                            final isSelected =
                                selectedSubservices.contains(subservice.id);

                            return GestureDetector(
                              onTap: () {
                                setState(() {
                                  if (isSelected) {
                                    selectedSubservices.remove(subservice.id);
                                  } else {
                                    selectedSubservices.add(subservice.id);
                                  }
                                });
                              },
                              child: Servicewidget(
                                service: subservice,
                                type: "sub",
                                selected: isSelected,
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
