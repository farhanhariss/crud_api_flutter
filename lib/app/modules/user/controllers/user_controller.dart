import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

import '../../../data/providers/user_provider.dart';
import '../../../data/models/user_model.dart';

class UserController extends GetxController {
  UserProvider _userProvider = UserProvider();

  late TextEditingController nameController;
  late TextEditingController emailController;
  late TextEditingController phoneController;
  late TextEditingController birthdayController;
  late TextEditingController salaryController;

  

  @override
  void onInit() {
    nameController = TextEditingController();
    emailController = TextEditingController();
    phoneController = TextEditingController();
    birthdayController = TextEditingController();
    salaryController = TextEditingController();
    super.onInit();
  }

  @override
  void onClose() {
    nameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    birthdayController.dispose();
    salaryController.dispose();
  }

  Future<User?> getUserById(int id) async {
    try {
      return await _userProvider.getUserById(id);
    } catch (e) {
      // Handle the error, e.g., log it or show a friendly message.
      print('Error in getUserById: $e');
      return null;
    }
  }

  Future<List<User>> getAllUsers() async {
    try {
      return await _userProvider.getAllUsers();
    } catch (e) {
      // Handle the error, e.g., log it or show a friendly message.
      print('Error in getAllUsers: $e');
      return [];
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
      await getAllUsers();
      update();

    } catch (e) {
      // Handle the error, e.g., log it or show a friendly message.
      print('Error in createUser: $e');
      return Future.error(e);
    }
  }

  deleteUser(int id) async {
    try {
      await _userProvider.deleteUser(id);
    } catch (e) {
      // Handle the error, e.g., log it or show a friendly message.
      print('Error in deleteUser: $e');
    }
  }

  Future<void> refreshUsers() async {
    await getAllUsers();
    update();
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
      await getAllUsers();
      update();

    } catch (e) {
      // Handle the error, e.g., log it or show a friendly message.
      print('Error in updateUser: $e');
      return Future.error(e);
    }
  }
}
