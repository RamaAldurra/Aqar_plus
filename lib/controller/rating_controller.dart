import 'package:aqar_plus/services/rating_services.dart';
import 'package:get/get.dart';

class RatingController extends GetxController {
  final RatingServices ratingServices = RatingServices();
  var isLoading = false.obs;
  var error = ''.obs;

  Future<void> addRating({int? property_id, int? rating}) async {
    try {
      isLoading.value = true;
      error.value = '';
      await ratingServices.addRating(property_id, rating);
    } catch (e) {
      error.value = e.toString();
    } finally {
      isLoading.value = false;
    }
  }
}
