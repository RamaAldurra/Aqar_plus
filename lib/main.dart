import 'package:aqar_plus/services/favorite_services.dart';
import 'package:aqar_plus/view/Filter_Screen.dart';
import 'package:aqar_plus/view/Home_Screen.dart';
import 'package:aqar_plus/view/Property_Details_Screen.dart';
import 'package:aqar_plus/view/login.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:provider/provider.dart';
import 'controller/property_controller.dart';

void main() {
  Get.put(PropertyController());
  runApp(
    ChangeNotifierProvider(
      create: (_) => FavoriteServices(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: LoginScreen()
      // PropertyDetailsPage(
      //   images: [
      //     'images/Living_Room.jpg',
      //     'images/House.jpg'
      //   ],
      //   name: 'شقة فاخرة',
      //   type: 'شقة',
      //   rooms: 3,
      //   price: 450000,
      //   area: 140.0,
      //   description:
      //       'شقة جميلة بإطلالة بانورامية وتشطيب فاخر، قريبة من الخدمات.',
      //   rating: 4.5,
      //   province: 'دمشق',
      // ),
    );
  }
}
