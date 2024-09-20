import 'package:flutter/material.dart';
import 'package:gefest/presentation/shared/base_elevated_button.dart';
import 'package:gefest/presentation/shared/outline_area.dart';
import 'package:gefest/theme.dart';
import 'package:url_launcher/url_launcher_string.dart';

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
              if (MediaQuery.sizeOf(context).width > 530)
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
                )
              else
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      "assets/images/logo.png",
                      width: 120,
                    ),
                    Text("Замены уксивтика",
                        style: Fa.big.copyWith(fontWeight: FontWeight.bold)),
                  ],
                ),
              const SizedBox(
                height: 20,
              ),
              if (MediaQuery.sizeOf(context).width > 530)
                OutlineArea(
                  child: _buildLoginForm(),
                )
              else
                Padding(
                    padding: const EdgeInsets.all(28), child: _buildLoginForm())
            ],
          ),
        ),
      ),
    );
  }

  Column _buildLoginForm() {
    return Column(
      children: [
        const BaseTextField(
          header: "Почта",
          hintText: "xyz@gmail.com",
          autofillHints: [AutofillHints.email],
        ),
        const SizedBox(
          height: 20,
        ),
        const BaseTextField(
          header: "Пароль",
          hintText: "🔑",
          hidable: true,
          autofillHints: [AutofillHints.password],
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
            GestureDetector(
              onTap: () {
                launchUrlString("https://t.me/mdktdys");
              },
              child: Text(
                "dev: @mdktdys",
                style: Fa.smallMono,
              ),
            ),
          ],
        )
      ],
    );
  }
}
