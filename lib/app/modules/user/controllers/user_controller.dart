import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:user_application/app/routes/app_pages.dart';

import '../../../data/providers/user_provider.dart';
import '../../../data/models/user_model.dart';

class UserController extends GetxController {
  UserProvider _userProvider = UserProvider();

  late TextEditingController nameController;
  late TextEditingController emailController;
  late TextEditingController phoneController;
  late TextEditingController birthdayController;
  late TextEditingController salaryController;

  final RxList<User> users = <User>[].obs;
  final Rx<User> currentUser = User().obs;
  final RxBool isLoading = true.obs;

  @override
  void onInit() {
    nameController = TextEditingController();
    emailController = TextEditingController();
    phoneController = TextEditingController();
    birthdayController = TextEditingController();
    salaryController = TextEditingController();
    super.onInit();
    refreshUsers();
  }

  @override
  void onClose() {
    super.onClose();
  }

  Future<User?> getUserById(int id) async {
    try {
      print('getUserById called with id: $id');
      User? fetchedUser = await _userProvider.getUserById(id);
      return currentUser.value = fetchedUser!;
    } catch (e) {
      // Handle the error, e.g., log it or show a friendly message.
      print('Error in getUserById: $e');
      return null;
    }
  }

  Future<void> getAllUsers() async {
    try {
      final List<User> fetchedUsers = await _userProvider.getAllUsers();
      users.assignAll(fetchedUsers);
    } catch (e) {
      // Handle the error, e.g., log it or show a friendly message.
      print('Error in getAllUsers: $e');
    } finally {
      isLoading.value = false;
    }
  }

  createUser() async {
    try {
      _userProvider.createUser(
        nameController.text,
        emailController.text,
        int.tryParse(phoneController.text) ?? 0,
        birthdayController.text,
        salaryController.text,
      );
      Get.snackbar(
        'Success',
        'User created successfully',
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );
      nameController.text = '';
      emailController.text = '';
      phoneController.text = '';
      birthdayController.text = '';
      salaryController.text = '';
      Get.offAllNamed(Routes.USER);
      await getAllUsers();
    } catch (e) {
      // Handle the error, e.g., log it or show a friendly message.
      print('Error in createUser: $e');
      return Future.error(e);
    }
  }

  deleteUser(int id) async {
    try {
      Get.dialog(
        AlertDialog(
          title: const Text('Delete Confirmation'),
          content: const Text('Are you sure you want to delete this user?'),
          actions: [
            TextButton(
              onPressed: () async {
                await _userProvider.deleteUser(id);
                Get.back(); // Close the dialog
                refreshUsers();
                Get.snackbar(
                  'Success',
                  'User deleted successfully',
                  snackPosition: SnackPosition.TOP,
                  backgroundColor: Colors.green,
                  colorText: Colors.white,
                );
              }, // Set color
              style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(
                      Colors.red)),
              child: const Text('Yes',
                  style: TextStyle(color: Colors.white)), // Set background color
            ),
            TextButton(
              onPressed: () => Get.back(), // Close the dialog
              child: const Text('No'),
            ),
          ],
        ),
      );

      getAllUsers();
    } catch (e) {
      // Handle the error, e.g., log it or show a friendly message.
      print('Error in deleteUser: $e');
    }
  }

  Future<void> refreshUsers() async {
    isLoading.value = false;
    await getAllUsers();
  }

  updateUser(int id) async {
    try {
      _userProvider.updateUser(
        id,
        nameController.text,
        emailController.text,
        int.tryParse(phoneController.text) ?? 0,
        birthdayController.text,
        salaryController.text,
      );
      await getUserById(id);
      update();
    } catch (e) {
      // Handle the error, e.g., log it or show a friendly message.
      print('Error in updateUser: $e');
      return Future.error(e);
    }
  }
}
