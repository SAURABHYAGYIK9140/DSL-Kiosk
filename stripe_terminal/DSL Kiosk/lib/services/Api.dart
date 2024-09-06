import 'dart:convert';

import 'package:dsl_kiosk/models/BookingModel.dart';
import 'package:dsl_kiosk/models/Timings.dart';
import 'package:http/http.dart' as http;

import '../models/Category.dart';
import '../models/Professional.dart';
import '../models/Service.dart';

class ApiService{
  // baseUrl
  static const String baseUrl = 'https://dsl.devolyt.com/api/';

  // Endpoints
  static const String categoriesEndpoint = 'ki_get_categories';
  static const String servicesEndpoint = 'ki_get_services';
  static const String subservicesEndpoint = 'ki_get_sub_services';
  static const String AddonEndpoint = 'ki_get_addon_services';
  static const String professionalsEndpoint = 'get_professionals';
  static const String get_next_slotssEndpoint = 'get_next_slots';
  static const String get_latter_slotsEndpoint = 'get_latter_slots';
  static final String addKiBookingEndpoint = 'add_ki_booking';
  static final String search_ki_bookingEndpoint = 'search_ki_booking';

  static Future<List<Category>> postCategories() async {
    var headersList = {
      'Accept': '*/*',
      'User-Agent': 'Thunder Client (https://www.thunderclient.com)',
      'Content-Type': 'application/json'
    };

    final url = Uri.parse('$baseUrl$categoriesEndpoint');

    try {
      var response = await http.post(
        url,
        headers: headersList,
        body: jsonEncode({}), // Assuming the body needs to be an empty object, otherwise adjust accordingly.
      );

      if (response.statusCode >= 200 && response.statusCode < 300) {
        var jsonResponse = jsonDecode(response.body);

        if (jsonResponse['data'] is List) {
          List<dynamic> dataList = jsonResponse['data'];
          List<Category> categories = dataList.map((data) {
            try {
              return Category.fromJson(data);
            } catch (e) {
              print('Error parsing category: $e');
              print('Category data: $data');
              rethrow;
            }
          }).toList();
          return categories;
        } else {
          print('Error: Expected a list for "data" key');
          return [];
        }
      } else {
        print(response.reasonPhrase);
        return [];
      }
    } catch (e) {
      print('Error: $e');
      return [];
    }
  }
  static Future<List<Category>> postSubCategories(Map<String, dynamic> subbody) async {
    var headersList = {
      'Accept': '*/*',
      'User-Agent': 'Thunder Client (https://www.thunderclient.com)',
      'Content-Type': 'application/json'
    };

    final url = Uri.parse('$baseUrl$categoriesEndpoint');

    try {
      var response = await http.post(
        url,
        headers: headersList,
        body: jsonEncode(subbody), // Assuming the body needs to be an empty object, otherwise adjust accordingly.
      );

      if (response.statusCode >= 200 && response.statusCode < 300) {
        var jsonResponse = jsonDecode(response.body);

        if (jsonResponse['data'] is List) {
          List<dynamic> dataList = jsonResponse['data'];
          List<Category> categories = dataList.map((data) {
            try {
              return Category.fromJson(data);
            } catch (e) {
              print('Error parsing category: $e');
              print('Category data: $data');
              rethrow;
            }
          }).toList();
          return categories;
        } else {
          print('Error: Expected a list for "data" key');
          return [];
        }
      } else {
        print(response.reasonPhrase);
        return [];
      }
    } catch (e) {
      print('Error: $e');
      return [];
    }
  }
  static Future<List<Service>> postServices(Map<String, String> body) async {
    var headersList = {
      'Accept': '*/*',
      'User-Agent': 'Thunder Client (https://www.thunderclient.com)',
    };

    final url = Uri.parse('$baseUrl$servicesEndpoint');

    var req = http.MultipartRequest('POST', url);
    req.headers.addAll(headersList);
    req.fields.addAll(body);

    try {
      var res = await req.send();
      final resBody = await res.stream.bytesToString();

      if (res.statusCode >= 200 && res.statusCode < 300) {
        var jsonResponse = jsonDecode(resBody);
        List<dynamic> dataList = jsonResponse['data'];
        print("postServices"+dataList.toString());
        List<Service> services = dataList.map((data) => Service.fromJson(data)).toList();
        return services;
      } else {
        print(res.reasonPhrase);
        return [];
      }
    } catch (e) {
      print('Error: $e');
      return [];
    }
  }
  static Future<List<Service>> postSubServices(Map<String, String> body) async {
    var headersList = {
      'Accept': '*/*',
      'User-Agent': 'Thunder Client (https://www.thunderclient.com)',
    };

    final url = Uri.parse('$baseUrl$subservicesEndpoint');

    var req = http.MultipartRequest('POST', url);
    req.headers.addAll(headersList);
    req.fields.addAll(body);

    try {
      var res = await req.send();
      final resBody = await res.stream.bytesToString();

      if (res.statusCode >= 200 && res.statusCode < 300) {
        var jsonResponse = jsonDecode(resBody);
        List<dynamic> dataList = jsonResponse['data'];
        List<Service> services = dataList.map((data) => Service.fromJson(data)).toList();
        return services;
      } else {
        print(res.reasonPhrase);
        return [];
      }
    } catch (e) {
      print('Error: $e');
      return [];
    }
  }
  static Future<List<Service>> postaddon(Map<String, String> body) async {
    print("bodybodybody"+body.toString());
    var headersList = {
      'Accept': '*/*',
      'User-Agent': 'Thunder Client (https://www.thunderclient.com)',
    };

    final url = Uri.parse('$baseUrl$AddonEndpoint');

    var req = http.MultipartRequest('POST', url);
    req.headers.addAll(headersList);
    req.fields.addAll(body);

    try {
      var res = await req.send();
      final resBody = await res.stream.bytesToString();

      if (res.statusCode >= 200 && res.statusCode < 300) {
        var jsonResponse = jsonDecode(resBody);
        List<dynamic> dataList = jsonResponse['data'];
        List<Service> services = dataList.map((data) => Service.fromJson(data)).toList();
        return services;
      } else {
        print(res.reasonPhrase);
        return [];
      }
    } catch (e) {
      print('Error: $e');
      return [];
    }
  }

