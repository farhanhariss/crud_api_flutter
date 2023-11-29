import 'package:flutter/material.dart';

import 'package:get/get.dart';
import '../controllers/user_controller.dart';
import '../../../data/models/user_model.dart';

class ListUserView extends GetView<UserController> {
  
  const ListUserView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('List User'),
          centerTitle: true,
        ),
        body: FutureBuilder<List<User>>(
            future: controller.getAllUsers(), 
            builder: (context, snap){
              print(snap.data!.length);
              if(snap.connectionState == ConnectionState.waiting){
                return const Center(child: CircularProgressIndicator());
              }
              if(snap.data?.length == 0){
                return Center(
                  child: Text("No Data"));
              }
              else{
                return ListView.builder(
                  itemCount: snap.data!.length,
                  itemBuilder: (context, index){
                    User user = snap.data![index];
                    return ListTile(
                      title: Text(user.name!),
                      subtitle: Text(user.email!),
                      trailing: IconButton(
                        onPressed: (){},
                        icon: const Icon(Icons.delete),
                      ),
                    );
                  },
                );
              }
            }
            )
            );
  }
}
