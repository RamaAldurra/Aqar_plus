import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/favorite_services.dart';
import '../widgets/property_card.dart';

class FavoritesPage extends StatefulWidget {
  const FavoritesPage({super.key});

  @override
  State<FavoritesPage> createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage> {
  late FavoriteServices favoriteServices;

  @override
  void initState() {
    super.initState();
    // تأجيل استدعاء fetchFavorites بعد بناء الواجهة لأول مرة
    WidgetsBinding.instance.addPostFrameCallback((_) {
      favoriteServices = Provider.of<FavoriteServices>(context, listen: false);
      favoriteServices.fetchFavorites();
    });
  }

  Future<void> _refreshFavorites() async {
    await favoriteServices.fetchFavorites();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('المفضلة'),
        centerTitle: true,
      ),
      body: Consumer<FavoriteServices>(
        builder: (context, favService, child) {
          final favorites = favService.favorites;

          if (favorites.isEmpty) {
            return const Center(child: Text('لا يوجد عقارات مفضلة بعد'));
          }

          return RefreshIndicator(
            onRefresh: _refreshFavorites,
            child: ListView.builder(
              itemCount: favorites.length,
              itemBuilder: (context, index) {
                return PropertyCard(property: favorites[index]);
              },
            ),
          );
        },
      ),
    );
  }
}
