import 'package:http/http.dart' as http;
import 'dart:convert';

import '../core/config.dart';
import '../models/user_profile.dart';
import 'SharedPrefs.dart';


class ProfileService {
  Future<UserProfile> fetchUserProfile() async {
    final token = await SharedPrefs.getToken();
    final url = Uri.parse('${Config.baseUrl}${Config.showProfile}');

    final response = await http.get(
      url,
      headers: {
        'Authorization': 'Bearer $token',
        'Accept': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      return UserProfile.fromJson(jsonData);
    } else {
      throw Exception('فشل في جلب البيانات: ${response.statusCode}');
    }
  }
}
