// ignore_for_file: equal_keys_in_map

import 'package:flutter/material.dart';
import 'package:postman/pages/info_page.dart';


import 'package:postman/pages/network_page.dart';
import 'package:postman/pages/post_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(

        primarySwatch: Colors.orange,
        //useMaterial3: true,
      ),
      home: const NetworkPage(),
routes: {
  EmployeeInfoPage.id: (context) => const EmployeeInfoPage (),
  PostPage.id: (context) => const PostPage (),
},
    );
  }
}




