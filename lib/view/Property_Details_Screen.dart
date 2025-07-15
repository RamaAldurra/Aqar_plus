import 'package:aqar_plus/models/Property_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';

import '../controller/favorite_controller.dart';
import '../controller/rating_controller.dart';

class PropertyDetailsPage extends StatefulWidget {
  final Property property;

  PropertyDetailsPage({required this.property});

  @override
  _PropertyDetailsPageState createState() => _PropertyDetailsPageState();
}

class _PropertyDetailsPageState extends State<PropertyDetailsPage> {
  int userRating = 0; // تقييم المستخدم
  RatingController ratingController = Get.put(RatingController());

  bool isFavorite = false;
  final favoriteController = Get.put(FavoriteController());

  @override
  void initState() {
    super.initState();
    isFavorite = widget.property.isFavorite ?? false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('تفاصيل العقار', style: TextStyle(color: Colors.white)),
        backgroundColor: Color(0xFF0073CF),
        centerTitle: true,
      ),
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // الصور
              SizedBox(
                height: 290,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: widget.property.images.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (_) => FullScreenImageViewer(
                            images: widget.property.images,
                            initialIndex: index,
                          ),
                        ));
                      },
                      child: Container(
                        margin:
                            EdgeInsets.symmetric(horizontal: 8, vertical: 12),
                        width: MediaQuery.of(context).size.width * 0.8,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          image: DecorationImage(
                            image: NetworkImage(widget.property.images[index]),
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
                      ),
                    );
                  },
                ),
              ),

              // تقييم المستخدم
              SizedBox(
                height: 10,
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // ⭐️ Rating stars
                    Expanded(
                      child: RatingBar(
                        initialRating: widget.property.userRating ?? 0,
                        allowHalfRating: false,
                        itemCount: 5,
                        itemSize: 30,
                        ratingWidget: RatingWidget(
                          full: Icon(Icons.star, color: Colors.amber),
                          half: Icon(Icons.star_half, color: Colors.amber),
                          empty: Icon(Icons.star_border, color: Colors.amber),
                        ),
                        onRatingUpdate: (newRating) async {
                          await ratingController.addRating(
                            property_id: widget.property.id,
                            rating: newRating.toInt(),
                          );
                          setState(() {
                            userRating = newRating.toInt();
                            widget.property.userRating = newRating;
                          });
                        },
                      ),
                    ),
                    const SizedBox(width: 12),

                    // ❤️ Favorite icon
                    IconButton(
                      iconSize: 30,
                      icon: Icon(
                        isFavorite ? Icons.favorite : Icons.favorite_border,
                        color: Colors.red,
                      ),
                      onPressed: () async {
                        if (isFavorite) {
                          await favoriteController.deleteFavorite(
                              property_id: widget.property.id);
                        } else {
                          await favoriteController.addFavorite(
                              property_id: widget.property.id);
                        }
                        setState(() {
                          isFavorite = !isFavorite;
                          widget.property.isFavorite =
                              isFavorite; // لتحديث الكارد أيضًا عند الرجوع
                        });
                      },
                    ),
                  ],
                ),
              ),

              // الاسم
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Text(
                  widget.property.name,
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
              ),

              // معلومات العقار
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      _infoIconText(Icons.home, widget.property.type),
                      SizedBox(width: 16),
                      _infoIconText(Icons.bed, '${widget.property.room} غرف'),
                      SizedBox(width: 16),
                      _infoIconText(Icons.attach_money,
                          '${widget.property.finalPrice.toStringAsFixed(0)} ر.س'),
                      SizedBox(width: 16),
                      _infoIconText(Icons.square_foot,
                          '${widget.property.area.toStringAsFixed(0)} م²'),
                    ],
                  ),
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
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Text(
                  widget.property.description,
                  style: TextStyle(fontSize: 16, height: 1.4),
                ),
              ),

              SizedBox(height: 16),

              // التقييم العام
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Text(
                  'التقييم العام:',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  children: [
                    ...List.generate(5, (index) {
                      return Icon(
                        index < widget.property.averageRating!
                            ? Icons.star
                            : Icons.star_border,
                        color: Colors.amber,
                        size: 28,
                      );
                    }),
                    SizedBox(width: 8),
                    Text(
                      widget.property.averageRating!.toStringAsFixed(1),
                      style: TextStyle(fontSize: 18),
                    ),
                  ],
                ),
              ),

              SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }

  Widget _infoIconText(IconData icon, String text) {
    return Row(
      children: [
        Icon(icon, color: Color(0xFF0073CF)),
        SizedBox(width: 4),
        Text(text, style: TextStyle(fontSize: 16)),
      ],
    );
  }
}

// واجهة عرض الصور ملء الشاشة
class FullScreenImageViewer extends StatefulWidget {
  final List<String> images;
  final int initialIndex;

  const FullScreenImageViewer({
    required this.images,
    required this.initialIndex,
  });

  @override
  _FullScreenImageViewerState createState() => _FullScreenImageViewerState();
}

class _FullScreenImageViewerState extends State<FullScreenImageViewer> {
  late PageController _pageController;
  late int currentIndex;

  @override
  void initState() {
    super.initState();
    currentIndex = widget.initialIndex;
    _pageController = PageController(initialPage: currentIndex);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        iconTheme: IconThemeData(color: Colors.white),
        elevation: 0,
      ),
      body: PageView.builder(
        controller: _pageController,
        itemCount: widget.images.length,
        onPageChanged: (index) {
          setState(() => currentIndex = index);
        },
        itemBuilder: (context, index) {
          return Center(
            child: InteractiveViewer(
              child: Image.network(
                widget.images[index],
                fit: BoxFit.contain,
              ),
            ),
          );
        },
      ),
    );
  }
}
