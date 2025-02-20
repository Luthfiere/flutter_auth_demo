import 'dart:convert';

class LoginResponseModel {
  final String accessToken;
  final String refreshToken;
  final int id;
  final String username;
  final String email;
  final String firstName;
  final String lastName;
  final String gender;
  final String image;

  LoginResponseModel({
    required this.accessToken,
    required this.refreshToken,
    required this.id,
    required this.username,
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.gender,
    required this.image,
  });

  // Factory untuk parsing JSON dari API
  factory LoginResponseModel.fromJson(Map<String, dynamic> json) {
    return LoginResponseModel(
      accessToken: json["accessToken"] ?? "",
      refreshToken: json["refreshToken"] ?? "",
      id: json["id"] ?? 0,
      username: json["username"] ?? "Unknown",
      email: json["email"] ?? "",
      firstName: json["firstName"] ?? "",
      lastName: json["lastName"] ?? "",
      gender: json["gender"] ?? "",
      image: json["image"] ?? "",
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "accessToken": accessToken,
      "refreshToken": refreshToken,
      "id": id,
      "username": username,
      "email": email,
      "firstName": firstName,
      "lastName": lastName,
      "gender": gender,
      "image": image,
    };
  }
}
