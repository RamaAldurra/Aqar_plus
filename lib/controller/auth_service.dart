class AuthService {
  Future<bool> login(String email, String password) async {
    // محاكاة طلب API
    await Future.delayed(const Duration(seconds: 2));
    return true; // هنا تضع استدعاء API حقيقي لاحقاً
  }
}