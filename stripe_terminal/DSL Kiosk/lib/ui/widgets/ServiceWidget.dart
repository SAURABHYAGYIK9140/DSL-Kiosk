import 'package:dsl_kiosk/models/Service.dart';
import 'package:dsl_kiosk/utils/route_pages/page_name.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../controllers/ProfessionalController.dart';
import '../../controllers/ServiceController.dart';
import '../../utils/Colors.dart';

// class Servicewidget extends StatelessWidget {
//   final Service service;
//   final String type;
//   final bool selected;
//
//   Servicewidget({required this.service, required this.type, required this.selected});
//
//   @override
//   Widget build(BuildContext context) {
//     final ServiceController serviceController = Get.put(ServiceController());
//     final ProfessionalController professionalController = Get.put(ProfessionalController());
//
//     // MediaQuery for screen size and orientation
//     var screenSize = MediaQuery.of(context).size;
//     var orientation = MediaQuery.of(context).orientation;
//
//     return Container(
//       child: Card(
//         margin: EdgeInsets.all(2),
//         color: Colors.white,
//         elevation: 5,
//         shape: selected
//             ? RoundedRectangleBorder(
//           side: BorderSide(color: Colors.blue, width: 2),
//           borderRadius: BorderRadius.circular(5),
//         )
//             : RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(5),
//         ),
//         child: Stack(
//           children: [
//             Positioned(
//               top: 2,
//               right: 5,
//               child: selected ? Icon(Icons.done) : Icon(Icons.add),
//             ),
//             Container(
//               margin: EdgeInsets.only(left: 5, top: 8),
//               padding: const EdgeInsets.all(10.0),
//               height: screenSize.height * 0.4,  // Adjust height based on screen size
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     service.title,
//                     maxLines: 2,
//                     style: TextStyle(
//                       color: Colors.black,
//                       fontSize: screenSize.width * 0.05,  // Adjust font size based on screen size
//                       fontWeight: FontWeight.w500,
//                     ),
//                   ),
//                   SizedBox(
//                     height: 10,
//                   ),
//                   Expanded(
//                     child: Text(
//                       service.description,
//                       maxLines: 3,
//                       style: TextStyle(
//                         color: Colors.black,
//                         fontSize: screenSize.width * 0.035,  // Adjust font size based on screen size
//                         fontWeight: FontWeight.w400,
//                       ),
//                     ),
//                   ),
//                   SizedBox(
//                     height: 10,
//                   ),
//                   Column(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       Row(
//                         children: [
//                           Text(
//                             "Price : £${service.price}",
//                             style: TextStyle(
//                               color: Colors.black,
//                               fontSize: screenSize.width * 0.04,  // Adjust font size based on screen size
//                               fontWeight: FontWeight.w500,
//                             ),
//                           ),
//                         ],
//                       ),
//                       Row(
//                         children: [
//                           Text(
//                             "Time : ${service.duration} min",
//                             style: TextStyle(
//                               color: Colors.black,
//                               fontSize: screenSize.width * 0.04,  // Adjust font size based on screen size
//                               fontWeight: FontWeight.w500,
//                             ),
//                           ),
//                         ],
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
import 'package:dsl_kiosk/models/Service.dart';
import 'package:dsl_kiosk/utils/route_pages/page_name.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../controllers/ProfessionalController.dart';
import '../../controllers/ServiceController.dart';
import '../../utils/Colors.dart';

import 'package:auto_size_text/auto_size_text.dart';

class Servicewidget extends StatelessWidget {
  final Service service;
  final String type;
  final bool selected;

  Servicewidget({required this.service, required this.type, required this.selected});

  @override
  Widget build(BuildContext context) {
    final ServiceController serviceController = Get.put(ServiceController());
    final ProfessionalController professionalController = Get.put(ProfessionalController());

    var screenSize = MediaQuery.of(context).size;

    return Container(
      child: Card(
        margin: EdgeInsets.all(2),
        color: Colors.white,
        elevation: 5,
        shape: selected
            ? RoundedRectangleBorder(
          side: BorderSide(color: Colors.blue, width: 2),
          borderRadius: BorderRadius.circular(5),
        )
            : RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5),
        ),
        child: Stack(
          children: [
            Positioned(
              top: 2,
              right: 5,
              child: selected ? Icon(Icons.done) : Icon(Icons.add),
            ),
            Container(
              margin: EdgeInsets.only(left: 5, top: 8),
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AutoSizeText(
                    service.title,
                    maxLines: 2,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: screenSize.width * 0.040,
                      fontWeight: FontWeight.w500,
                    ),
                    minFontSize: 8,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 10),
                  Expanded(
                    child: AutoSizeText(
                      service.description,
                      maxLines: 3,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: screenSize.width * 0.030,
                        fontWeight: FontWeight.w400,
                      ),
                      minFontSize: 8,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          AutoSizeText(
                            "Price : £${service.price}",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: screenSize.width * 0.031,
                              fontWeight: FontWeight.w500,
                            ),
                            minFontSize: 8,
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          AutoSizeText(
                            "Time : ${service.duration} min",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: screenSize.width * 0.031,
                              fontWeight: FontWeight.w500,
                            ),
                            minFontSize: 8,
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
