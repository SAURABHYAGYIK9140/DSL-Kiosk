import 'dart:convert';

class BookingModel {
  final int id;
  final int userId;
  final List<int> serviceId;
  final List<int> addonId;
  final int professionId;
  final int? totalServiceDuration;
  final int? totalAddonDuration;
  final DateTime ddate;
  final int slotId;
  final String slotDate;
  final String slotTime;
  final String firstName;
  final String lastName;
  final String email;
  final String mobile;
  final int status;
  final int otp;
  final String? rememberToken;
  final String? deviceToken;
  final DateTime createdAt;
  final DateTime updatedAt;

  BookingModel({
    required this.id,
    required this.userId,
    required this.serviceId,
    required this.addonId,
    required this.professionId,
    this.totalServiceDuration,
    this.totalAddonDuration,
    required this.ddate,
    required this.slotId,
    required this.slotDate,
    required this.slotTime,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.mobile,
    required this.status,
    required this.otp,
    this.rememberToken,
    this.deviceToken,
    required this.createdAt,
    required this.updatedAt,
  });

  factory BookingModel.fromJson(Map<String, dynamic> json) {
    return BookingModel(
      id: json['id'],
      userId: json['user_id'],
      serviceId: List<int>.from(json['service_id'] is String ? jsonDecode(json['service_id']) : json['service_id']),
      addonId: List<int>.from(json['addon_id'] is String ? jsonDecode(json['addon_id']) : json['addon_id']),
      professionId: json['profession_id'],
      totalServiceDuration: json['total_service_duration'],
      totalAddonDuration: json['total_addon_duration'],
      ddate: DateTime.parse(json['ddate']),
      slotId: json['slot_id'],
      slotDate: json['slot_date'],
      slotTime: json['slot_time'],
      firstName: json['first_name'],
      lastName: json['last_name'],
      email: json['email'],
      mobile: json['mobile'],
      status: json['status'],
      otp: json['otp'],
      rememberToken: json['remember_token'],
      deviceToken: json['device_token'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user_id': userId,
      'service_id': serviceId,
      'addon_id': addonId,
      'profession_id': professionId,
      'total_service_duration': totalServiceDuration,
      'total_addon_duration': totalAddonDuration,
      'ddate': ddate.toIso8601String(),
      'slot_id': slotId,
      'slot_date': slotDate,
      'slot_time': slotTime,
      'first_name': firstName,
      'last_name': lastName,
      'email': email,
      'mobile': mobile,
      'status': status,
      'otp': otp,
      'remember_token': rememberToken,
      'device_token': deviceToken,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }
}
