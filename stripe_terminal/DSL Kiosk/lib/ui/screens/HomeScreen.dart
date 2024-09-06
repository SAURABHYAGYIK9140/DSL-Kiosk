import 'package:dsl_kiosk/controllers/home_controller/HomeController.dart';
import 'package:dsl_kiosk/ui/widgets/CustomeWidgets.dart';
import 'package:dsl_kiosk/utils/route_pages/page_name.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../utils/Constants.dart';
import '../../utils/Colors.dart';
import 'package:get/get.dart';
import '../../utils/utils.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

final homecontroller=Get.put(Homecontroller());
    return SafeArea(
      child: Scaffold(
        body: Container(
          color: Colors.white,
          child: Stack(
            children: [
              Positioned.fill(
                child: Container(
                  child: Positioned.fill(
                    child: Image.asset(
                      'assets/images/mainbg.jfif',
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              Positioned.fill(
                right: 0,
                bottom: 0,
                top: 0,
                left: 0,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: width * 0.04, vertical: height * 0.04),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Spacer(),
                      Padding(
                        padding: EdgeInsets.only(bottom: height * 0.02),
                        child: Text(
                          "TOUCH \nHERE",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                            color: Colors.white,
                            fontSize: width * 0.095,
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: width * 0.22),
                        child: Image.asset(
                          'assets/images/tap.png',
                          height: height * 0.12,
                          fit: BoxFit.cover,
                        ),
                      ),
                      SizedBox(height: height * 0.10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          InkWell(
                            onTap: () {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return Dialog(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(width * 0.01),
                                    ),
                                    elevation: 0.0,
                                    backgroundColor: Colors.transparent,
                                    child: Customewidgets.dialogContent(
                                        homecontroller,
                                        context),
                                  );
                                },
                              );
                            },
                            child: Card(
                              elevation: 10,
                              color: Colors.white,
                              child: Padding(
                                padding: EdgeInsets.all(width * 0.08),
                                child: Text(
                                  "CHECK \nIN",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                    fontSize: width * 0.055,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              Get.toNamed(MyPagesName.Showservices);
                            },
                            child: Card(
                              elevation: 10,
                              color: Colors.white,
                              child: Padding(
                                padding: EdgeInsets.all(width * 0.08),
                                child: Text(
                                  "BOOK &\nPAY",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,

                                    color: Colors.black,
                                    fontSize: width * 0.055,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Spacer(),
                    ],
                  ),
                ),
              ),
              Positioned(
                left: 0,
                right: 0,
                bottom: 0,
                child: Container(
                  alignment: Alignment.center,
                  color: Colors.white,
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            margin: EdgeInsets.only(top: height * 0.02),
                            child: Image.asset(
                              'assets/images/qr.jpg',
                              height: height * 0.12,
                            ),
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                "Scan to view our website!",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: width * 0.04,
                                ),
                              ),
                              Text(
                                "www.dslclinic.com",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: width * 0.04,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                child: Container(
                  alignment: Alignment.center,
                  color: Colors.white,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "DSL CLINIC",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: width * 0.06,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}