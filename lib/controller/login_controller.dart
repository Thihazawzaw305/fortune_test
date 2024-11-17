import 'package:flutter/material.dart';
import 'package:fortune_test/screens/admin_dashboard.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart';
import 'package:fortune_test/network/the_api.dart';
import 'package:fortune_test/network/responses/login_response.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginController extends GetxController {
  final Dio _dio = Dio();
  late final TheApi _api;

  // Observable variables
  var isLoading = false.obs;
  var errorMessage = "".obs;
  var loginSuccess = false.obs;

  LoginController() {
    _api = TheApi(_dio);
  }

  Future<void> login(
      BuildContext context, String username, String password) async {
    isLoading.value = true;
    errorMessage.value = "";
    loginSuccess.value = false;

    try {
      final response = await _api.loginUser({
        "username": username,
        "password": password,
      });
      // Login successful
      loginSuccess.value = true;
      print("Login Successful! Token: ${response.token}");

      // Save token locally if needed
      // e.g., using SharedPreferences or SecureStorage
      _saveTokenToSharedPreferences(response.token);
      // Navigate to the home screen (admin or user dashboard, depending on role)
      // For now, assuming we go to the admin dashboard after login:
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomePage()),
      );
    } catch (error) {
      // Handle error
      errorMessage.value = error.toString();
      print("Login Failed: $error");
    } finally {
      isLoading.value = false;
    }
  }

  // Save token to SharedPreferences
  Future<void> _saveTokenToSharedPreferences(String token) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('auth_token', token);
    print("Token saved in SharedPreferences");
  }

  // Optionally, you can add a method to load the token if needed
  Future<String?> getTokenFromSharedPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('auth_token');
  }
}
