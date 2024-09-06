import 'package:dsl_kiosk/models/Service.dart';
import 'package:dsl_kiosk/ui/widgets/CustomeWidgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/ServiceController.dart';
import '../../utils/Colors.dart';

class Addonswidgets extends StatelessWidget {
  final Service service;
  final bool selected;

  Addonswidgets({required this.service, required this.selected});

  @override
  Widget build(BuildContext context) {
    final ServiceController serviceController = Get.put(ServiceController());

    return Container(
      child: Card(
        color: Colors.white,
        margin: EdgeInsets.all(2),
        elevation: 5,
        shape: selected
            ? RoundedRectangleBorder(
          side: BorderSide(color: Colors.blue, width: 2),
          borderRadius: BorderRadius.circular(5),
        )
            : RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5),
        ),
        // color: selected ? Colors.blue.withOpacity(0.1) : bgcolor,
        child: Stack(
          children: [
            Positioned(
                top: 3,
                right: 5,
                child: selected ? Icon(Icons. done) : Icon(Icons.add) ),
            Container(
              margin: EdgeInsets.only(left: 5),
              padding: const EdgeInsets.all(10.0),
              height: 500,
              child: Column(
                children: [
                  Text(
                    service.title,
                    style: TextStyle(color: Colors.black, fontSize: 17, fontWeight: FontWeight.w500),
                  ),
                  SizedBox(
                    height: 1,
                  ),
                  Expanded(
                    child: Text(
                      maxLines: 5,
                      service.description,
                      style: TextStyle(color: Colors.transparent, fontSize: 14, fontWeight: FontWeight.w400),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Text(
                            textAlign: TextAlign.start,
                            "Price : £" + service.price.toString(),
                            style: TextStyle(color: Colors.black, fontSize: 15, fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Text(
                            textAlign: TextAlign.start,
                            "Time : " + service.duration.toString() + " min",
                            style: TextStyle(color: Colors.black, fontSize: 15, fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
