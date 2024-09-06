import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/ProfessionalController.dart';
import '../../utils/Colors.dart';

class BookingConfirmedMessage extends StatelessWidget {
  final ProfessionalController controller = Get.put(ProfessionalController());

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size; // Get screen size

    return Scaffold(
      bottomNavigationBar: BottomAppBar(
        child: Container(
          width: screenSize.width,
          height: 60, // Set a fixed height
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
              backgroundColor: buttoncolor2, // Use defined button color
              elevation: 0, // No elevation
            ),
            onPressed: () {
              Get.offAllNamed('/home'); // Navigate to home page
            },
            child: Text(
              'Go to Home',
              style: TextStyle(fontSize: 20, color: Colors.white),
            ),
          ),
        ),
      ),
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
        backgroundColor: buttoncolor2,
        title: Text('DSL Clinic ', style: TextStyle(fontSize: 20, color: Colors.white)),
      ),
      body: Center(
        child: Container(
          width: screenSize.width * 0.8, // 80% of screen width
          margin: EdgeInsets.all(16.0),
          padding: EdgeInsets.all(24.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16.0),
            boxShadow: [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 10.0,
                offset: Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.check_circle,
                color: Colors.green,
                size: screenSize.width * 0.2, // 20% of screen width
              ),
              SizedBox(height: 16),
              Text(
                'Booking Successful',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 16),
              Text(
                'Your booking has been confirmed for ' +
                    controller.selectedtiming.date + " at " + controller.selectedtiming.slot + " " +
                    '.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey[700],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
