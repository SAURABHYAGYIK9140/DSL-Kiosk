
import 'package:dsl_kiosk/models/Service.dart';
import 'package:dsl_kiosk/ui/widgets/ServiceWidget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/CategoryController.dart';
import '../../controllers/ServiceController.dart';
import '../../utils/Colors.dart';
import '../../utils/route_pages/page_name.dart';

class Showservices extends StatefulWidget {
  @override
  _ShowservicesState createState() => _ShowservicesState();
}

class _ShowservicesState extends State<Showservices> {
  final CategoryController categoryController = Get.put(CategoryController());
  final ServiceController serviceController = Get.put(ServiceController());
  // final RxList<String> selectedServices =
  //     <String>[].obs; // List to store selected service IDs

  double calculateTotalPrice() {
    // Convert the price string to double and sum them up, handling any conversion errors
    return serviceController.selectedServices.fold(0.0, (sum, service) {
      double price = double.tryParse(service.price.toString()) ?? 0.0;
      return sum + price;
    });
  }
  String calculateTotalDuration() {
    int totalMinutes = serviceController.selectedServices.fold(0, (sum, service) {
      // Add the duration directly as it's already in minutes
      return sum + (int.tryParse(service.duration.toString()) ?? 0);
    });

    int hours = totalMinutes ~/ 60;
    int minutes = totalMinutes % 60;

    return "${hours}h ${minutes}m";
  }
  String calculateTotalDurationInmin() {
    int totalMinutes = serviceController.selectedServices.fold(0, (sum, service) {
      // Add the duration directly as it's already in minutes
      return sum + (int.tryParse(service.duration.toString()) ?? 0);
    });

    return "$totalMinutes";
  }

  List<int> getAllServiceIds() {
    return serviceController.selectedServices.map((service) => service.id).toList();
  }


