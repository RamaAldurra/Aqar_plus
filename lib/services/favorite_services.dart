import 'package:flutter/material.dart';
import '../models/Property_model.dart';
import 'dart:convert';
import 'package:aqar_plus/core/config.dart';
import 'package:http/http.dart' as http;

class FavoriteServices extends ChangeNotifier {
  final List<Property> _favorites = [];

  List<Property> get favorites => _favorites;

  void toggleFavorite(Property property) {
    if (_favorites.contains(property)) {
      _favorites.remove(property);
    } else {
      _favorites.add(property);
    }
    notifyListeners();
  }

  bool isFavorite(Property property) => _favorites.contains(property);

  final urlAdd = Uri.parse('${Config.baseUrl}${Config.addFavoriteUser}');
  final urlDelete = Uri.parse('${Config.baseUrl}${Config.deleteFavoriteUser}');

  Future<void> addFavorite(int? property_id) async {
    final body = {"property_id": property_id};

    final response = await http.post(
      urlAdd,
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization':
            'Bearer 1|znY8JP6kgHaLWmGRbKFQ0PoVq1YRul7P3xhVJ1yude44d3ad'
        // SheredPreferance.token
      },
      body: jsonEncode(body),
    );

    print(response.statusCode);
    print("response.body" + response.body);

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      print('تمت الاضافة الى المفضلة');
    } else {
      throw Exception("فشل في تحميل البيانات: ${response.statusCode}");
    }
  }

  Future<void> deleteFavorite(int? property_id) async {
    final body = {"property_id": property_id};

    final response = await http.post(
      urlDelete,
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization':
            'Bearer 1|znY8JP6kgHaLWmGRbKFQ0PoVq1YRul7P3xhVJ1yude44d3ad'
        // SheredPreferance.token
      },
      body: jsonEncode(body),
    );

    print(response.statusCode);
    print("response.body" + response.body);

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      print("تمت الازالة من المفضلة");
    } else {
      throw Exception("فشل في تحميل البيانات: ${response.statusCode}");
    }
  }

Future<void> fetchFavorites() async {
  try {
    final url = Uri.parse('${Config.baseUrl}${Config.showFavorite}');
    final response = await http.get(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer 1|znY8JP6kgHaLWmGRbKFQ0PoVq1YRul7P3xhVJ1yude44d3ad',
      },
    );

    if (response.statusCode == 200) {
      final decoded = json.decode(response.body);
      print('Response body: ${response.body}');
      if (decoded is List) {
        _favorites.clear();
        for (var item in decoded) {
          _favorites.add(Property.fromJson(item));
        }
        notifyListeners();
      } else {
        print("⚠️ الاستجابة لم تكن قائمة كما هو متوقع");
      }

    } else {
      throw Exception('فشل في تحميل المفضلة');
    }
  } catch (e) {
    print('Error fetching favorites: $e');
  }
}

}
