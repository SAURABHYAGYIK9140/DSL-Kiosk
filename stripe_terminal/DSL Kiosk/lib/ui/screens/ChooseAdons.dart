import 'package:dsl_kiosk/models/Service.dart';
import 'package:dsl_kiosk/ui/widgets/Addonswidgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/ServiceController.dart';
import '../../utils/Colors.dart';
import '../widgets/CustomeWidgets.dart';

class Chooseadons extends StatefulWidget {
  const Chooseadons({super.key});

  @override
  _ChooseadonsState createState() => _ChooseadonsState();
}

class _ChooseadonsState extends State<Chooseadons> {
  final ServiceController serviceController = Get.put(ServiceController());
  final RxList<Service> selectedAddons = <Service>[].obs;

  double calculateTotalPrice() {
    // Convert the price string to double and sum them up, handling any conversion errors
    return selectedAddons.fold(0.0, (sum, service) {
      double price = double.tryParse(service.price.toString()) ?? 0.0;
      return sum + price;
    });
  }

  // String calculateTotalDuration() {
  //   int totalMinutes = selectedAddons.fold(0, (sum, service) {
  //     int hours = 0;
  //     int minutes = 0;
  //
  //     // Parse the duration string
  //     if (service.duration.contains('hour')) {
  //       // Extract hours
  //       hours = int.tryParse(service.duration.split(' ')[0]) ?? 0;
  //     }
  //     if (service.duration.contains('minute')) {
  //       // Extract minutes
  //       List<String> parts = service.duration.split(' ');
  //       for (int i = 0; i < parts.length; i++) {
  //         if (parts[i].contains('minute')) {
  //           minutes = int.tryParse(parts[i - 1]) ?? 0;
  //         }
  //       }
  //     }
  //
  //     return sum + (hours * 60) + minutes;
  //   });
  //   int hours = totalMinutes ~/ 60;
  //   int minutes = totalMinutes % 60;
  //
  //   return "${hours}h ${minutes}m";
  // }
  String calculateTotalDuration() {
    int totalMinutes = selectedAddons.fold(0, (sum, service) {
      // Add the duration directly as it's already in minutes
      return sum + (int.tryParse(service.duration.toString()) ?? 0);
    });
    totalMinutes =totalMinutes+ serviceController.selectedServices.fold(0, (sum, service) {
      // Add the duration directly as it's already in minutes
      return sum + (int.tryParse(service.duration.toString()) ?? 0);
    });
    int hours = totalMinutes ~/ 60;
    int minutes = totalMinutes % 60;

    return "${hours}h ${minutes}m";
  }

  String calculateTotalDurationInmin() {
    int totalMinutes = selectedAddons.fold(0, (sum, service) {
      // Add the duration directly as it's already in minutes
      return sum + (int.tryParse(service.duration.toString()) ?? 0);
    });

    return "$totalMinutes";
  }
  List<int> getAllAddonIds() {
    return selectedAddons.map((service) => service.id).toList();
  }

  @override
  Widget build(BuildContext context) {
    double totalServicePrice = double.parse(serviceController.total_service_price.value.toString());
    double totalServiceduration = double.parse(serviceController.total_service_duration.value.toString());
    double calculatedPrice = calculateTotalPrice();
    String priceString = "£${(totalServicePrice + calculatedPrice).toStringAsFixed(2)}";

    return SafeArea(
      child: Scaffold(
        bottomNavigationBar: BottomAppBar(
          height: MediaQuery.of(context).size.height * 0.13, // Adjusts height based on screen size

          color: buttoncolor3,
          child: Container(
            child: Row(

              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Align(
                        alignment: AlignmentDirectional.centerStart,
                        child: Text(
                          ""+
                          priceString,textAlign: TextAlign.left,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: MediaQuery.of(context).size.width *
                                0.06, // Dynamic font size
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Text(
                        (serviceController.selectedServices.length+selectedAddons.length).toString() +
                            " services "
                                "- " +
                            " ${calculateTotalDuration()}",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: MediaQuery.of(context).size.width *
                              0.042, // Dynamic font size
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.only(
                      right: MediaQuery.of(context).size.width *
                          0.04), // Dynamic padding
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
                      // if(selectedAddons.length==0)
                      // {
                      //   Get.snackbar("No Service selected", "Please select a service",snackPosition: SnackPosition.BOTTOM);
                      //
                      //   return;
                      // }
                      serviceController.total_addon_duration.value =
                          calculateTotalDurationInmin();
                      serviceController.total_addon_price.value=double.tryParse(calculateTotalPrice().toStringAsFixed(2).toString())!;
                      serviceController.selected_addonsid.value=getAllAddonIds();

                      // serviceController.addon_id = service.id;
                      Customewidgets.showYesNoDialog(context);
// Get.toNamed(MyPagesName.Chooseadons);
                    },
                    child: Text(
                      "Continue",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: MediaQuery.of(context).size.width *
                            0.045, // Dynamic font size
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
          title: Text("Choose your Add-ons"),
        ),
        backgroundColor: Colors.white,
        body: Column(
          children: [
            Obx(() {
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
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2, // Number of items per row
                          mainAxisSpacing: 10.0,
                          crossAxisSpacing: 10.0,
                          mainAxisExtent: 200,
                        ),
                        itemCount: serviceController.addon.length,
                        // Number of items in the grid
                        itemBuilder: (context, index) {
                          final addon = serviceController.addon[index];
                          final isSelected =
                              selectedAddons.any((s) => s.id == addon.id);

                          return GestureDetector(
                            onTap: () {
                              print("selectedServices" +
                                  selectedAddons.length.toString());

                              setState(() {
                                if (isSelected) {
                                  selectedAddons
                                      .removeWhere((s) => s.id == addon.id);
                                } else {
                                  selectedAddons.add(addon);
                                }
                              });
                            },
                            child: Addonswidgets(
                              service: addon,
                              selected: isSelected,
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                );
              }
            }),
          ],
        ),
      ),
    );
  }
}
