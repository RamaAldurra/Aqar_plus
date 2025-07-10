import 'package:flutter/material.dart';
import '../models/Property_model.dart';


class FavoritesManager extends ChangeNotifier {
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
}
