import 'package:flutter/material.dart';
import 'package:gefest/presentation/shared/base_elevated_button.dart';
import 'package:gefest/presentation/shared/outline_area.dart';
import 'package:gefest/theme.dart';

import '../../shared/shared.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 510),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    "assets/images/logo.png",
                    width: 80,
                  ),
                  Text("Замены уксивтика",
                      style: Fa.big.copyWith(fontWeight: FontWeight.bold)),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              OutlineArea(
                child: Column(
                  children: [
                    const BaseTextField(
                      header: "Почта",
                      hintText: "xyz@gmail.com",
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const BaseTextField(
                      header: "Пароль",
                      hintText: "🔑",
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    BaseElevatedButton(
                      text: "Войти",
                      onTap: () {},
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "@mdktdys",
                          style: Fa.smallMono,
                        ),
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
