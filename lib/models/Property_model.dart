class Property {
  final int id;
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
  final List<String> images;
  final int provinceId;

  Property({
    required this.id,
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
    required this.images,
    required this.provinceId,
  });

  factory Property.fromJson(Map<String, dynamic> json) {
    return Property(
      id: json['id'],
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
          .replaceAll('127.0.0.1', '192.168.2.163'),
      images: (json['images'] as List<dynamic>)
          .map((img) => (img['image_path'] as String)
              .replaceAll('127.0.0.1', '192.168.2.163'))
          .toList(),
      provinceId: json['province_id'],
    );
  }
}
