import 'package:aqar_plus/core/config.dart';

class UserProfile {
  final String name;
  final String email;
  final int balance;
  final String profilePhoto;

  UserProfile({
    required this.name,
    required this.email,
    required this.balance,
    required this.profilePhoto,
  });

  factory UserProfile.fromJson(Map<String, dynamic> json) {
    return UserProfile(
      name: json['name'],
      email: json['email'],
      balance: json['balance'],
      profilePhoto: (json['profile_photo'] as String).replaceAll('127.0.0.1', Config.host),
    );
  }
}
