import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import '../models/Property_model.dart';

class PropertyCard extends StatefulWidget {
  final Property property;

  const PropertyCard({super.key, required this.property});

  @override
  State<PropertyCard> createState() => _PropertyCardState();
}

class _PropertyCardState extends State<PropertyCard> {
  bool isFavorited = false;
  double rating = 0.0;

  @override
  Widget build(BuildContext context) {
    final property = widget.property;
    final List<String> provinces = [
      'دمشق',
      'ريف دمشق',
      'درعا',
      'السويداء',
      'القنيطرة',
      'حمص',
      'حماة',
      'طرطوس',
      'اللاذقية',
      'إدلب',
      'حلب',
      'الرقة',
      'دير الزور',
      'الحسكة',
    ];

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
        child: Card(
          color: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          elevation: 4,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 🔹 صور العقار
              SizedBox(
                height: 210,
                child: ClipRRect(
                  borderRadius:
                      const BorderRadius.vertical(top: Radius.circular(16)),
                  child: property.images.isNotEmpty
                      ? ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: 3,
                          itemBuilder: (context, index) {
                            return Image.network(
                              property.images[index],
                              width: MediaQuery.of(context).size.width - 32,
                              fit: BoxFit.cover,
                              loadingBuilder:
                                  (context, child, loadingProgress) {
                                if (loadingProgress == null) return child;
                                return Center(
                                  child: CircularProgressIndicator(
                                    value: loadingProgress.expectedTotalBytes !=
                                            null
                                        ? loadingProgress
                                                .cumulativeBytesLoaded /
                                            (loadingProgress
                                                    .expectedTotalBytes ??
                                                1)
                                        : null,
                                  ),
                                );
                              },
                              errorBuilder: (context, error, stackTrace) {
                                return const Center(
                                  child: Icon(Icons.broken_image,
                                      size: 60, color: Colors.grey),
                                );
                              },
                            );
                          },
                        )
                      : Image.asset(
                          'images/House.jpg', // صورة افتراضية في حال لا يوجد صور
                          width: MediaQuery.of(context).size.width - 32,
                          fit: BoxFit.cover,
                        ),
                ),
              ),

              // 🔹 معلومات العقار
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // 🔹 نوع العقار + أيقونة القلب
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          property.name, // ← اسم العقار (مثل "فيلا")
                          style: const TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        IconButton(
                          iconSize: 30,
                          icon: Icon(
                            isFavorited
                                ? Icons.favorite
                                : Icons.favorite_border,
                            color: Colors.red,
                          ),
                          onPressed: () {
                            setState(() {
                              isFavorited = !isFavorited;
                            });
                          },
                        ),
                      ],
                    ),

                    const SizedBox(height: 4),
                    Text(
                      'المحافظة: ${property.provinceId}',
                      style: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 4),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'السعر: \$${property.finalPrice.toString()}',
                          style: TextStyle(color: Colors.grey[700]),
                        ),
                        RatingBar(
                          initialRating: rating,
                          direction: Axis.horizontal,
                          allowHalfRating: false,
                          itemCount: 5,
                          itemSize: 24,
                          ratingWidget: RatingWidget(
                            full: const Icon(Icons.star, color: Colors.amber),
                            half: const Icon(Icons.star_half,
                                color: Colors.amber),
                            empty: const Icon(Icons.star_border,
                                color: Colors.amber),
                          ),
                          onRatingUpdate: (newRating) {
                            setState(() {
                              rating = newRating;
                            });
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
