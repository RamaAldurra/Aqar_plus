import 'package:get/get.dart';
import '../models/user_profile.dart';
import '../services/profile_service.dart';

class ProfileController extends GetxController {
  final ProfileService profileService = ProfileService();

  var profile = Rxn<UserProfile>();
  var isLoading = false.obs;
  var error = ''.obs;

  Future<void> getProfile() async {
    try {
      isLoading.value = true;
      error.value = '';
      profile.value = await profileService.fetchUserProfile();
    } catch (e) {
      error.value = e.toString();
    } finally {
      isLoading.value = false;
    }
  }
}
