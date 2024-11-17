// // import 'package:flutter/material.dart';
// // import 'package:get/get.dart';
// // import '../controller/home_page_controller.dart';
// //  // Import the HomePageController
// //
// // class HomePage extends StatelessWidget {
// //   @override
// //   Widget build(BuildContext context) {
// //     // Instantiate the controller
// //     final HomePageController controller = Get.put(HomePageController());
// //
// //     return Scaffold(
// //       appBar: AppBar(
// //         title: Text('User List'),
// //       ),
// //       body: Obx(() {
// //         if (controller.isLoading.value) {
// //           return Center(child: CircularProgressIndicator());
// //         } else if (controller.errorMessage.isNotEmpty) {
// //           return Center(child: Text('Error: ${controller.errorMessage}'));
// //         } else if (controller.userList.isEmpty) {
// //           return Center(child: Text('No users found.'));
// //         } else {
// //           return ListView.builder(
// //             itemCount: controller.userList.length,
// //             itemBuilder: (context, index) {
// //               final user = controller.userList[index];
// //               return ListTile(
// //                 title: Text(user.userName ?? 'No username'),
// //                 subtitle: Text('User ID: ${user.userId}'),
// //               );
// //             },
// //           );
// //         }
// //       }),
// //     );
// //   }
// // }
//
//
//
//
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import '../controller/home_page_controller.dart';
// import '../controller/register_controller.dart';
//
// class HomePage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     final HomePageController homeController = Get.put(HomePageController());
//     final RegisterController registerController = Get.put(RegisterController());
//
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('User List'),
//         actions: [TextButton(
//           onPressed: () => _showCreateUserDialog(registerController, homeController),
//           child: const Text("Create new User"),
//         ),]
//       ),
//       body: Column(
//         children: [
//           Expanded(
//             child: Obx(() {
//               if (homeController.isLoading.value) {
//                 return const Center(child: CircularProgressIndicator());
//               } else if (homeController.errorMessage.isNotEmpty) {
//                 return Center(child: Text('Error: ${homeController.errorMessage}'));
//               } else if (homeController.userList.isEmpty) {
//                 return const Center(child: Text('No users found.'));
//               } else {
//                 return ListView.builder(
//                   itemCount: homeController.userList.length,
//                   itemBuilder: (context, index) {
//                     final user = homeController.userList[index];
//                     return ListTile(
//                       title: Text(user.userName ?? 'No username'),
//                       subtitle: Text('User ID: ${user.userId}'),
//                       trailing: IconButton(
//                         icon: const Icon(Icons.delete, color: Colors.red),
//                         onPressed: () => _confirmDeleteUser(context, homeController, user.userId),
//                       ),
//                     );
//                   },
//                 );
//               }
//             }),
//           ),
//         ],
//       ),
//     );
//   }
//
//   // Show confirmation dialog before deleting a user
//   void _confirmDeleteUser(
//       BuildContext context, HomePageController controller, int userId) {
//     Get.dialog(
//       AlertDialog(
//         title: const Text('Confirm Delete'),
//         content: const Text('Are you sure you want to delete this user?'),
//         actions: [
//           TextButton(
//             onPressed: () => Get.back(), // Close dialog
//             child: const Text('Cancel'),
//           ),
//           TextButton(
//             onPressed: () {
//               Get.back(); // Close dialog
//               controller.deleteUser(userId); // Call delete method
//             },
//             child: const Text('Delete'),
//           ),
//         ],
//       ),
//     );
//   }
//
//   void _showCreateUserDialog(
//       RegisterController registerController, HomePageController homeController) {
//     final usernameController = TextEditingController();
//     final passwordController = TextEditingController();
//
//     Get.dialog(
//       AlertDialog(
//         title: const Text('Create New User'),
//         content: Column(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             TextField(
//               controller: usernameController,
//               decoration: const InputDecoration(labelText: 'Username'),
//             ),
//             TextField(
//               controller: passwordController,
//               decoration: const InputDecoration(labelText: 'Password'),
//               obscureText: true,
//             ),
//           ],
//         ),
//         actions: [
//           TextButton(
//             onPressed: () => Get.back(), // Close dialog
//             child: const Text('Cancel'),
//           ),
//           TextButton(
//             onPressed: () async {
//               final username = usernameController.text.trim();
//               final password = passwordController.text.trim();
//
//               if (username.isEmpty || password.isEmpty) {
//                 Get.snackbar('Error', 'Please fill all fields',
//                     snackPosition: SnackPosition.BOTTOM);
//                 return;
//               }
//
//               // Pass values to the controller
//               registerController.username.value = username;
//               registerController.password.value = password;
//
//               // Call the register API
//               registerController.registerUser();
//
//               // Refresh user list after successful registration
//               homeController.onInit();
//               Get.back(); // Close dialog
//             },
//             child: const Text('Create'),
//           ),
//         ],
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/home_page_controller.dart';
import '../controller/register_controller.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final HomePageController homeController = Get.put(HomePageController());
    final RegisterController registerController = Get.put(RegisterController());

    return Scaffold(
      appBar: AppBar(
        title: const Text('User List'),
        actions: [
          TextButton(
            onPressed: () =>
                _showCreateUserDialog(registerController, homeController),
            child: const Text("Create new User",),
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: Obx(() {
              if (homeController.isLoading.value) {
                return const Center(child: CircularProgressIndicator());
              } else if (homeController.errorMessage.isNotEmpty) {
                return Center(child: Text('Error: ${homeController.errorMessage}'));
              } else if (homeController.userList.isEmpty) {
                return const Center(child: Text('No users found.'));
              } else {
                return ListView.builder(
                  itemCount: homeController.userList.length,
                  itemBuilder: (context, index) {
                    final user = homeController.userList[index];
                    return ListTile(
                      title: Text(user.userName ?? 'No username'),
                      subtitle: Text('User ID: ${user.userId}'),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: const Icon(Icons.edit, color: Colors.blue),
                            onPressed: () => _showEditUserDialog(context, homeController, user, user.userId),
                          ),
                          IconButton(
                            icon: const Icon(Icons.delete, color: Colors.red),
                            onPressed: () =>
                                _confirmDeleteUser(context, homeController, user.userId),
                          ),
                        ],
                      ),
                    );
                  },
                );
              }
            }),
          ),
        ],
      ),
    );
  }

  // Show confirmation dialog before deleting a user
  void _confirmDeleteUser(
      BuildContext context, HomePageController controller, int userId) {
    Get.dialog(
      AlertDialog(
        title: const Text('Confirm Delete'),
        content: const Text('Are you sure you want to delete this user?'),
        actions: [
          TextButton(
            onPressed: () => Get.back(), // Close dialog
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Get.back(); // Close dialog
              controller.deleteUser(userId); // Call delete method
            },
            child: const Text('Delete'),
          ),
        ],
      ),
    );
  }

  // Show dialog to edit the user
  void _showEditUserDialog(
      BuildContext context, HomePageController controller, dynamic user, int userId) {
    final usernameController = TextEditingController(text: user.userName);
    final passwordController = TextEditingController(); // Password is not prefetched

    Get.dialog(
      AlertDialog(
        title: const Text('Edit User'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: usernameController,
              decoration: const InputDecoration(labelText: 'Username'),
            ),
            TextField(
              controller: passwordController,
              decoration: const InputDecoration(labelText: 'Password'),
              obscureText: true,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Get.back(), // Close dialog
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () async {
              final newUsername = usernameController.text.trim();
              final newPassword = passwordController.text.trim();

              if (newUsername.isEmpty || newPassword.isEmpty) {
                Get.snackbar('Error', 'Please fill all fields',
                    snackPosition: SnackPosition.BOTTOM);
                return;
              }

              // Update user details via controller
              controller.username.value = newUsername;
              controller.password.value = newPassword;

              // Call the UpdateUser method in the controller
               controller.UpdateUser(userId);

              // Refresh the list after editing
              Get.back(); // Close dialog
            },
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }

  // Show dialog to create a new user
  void _showCreateUserDialog(
      RegisterController registerController, HomePageController homeController) {
    final usernameController = TextEditingController();
    final passwordController = TextEditingController();

    Get.dialog(
      AlertDialog(
        title: const Text('Create New User'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: usernameController,
              decoration: const InputDecoration(labelText: 'Username'),
            ),
            TextField(
              controller: passwordController,
              decoration: const InputDecoration(labelText: 'Password'),
              obscureText: true,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Get.back(), // Close dialog
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () async {
              final username = usernameController.text.trim();
              final password = passwordController.text.trim();

              if (username.isEmpty || password.isEmpty) {
                Get.snackbar('Error', 'Please fill all fields',
                    snackPosition: SnackPosition.BOTTOM);
                return;
              }

              // Pass values to the controller
              homeController.username.value = username;
              homeController.password.value = password;

              // Call the register API

              // Refresh user list after successful registration
               // Close dialog
              homeController.createUser();

              Get.back();
            },
            child: const Text('Create'),
          ),
        ],

      ),
    );
  }
}
