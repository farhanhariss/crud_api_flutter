import 'package:flutter/material.dart';

import 'package:get/get.dart';
// import 'package:user_application/app/data/models/user_model.dart';
import '../views/edit_user_profile_view.dart';

import '../controllers/user_controller.dart';

class UserView extends GetView<UserController> {
  final int id;

  const UserView({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    double deviceWidth = MediaQuery.of(context).size.width;
    controller.getUserById(id);
    return Scaffold(
      appBar: AppBar(
          title: const Text('User Profile'),
          centerTitle: true,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () => Get.back(),
          )),
      body: RefreshIndicator(
        onRefresh: () => controller.getUserById(id),
        child: Obx(() {
          final user = controller.currentUser;
          if (controller.isLoading.value) {
            return const Center(child: CircularProgressIndicator());
          }
          if (user.value.id == null) {
            return Center(
                child: ElevatedButton(
                    onPressed: () => controller.getUserById(id),
                    child: Text("Tekan")));
          } else {
            return Card(
              shadowColor: Colors.black,
              margin: EdgeInsetsGeometry.lerp(
                  EdgeInsets.zero, const EdgeInsets.all(3), 10 ),
              elevation: 10,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              child: SingleChildScrollView(
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      children: [
                        SizedBox(
                          width: deviceWidth * 0.7,
                          child: Center(
                            child: Column(
                              children: [
                                UserInfo(
                                    textLeft: "Name", textRight: user.value.name!),
                                const SizedBox(height: 10),
                                UserInfo(
                                    textLeft: "Email",
                                    textRight: user.value.email!),
                                const SizedBox(height: 10),
                                UserInfo(
                                    textLeft: "Phone",
                                    textRight: user.value.phone!.toString()),
                                const SizedBox(height: 10),
                                UserInfo(
                                    textLeft: "Birthday",
                                    textRight: user.value.birthday!),
                                const SizedBox(height: 10),
                                UserInfo(
                                    textLeft: "Salary",
                                    textRight: user.value.salary!)
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        ElevatedButton(
                          onPressed: () =>
                              Get.to(EditUserProfileView(id: user.value.id!)),
                          style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.all(Colors.blue)),
                          child: Text("Edit User"),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          }
        }),
      ),
    );
  }
}

class UserInfo extends StatelessWidget {
  final String textLeft;
  final String textRight;

  UserInfo({required this.textLeft, required this.textRight});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 5,
          child: Text(
            textLeft,
            style: const TextStyle(
                fontSize: 18, fontWeight: FontWeight.w600, color: Colors.grey),
          ),
        ),
        Expanded(
          flex: 5,
          child: Text(
            textRight,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
          ),
        ),
      ],
    );
  }
}
