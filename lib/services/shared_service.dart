import 'dart:convert';
import 'package:api_cache_manager/api_cache_manager.dart';
import 'package:api_cache_manager/models/cache_db_model.dart';
import 'package:demo/models/login_response_model.dart';
import 'package:flutter/material.dart';

class SharedService {
  static Future<bool> isLoggedIn() async {
    return await APICacheManager().isAPICacheKeyExist("login_details");
  }

  static Future<LoginResponseModel?> loginDetails() async {
    var isKeyExist = await APICacheManager().isAPICacheKeyExist("login_details");

    if (isKeyExist) {
      var cacheData = await APICacheManager().getCacheData("login_details");
      return LoginResponseModel.fromJson(jsonDecode(cacheData.syncData));
    }
    return null;
  }

  static Future<void> setLoginDetails(LoginResponseModel model) async {
    try {
      APICacheDBModel cacheDBModel = APICacheDBModel(
        key: "login_details",
        syncData: jsonEncode(model.toJson()), // Memastikan `toJson()` dipanggil
      );

      await APICacheManager().addCacheData(cacheDBModel);
      print("User login details saved successfully!");
    } catch (e) {
      print("Error saving login details: $e");
    }
  }

  static Future<void> logout(BuildContext context) async {
    await APICacheManager().deleteCache("login_details");
    Navigator.pushNamedAndRemoveUntil(context, '/login', (route) => false);
  }
}
