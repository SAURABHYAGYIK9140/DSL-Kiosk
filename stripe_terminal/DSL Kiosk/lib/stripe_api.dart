// ignore_for_file: avoid_print

import 'dart:convert';
import 'package:stripe/stripe.dart';

import 'models/k.dart';

class StripeApi {

  static const String secretKey = 'sk_test_51Pc1lXRpzFtip9xRg4LAQzvy4tp79rOfVVjgFVbWhBJLPFD3Fuzz7ZHoZedbJawPxUfLEszhe3xUjec6aDU4WxOd00didUS7dt';

  final _stripe = Stripe(secretKey);

  StripeApi() {
    if (secretKey.isEmpty) {
      throw ArgumentError('Secret key is not set');
    }
  }

  Future<String> createTerminalConnectionToken() async {
    try {
      final terminalToken = await _stripe.client.post('/terminal/connection_tokens');
      print(jsonEncode(terminalToken));
      return terminalToken['secret'] as String;
    } catch (error, stackTrace) {
      print('$error\n$stackTrace');
      rethrow;
    }
  }

  Future<Map<String, dynamic>> createLocation() async {
    final location = await _stripe.client.post('/terminal/locations', data: {
      'display_name': 'Mek',
      'address': {
        'line1': '221B Baker Street',
        'city': 'London',
        'state': '',
        'country': 'GB', // UK country code
        'postal_code': 'NW1 6XE',
      }
    });
    print(jsonEncode(location));
    return location;
  }

  Future<Map<String, dynamic>> fetchLocations() async {
    final locations = await _stripe.client.get('/terminal/locations');
    print(jsonEncode(locations));
    return locations;
  }

  Future<String> createPaymentIntent() async {
    final paymentIntent = await _stripe.client.post('payment_intents', data: {
      'currency': 'gbp', // GBP as the currency for the UK
      'payment_method_types': ['card_present'],
      'capture_method': 'manual',
      'amount': 1000, // Amount in pence (1000 pence = £10.00)
    });
    print(jsonEncode(paymentIntent));
    return paymentIntent['client_secret'];
  }

  Future<void> createReader() async {
    try {
      final paymentIntent = await _stripe.client.post('/terminal/readers', data: {
        'registration_code': 'simulated',
        'location': 'tml_FrlzzgWgEfw3PV',  // Replace with a valid location ID
        'label': 'Simulated device',
      });
      print(jsonEncode(paymentIntent));
    } catch (error, stackTrace) {
      print('$error\n$stackTrace');
      rethrow;
    }
  }
}
