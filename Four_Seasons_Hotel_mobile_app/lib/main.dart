import 'package:flutter/material.dart';
import 'package:mobile_final_project/login.dart';
import 'reservation.dart';
import 'rooms.dart';

//12132034 Omar Al Zoghbi
//12132554 Hamza Abo Saado

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Login(),
    );
  }
}
