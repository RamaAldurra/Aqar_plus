import 'package:aqar_plus/widgets/SearchBarHeaderDelegate.dart';
import 'package:aqar_plus/widgets/property_card.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

import '../controller/property_controller.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  static String id = "HomeScreen";

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  late TabController _tabController;
  final propertyController = Get.find<PropertyController>();
  String selectedType = "اجار"; // القيمة المبدئية (للإيجار)

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      propertyController.fetchPropertiesByType(selectedType);
    });

    _tabController.addListener(() {
      if (_tabController.indexIsChanging) return;

      setState(() {
        selectedType = _tabController.index == 0 ? "اجار" : "بيع";
      });

      propertyController.fetchPropertiesByType(selectedType);
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 200,
            pinned: false,
            flexibleSpace: FlexibleSpaceBar(
              background: Image.asset(
                'images/HomeScreen.jpg',
                fit: BoxFit.cover,
              ),
            ),
          ),
          SliverPersistentHeader(
            pinned: true,
            delegate: SearchBarHeaderDelegate(
              controller: _tabController,
              selectedTypeCallback: (type) {
                setState(() {
                  selectedType = type;
                });
              },
            ),
          ),
          SliverToBoxAdapter(child: Obx(() {
            if (propertyController.isLoading.value) {
              return const Center(child: CircularProgressIndicator());
            }

            final properties = propertyController.properties;
            if (properties.isEmpty) {
              return const Center(child: Text("لا يوجد عقارات حالياً"));
            }

            return ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: properties.length,
              itemBuilder: (context, index) =>
                  PropertyCard(property: properties[index]),
            );
          })),
        ],
      ),
    );
  }
}
