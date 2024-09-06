import 'package:dsl_kiosk/ui/widgets/CustomeWidgets.dart';
import 'package:dsl_kiosk/utils/route_pages/page_name.dart';
import 'package:flutter/material.dart';

import '../../utils/Colors.dart';
import 'package:get/get.dart';
class Checkedin extends StatelessWidget {
  const Checkedin({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Positioned(
            top: 120,
            left: MediaQuery.of(context).size.width / 2 - 60, // Center horizontally
            child: CircleAvatar(
              radius: 60,
              backgroundColor: Colors.transparent, // Set background color to transparent
              child: ClipOval(
                // Use ClipOval to clip the child into a circle
                child: Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/images/done.png'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ),
          ),

          Padding(
            padding: EdgeInsets.symmetric(horizontal: 25,vertical: 10),
            child: Center(
              child:      Text(
                textAlign: TextAlign.center,
                "Thanks you're checked in \n\n"
                    "Please take a seat in our waiting area and one of our team will be with you shortly",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                ),
              ),
            ),
          ),
          Positioned(
            left: 10,
              right: 10,
              bottom: 1, child:  ElevatedButton
            (
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
              Get.offAllNamed(MyPagesName.home);
            },
            child: Text(
              "BACK TO HOME",
              style: TextStyle(color: Colors.white),
            ),
          ))
        ],
      ),
    );
  }
}
