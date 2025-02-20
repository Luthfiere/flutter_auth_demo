import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:demo/models/login_response_model.dart';
import 'package:demo/services/shared_service.dart';
import '../models/login_request_model.dart';

class ApiService {
  static Future<String> getUserProfile() async {
    LoginResponseModel? user = await SharedService.loginDetails();

    if (user == null || user.accessToken.isEmpty) {
      return "No user found!";
    }

    try {
      final response = await http.get(
        Uri.parse("https://dummyjson.com/auth/me"), // API Endpoint
        headers: {
          "Authorization": "Bearer ${user.accessToken}",
        },
      );

      if (response.statusCode == 200) {
        return response.body;
      } else {
        return "Failed to fetch profile";
      }
    } catch (e) {
      return "Error: $e";
    }
  }

  static Future<bool> login(LoginRequestModel model) async {
    try {
      final response = await http.post(
        Uri.parse("https://dummyjson.com/auth/login"),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(model.toJson()),
      );

      print("Response: ${response.body}");

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        if (data["accessToken"] == null) {
          throw Exception("Login failed: accessToken is missing");
        }

        LoginResponseModel user = LoginResponseModel.fromJson(data);
        await SharedService.setLoginDetails(user);
        return true;
      } else {
        throw Exception("Login failed: ${response.body}");
      }
    } catch (e) {
      throw Exception("Login failed: $e");
    }
  }
}
