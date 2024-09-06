import 'package:dsl_kiosk/ui/widgets/CalendarAppBar.dart';
import 'package:dsl_kiosk/utils/Colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/ProfessionalController.dart';
import '../../controllers/ServiceController.dart';
import '../../services/Api.dart';
import '../../utils/route_pages/page_name.dart';
import '../widgets/CustomeWidgets.dart';
import 'package:intl/intl.dart';

class ChooseAppointmentTime extends StatefulWidget {
  const ChooseAppointmentTime({super.key});

  @override
  State<ChooseAppointmentTime> createState() => _ChooseAppointmentTimeState();
}

class _ChooseAppointmentTimeState extends State<ChooseAppointmentTime> {
  bool showtexts = true;
  int selectedIdx = -1; // Variable to store the index of the selected item
  int selectedIdx2 = -1; // Variable to store the index of the selected item
  final ProfessionalController controller = Get.put(ProfessionalController());
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController mobileController = TextEditingController();
  final ServiceController serviceController = Get.put(ServiceController());
  final ProfessionalController professionalController = Get.put(ProfessionalController());
String selecteddate="";
String slotid="";
  final _formKey = GlobalKey<FormState>();


  void bookAppointment() async {
    DateTime now = DateTime.now();
    String formattedDate = DateFormat('yyyy-MM-dd').format(now);
    print(formattedDate);
    Map<String, dynamic> bookAppointment = {
      'service_id': ''+serviceController.selected_servicesid.value.toString(),
      'addon_id': ''+serviceController.selected_addonsid.value.toString(),
      'profession_id': ''+professionalController.profession_id,
      'date': ''+formattedDate, // Replace with your date
      'slot_id': ''+slotid,
      'slot_time': ''+ professionalController.selectedtiming.slot,
      'slot_date': ''+selecteddate,
      'first_name': firstNameController.text,
      'last_name': lastNameController.text,
      'email': emailController.text,
      'mobile': mobileController.text,
    };
    professionalController.bookAppointment_name.value=firstNameController.text+" "+lastNameController.text;
    print("bookAppointment"+bookAppointment.toString());

    bool success = await ApiService.addKiBooking(bookAppointment);
    // Close the dialog regardless of success or failure
    if (success) {

      Navigator.pop(context);

      // Handle success
      // Get.snackbar(
      //   "Booking added",
      //   "Booking added successfully",
      //   snackPosition: SnackPosition.BOTTOM,
      //   duration: Duration(seconds: 1), // Adjust the duration here
      // );

      // Future.delayed(Duration(seconds: 2), () {
        Get.toNamed(MyPagesName.Bookingconfirmation);
      // });
      print('Booking added successfully');
      // Optionally, navigate to confirmation page or show success message
      // Navigator.of(context).pushNamed(MyPagesName.Bookingconfirmation);
    } else {
      // Handle failure
      print('Failed to add booking');
      // Optionally, show error message
    }
    // Navigator.of(context).pop();


  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawerScrimColor: Colors.white,
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text("Choose your appointment"),
      ),
      body: Stack(
        children: [
          Positioned.fill(
            child: Padding(
              padding: EdgeInsets.only(bottom: 125, right: 25, left: 25),
              child: Center(
                child: showtexts
                    ? Text(
                        "We are sorry - all of your appointments on this day have been booked!\n"
                        "To join the wait list, press the button below. We will connect you if any space becomes available.",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                        ),
                      )
                    : appointmenttime(),
              ),
            ),
          ),
          Positioned(
            bottom: 10,
            left: 8,
            right: 8,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Align(
                  alignment: AlignmentDirectional.centerEnd,
                  child: showtexts
                      ? ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5)),
                            ),
                            backgroundColor: buttoncolor2,
                            // Use your defined button color
                            shadowColor: Colors.transparent,
                            // No shadow
                            elevation: 0, // No elevation
                          ),
                          onPressed: () {
                            setState(() {
                              showtexts = false;
                            });
                          },
                          child: Text(
                            "GO TO FIRST AVAILABLE APPOINTMENT",
                            style: TextStyle(color: Colors.white),
                          ),
                        )
                      : Text(""),
                ),
                SizedBox(height: 8), // Add space between buttons
                Align(
                  alignment: AlignmentDirectional.centerEnd,
                  child: showtexts
                      ? ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5)),
                            ),
                            backgroundColor: buttoncolor2,
                            // Use your defined button color
                            shadowColor: Colors.transparent,
                            // No shadow
                            elevation: 0, // No elevation
                          ),
                          onPressed: () {
                            // Navigator.of(context).pop();
                            // Get.toNamed(MyPagesName.noBookingFound);
                          },
                          child: Text(
                            'JOIN WAIT LIST FOR 23 JUNE',
                            style: TextStyle(color: Colors.white),
                          ),
                        )
                      : Text(""),
                ),
                CalendarAppBar(),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            "Final price: £"+(serviceController.total_service_price.value+serviceController.total_addon_price.value).toString(),
                            style: TextStyle(color: Colors.black),
                          ),
                          Text(
                            serviceController.addTimes(),
                            style: TextStyle(color: Colors.black),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(5)),
                              ),
                              backgroundColor: buttoncolor2,
                              // Use your defined button color
                              shadowColor: Colors.transparent,
                              // No shadow
                              elevation: 0, // No elevation
                            ),
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: Text(
                              "BACK",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                          SizedBox(width: 8), // Add space between buttons
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(5)),
                              ),
                              backgroundColor: buttoncolor2,
                              // Use your defined button color
                              shadowColor: Colors.transparent,
                              // No shadow
                              elevation: 0, // No elevation
                            ),
                            onPressed: () {
                              if(slotid=="")
                                {
                                  Get.snackbar("Select slot", "Please select a slot",snackPosition: SnackPosition.BOTTOM);
                               return;
                                }
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return Dialog(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20.0),
                                    ),
                                    elevation: 0.0,
                                    backgroundColor: Colors.transparent,
                                    child: SingleChildScrollView(
                                      child: Container(
                                        padding: EdgeInsets.all(18.0),
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.circular(20.0),
                                        ),
                                        child: Form(
                                          key: _formKey, // Add a GlobalKey<FormState>
                                          child: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              IconButton(
                                                icon: Icon(Icons.close),
                                                onPressed: () {
                                                  Navigator.of(context).pop();
                                                },
                                                alignment: Alignment.topRight,
                                              ),
                                              SizedBox(height: 10.0),
                                              Text(
                                                "Please enter your details to secure your booking",
                                                style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                              SizedBox(height: 10.0),
                                              TextFormField(
                                                controller: firstNameController,
                                                decoration: InputDecoration(
                                                  border: OutlineInputBorder(),
                                                  hintText: 'Enter your first name',
                                                ),
                                                validator: (value) {
                                                  if (value == null || value.isEmpty) {
                                                    return 'Please enter your first name';
                                                  }
                                                  return null;
                                                },
                                              ),
                                              SizedBox(height: 16.0),
                                              TextFormField(
                                                controller: lastNameController,
                                                decoration: InputDecoration(
                                                  border: OutlineInputBorder(),
                                                  hintText: 'Enter your last name',
                                                ),
                                                validator: (value) {
                                                  if (value == null || value.isEmpty) {
                                                    return 'Please enter your last name';
                                                  }
                                                  return null;
                                                },
                                              ),
                                              SizedBox(height: 16.0),
                                              TextFormField(
                                                controller: emailController,
                                                decoration: InputDecoration(
                                                  border: OutlineInputBorder(),
                                                  hintText: 'Enter your email',
                                                ),
                                                validator: (value) {
                                                  if (value == null || value.isEmpty) {
                                                    return 'Please enter your email';
                                                  }
                                                  if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                                                    return 'Please enter a valid email';
                                                  }
                                                  return null;
                                                },
                                              ),
                                              SizedBox(height: 16.0),
                                              TextFormField(
                                                maxLength: 10,

                                                keyboardType: TextInputType.number,
                                                controller: mobileController,
                                                decoration: InputDecoration(
                                                  border: OutlineInputBorder(),
                                                  hintText: 'Enter your phone number',
                                                ),
                                                validator: (value) {
                                                  if (value == null || value.isEmpty) {
                                                    return 'Please enter your phone number';
                                                  }
                                                  if (!RegExp(r'^\d+$').hasMatch(value)) {
                                                    return 'Please enter a valid phone number';
                                                  }
                                                  if (value.length>10) {
                                                    return 'Please enter a valid phone number';
                                                  }
                                                  return null;
                                                },
                                              ),
                                              SizedBox(height: 16.0),
                                              ElevatedButton(
                                                style: ElevatedButton.styleFrom(

                                                  shape: RoundedRectangleBorder(
                                                      borderRadius: BorderRadius.all(Radius.circular(5))
                                                  ),
                                                  fixedSize: Size(MediaQuery.of(context).size.width, 50),
                                                  backgroundColor: buttoncolor2, // This makes the button transparent
                                                  shadowColor: Colors.transparent, // No shadow
                                                  elevation: 0, // No elevation
                                                ),
                                                onPressed: () {

                                                  if (_formKey.currentState!.validate()) {
                                                    bookAppointment();
                                                    // Navigator.of(context).pop();
                                                    // Get.toNamed(MyPagesName.Bookingconfirmation);
                                                  }
                                                },
                                                child: Text('BOOK NOW',style: TextStyle(color: Colors.white),),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              );
                            },

                            child: Text(
                              'NEXT',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget appointmenttime() {
    return Column(
      children: [
        Obx(
          () {
            if (controller.isLoading.value != true) {
              return Align(
                alignment: AlignmentDirectional.topStart,
                child: Text(
                  'Next available on ' + controller.timing1[0].date,
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 20,
                    color: Colors.black,
                  ),
                ),
              );
            } else {
              return Align(
                alignment: AlignmentDirectional.topStart,
                child: Text(
                  'Next available on ',
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 20,
                    color: Colors.black,
                  ),
                ),
              );
            }
          },
        ),
        SizedBox(
          height: 20,
        ),
        Obx(
          () {
            if (controller.isLoading.value) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else {
              print('objecttiming1 --'+controller.timing1.length.toString());

              return Container(
                height: 150,
                child: GridView.builder(
                  scrollDirection: Axis.horizontal,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 10,
                    crossAxisSpacing: 10,
                    childAspectRatio: 2,
                    mainAxisExtent: 130,
                  ),
                  itemCount: controller.timing1.length,
                  itemBuilder: (context, index) {
                    // Assuming controller.timing1[index].date is a String
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          selecteddate=controller.timing1[index].date;
                          professionalController.selectedtiming=controller.timing1[index];
                          print("selectedtiming"+ professionalController.selectedtiming.date);
                          slotid=controller.timing1[index].id.toString();
                          selectedIdx2 = index;
                          selectedIdx = -1;

                        });
                      },
                      child: Card(
                        color: selectedIdx2 == index ? buttoncolor2 :  Colors.grey,
                        child: Padding(
                          padding: EdgeInsets.all(15),
                          child: Text(
                            controller.timing1[index].slot+"",
                            textAlign: TextAlign.start,
                            style: TextStyle(
                              fontWeight: FontWeight.w300,
                              fontSize: 20,
                              color: selectedIdx2 == index ? Colors.white : Colors.black,
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              );
            }
          },
        ),
        SizedBox(
          height: 20,
        ),
        Obx(
              () {
            if (controller.isLoading2.value != true) {
              return Align(
                alignment: AlignmentDirectional.topStart,
                child: Text(
                  'Later on ' + controller.timing2[0].date,
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 20,
                    color: Colors.black,
                  ),
                ),
              );
            } else {
              return Align(
                alignment: AlignmentDirectional.topStart,
                child: Text(
                  'Later on ',
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 20,
                    color: Colors.black,
                  ),
                ),
              );
            }
          },
        ),
        SizedBox(
          height: 20,
        ),
        Obx(() {
    if (controller.isLoading.value) {
      return Center(
        child: CircularProgressIndicator(),
      );
    }
    else{
      return  Expanded(
        child: SingleChildScrollView(
          child: Padding(

            padding: const EdgeInsets.only(bottom: 40.0),
            child: GridView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                // Number of items per row
                mainAxisSpacing: 10.0,
                crossAxisSpacing: 10.0,
                mainAxisExtent: 100,
                childAspectRatio: 2,
              ),
              itemCount: controller.timing2.length,
              // Number of items in the grid
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      professionalController.selectedtiming=controller.timing2[index];
                      selecteddate=controller.timing2[index].date;
                      slotid=controller.timing2[index].id.toString();
                      selectedIdx = index;
                      selectedIdx2 = -1;

                    });
                  },
                  child: Align(
                    alignment: AlignmentDirectional.topStart,
                    child: Card(
                      color: selectedIdx == index ? buttoncolor2 :  Colors.grey,
                      // Change color of selected item
                      child: Padding(
                        child: Text(
                          controller.timing2[index].slot,
                          textAlign: TextAlign.start,
                          style: TextStyle(
                            fontWeight: FontWeight.w300,
                            fontSize: 20,
                            color: selectedIdx == index ? Colors.white : Colors.black,

                          ),
                        ),
                        padding: EdgeInsets.all(15),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      );

        }
    },),
      ],
    );
  }
}
