// login_models.dart

class LoginModel {
  final String name;
  final String password;

  LoginModel({required this.name, required this.password});

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'password': password,
    };
  }
}

class LoginResponseModel {
  final String message;
  final String? token;

  LoginResponseModel({required this.message, this.token});

  factory LoginResponseModel.fromJson(Map<String, dynamic> json) {
    return LoginResponseModel(
      message: json['message'],
      token: json['token'],
    );
  }
}
