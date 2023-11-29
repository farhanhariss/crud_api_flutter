// import 'package:flutter/material.dart';

// import 'package:get/get.dart';

// class EditUserProfileView extends GetView {
//   final _userName = TextEditingController();
//   final _userEmail = TextEditingController();
//   final _userPhone = TextEditingController();

//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Scaffold(
//         appBar: AppBar(
//           title: const Text('Edit User Profile'),
//           centerTitle: true,
//         ),
//         body: Center(
//             child: Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 20.0),
//           child: Column(
//             children: [
//               SizedBox(
//                 height: 10.0,
//               ),
//               TextField(
//                 controller: _userName,
//                 decoration: const InputDecoration(
//                     border: OutlineInputBorder(),
//                     labelText: 'Nama',
//                     hintText: 'Masukkan Nama'),
//               ),
//               SizedBox(
//                 height: 10.0,
//               ),
//               TextField(
//                 controller: _userEmail,
//                 decoration: const InputDecoration(
//                     border: OutlineInputBorder(),
//                     labelText: 'Email',
//                     hintText: 'Masukkan Email'),
//               ),
//               SizedBox(
//                 height: 10.0,
//               ),
//               TextField(
//                 controller: _userPhone,
//                 decoration: const InputDecoration(
//                     border: OutlineInputBorder(),
//                     labelText: 'Phone',
//                     hintText: 'Masukkan Phone'),
//               ),
//               SizedBox(
//                 height: 10.0,
//               ),
//               ElevatedButton(onPressed: ()=>{"Button diklik"}, child: Text('Simpan'))
//             ],
//           ),
//         )),
//       ),
//     );
//   }
// }
