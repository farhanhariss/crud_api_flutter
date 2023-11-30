class User {
  int? id;
  String? name;
  String? email;
  int? phone;
  String? birthday;
  String? salary;

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    birthday = json['birthday'];
    salary = json['salary'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['email'] = email;
    data['phone'] = phone;
    data['birthday'] = birthday;
    data['salary'] = salary;
    return data;
  }


  //Parse json to List
  static List<User> fromJsonList(List? data) {
    if (data == null || data.length == 0) return [];
    return data.map((item) => User.fromJson(item)).toList();
  }
}
