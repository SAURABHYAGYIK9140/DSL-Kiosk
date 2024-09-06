import 'package:dsl_kiosk/controllers/home_controller/HomeController.dart';
import 'package:dsl_kiosk/ui/widgets/CustomeWidgets.dart';
import 'package:flutter/material.dart';
import '../../utils/Colors.dart';
import 'package:get/get.dart';

class MyBookings extends StatelessWidget {
  const MyBookings({super.key});

  @override
  Widget build(BuildContext context) {
    final Homecontroller homeController = Get.find();
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          'My Bookings',
          style: TextStyle(
            fontSize: screenWidth * 0.057, // Adjust font size based on screen width
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Obx(() {
            if (homeController.isLoading.value) {
              return Center(child: CircularProgressIndicator());
            } else if (homeController.categories.isEmpty) {
              return Padding(
                padding: EdgeInsets.all(screenWidth * 0.05), // Adjust padding based on screen width
                child: Center(
                  child: Text(
                    "Sorry we could not find your booking \n\n"
                        "No problem, just press the button below and we'll let the team know you have arrived",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: screenWidth * 0.045, // Adjust font size based on screen width
                    ),
                  ),
                ),
              );
            } else {
              return Padding(
                padding: EdgeInsets.only(bottom: screenHeight * 0.1), // Adjust bottom padding based on screen height
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Expanded(
                      child: ListView.builder(
                        itemCount: homeController.categories.length,
                        itemBuilder: (context, index) {
                          final booking = homeController.categories[index];
                          return Card(
                            margin: EdgeInsets.all(screenWidth * 0.03), // Adjust margin based on screen width
                            elevation: 7,
                            color: Colors.white,
                            child: ListTile(
                              title: Text(
                                'Name : ${booking.firstName} ${booking.lastName}',
                                style: TextStyle(
                                  fontSize: screenWidth * 0.04, // Adjust font size based on screen width
                                ),
                              ),
                              subtitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('Email: ${booking.email}'),
                                  Text('Mobile: ${booking.mobile}'),
                                  Text('Date: ${booking.ddate.toLocal()}'),
                                  Text('Slot: ${booking.slotDate} ${booking.slotTime ?? ''}'),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              );
            }
          }),
          Positioned(
            bottom: screenHeight * 0.02, // Adjust bottom position based on screen height
            left: screenWidth * 0.02, // Adjust left position based on screen width
            right: screenWidth * 0.02, // Adjust right position based on screen width
            child: Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(5)),
                      ),
                      backgroundColor: buttoncolor2, // Use your defined button color
                      shadowColor: Colors.transparent, // No shadow
                      elevation: 0, // No elevation
                    ),
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return Dialog(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                            elevation: 0.0,
                            backgroundColor: Colors.transparent,
                            child: Customewidgets.dialogContent2(context),
                          );
                        },
                      );
                    },
                    child: Padding(
                      padding: EdgeInsets.all(screenWidth * 0.02), // Adjust padding based on screen width
                      child: Text(
                        "MY BOOKING ISN'T IN THE LIST",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: screenWidth * 0.02), // Add space between buttons based on screen width
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(5)),
                      ),
                      backgroundColor: buttoncolor2, // Use your defined button color
                      shadowColor: Colors.transparent, // No shadow
                      elevation: 0, // No elevation
                    ),

                    onPressed: () {
                      Navigator.of(context).pop();

                      // Optionally, add action for this button
                    },
                    child: Padding(
                      padding: EdgeInsets.all(screenWidth * 0.02), // Adjust padding based on screen width
                      child: Text(
                        'CHECK IN',
                        style: TextStyle(color: Colors.white),
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
  }
}