class Profile {
  final String name;
  final String email;
  final String dob;
  final String gender;

  Profile({required this.name, required this.email, required this.dob, required this.gender});

  factory Profile.fromJson(Map<String, dynamic> json) {
    return Profile(
      name: json['name'],
      email: json['email'],
      dob: json['dob'],
      gender: json['gender'],
    );
  }
}

class UserProfile {
  final String mobile;
  final String registration;
  final String applicationStatus;
  final Profile profile;
  final String pin;
  final String photo;

  UserProfile({
    required this.mobile,
    required this.registration,
    required this.applicationStatus,
    required this.profile,
    required this.pin,
    required this.photo,
  });

  factory UserProfile.fromJson(Map<String, dynamic> json) {
    return UserProfile(
      mobile: json['mobile'],
      registration: json['registration'],
      applicationStatus: json['status']['application'],
      profile: Profile.fromJson(json['profile']),
      pin: json['pin'],
      photo: json['photo'],
    );
  }
}
