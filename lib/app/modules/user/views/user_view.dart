import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:user_application/app/data/models/user_model.dart';

import '../controllers/user_controller.dart';

class UserView extends GetView<UserController> {
  final int id;

  const UserView({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    double deviceHeight = MediaQuery.of(context).size.height;
    double deviceWidth = MediaQuery.of(context).size.width;
    return Scaffold(
        body: FutureBuilder<User?>(
            future: controller.getUserById(id),
            builder: (context, snap) {
              if (snap.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }
              if (snap.data == null) {
                return Center(child: Text("No Data"));
              } else {
                User user = snap.data!;
                return Column(
                  children: [
                    Container(
                      width: deviceWidth,
                      height: deviceHeight * 0.3,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          UserInfo(textLeft: "name", textRight: user.name!),
                          UserInfo(textLeft: "email", textRight: user.email!),
                          UserInfo(
                              textLeft: "phone",
                              textRight: user.phone!.toString()),
                          UserInfo(
                              textLeft: "birthday", textRight: user.birthday!),
                          UserInfo(textLeft: "salary", textRight: user.salary!)
                        ],
                      ),
                    ),
                    const SizedBox(height: 10),
                    ElevatedButton(
                      onPressed: () async {
                        print(user.id);

                        // Check the data type using runtimeType
                        if (user.id.runtimeType == String) {
                          print('The user.id is a String.');
                        } else if (user.id.runtimeType == int) {
                          print('The user.id is an int.');
                        } else {
                          print('The user.id has a different data type.');
                        }
                        await controller.deleteUser(user.id!);
                        Get.back();
                      },
                      child: Text("Delete Button"),
                    ),
                  ],
                );
              }
            }));
  }
}

class UserInfo extends StatelessWidget {
  final String textLeft;
  final String textRight;

  UserInfo({required this.textLeft, required this.textRight});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          flex: 5,
          child: Text(
            textLeft,
            style: const TextStyle(
                fontSize: 17, fontWeight: FontWeight.w600, color: Colors.grey),
          ),
        ),
        Expanded(
          flex: 5,
          child: Text(
            textRight,
            style: const TextStyle(fontSize: 17, fontWeight: FontWeight.w600),
          ),
        ),
      ],
    );
  }
}
