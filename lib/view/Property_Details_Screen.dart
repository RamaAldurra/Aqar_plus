import 'package:flutter/material.dart';

class PropertyDetailsPage extends StatelessWidget {
  final List<String> images; // روابط الصور
  final String name;
  final String type;
  final int rooms;
  final double price;
  final double area;
  final String description;
  final double rating; // من 0 الى 5
  final String province;

  PropertyDetailsPage({
    required this.images,
    required this.name,
    required this.type,
    required this.rooms,
    required this.price,
    required this.area,
    required this.description,
    required this.rating,
    required this.province,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('تفاصيل العقار'),
        backgroundColor: Color(0xFF0073CF),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // الصور مع سكرول أفقي
            SizedBox(
              height: 250,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: images.length,
                itemBuilder: (context, index) {
                  return Container(
                    margin: EdgeInsets.symmetric(horizontal: 8, vertical: 12),
                    width: MediaQuery.of(context).size.width * 0.8,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      image: DecorationImage(
                        image: NetworkImage(images[index]),
                        fit: BoxFit.cover,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black26,
                          blurRadius: 5,
                          offset: Offset(0, 5),
                        )
                      ],
                    ),
                  );
                },
              ),
            ),

            // الاسم والنوع وعدد الغرف والسعر والمساحة
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Text(
                name,
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [
                  _infoIconText(Icons.home, type),
                  SizedBox(width: 16),
                  _infoIconText(Icons.bed, '$rooms غرف'),
                  SizedBox(width: 16),
                  _infoIconText(
                      Icons.attach_money, '${price.toStringAsFixed(0)} ر.س'),
                  SizedBox(width: 16),
                  _infoIconText(
                      Icons.square_foot, '${area.toStringAsFixed(0)} م²'),
                ],
              ),
            ),

            SizedBox(height: 16),

            // وصف العقار
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                'وصف العقار',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Text(
                description,
                style: TextStyle(fontSize: 16, height: 1.4),
              ),
            ),

            SizedBox(height: 16),

            // التقييم بالنجوم
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [
                  Text(
                    'التقييم',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(width: 16),
                  ...List.generate(5, (index) {
                    return Icon(
                      index < rating ? Icons.star : Icons.star_border,
                      color: Colors.amber,
                      size: 28,
                    );
                  }),
                  SizedBox(width: 8),
                  Text(
                    rating.toStringAsFixed(1),
                    style: TextStyle(fontSize: 18),
                  )
                ],
              ),
            ),

            SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  Widget _infoIconText(IconData icon, String text) {
    return Row(
      children: [
        Icon(icon, color: Colors.teal),
        SizedBox(width: 4),
        Text(text, style: TextStyle(fontSize: 16)),
      ],
    );
  }
}
