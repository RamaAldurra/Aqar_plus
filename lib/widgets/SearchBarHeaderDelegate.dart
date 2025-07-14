import 'package:aqar_plus/view/Filter_Screen.dart';
import 'package:flutter/material.dart';

/// مخصص لتثبيت التبويبات والبحث
class SearchBarHeaderDelegate extends SliverPersistentHeaderDelegate {
  final double _height = 115;
  final TabController controller;
  final void Function(String) selectedTypeCallback;

  SearchBarHeaderDelegate({
    required this.controller,
    required this.selectedTypeCallback,
  });

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      margin: const EdgeInsets.fromLTRB(1, 1, 1, 5),
      color: Colors.white,
      padding: const EdgeInsets.all(1),
      child: Container(
        width: MediaQuery.of(context).size.width * 0.9,
        padding: const EdgeInsets.fromLTRB(5, 5, 5, 5),
        margin: const EdgeInsets.fromLTRB(10, 1, 10, 1),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: Colors.grey.shade300,
            width: 1.0,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 6,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          children: [
            Container(
              height: 40,
              width: MediaQuery.of(context).size.width * 0.9,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
              ),
              child: TabBar(
                controller: controller,
                labelColor: const Color.fromARGB(255, 62, 115, 140),
                unselectedLabelColor: Colors.grey,
                indicatorPadding:
                    const EdgeInsets.symmetric(horizontal: -50, vertical: 5),
                indicator: BoxDecoration(
                  color: const Color.fromARGB(255, 187, 216, 239),
                  borderRadius: BorderRadius.circular(10),
                ),
                onTap: (index) {
                  final type = index == 0 ? "rent" : "sale";
                  selectedTypeCallback(type);
                },
                tabs: const [
                  Tab(text: "للإيجار"),
                  Tab(text: "للبيع"),
                ],
              ),
            ),
            const SizedBox(height: 7),
            InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => FilterPage(listingType: controller.index == 0 ? "اجار" : "بيع"),
                  ),
                );
              },
              child: Container(
                height: 40,
                width: MediaQuery.of(context).size.width * 0.9,
                padding: const EdgeInsets.symmetric(horizontal: 12),
                decoration: BoxDecoration(
                  color: Colors.grey[100],
                  borderRadius: BorderRadius.circular(12),
                ),
                alignment: Alignment.centerLeft,
                child: Row(
                  children: const [
                    Icon(
                      Icons.search,
                      color: Color.fromARGB(255, 62, 115, 140),
                    ),
                    SizedBox(width: 10),
                    Text(
                      'قم بتصفية العقارات حسب اهتمامك ',
                      style: TextStyle(color: Colors.grey),
                      textDirection: TextDirection.rtl,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  double get maxExtent => _height;

  @override
  double get minExtent => _height;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) =>
      false;
}