  static Future<List<Professional>> postProfessionals(Map<String, dynamic> subbody) async {
    var headersList = {
      'Accept': '*/*',
      'User-Agent': 'Thunder Client (https://www.thunderclient.com)',
    };
    print('bodyprofff$subbody');
    final url = Uri.parse('$baseUrl$professionalsEndpoint');

    var req = http.MultipartRequest('POST', url);
    req.headers.addAll(headersList);

    try {
      // var res = await req.send();
      // final resBody = await res.stream.bytesToString();
      var res = await http.post(
        url,
        headers: headersList,
        body: jsonEncode(subbody), // Assuming the body needs to be an empty object, otherwise adjust accordingly.
      );
      if (res.statusCode >= 200 && res.statusCode < 300) {
        var jsonResponse = jsonDecode(res.body);
        print("sssssss"+jsonResponse.toString());
        List<dynamic> dataList = jsonResponse['data'];
        List<Professional> professionals = dataList.map((data) => Professional.fromJson(data)).toList();
        return professionals;
      } else {
        print(res.reasonPhrase);
        return [];
      }
    } catch (e) {
      print('Error: $e');
      return [];
    }
  }
  static Future<List<Timings>> postget_next_slots(Map<String, String> body) async {
    var headersList = {
      'Accept': '*/*',
      'User-Agent': 'Thunder Client (https://www.thunderclient.com)',
    };

    final url = Uri.parse('$baseUrl$get_latter_slotsEndpoint');

    var req = http.MultipartRequest('POST', url);
    req.headers.addAll(headersList);
    req.fields.addAll(body);

    try {
      var res = await req.send();
      final resBody = await res.stream.bytesToString();
      if (res.statusCode >= 200 && res.statusCode < 300) {
        var jsonResponse = jsonDecode(resBody);
        // print("postget_next_slots"+body.toString());
        // print("postget_next_slots"+jsonResponse.toString());
        List<dynamic> dataList = jsonResponse['data'];
        List<Timings> professionals = dataList.map((data) => Timings.fromJson(data)).toList();
        return professionals;
      } else {
        print(res.reasonPhrase);
        return [];
      }
    } catch (e) {
      print('Error: $e');
      return [];
    }
  }
  static Future<List<Timings>> get_latter_slots(Map<String, String> body) async {
    var headersList = {
      'Accept': '*/*',
      'User-Agent': 'Thunder Client (https://www.thunderclient.com)',
    };
    print("get_next_slotssEndpoint"+body.toString());

    final url = Uri.parse('$baseUrl$get_next_slotssEndpoint');

    var req = http.MultipartRequest('POST', url);
    req.headers.addAll(headersList);
    req.fields.addAll(body);

    try {
      var res = await req.send();
      final resBody = await res.stream.bytesToString();

      if (res.statusCode >= 200 && res.statusCode < 300) {
        var jsonResponse = jsonDecode(resBody);
        print("sssssss"+jsonResponse.toString());

        List<dynamic> dataList = jsonResponse['data'];
        List<Timings> professionals = dataList.map((data) => Timings.fromJson(data)).toList();
        return professionals;
      } else {
        print(res.reasonPhrase);
        return [];
      }
    } catch (e) {
      print('Error: $e');
      return [];
    }
  }

  static Future<bool> addKiBooking(Map<String, dynamic> body) async {
    var headersList = {
      'Accept': '*/*',
      'User-Agent': 'Thunder Client (https://www.thunderclient.com)',
      'Content-Type': 'application/json', // Assuming JSON request
    };
    final url = Uri.parse('$baseUrl$addKiBookingEndpoint');

    try {
      var res = await http.post(
        url,
        headers: headersList,
        body: jsonEncode(body),
      );

      if (res.statusCode >= 200 && res.statusCode < 300) {
        var jsonResponse = jsonDecode(res.body);
        print("addKiBooking response: $jsonResponse");
        // Handle response as needed, e.g., return true for success
        return true;
      } else {
        print('Failed to add booking: ${res.reasonPhrase}');
        return false;
      }
    } catch (e) {
      print('Error adding booking: $e');
      return false;
    }
  }

  static Future<List<BookingModel>> search_ki_booking(Map<String, String> body) async {
    var headersList = {
      'Accept': '*/*',
      'User-Agent': 'Thunder Client (https://www.thunderclient.com)',
    };
    print("get_next_slotssEndpoint"+body.toString());

    final url = Uri.parse('$baseUrl$search_ki_bookingEndpoint');

    var req = http.MultipartRequest('POST', url);
    req.headers.addAll(headersList);
    req.fields.addAll(body);

    try {
      var res = await req.send();
      final resBody = await res.stream.bytesToString();

      if (res.statusCode >= 200 && res.statusCode < 300) {
        var jsonResponse = jsonDecode(resBody);
        print("BookingModel"+jsonResponse.toString());

        List<dynamic> dataList = jsonResponse['data'];
        List<BookingModel> professionals = dataList.map((data) => BookingModel.fromJson(data)).toList();
        return professionals;
      } else {
        print(res.reasonPhrase);
        return [];
      }
    } catch (e) {
      print('Error: $e');
      return [];
    }
  }

}