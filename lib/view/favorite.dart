import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/favorites_manager.dart';
import '../widgets/property_card.dart';

class FavoritesPage extends StatelessWidget {
  const FavoritesPage({super.key});

  @override
  Widget build(BuildContext context) {
    final favorites = Provider.of<FavoritesManager>(context).favorites;

    return Scaffold(
      appBar: AppBar(
        title: const Text("المفضلة"),
        centerTitle: true,
      ),
      body: favorites.isEmpty
          ? const Center(child: Text("لا يوجد عقارات مفضلة بعد"))
          : ListView.builder(
              itemCount: favorites.length,
              itemBuilder: (context, index) {
                return PropertyCard(property: favorites[index]); // تمرير العقار
              },
            ),
    );
  }
}
