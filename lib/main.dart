import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:fortune_test/screens/login_screen.dart';
import 'package:fortune_test/screens/register_screen.dart';
import 'package:fortune_test/screens/admin_dashboard.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter API App',
      theme: ThemeData(primarySwatch: Colors.blue),
      initialRoute: '/login',
      getPages: [
        GetPage(name: '/register', page: () => RegisterScreen()),
        GetPage(name: '/login', page: () => LoginScreen()),
        GetPage(name: '/admin', page: () => HomePage()),
        // GetPage(name: '/user', page: () => UserDashboard()),
      ],
    );
  }
}
