import 'package:aqar_plus/widgets/SearchBarHeaderDelegate.dart';
import 'package:aqar_plus/widgets/property_card.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import '../controller/property_controller.dart';

class FilterResault extends StatefulWidget {
  const FilterResault({super.key});
 
  @override
  State<FilterResault> createState() => _FilterResaultState();
}

class _FilterResaultState extends State<FilterResault> with TickerProviderStateMixin {
  final propertyController = Get.find<PropertyController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
       
      ),
      body: CustomScrollView(
        slivers: [
    
    SliverToBoxAdapter(
  child: Obx(() {
    if (propertyController.isLoading.value) {
      return Padding(
        padding: const EdgeInsets.only(top: 32.0),
        child: Center(child: CircularProgressIndicator()),
      );
    }

    final properties = propertyController.properties;
    if (properties.isEmpty) {
      return Padding(
        padding: const EdgeInsets.only(top: 32.0),
        child: Center(child: Text("لا يوجد عقارات حالياً")),
      );
    }

    return ListView.builder(
      physics: NeverScrollableScrollPhysics(), // مهم لأنك تستخدم CustomScrollView
      shrinkWrap: true, // لتجنب overflow
      itemCount: properties.length,
      itemBuilder: (context, index) =>
          PropertyCard(property: properties[index]),
    );
  }),
),

   ],
      ),
    );
  }
}
