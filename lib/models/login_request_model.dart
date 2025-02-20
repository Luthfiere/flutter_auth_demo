class LoginRequestModel {
  String username;
  String password;
  int expiresInMins;

  LoginRequestModel({
    required this.username,
    required this.password,
    this.expiresInMins = 60,
  });

  Map<String, dynamic> toJson() {
    return {
      "username": username,
      "password": password,
      "expiresInMins": expiresInMins
    };
  }
}
