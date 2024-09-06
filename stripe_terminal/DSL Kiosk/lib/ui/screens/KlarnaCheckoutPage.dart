import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:stripe_terminal/stripe_terminal.dart';

class KlarnaCheckoutPage extends StatefulWidget {
  @override
  _KlarnaCheckoutPageState createState() => _KlarnaCheckoutPageState();
}

class _KlarnaCheckoutPageState extends State<KlarnaCheckoutPage> {
  StripeTerminal? stripeTerminal;
  List<StripeReader> readers = [];
  bool isStripeTerminalInitialized = false;

  @override
  void initState() {
    super.initState();
    requestPermissions();
  }

  void requestPermissions() async {
    Map<Permission, PermissionStatus> statuses = await [
      Permission.bluetooth,
      Permission.bluetoothScan,
      Permission.bluetoothConnect,
      Permission.location,
    ].request();

    bool allGranted = statuses.values.every((status) => status.isGranted);
    if (allGranted) {
      await initializeStripeTerminal();
    } else {
      _showSnackbar("Permissions not granted");
    }
  }

  Future<void> initializeStripeTerminal() async {
    if (stripeTerminal == null) {
      stripeTerminal = await StripeTerminal.getInstance(
        fetchToken: () async {
          // Return the hardcoded connection token
          const token = "pk_test_51Pc1lXRpzFtip9xRH2cPX7O9CUTCSJn5AkMu39FwzZHGkJjUDXbKCpnnSAhhdCpDBkxdNcstgM6hgiLcj3GhVTgH00kekS9rFj"; // Replace with your actual token
          return token;
        },
      );
      setState(() {
        isStripeTerminalInitialized = true;
      });
    }
  }

  Future<void> discoverReaders() async {
    await _initializeIfNeeded();

    stripeTerminal!.discoverReaders(DiscoverConfig(simulated: true, discoveryMethod: DiscoveryMethod.embedded)).listen((List<StripeReader> readers) {
      setState(() {
        this.readers = readers;
      });
    });
  }

  // Future<void> connectBluetoothReader() async {
  //   await _initializeIfNeeded();
  //
  //   // Replace this serial number with the one from your WisePad™ 3 device
  //   const serialNumber = "WPC323207010205";
  //
  //   // Replace with your desired location ID
  //   const locationId = "tml_FrlzzgWgEfw3PV";
  //
  //   if (readers.isNotEmpty) {
  //     bool connected = await stripeTerminal!.connectBluetoothReader(
  //       serialNumber,
  //       locationId: 'tml_FrlzzgWgEfw3PV',
  //     );
  //     if (connected) {
  //       _showSnackbar("Connected to the WisePad™ 3 device");
  //     } else {
  //       _showSnackbar("Failed to connect to the WisePad™ 3 device");
  //     }
  //   } else {
  //     _showSnackbar("No readers found");
  //   }
  // }


  // Future<void> scanCard() async {
  //   await _initializeIfNeeded();
  //
  //   try {
  //     StripePaymentMethod paymentMethod = await stripeTerminal!.readReusableCardDetail();
  //     _showSnackbar("A card was read, the last four digits are ${paymentMethod.card?.last4}");
  //   } catch (e) {
  //     _showSnackbar("Failed to read card details: $e");
  //   }
  // }

  Future<String> createPaymentIntent() async {
    return "sk_test_51Pc1lXRpzFtip9xRg4LAQzvy4tp79rOfVVjgFVbWhBJLPFD3Fuzz7ZHoZedbJawPxUfLEszhe3xUjec6aDU4WxOd00didUS7dt";
  }

  Future<void> scanPaymentMethod() async {
    await _initializeIfNeeded();

    try {
      String paymentIntentClientSecret = await createPaymentIntent();
      StripePaymentIntent paymentIntent = await stripeTerminal!.collectPaymentMethod(paymentIntentClientSecret);
      _showSnackbar("A payment intent has captured a payment method. Send this payment intent to your backend to capture the payment.");
    } catch (e) {
      _showSnackbar("Failed to collect payment method: $e");
    }
  }

  Future<void> _initializeIfNeeded() async {
    if (!isStripeTerminalInitialized) {
      await initializeStripeTerminal();
    }
  }

  void _showSnackbar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Stripe Terminal"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: discoverReaders,
              child: Text("Discover Readers"),
            ),
            ElevatedButton(
              onPressed: connectBluetoothReader,
              child: Text("Connect to Bluetooth Reader"),
            ),
            ElevatedButton(
              onPressed: scanCard,
              child: Text("Scan Card"),
            ),
            ElevatedButton(
              onPressed: scanPaymentMethod,
              child: Text("Scan Payment Method"),
            ),
          ],
        ),
      ),
    );
  }
  Future<void> connectBluetoothReader() async {
    await _initializeIfNeeded();

    if (readers.isNotEmpty) {
      const serialNumber = "WPC323207010205";
      const locationId = "tml_FrlzzgWgEfw3PV";

      bool connected = await stripeTerminal!.connectBluetoothReader(
        serialNumber,
        locationId: locationId,
      );

      if (connected) {
        _showSnackbar("Connected to the WisePad™ 3 device");
      } else {
        _showSnackbar("Failed to connect to the WisePad™ 3 device");
      }
    } else {
      _showSnackbar("No readers found");
    }
  }

  Future<void> scanCard() async {
    await _initializeIfNeeded();

    if (readers.isNotEmpty) {
      try {
        final connectedReader = await stripeTerminal!.fetchConnectedReader();
        if (connectedReader != null) {
          StripePaymentMethod paymentMethod = await stripeTerminal!.readReusableCardDetail();
          _showSnackbar("A card was read, the last four digits are ${paymentMethod.card?.last4}");
        } else {
          _showSnackbar("No reader is currently connected.");
        }
      } catch (e) {
        _showSnackbar("Failed to read card details: $e");
      }
    } else {
      _showSnackbar("No readers found.");
    }
  }


}