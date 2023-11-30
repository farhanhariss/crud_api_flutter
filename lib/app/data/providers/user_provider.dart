import 'package:get/get.dart';

import '../models/user_model.dart';

// Digunakan untuk connect ke HTTP
class UserProvider extends GetConnect {
  Future<User?> getUserById(int id) async {
    final response = await get('http://10.0.2.2:3000/api/get_user/$id');
    print('Raw Response: ${response.body}');
    return User.fromJson(response.body["data"]);
  }

  Future<List<User>> getAllUsers() async {
    final response = await get('http://10.0.2.2:3000/api/users');

    // Print the raw response for debugging purposes
    print('Raw Response: ${response.body}');

    // Assuming your User class has a method to convert JSON to a List<User>
    return User.fromJsonList(response.body["data"]);
  }

  Future createUser(String name, String email, int phone, String birthday, String salary) async {
    final bodyData = {
      'name': name,
      'email': email,
      'phone': phone,
      'birthday': birthday,
      'salary': salary,
    };
    final response = await post('http://10.0.2.2:3000/api/create_user', bodyData);
    await getAllUsers();
    print('Raw Response: ${response.body}');
    return response;
  }

  Future deleteUser(int id) async {
  await delete('http://10.0.2.2:3000/api/delete_user/$id');
  await getAllUsers();;
  }
}

//TODO add create user, delete user. &update user

// Future<Response<User>> postUser(User user) async => await post('user', user);
