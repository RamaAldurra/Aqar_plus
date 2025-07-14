import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/login_model.dart';
import '../core/config.dart';

class LoginService {
  static Future<http.Response> login(LoginModel model) async {
    var url = Uri.parse(Config.baseUrl + Config.loginUser);
    var headers = {'Content-Type': 'application/json'};
    var body = jsonEncode(model.toJson());

    return await http.post(url, headers: headers, body: body);
  }
}
