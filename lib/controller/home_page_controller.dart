import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:fortune_test/network/the_api.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../data/user_vo.dart';

class HomePageController extends GetxController {
  final Dio _dio = Dio();
  late final TheApi _api;
  var userList = <UserVO>[].obs; // Observable list to hold users
  var isLoading = true.obs; // Observable for loading state
  var errorMessage = ''.obs; // Observable for error messages
  final username = ''.obs;
  final password = ''.obs;
  final role = 'USER'.obs; // Default role
  HomePageController() {
    _api = TheApi(_dio);
  }

  @override
  void onInit() {
    super.onInit();
    _fetchUserList();// Fetch user list when the controller is initialized
  }

  // Fetch user list from the API
  Future<void> _fetchUserList() async {
    try {
      isLoading(true); // Start loading
      final token = await getTokenFromSharedPreferences();
      if (token == null) {
        throw Exception('Token is missing');
      }

      final response = await _api.getUserList('Bearer $token');
      userList.assignAll(response.users); // Update the userList
    } catch (error) {
      errorMessage.value = error.toString(); // Set the error message if any
    } finally {
      isLoading(false); // Stop loading
    }
  }

  // Add this method to the HomePageController
  Future<void> deleteUser(int userId) async {
    try {
      isLoading(true); // Start loading
      final token = await getTokenFromSharedPreferences();
      if (token == null) {
        throw Exception('Token is missing');
      }

      // Call delete API
      await _api.deleteUser('Bearer $token', userId);

      // Update the user list by removing the deleted user
    _fetchUserList();
    userList.refresh();
      Get.snackbar('Success', 'User deleted successfully!',
          snackPosition: SnackPosition.BOTTOM);
    } catch (error) {
      Get.snackbar('Error', 'Failed to delete user: $error',
          snackPosition: SnackPosition.BOTTOM);
    } finally {
      isLoading(false); // Stop loading
    }
  }

  Future<void> UpdateUser(int userId) async {
    isLoading.value = true;

    final body = {
      "username": username.value,
      "password": password.value,
      "role": role.value,
    };

    try {
      final token = await getTokenFromSharedPreferences();
      if(token ==null){
        throw Exception();
      }
      final response = await _api.upDateUser('Bearer $token',userId,body);
      isLoading.value = false;
      _fetchUserList();
      userList.refresh();
      Get.snackbar(
        "Success",
        response.message ?? "User updated successfully",
        snackPosition: SnackPosition.BOTTOM,
      );
    } catch (e) {
      isLoading.value = false;

      Get.snackbar(
        "Error",
        "Update failed: $e",
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }
  Future<void> createUser() async {
    isLoading.value = true;

    final body = {
      "username": username.value,
      "password": password.value,
      "role": role.value,
    };

    try {
      final response = await _api.registerUser(body);
      isLoading.value = false;
      _fetchUserList();
      userList.refresh();
      Get.snackbar(
        "Success",
        response.message ?? "User registered successfully",
        snackPosition: SnackPosition.BOTTOM,
      );
    } catch (e) {
      isLoading.value = false;

      Get.snackbar(
        "Error",
        "Registration failed: $e",
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }
  // Optionally, you can add a method to load the token if needed
  Future<String?> getTokenFromSharedPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('auth_token');
  }
}

