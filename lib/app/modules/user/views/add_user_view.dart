import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/user_controller.dart';

class AddUserView extends GetView<UserController> {
  final userController = Get.put(UserController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create User'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                controller: userController.nameController,
                decoration: InputDecoration(labelText: 'Name'),
                // You might want to handle the input value with a controller
              ),
              TextFormField(
                controller: userController.emailController,
                decoration: const InputDecoration(labelText: 'Email'),
                keyboardType: TextInputType.emailAddress,
              ),
              TextFormField(
                controller: userController.phoneController,
                decoration: const InputDecoration(labelText: 'Phone'),
                keyboardType: TextInputType.phone,
              ),
              TextFormField(
                controller: userController.birthdayController,
                decoration: const InputDecoration(labelText: 'Birthday'),
              ),
              TextFormField(
                controller: userController.salaryController,
                decoration: const InputDecoration(labelText: 'Salary'),
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  if (userController.nameController.text.isEmpty ||
                      userController.emailController.text.isEmpty ||
                      userController.phoneController == 0 ||
                      userController.birthdayController.text.isEmpty ||
                      userController.salaryController.text.isEmpty) {
                    Get.snackbar('Error', 'Field tidak boleh kosong');
                    return;
                  } else {
                    await userController.createUser();
                    userController.nameController.text = '';
                    userController.emailController.text = '';
                    userController.phoneController.text = '';
                    userController.birthdayController.text = '';
                    userController.salaryController.text = '';
                    Get.back();
                  }
                },
                child: const Text('Create User'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
