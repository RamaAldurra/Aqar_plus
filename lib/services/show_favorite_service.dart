import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../core/config.dart';
import '../models/Property_model.dart';

class ShowFavoriteService extends ChangeNotifier {
  final List<Property> _favorites = [];

  List<Property> get favorites => _favorites;

  Future<void> fetchFavorites() async {
    try {
      final url = Uri.parse('${Config.baseUrl}/favorites'); // رابط ال API
      final response = await http.get(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization':
            'Bearer 1|znY8JP6kgHaLWmGRbKFQ0PoVq1YRul7P3xhVJ1yude44d3ad' // ضع التوكن الحقيقي هنا
        },
      );

      if (response.statusCode == 200) {
        final List data = json.decode(response.body);
        _favorites.clear();
        for (var item in data) {
          _favorites.add(Property.fromJson(item));
        }
        notifyListeners();
      } else {
        throw Exception('فشل في تحميل المفضلة');
      }
    } catch (e) {
      print('Error fetching favorites: $e');
    }
  }

  // باقي دوالك مثل addFavorite و deleteFavorite وهكذا
}
