
import 'package:dsl_kiosk/controllers/home_controller/HomeController.dart';
import 'package:dsl_kiosk/utils/Colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_stripe/flutter_stripe.dart';

import '../../utils/route_pages/page_name.dart';
import '../screens/ChooseAppointmenttime.dart';
import '../screens/ProfessionalSelectionScreen.dart';

class Customewidgets {
  static Widget bgcoloricon(IconData icon) {
    return Container(
      width: 30,
      height: 30,
      decoration: BoxDecoration(
        color: Colors.black,
        shape: BoxShape.circle,
      ),
      child: Center(
        child: Icon(
          icon,
          size: 20.0,
          color: Colors.white,
        ),
      ),
    );
  }

  static Widget bgcoloricon2(IconData icon) {
    return Container(
      width: 25,
      height: 25,
      decoration: BoxDecoration(
        color: Colors.grey,
        shape: BoxShape.circle,
      ),
      child: Center(
        child: Icon(
          icon,
          size: 17.0,
          color: Colors.white,
        ),
      ),
    );
  }

  static Widget space() {
    return Container(
      color: Colors.blueGrey,
      height: .6,
    );
  }

  static Widget space2() {
    return Container(
      color: Colors.white,
      height: .6,
    );
  }

  static Widget dialogContent(
      Homecontroller homecontroller,
      BuildContext context) {
    return Container(
      padding: EdgeInsets.all(2.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: Stack(
        children: [
          Positioned(
              right: 1,
              child: IconButton(
                icon: Icon(Icons.close),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              )),
          Padding(

            padding: const EdgeInsets.all(18.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "Find your booking",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.w600
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  "Please enter your first name so we can locate your appointment",
                  style: TextStyle(

                    color: Colors.black,
                    fontSize: 14,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                TextField(
                  onChanged:  (value) {
                    homecontroller.searchedtext.value=value;
                  },
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),

                    hintText: 'Enter your text...',
                  ),
                ),
                SizedBox(height: 16.0),
                ElevatedButton(

                  style: ElevatedButton.styleFrom(

                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(5))
                    ),
                    fixedSize: Size(MediaQuery
                        .of(context)
                        .size
                        .width, 50),

                    backgroundColor: buttoncolor2,
                    // This makes the button transparent
                    shadowColor: Colors.transparent,
                    // No shadow
                    elevation: 0, // No elevation
                  ),

                  onPressed: () {
                    homecontroller.fetchbookings(context);

                  },
                  child: Text('Submit', style: TextStyle(color: Colors.white),),
                ),
                SizedBox(height: 16.0),

              ],
            ),
          )
        ],
      ),
    );
  }

  static Widget dialogContent2(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(2.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: Stack(
        children: [
          Positioned(
              right: 1,
              child: IconButton(
                icon: Icon(Icons.close),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              )),
          Padding(

            padding: const EdgeInsets.all(18.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "No problem - You are checked in ",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.w600
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Text(
                  "We have let your therepist know that you have arrived",
                  style: TextStyle(

                    color: Colors.black,
                    fontSize: 14,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                ElevatedButton(

                  style: ElevatedButton.styleFrom(

                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(5))
                    ),
                    fixedSize: Size(MediaQuery
                        .of(context)
                        .size
                        .width, 50),

                    backgroundColor: buttoncolor2,
                    // This makes the button transparent
                    shadowColor: Colors.transparent,
                    // No shadow
                    elevation: 0, // No elevation
                  ),

                  onPressed: () {
                    Navigator.of(context).pop();

                    Get.toNamed(MyPagesName.Checkedin);
                  },
                  child: Text('OK', style: TextStyle(color: Colors.white),),
                ),
                SizedBox(height: 16.0),

              ],
            ),
          )
        ],
      ),
    );
  }

  static void showYesNoDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Text("Do you need removals?"),
          title: Text("Need removals?"),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                // Action when "Yes" is pressed
                Navigator.of(context).pop(true);
                Get.toNamed(MyPagesName.ProfessionalSelectionScreen);
              },
              child: Text("Yes"),
            ),
            TextButton(
              onPressed: () {
                // Action when "No" is pressed
                Navigator.of(context).pop(
                    false); // Dismiss the dialog and return false
                Get.toNamed(MyPagesName.ProfessionalSelectionScreen);

              },
              child: Text("No"),
            ),
          ],
        );
      },
    ).then((value) {
      // Handle the result (true for "Yes", false for "No")
      if (value == true) {
        print("User clicked Yes");
        // Perform the action when "Yes" is clicked
      } else if (value == false) {
        print("User clicked No");
        // Perform the action when "No" is clicked
      }
    });
  }

  static Widget dialogContent_booking(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(2.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: Stack(
        children: [
          Positioned(
              right: 1,
              child: IconButton(
                icon: Icon(Icons.close),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              )),
          Padding(

            padding: const EdgeInsets.all(18.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "Please enter your details to secure your booking",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.w600
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                SizedBox(
                  height: 10,
                ),
                TextField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),

                    hintText: 'Enter your first name',
                  ),
                ),
                SizedBox(height: 16.0),
                TextField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),

                    hintText: 'Enter your last name',
                  ),
                ),
                SizedBox(height: 16.0),
                TextField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),

                    hintText: 'Enter your email ',
                  ),
                ),
                SizedBox(height: 16.0),
                TextField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),

                    hintText: 'Enter your phone number',
                  ),
                ),
                SizedBox(height: 16.0),
                ElevatedButton(

                  style: ElevatedButton.styleFrom(

                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(5))
                    ),
                    fixedSize: Size(MediaQuery
                        .of(context)
                        .size
                        .width, 50),

                    backgroundColor: buttoncolor,
                    // This makes the button transparent
                    shadowColor: Colors.transparent,
                    // No shadow
                    elevation: 0, // No elevation
                  ),

                  onPressed: () {
                    Navigator.of(context).pop();
                    Get.toNamed(MyPagesName.Bookingconfirmation);
                  },
                  child: Text(
                    'BOOK NOW', style: TextStyle(color: Colors.black),),
                ),
                SizedBox(height: 16.0),

              ],
            ),
          )
        ],
      ),
    );
  }

  static Widget dialogContent_paybooking(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(2.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: Stack(
        children: [
          Positioned(
              right: 1,
              child: IconButton(
                icon: Icon(Icons.close),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              )),
          Padding(

            padding: const EdgeInsets.all(18.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "Before you coninue",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.w600
                  ),
                ),

                SizedBox(height: 5.0),
                Text(
                  textAlign: TextAlign.center,
                  "Please press the accept our terms and condtions",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 14,
                      fontWeight: FontWeight.w400
                  ),
                ),
                SizedBox(height: 5.0),
                Text(
                  "• The new software update will enhance user experience and performance\n"
                      "• Team building activities are scheduled for next Friday.\n"
                      "• The marketing campaign has successfully increased brand awareness.\n"
                      "• Remote work policies are being reviewed for better flexibility.\n"
                      "• Customer feedback is crucial for our continuous improvement.",
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                SizedBox(height: 15.0),

                ElevatedButton(

                  style: ElevatedButton.styleFrom(

                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(5))
                    ),
                    fixedSize: Size(MediaQuery
                        .of(context)
                        .size
                        .width, 50),

                    backgroundColor: buttoncolor,
                    // This makes the button transparent
                    shadowColor: Colors.transparent,
                    // No shadow
                    elevation: 0, // No elevation
                  ),

                  onPressed: () async {
                    Navigator.of(context).pop();

                  },
                  child: Text(
                    'I AGREE', style: TextStyle(color: Colors.black),),
                ),
                SizedBox(height: 16.0),

              ],
            ),
          )
        ],
      ),
    );
  }

  Future<void> confirmPayment(String clientSecret) async {

  }


}

