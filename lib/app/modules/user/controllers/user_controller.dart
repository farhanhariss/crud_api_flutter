import 'package:get/get.dart';

import '../../../data/providers/user_provider.dart';
import '../../../data/models/user_model.dart';

class UserController extends GetxController {


  UserProvider _userProvider = UserProvider();

  Future<User?> getUserById(int id) async {
    return await _userProvider.getUserById(id);
  }

  Future<List<User>> getAllUsers() async {
    return await _userProvider.getAllUsers();
  }
}
