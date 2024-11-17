import 'package:flutter/material.dart';
import 'package:fortune_test/screens/login_screen.dart';
import 'package:get/get.dart';
import '../controller/register_controller.dart';


class RegisterScreen extends StatelessWidget {
  final RegisterController controller = Get.put(RegisterController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Register"),
      ),
      body: Obx(
            () => controller.isLoading.value
            ? Center(child: CircularProgressIndicator())
            : Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              TextField(
                onChanged: (value) => controller.username.value = value,
                decoration: InputDecoration(labelText: "Username"),
              ),
              TextField(
                onChanged: (value) => controller.password.value = value,
                decoration: InputDecoration(labelText: "Password"),
                obscureText: true,
              ),
              Obx(() => DropdownButton<String>(
                value: controller.role.value,
                onChanged: (value) {
                  if (value != null) {
                    controller.role.value = value;
                  }
                },
                items: ["USER", "ADMIN"]
                    .map((role) => DropdownMenuItem(
                  value: role,
                  child: Text(role),
                ))
                    .toList(),
              )),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: controller.registerUser,
                child: Text("Register"),
              ),
              TextButton(onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => LoginScreen()),
                );


              }, child: Text("Login"))
            ],
          ),
        ),
      ),
    );
  }
}