  String selectedcatid='';
  int selectedcategory=-1;
  int selectedsubcategory=-1;
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {

    return SafeArea(

      child: Scaffold(
        bottomNavigationBar: BottomAppBar(
          height: MediaQuery.of(context).size.height * 0.13, // Adjusts height based on screen size

          color: buttoncolor3,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width * 0.04), // Dynamic horizontal padding
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
                          "£${calculateTotalPrice().toStringAsFixed(2)}",
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: MediaQuery.of(context).size.width * 0.06, // Dynamic font size
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Text(
                        "${serviceController.selectedServices.length} services - ${calculateTotalDuration()}",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: MediaQuery.of(context).size.width * 0.042, // Dynamic font size
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    )
                  ],
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(9)),
                    ),
                    backgroundColor: Colors.black,
                    shadowColor: Colors.transparent,
                    elevation: 0,
                  ),
                  onPressed: () {

                    if(serviceController.selectedServices.isEmpty) {
                      Get.snackbar("No Service selected", "Please select a service", snackPosition: SnackPosition.BOTTOM);
                      return;
                    }
                    serviceController.total_service_price.value = double.tryParse(calculateTotalPrice().toStringAsFixed(2))!;
                    serviceController.total_service_duration.value = calculateTotalDurationInmin();

                    print('total_service_duration ${serviceController.total_service_duration.value}');
                    print('selected_services ${getAllServiceIds()}');
                    serviceController.selected_servicesid.value = getAllServiceIds();
                    serviceController.fetchAddon(getAllServiceIds().toString());
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
              ],
            ),
          ),
        ),
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: Text("Choose your service"),
        ),
        backgroundColor: Colors.white,
        body: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(height: 10,),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Text(
                "Categories " ,
                style: TextStyle(color: Colors.black,fontSize: 18),
              ),
            ),
            Obx(
              () {
                if (categoryController.isLoading.value) {
                  return SizedBox();
                } else {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      height: 50.0,
                      // Set a fixed height for the horizontal ListView
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: categoryController.categories.value.length,
                        // Number of items in the list
                        itemBuilder: (context, index) {
                          return Container(
                            margin: EdgeInsets.only(left: 5, right: 5),
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(5)),
                                ),
                                backgroundColor:selectedcategory==index?buttoncolor2:
                                buttoncolor3     ,
                                // Use your defined button color
                                shadowColor: Colors.transparent,
                                // No shadow
                                elevation: 0, // No elevation
                              ),
                              onPressed: () {
                                selectedsubcategory=-1;

                                selectedcategory=index;
                                selectedcatid=categoryController
                                    .categories.value[index].id.toString();
                                serviceController.selectedcatis.value=selectedcatid;

                                categoryController.fetchSubCategories(categoryController
                                    .categories.value[index].id.toString());
                                serviceController.isLoading.value = true;
                                setState(() {

                                });
                                serviceController.fetchServices(
                                    selectedcatid,'');
                              },
                              child: Text(
                                " " +
                                    categoryController
                                        .categories.value[index].name.toUpperCase(),
                                style: TextStyle(color:
                                        selectedcategory==index?  Colors.white:
                                    Colors.black
                                  ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  );
                }
              },
            ),


            Obx(
                  () {
                if (categoryController.isSubcatLoading.value) {
                  return   const SizedBox.shrink();
                }
                else if(categoryController.subcategories.value.length==0)
                  {
                    return   const SizedBox.shrink();
                  }
                else {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        child: Text(
                          "SubCategories " ,
                          style: TextStyle(color: Colors.black,fontSize: 18),
                        ),
                      ),
                      SizedBox(height: 10,),

                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          height: 50.0,
                          // Set a fixed height for the horizontal ListView
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: categoryController.subcategories.value.length,
                            // Number of items in the list
                            itemBuilder: (context, index) {
                              return Container(
                                margin: EdgeInsets.only(left: 5, right: 5),
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    shape: RoundedRectangleBorder(
                                      borderRadius:
                                      BorderRadius.all(Radius.circular(5)),
                                    ),
                                    backgroundColor:selectedsubcategory==index?buttoncolor2:
                                    buttoncolor3,
                                    shadowColor: Colors.transparent,
                                    // No shadow
                                    elevation: 0, // No elevation
                                  ),
                                  onPressed: () {
                                    selectedsubcategory=index;
                                    serviceController.isLoading.value = true;
                                    setState(() {

                                    });
                                    serviceController.fetchServices(selectedcatid,
                                        categoryController
                                            .subcategories.value[index].id.toString());
                                  },
                                  child: Text(
                                    " " +
                                        categoryController
                                            .subcategories.value[index].name.toUpperCase(),
                                    style: TextStyle(color:
                                    selectedsubcategory==index?  Colors.white:
                                    Colors.black

                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                    ],
                  );
                }
              },
            ),

            Obx(
                  () {
                if (serviceController.isLoading.value) {
                  return Expanded(child: Center(child: CircularProgressIndicator(
                    color: Colors.blue,
                  )));
                } else if (serviceController.services.value.isEmpty) {
                  return Expanded(
                    child: const Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(top: 0.0),
                            child: Text(
                              'NO SERVICE FOUND',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 20,  // Adjust font size based on screen size
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
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
                            mainAxisExtent: 210,
                          ),
                          itemCount: serviceController.services.length,
                          // Number of items in the grid
                          itemBuilder: (context, index) {
                            final service = serviceController.services[index];
                            final isSelected = serviceController.selectedServices.any((s) => s.id == service.id);

                            return InkWell(
                              onTap: () {
                                showCustomDialog(context, service, index);
                              },
                              child: Servicewidget(
                                service: service,
                                type: "show",
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
  int _calculateLines(BuildContext context, String text) {
    final span = TextSpan(
      text: text,
      style: TextStyle(
        fontSize: 13,
        fontWeight: FontWeight.normal,
      ),
    );

    final tp = TextPainter(
      text: span,
      maxLines: _isExpanded ? null : 5,
      textDirection: TextDirection.ltr,
      ellipsis: _isExpanded ? null : '...',
    );

    tp.layout(maxWidth: MediaQuery.of(context).size.width);
    return tp.computeLineMetrics().length;
  }
  void showCustomDialog(BuildContext context, Service service, int index) {
    double height=350;
    if((_calculateLines(context, service.description))>3)
    {
      height=450;

    }else{
      height=300;

    }
    showDialog(
      context: context,
      builder: (BuildContext context) {
        final service = serviceController.services[index];
        final isSelected = serviceController.selectedServices.any((s) => s.id == service.id);
        bool _isExpanded = false;

        return StatefulBuilder(
          builder: (context, setState2) {
            return Dialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              child: Stack(
                children: [
                  Positioned(
                    right: 10,
                    top: 10,
                    child: GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Icon(Icons.close),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(20),
                    height: height,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          service.title,
                          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 10),
                        Container(
                          child: Expanded(
                            child: SingleChildScrollView(
                              child: Text(
                                service.description,
                                maxLines: _isExpanded ? null : 10,
                                overflow: _isExpanded ? TextOverflow.visible : TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                            ),
                          ),
                        ),
                        if( (_calculateLines(context, service.description))>3)
                        GestureDetector(
                          onTap: () {
                            setState2(() {
                              _isExpanded = !_isExpanded;
                            });
                          },
                          child: Text(
                            _isExpanded ? "Show less" : "Show more",
                            style: TextStyle(
                              color: Colors.blue,
                              fontSize: 13,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),

                        SizedBox(height: 10),
                        Text(
                          '${service.duration.toString()} min',
                          style: TextStyle(fontSize: 18),
                        ),
                        SizedBox(height: 5),
                        Text(
                          '£${service.price.toString()}',
                          style: TextStyle(fontSize: 18),
                        ),
                        SizedBox(height: 25),

                        Center(
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

                              setState(() {
                                print("selectedServices"+serviceController.selectedServices.toString());
                                if (isSelected) {
                                  serviceController.selectedServices.removeWhere((s) => s.id == service.id);
                                } else {
                                  serviceController.selectedServices.add(service);
                                }
                              });
                              Navigator.pop(context);
                            },
                            child: Text(
                              isSelected ? "Remove from booking" : "Add to booking",
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
                ],
              ),
            );
          },
        );
      },
    );
  }

  void showCustomDialog2(BuildContext context, Service service,int index) {
    double height=350;
    if((_calculateLines(context, service.description))>3)
    {
      height=450;

    }else{
      height=300;

    }
    bool _isExpanded = false;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        final service = serviceController.services[index];
        final isSelected = serviceController.selectedServices.any((s) => s.id == service.id);

        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          child: Stack(
            children: [
              Positioned(
                  right: 10,
                  top: 10,
                  child: GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Icon(Icons.close))),

              Container(
                padding: EdgeInsets.all(20),
                height: height,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      service.title,
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 10),
                    Expanded(
                      child: SingleChildScrollView(
                        child: Text(
                          service.description,
                          maxLines: _isExpanded ? null : 7,
                          overflow: _isExpanded ? TextOverflow.visible : TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                      ),
                    ),
                    Visibility(
                      visible: (_calculateLines(context, service.description))>3,
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            _isExpanded = !_isExpanded;
                          });
                        },
                        child: Text(
                          _isExpanded ? "Show less" : "Show more",
                          style: TextStyle(
                            color: Colors.blue,
                            fontSize: 13,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      service.duration.toString()+" min",
                      style: TextStyle(fontSize: 18),
                    ),

                    SizedBox(height: 5),
                    Text(
                      '£'+service.price.toString(),
                      style: TextStyle(fontSize: 18),
                    ),

                    Spacer(),
                    Center(
                      child: Padding(
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

                            setState(() {
                              print("selectedServices"+serviceController.selectedServices.toString());
                              if (isSelected) {
                                serviceController.selectedServices.removeWhere((s) => s.id == service.id);
                              } else {
                                serviceController.selectedServices.add(service);
                              }
                            });
                            Navigator.pop(context);

                          },
                          child: Text(
                            isSelected?
                            "Remove from booking":
                            "Add to booking",

                            style: TextStyle(
                              color: Colors.white,
                              fontSize: MediaQuery.of(context).size.width * 0.045, // Dynamic font size
                            ),
                          ),
                        ),
                      ),


                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
