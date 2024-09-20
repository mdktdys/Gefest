import 'package:flutter/material.dart';
import 'package:gefest/presentation/screens/login/login.dart';
import 'package:gefest/theme.dart';

void main() {
  runApp(MaterialApp(
    color: Colors.blue,
    debugShowCheckedModeBanner: false,
    home: const LoginScreen(),
    theme: darkTheme
  ));
}
