import 'package:get/get.dart';
import '../services/favorite_services.dart';

class FavoriteController extends GetxController {
  final FavoriteServices favoriteServices = FavoriteServices();
  var isLoading = false.obs;
  var error = ''.obs;

  Future<void> addFavorite({int? property_id}) async {
    try {
      isLoading.value = true;
      error.value = '';
      await favoriteServices.addFavorite(property_id);
    } catch (e) {
      error.value = e.toString();
    } finally {
      isLoading.value = false;
    }
  }
  Future<void> deleteFavorite({int? property_id}) async {
    try {
      isLoading.value = true;
      error.value = '';
      await favoriteServices.deleteFavorite(property_id);
    } catch (e) {
      error.value = e.toString();
    } finally {
      isLoading.value = false;
    }
  }
}
