import 'package:flutter/material.dart';
import 'package:gefest/presentation/screens/login/login.dart';

void main() {
  runApp(MaterialApp(
    color: Colors.blue,
    debugShowCheckedModeBanner: false,
    home: const LoginScreen(),
    theme: ThemeData.light().copyWith(),
  ));
}
