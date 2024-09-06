import 'package:dsl_kiosk/ui/screens/HomeScreen.dart';
import 'package:dsl_kiosk/ui/screens/KlarnaCheckoutPage.dart';
import 'package:dsl_kiosk/ui/screens/StripeTerminal.dart';
import 'package:dsl_kiosk/utils/route_pages/page_name.dart';
import 'package:flutter/material.dart';
import 'package:get/get_connect.dart';
import 'package:get/get.dart';


import '../../binding/home_binding/home_binding.dart';
import '../../binding/internet_binding/internet_binding.dart';
import '../../binding/splash_binding/SplashBinding.dart';

import '../../ui/screens/BookingConfirmation.dart';
import '../../ui/screens/BookingConfirmedMessage.dart';
import '../../ui/screens/CheckedIn.dart';
import '../../ui/screens/ChooseAdons.dart';
import '../../ui/screens/ChooseAppointmenttime.dart';
import '../../ui/screens/NoBookingFound.dart';
import '../../ui/screens/ProfessionalSelectionScreen.dart';
import '../../ui/screens/SelectSubService.dart';
import '../../ui/screens/ShowServices.dart';
import '../../ui/screens/SplashPage.dart';
import '../../ui/screens/WebScreen.dart';


class MyPages
{
  static List<GetPage> get list => [
    GetPage(
        name: MyPagesName.splashFile,
        // page: () => SplashPage(),
        page: () => Stripeterminal(),
        binding: SplashBinding()),
    // GetPage(
    //     name: MyPagesName.login,
    //     page: () => LoginScreen(),
    //   binding: InternetBinding()
    // ),
    // GetPage(
    //     name: MyPagesName.verifyotp,
    //     page: () => VerifyPage(),
    // ),
    // GetPage(
    //     name: MyPagesName.createprofile,
    //     page: () => CreateProfileScreen(),
    // ),
    GetPage(
      name: MyPagesName.home,
      page: () => HomeScreen(),
      binding:HomeBinding(),
    ),
    GetPage(
      name: MyPagesName.nobookingfound,
      page: () => MyBookings(),
    ),
    GetPage(
      name: MyPagesName.Checkedin,
      page: () => Checkedin(),
    ),
    GetPage(
      name: MyPagesName.Showservices,
      page: () => Showservices(),
    )
    ,
    GetPage(
      name: MyPagesName.Chooseadons,
      page: () => Chooseadons(),
    )
    ,
    GetPage(
      name: MyPagesName.Chooseappointmenttime,
      page: () => ChooseAppointmentTime(),
    )
    ,
    GetPage(
      name: MyPagesName.Bookingconfirmation,
      page: () => BookingConfirmation(),
    )
    ,
    GetPage(
      name: MyPagesName.ProfessionalSelectionScreen,
      page: () => ProfessionalSelectionScreen(),
    )
    ,
    GetPage(
      name: MyPagesName.Selectsubservice,
      page: () => Selectsubservice(),
    )
    ,
    GetPage(
      name: MyPagesName.klarna,
      page: () => KlarnaCheckoutPage(),
    )
    ,
    GetPage(
      name: MyPagesName.Webscreen,
      page: () => Webscreen(),
    )
    ,
    GetPage(
      name: MyPagesName.BookingConfirmedMessage,
      page: () => BookingConfirmedMessage(),
    )
  ];
}