// Login model

class LoginResponseModel {
  final String token;
  final String error;



  LoginResponseModel({required this.token, required this.error});

  factory LoginResponseModel.fromJson(final json) {
    return LoginResponseModel(
        token: json['token'] ?? "", error: json['error'] ?? "");
  }
}

class LoginRequestModel {
  String username;
  String password;
  String device_identification;
  String firebase_messaging_token;


  LoginRequestModel({
    required this.username,
    required this.password,
    required this.device_identification,
    required this.firebase_messaging_token
  });

  Map<String, dynamic> toJson() {
    final map = {
      'username': username.trim(),
      'password': password.trim(),
      'device_identification': device_identification.trim(),
      'firebase_messaging_token': firebase_messaging_token.trim(),
    };
    return map;
  }
}