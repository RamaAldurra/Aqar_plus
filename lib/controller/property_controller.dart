import 'package:get/get.dart';
import '../models/Property_model.dart';
import '../services/property_service_filter.dart';

class PropertyController extends GetxController {
  final PropertyService _propertyService = PropertyService();

  var properties = <Property>[].obs;
  var isLoading = false.obs;
  var error = ''.obs;

  Future<void> filterProperties({
    String? type,
    String? name,
    int? rooms,
    double? areaMin,
    double? areaMax,
    int? priceMin,
    int? priceMax,
    int? province,
  }) async {
     print('🔎 Filter Parameters:');
  print('Type: $type');
  print('Name: $name');
  print('Rooms: $rooms');
  print('Area Min: $areaMin');
  print('Area Max: $areaMax');
  print('Price Min: $priceMin');
  print('Price Max: $priceMax');
  print('Province: $province');

    try {
      isLoading.value = true;
      error.value = '';

      final results = await _propertyService.filterProperties(
        type: type,
        name: name,
        rooms: rooms,
        areaMin: areaMin,
        areaMax: areaMax,
        priceMin: priceMin,
        priceMax: priceMax,
        province: province,
      );

      properties.value = results;
    } catch (e) {
      error.value = e.toString();
    } finally {
      isLoading.value = false;
    }
  }

 
void fetchPropertiesByType(String type) async {
  try {
    isLoading.value = true; // فقط لو تستخدم تحميل
    final result = await _propertyService.filterProperties(type: type);
    properties.assignAll(result);
  } catch (e) {
    print("خطأ في الجلب: $e");
    properties.clear();
  } finally {
    isLoading.value = false;
  }
}
}
