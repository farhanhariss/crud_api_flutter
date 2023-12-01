import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:user_application/app/data/models/user_model.dart';
import 'package:user_application/app/modules/user/controllers/user_controller.dart';

class EditUserProfileView extends GetView<UserController> {
  final int id;
  EditUserProfileView({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            title: const Text('Edit User Profile'),
            centerTitle: true,
          ),
          body: FutureBuilder<User?>(
              future: controller.getUserById(id),
              builder: (context, snap) {
                if (snap.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else {
                  User user = snap.data!;
                  return SingleChildScrollView(
                    child: Center(
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20.0),
                        child: Column(
                          children: [
                            SizedBox(height: 20),
                            TextFormField(
                              controller: controller.nameController
                                ..text = user.name!,
                              decoration: const InputDecoration(
                                  border: OutlineInputBorder(),
                                  labelText: 'Nama',
                                  hintText: 'Masukkan Nama'),
                            ),
                            const SizedBox(
                              height: 20.0,
                            ),
                            TextFormField(
                              controller: controller.emailController
                                ..text = user.email!,
                              decoration: const InputDecoration(
                                  border: OutlineInputBorder(),
                                  labelText: 'Email',
                                  hintText: 'Masukkan Email'),
                            ),
                            const SizedBox(
                              height: 20.0,
                            ),
                            TextFormField(
                              controller: controller.phoneController
                                ..text = user.phone!.toString(),
                              decoration: const InputDecoration(
                                  border: OutlineInputBorder(),
                                  labelText: 'Phone',
                                  hintText: 'Masukkan Phone'),
                            ),
                            const SizedBox(
                              height: 20.0,
                            ),
                            TextFormField(
                              controller: controller.birthdayController
                                ..text = user.birthday!,
                              decoration: const InputDecoration(
                                  border: OutlineInputBorder(),
                                  labelText: 'Bithday',
                                  hintText: 'Masukkan Birthday'),
                            ),
                            const SizedBox(
                              height: 20.0,
                            ),
                            TextFormField(
                              controller: controller.salaryController
                                ..text = user.salary!,
                              decoration: const InputDecoration(
                                  border: OutlineInputBorder(),
                                  labelText: 'Salary',
                                  hintText: 'Masukkan Salary'),
                            ),
                            const SizedBox(
                              height: 10.0,
                            ),
                            ElevatedButton(
                                onPressed: () async {
                                  controller.updateUser(id);
                                  Get.back();
                                },
                                child: const Text('Simpan')),
                          ],
                        ),
                      ),
                    ),
                  );
                }
              })),
    );
  }
}
