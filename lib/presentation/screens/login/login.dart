import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gefest/core/api/auth/supabase_auth.dart';
import 'package:gefest/core/messages/messages_provider.dart';
import 'package:gefest/presentation/shared/base_elevated_button.dart';
import 'package:gefest/presentation/shared/outline_area.dart';
import 'package:gefest/theme.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../../shared/shared.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  TextEditingController emailController = TextEditingController(text: "");
  TextEditingController passwordController = TextEditingController(text: "");
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: Stack(
        children: [
          Container(
            padding: const EdgeInsets.all(20),
            child: Align(
              alignment: Alignment.bottomRight,
              child: Text(
                "build: ${GetIt.I.get<PackageInfo>().buildNumber}",
                style: Fa.smallMono,
              ),
            ),
          ),
          Center(
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
                            style:
                                Fa.big.copyWith(fontWeight: FontWeight.bold)),
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
                            style:
                                Fa.big.copyWith(fontWeight: FontWeight.bold)),
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
                        padding: const EdgeInsets.all(28),
                        child: _buildLoginForm())
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  _login() async {
    if (_formKey.currentState!.validate()) {
      TextInput.finishAutofillContext();
      final ActionResult res =
          await Auth.signIn(emailController.text, passwordController.text);

      if (res is ActionResultError) {
        ref.watch(messagesProvider).showMessage(
            type: MesTypes.error,
            header: "Ошибка",
            body: res.text,
            context: context);
      }

      if (res is ActionResultOk) {
        context.go("/dashboard");
      }
    }
  }

  Form _buildLoginForm() {
    return Form(
      key: _formKey,
      child: AutofillGroup(
        child: Column(
          children: [
            BaseTextField(
              header: "Почта",
              hintText: "xyz@gmail.com",
              controller: emailController,
              onTapOutside: (p0) {
                _formKey.currentState!.validate();
              },
              onEditingComplete: () {
                _formKey.currentState!.validate();
              },
              validator: (p0) {
                if (p0 != null && !EmailValidator.validate(p0)) {
                  return "Некорректный Email";
                }
                return null;
              },
              autofillHints: const [AutofillHints.email],
            ),
            const SizedBox(
              height: 20,
            ),
            BaseTextField(
              header: "Пароль",
              controller: passwordController,
              hintText: "🔑",
              hidable: true,
              onFieldSubmitted: (p0) {
                _login();
              },
              autofillHints: const [AutofillHints.password],
            ),
            const SizedBox(
              height: 20,
            ),
            BaseElevatedButton(
              text: "Войти",
              onTap: () async {
                _login();
              },
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
        ),
      ),
    );
  }
}
