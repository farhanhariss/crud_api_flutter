import 'package:flutter/material.dart';

import 'package:get/get.dart';
import '../views/user_view.dart';
import '../views/add_user_view.dart';
import '../controllers/user_controller.dart';
import '../../../data/models/user_model.dart';

class ListUserView extends GetView<UserController> {
  const ListUserView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('List User'),
        centerTitle: true,
      ),
      body: RefreshIndicator(
        onRefresh: () => controller.refreshUsers(),
        child: Obx(
          () {
            final users = controller.users;

            if (controller.isLoading.value) {
              print(controller.isLoading.value);
              return const Center(child: CircularProgressIndicator());
            }
            if (users.isEmpty) {
              return Center(child: Text("No Data"));
            } else {
              return ListView.builder(
                itemCount: users.length,
                itemBuilder: (context, index) {
                  User user = users[index];
                  return ListTile(
                    title: Text(user.name!),
                    subtitle: Text(user.email!),
                    trailing: IconButton(
                      onPressed: () => controller.deleteUser(user.id!),
                      icon: const Icon(Icons.delete),
                    ),
                    onTap: () => Get.to(UserView(
                      id: user.id!,
                    )),
                  );
                },
              );
            }
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () async {
          controller.nameController.text = '';
          controller.emailController.text = '';
          controller.phoneController.text = '';
          controller.birthdayController.text = '';
          controller.salaryController.text = '';
          Get.to(AddUserView());
        },
      ),
    );
  }
}
