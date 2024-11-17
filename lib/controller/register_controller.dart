import 'package:dio/dio.dart';
import 'package:fortune_test/network/the_api.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';


class RegisterController extends GetxController {
  final username = ''.obs;
  final password = ''.obs;
  final role = 'USER'.obs; // Default role
  final isLoading = false.obs;

  final TheApi api  = TheApi(Dio());

  Future<void> registerUser() async {
    isLoading.value = true;

    final body = {
      "username": username.value,
      "password": password.value,
      "role": role.value,
    };

    try {
      final response = await api.registerUser(body);
      isLoading.value = false;

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
}
