import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/login_model.dart';
import 'dart:convert';
import '../services/login_services.dart';
import '../view/Home_Screen.dart';

class LoginController extends GetxController {
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  void loginUser() async {
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

        // ✅ عرض رسالة نجاح بدون context
        Get.snackbar(
          "نجاح",
          loginResponse.message,
          backgroundColor:  Color(0xFF0073CF),
          colorText: Colors.white,
          snackPosition: SnackPosition.BOTTOM,
          duration: const Duration(seconds: 3),
        );

        // ✅ التنقل إلى الصفحة الرئيسية
        Get.offAll(() => HomeScreen());
      } else {
        Get.snackbar(
          "فشل",
          loginResponse.message,
          backgroundColor:  Color(0xFF0073CF),
          colorText: Colors.white,
          snackPosition: SnackPosition.BOTTOM,
        );
      }
    } catch (e) {
      Get.snackbar(
        "خطأ",
        "حدث خطأ أثناء تسجيل الدخول",
        backgroundColor: Color(0xFF0073CF),
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }
}
