import 'package:dsl_kiosk/utils/BluetoothReader.dart';
import 'package:dsl_kiosk/utils/Colors.dart';
import 'package:dsl_kiosk/utils/route_pages/page_name.dart';
import 'package:dsl_kiosk/utils/route_pages/route_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_stripe/flutter_stripe.dart';

void main() {
  Stripe.publishableKey = 'pk_test_51Pc1lXRpzFtip9xRH2cPX7O9CUTCSJn5AkMu39FwzZHGkJjUDXbKCpnnSAhhdCpDBkxdNcstgM6hgiLcj3GhVTgH00kekS9rFj';
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'DSL Kiosk',
      debugShowCheckedModeBanner: false,

      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: buttoncolor2),
        useMaterial3: true,
      ),
        initialRoute: MyPagesName.splashFile,
        getPages: MyPages.list);
  }
}
