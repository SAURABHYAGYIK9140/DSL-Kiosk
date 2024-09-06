import 'dart:convert';

import 'package:dsl_kiosk/controllers/ServiceController.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import '../../controllers/ProfessionalController.dart';
import '../../utils/Colors.dart';
import '../../utils/route_pages/page_name.dart'; // Assuming you have a file for custom colors

class BookingConfirmation extends StatefulWidget {
  const BookingConfirmation({Key? key}) : super(key: key);

  @override
  State<BookingConfirmation> createState() => _BookingConfirmationState();
}

class _BookingConfirmationState extends State<BookingConfirmation> {
  Map<String, dynamic>? paymentIntent;
  final ProfessionalController controller = Get.put(ProfessionalController());
  final ServiceController serviceController = Get.put(ServiceController());
  bool showprogress = false;

  @override
  Widget build(BuildContext context) {
    List<String> titles = serviceController.selectedServices.value.map((service) => service.title).toList();
    var size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          "Your Booking",
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.black),
        ),
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.all(10),
              color: orange, // Use defined color from your Colors file
              child: Text(
                "Your booking will expire on "+controller.selectedtiming.date,
                style: TextStyle(fontSize: 14, color: Colors.white),
              ),
            ),
            SizedBox(height: 10),
            buildBookingDetail2(controller.selectedtiming.date + " " + controller.selectedtiming.slot, controller.bookAppointment_name.value),
            SizedBox(height: 10),
            Container(
              padding: EdgeInsets.all(10),
              child: Text(
                "Selected Plans",
                style: TextStyle(fontSize: 18, color: Colors.black),
              ),
            ),
            buildBookingDetail(
              titles.toString().replaceAll("[", "").replaceAll("]", ""),
              "Final price: £" + (serviceController.total_service_price.value + serviceController.total_addon_price.value).toString(),
            ),
            Expanded(
              child: Stack(
                children: [
                  Positioned(
                    left: 0,
                    right: 0,
                    bottom: 10,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Align(
                            alignment: AlignmentDirectional.bottomEnd,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.all(Radius.circular(5)),
                                ),
                                backgroundColor: buttoncolor2, // Use defined button color
                                elevation: 0, // No elevation
                              ),
                              onPressed: () async {
                                Get.toNamed(
                                  MyPagesName.klarna,
                                  arguments: "https://www.google.com/",
                                );
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(15.0),
                                child: Text(
                                  "PAY NOW BY Stripe terminal",
                                  textAlign: TextAlign.end,
                                  style: TextStyle(fontSize: 20, color: Colors.white),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Align(
                            alignment: AlignmentDirectional.bottomEnd,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.all(Radius.circular(5)),
                                ),
                                backgroundColor: buttoncolor2, // Use defined button color
                                elevation: 0, // No elevation
                              ),
                              onPressed: () async {
                                if (!showprogress) {
                                  showprogress = true;
                                }
                                setState(() {});
                                makePayment('US');
                              },
                              child: Stack(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(15.0),
                                    child: Text(
                                      "Pay By Klarna",
                                      textAlign: TextAlign.end,
                                      style: TextStyle(
                                        fontSize: 20,
                                        color: showprogress ? buttoncolor2 : Colors.white,
                                      ),
                                    ),
                                  ),
                                  if (showprogress)
                                    Positioned.fill(
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          CircularProgressIndicator(),
                                        ],
                                      ),
                                    ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildBookingDetail(String leftText, String rightText) {
    return Container(
      padding: EdgeInsets.all(15),
      color: buttoncolor2, // Use defined color from your Colors file
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            flex: 2,
            child: Text(
              leftText,
              style: TextStyle(fontSize: 14, color: Colors.white),
            ),
          ),
          SizedBox(width: 10),
          Expanded(
            flex: 2,
            child: Align(
              alignment: AlignmentDirectional.topCenter,
              child: Text(
                rightText,
                style: TextStyle(fontSize: 20, color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildBookingDetail2(String leftText, String rightText) {
    return Container(
      padding: EdgeInsets.all(15),
      color: buttoncolor2, // Use defined color from your Colors file
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            flex: 2,
            child: Text(
              leftText,
              style: TextStyle(fontSize: 17, color: Colors.white),
              maxLines: null,
              overflow: TextOverflow.visible,
            ),
          ),
          SizedBox(width: 10),
          Expanded(
            flex: 2,
            child: Align(
              alignment: AlignmentDirectional.topCenter,
              child: Text(
                rightText,
                style: TextStyle(fontSize: 20, color: Colors.white),
                maxLines: null,
                overflow: TextOverflow.visible,
              ),
            ),
          ),
        ],
      ),
    );
  }

  createPaymentIntent(String amount, String currency, String country) async {
    try {
      if (country != 'US') {
        throw Exception('Klarna payments are only available for US customers.');
      }

      Map<String, dynamic> body = {
        'amount': ((int.parse(amount)) * 100).toString(), // Amount must be in smaller unit of currency
        'currency': currency,
        'payment_method_types[]': 'klarna',
      };

      var secretKey = "sk_test_51Pc1lXRpzFtip9xRg4LAQzvy4tp79rOfVVjgFVbWhBJLPFD3Fuzz7ZHoZedbJawPxUfLEszhe3xUjec6aDU4WxOd00didUS7dt";
      var response = await http.post(
        Uri.parse('https://api.stripe.com/v1/payment_intents'),
        headers: {
          'Authorization': 'Bearer $secretKey',
          'Content-Type': 'application/x-www-form-urlencoded',
        },
        body: body,
      );

      print('Payment Intent Body: ${response.body.toString()}');
      return jsonDecode(response.body.toString());
    } catch (err) {
      print('Error creating payment intent: ${err.toString()}');
    }
  }

  Future<void> makePayment(String country) async {
    try {
      final billingDetails = BillingDetails(
        email: 'customer@example.com',
        address: Address(
          city: 'Los Angeles',
          country: 'US',
          line1: '123 Main St',
          line2: 'Apt 4B',
          postalCode: '90001',
          state: 'CA',
        ),
        phone: '123-456-7890',
        name: 'John Doe',
      );

      double total = serviceController.total_service_price.value + serviceController.total_addon_price.value;
      String numberString = total.toStringAsFixed(0); // '500'
      paymentIntent = await createPaymentIntent(numberString, 'usd', country);
      await Stripe.instance.initPaymentSheet(
        paymentSheetParameters: SetupPaymentSheetParameters(
          billingDetails: billingDetails,
          paymentIntentClientSecret: paymentIntent!['client_secret'],
          merchantDisplayName: 'Kiosk app',
        ),
      );
      displayPaymentSheet();
    } catch (e) {
      print("exception $e");
      if (e is StripeConfigException) {
        print("Stripe exception ${e.message}");
      } else {
        print("exception $e");
      }
    }
  }

  displayPaymentSheet() async {
    showprogress = false;
    setState(() {});

    try {
      await Stripe.instance.presentPaymentSheet();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Paid successfully")),
      );
      Get.toNamed(MyPagesName.BookingConfirmedMessage);

      // print('Payment successful. PaymentIntent: ${paymentIntent.toString()}');
      paymentIntent = null;
    } on StripeException catch (e) {
      print('Error: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Payment Cancelled")),
      );
    } catch (e) {
      print("Error in displaying");
      print('$e');
    }
  }

  void showPaymentSuccessDialog() {
    Get.defaultDialog(
      barrierDismissible: false,
      title: 'Payment Successful',
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.check_circle, color: Colors.green, size: 100),
          SizedBox(height: 20),
          Text(
            'Your payment was successful!',
            style: TextStyle(fontSize: 18),
          ),
        ],
      ),
      confirm: ElevatedButton(
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(2)),
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
    );
  }
}
