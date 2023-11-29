// import 'package:flutter/material.dart';

// import 'package:get/get.dart';

// import '../controllers/user_controller.dart';

// import './edit_user_profile_view.dart';

// class UserView extends GetView<UserController> {
//   const UserView({Key? key}) : super(key: key);
//   @override
//   Widget build(BuildContext context) {
//     double deviceWidth = MediaQuery.of(context).size.width;
//     double deviceHeight = MediaQuery.of(context).size.height;
//     print("Scaffold dibuat");
//     return Scaffold(
//         body: SingleChildScrollView(
//           child: Container(
//             child: Column(children: [
//               // Profile Picture
//               Container(
//                   width: deviceWidth * 1,
//                   height: deviceHeight * 0.45,
//                   decoration: const BoxDecoration(
//                       shape: BoxShape.rectangle,
//                       image: DecorationImage(
//                         image: NetworkImage(
//                             'https://images.pexels.com/photos/1172207/pexels-photo-1172207.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1'),
//                         fit: BoxFit.fill,
//                       ))),
//               const SizedBox(height: 20),
        
//               // Profile Name and Position
//               Container(
//                 width: deviceWidth * 1,
//                 child: Padding(
//                   padding: const EdgeInsets.symmetric(horizontal: 20.0),
//                   child: Column(
//                     mainAxisAlignment: MainAxisAlignment.start,
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text(
//                         "Farhan",
//                         style: const TextStyle(
//                             fontSize: 40, fontWeight: FontWeight.bold),
//                         textAlign: TextAlign.start,
//                       ),
//                       SizedBox(height: 5),
//                       Text(
//                         "Haus Intern",
//                         style:
//                             TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
        
//               SizedBox(
//                 height: 20,
//               ),
//               // Profile Detail Information
//               Container(
//                 width: deviceWidth * 0.8,
//                 // color: Colors.amber,
//                 child: Column(
//                   children: [
//                     // ID Number
//                     // Salary Request
//                     const SizedBox(
//                       height: 5.0,
//                     ),
//                     UserInfo(textLeft: "ID Number", textRight: "123123123"),
//                     // Location
//                     const SizedBox(
//                       height: 5.0,
//                     ),
//                     UserInfo(textLeft: "Salary Request", textRight: "Rp 20000"),
//                     // Birthday
//                     const SizedBox(
//                       height: 5.0,
//                     ),
//                     UserInfo(textLeft: "Birthday", textRight: "19/01/21"),
//                     // Email
//                     const SizedBox(
//                       height: 5.0,
//                     ),
//                     UserInfo(textLeft: "Email", textRight: "farhan@gmail.com"),
//                     // Mobile Phone
//                     const SizedBox(
//                       height: 5.0,
//                     ),
//                     UserInfo(textLeft: "Mobile Phone", textRight: "085212312")
//                   ],
//                 ),
//               )
//             ]),
//           ),
//         ),
//         floatingActionButton: FloatingActionButton(
//           onPressed: () {
//             // Get.to(EditUserProfileView());
//           },
//           backgroundColor: Colors.blue,
//           child: const Icon(Icons.edit),
//         ));
//   }
// }

// class UserInfo extends StatelessWidget {
//   final String textLeft;
//   final String textRight;

//   UserInfo({required this.textLeft, required this.textRight});

//   @override
//   Widget build(BuildContext context) {
//     return Row(
//         mainAxisAlignment: MainAxisAlignment.center,
//         crossAxisAlignment: CrossAxisAlignment.center,
//         children: [
//           Expanded(
//             flex: 5,
//             child: Text(
//               textLeft,
//               style: const TextStyle(fontSize: 17, fontWeight: FontWeight.w600, color: Colors.grey),
//             ),
//           ),
//           Expanded(
//             flex: 5,
//             child: Text(
//               textRight,
//               style: const TextStyle(fontSize: 17, fontWeight: FontWeight.w600),
//             ),
//           ),
//         ],
//       );
//   }
// }
