import 'package:flutter/material.dart';
import 'package:fortune_test/screens/register_screen.dart';
import 'package:get/get.dart';

import '../controller/login_controller.dart';

class LoginScreen extends StatelessWidget {
  final LoginController _controller = Get.put(LoginController());
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Login"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: usernameController,
              decoration: InputDecoration(labelText: "Username"),
            ),
            SizedBox(height: 10),
            TextField(
              controller: passwordController,
              decoration: InputDecoration(labelText: "Password"),
              obscureText: true,
            ),
            SizedBox(height: 20),
            Obx(() {
              if (_controller.isLoading.value) {
                return Center(child: CircularProgressIndicator());
              }
              return ElevatedButton(
                onPressed: () {
                  _controller.login(
                    context,  // Pass context here
                    usernameController.text.trim(),
                    passwordController.text.trim(),
                  );
                },
                child: Text("Login"),
              );
            }),
            SizedBox(height: 20),
            Obx(() {
              if (_controller.errorMessage.isNotEmpty) {
                return Text(
                  _controller.errorMessage.value,
                  style: TextStyle(color: Colors.red),
                );
              }
              return Container();
            }),
            TextButton(onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => RegisterScreen()),
              );


            }, child: Text("Register"))
          ],
        ),
      ),
    );
  }
}
