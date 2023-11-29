import 'package:get/get.dart';

import '../models/user_model.dart';


// Digunakan untuk connect ke HTTP
class UserProvider extends GetConnect {
  // @override
  // void onInit() {
  //   httpClient.defaultDecoder = (map) {
  //     if (map is Map<String, dynamic>) return User.fromJson(map);
  //     if (map is List) return map.map((item) => User.fromJson(item)).toList();
  //   };
  //   httpClient.baseUrl = 'YOUR-API-URL';
  // } 

  Future<User?> getUserById(int id) async {
    final response = await get('https://10.0.2.2:3000/api/get_user/$id');
    return User.fromJson(response.body["data"]);
  }

  Future<List<User>> getAllUsers() async {
    final response = await get('https://10.0.2.2:3000/api/users');
    return User.fromJsonList(response.body["data"]);
    }

  //TODO add create user, delete user. &update user
  // Future<Response<User>> postUser(User user) async => await post('user', user);
  // Future<Response> deleteUser(int id) async => await delete('user/$id');
}
