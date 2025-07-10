import 'dart:convert';
import 'package:aqar_plus/core/config.dart';
import 'package:http/http.dart' as http;
import '../models/Property_model.dart';

class PropertyService {
  Future<List<Property>> filterProperties(
      {String? type,
      String? name,
      int? rooms,
      double? areaMin,
      double? areaMax,
      int? priceMin,
      int? priceMax,
      int? province}) async {
    final url = Uri.parse("http://192.168.2.163:8000/api/filter/properties");
    final body = {
      if (type != null) 'type': type,
      if (name != null) 'name': name,
      if (rooms != null) 'rooms': rooms,
      if (areaMin != null) 'area_start': areaMin,
      if (areaMax != null) 'area_end': areaMax,
      if (priceMin != null) 'price_start': priceMin,
      if (priceMax != null) 'price_end': priceMax,
      if (province != null) 'province': province,
    };
    print(body);

    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
      body: jsonEncode(body),
    );

    print("response.body" + response.body);

    if (response.statusCode == 200) {
      final data = json.decode(response.body);

      if (data is List) {
        return data.map((item) => Property.fromJson(item)).toList();
      }

      if (data is Map && data['data'] is List) {
        return (data['data'] as List)
            .map((item) => Property.fromJson(item))
            .toList();
      }

      throw Exception("استجابة غير متوقعة من السيرفر");
    } else {
      throw Exception("فشل في تحميل البيانات: ${response.statusCode}");
    }
  }
}
