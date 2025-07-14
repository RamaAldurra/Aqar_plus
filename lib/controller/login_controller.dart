import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/login_model.dart';
import 'dart:convert';
import '../services/login_services.dart';

class LoginController extends GetxController {
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  Future<void> loginUser() async {
    try {
      final loginModel = LoginModel(
        name: nameController.text.trim(),
        password: passwordController.text.trim(),
      );

      final response = await LoginService.login(loginModel);
      final jsonData = jsonDecode(response.body);
      final loginResponse = LoginResponseModel.fromJson(jsonData);

      if (response.statusCode == 200 && loginResponse.token != null) {
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('token', loginResponse.token!);

        Get.snackbar("نجاح", loginResponse.message);
        // Navigate to home or whatever
      } else {
        Get.snackbar("خطأ", loginResponse.message);
      }
    } catch (e) {
      Get.snackbar("خطأ", "حدث خطأ أثناء تسجيل الدخول");
    }
  }
}
