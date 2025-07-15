import 'package:aqar_plus/core/config.dart';

class FavoriteProperty {
  final int id;
  final int provinceId;
  final int sellerId;
  final String name;
  final String type;
  final String status;
  final int month;
  final int room;
  final String nameAdmin;
  final int finalPrice;
  final double area;
  final String description;
  final String ownershipImage;

  FavoriteProperty({
    required this.id,
    required this.provinceId,
    required this.sellerId,
    required this.name,
    required this.type,
    required this.status,
    required this.month,
    required this.room,
    required this.nameAdmin,
    required this.finalPrice,
    required this.area,
    required this.description,
    required this.ownershipImage,
  });

  factory FavoriteProperty.fromJson(Map<String, dynamic> json) {
    return FavoriteProperty(
      id: json['id'],
      provinceId: json['province_id'],
      sellerId: json['seller_id'],
      name: json['name'],
      type: json['type'],
      status: json['status'],
      month: json['month'],
      room: json['room'],
      nameAdmin: json['name_admin'],
      finalPrice: json['final_price'],
      area: (json['area'] as num).toDouble(),
      description: json['description'],
      ownershipImage: (json['ownership_image'] as String)
          .replaceAll('127.0.0.1', Config.host),
    );
  }
}
