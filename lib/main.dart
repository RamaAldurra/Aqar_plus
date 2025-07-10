import 'package:aqar_plus/view/Filter_Screen.dart';
import 'package:aqar_plus/view/Home_Screen.dart';
import 'package:aqar_plus/view/login.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:provider/provider.dart';
import 'controller/property_controller.dart';
import 'services/favorites_manager.dart';


void main() {
   Get.put(PropertyController());
  runApp(
    ChangeNotifierProvider(
      create: (_) => FavoritesManager(),
      child: const MyApp(),
    ),
  );
}class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: LoginScreen(),
    );
  }
}
