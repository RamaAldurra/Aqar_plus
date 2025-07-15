import 'package:aqar_plus/widgets/SearchBarHeaderDelegate.dart';
import 'package:aqar_plus/widgets/property_card.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import '../widgets/custom_bottom_nav.dart';
import '../controller/property_controller.dart';
import 'favorite.dart';
import 'profile_page.dart';

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
  int selectedIndex = 0;

  late List<Widget> _pages;

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

    _pages = [
      _buildHomePage(), // الصفحة الرئيسية
       const FavoritesPage(),
      Center(child: Text("عقاراتي", style: TextStyle(fontSize: 22))),
       ProfilePage(),
    ];
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  Widget _buildHomePage() {
    return CustomScrollView(
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
        SliverToBoxAdapter(
          child: Obx(() {
            if (propertyController.isLoading.value) {
              return const Center(child: CircularProgressIndicator());
            }

            final properties = propertyController.properties;
            if (properties.isEmpty) {
              return const Center(child: Text("لا يوجد عقارات حالياً"));
            }

            return ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: properties.length,
              itemBuilder: (context, index) =>
                  PropertyCard(property: properties[index]),
            );
          }),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (selectedIndex != 0) {
          setState(() {
            selectedIndex = 0; // ارجع للرئيسية بدل ما تطلع من التطبيق
          });
          return false; // ما تخرج من التطبيق
        }
        return true; // لو أصلاً على الرئيسية، يخرج التطبيق
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        body: _pages[selectedIndex],
        bottomNavigationBar: CustomBottomNavBar(
          currentIndex: selectedIndex,
          onTap: (index) {
            setState(() {
              selectedIndex = index;
            });
          },
        ),
      ),
    );
  }
}
