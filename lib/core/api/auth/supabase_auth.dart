// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:get_it/get_it.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class Auth {
  static Future<ActionResult> signIn(String email, String password) async {
    try {
      final supabase = GetIt.I.get<Supabase>();
      final response = await supabase.client.auth
          .signInWithPassword(password: password, email: email);

      if (response.user != null) {
        return ActionResultOk(text: "Ok");
      }
    } catch (e) {
      return ActionResultError(text: e.toString());
    }

    return ActionResultError(text: "Неизвестная ошибка");
  }
}

abstract class ActionResult {
  String text;
  ActionResult({
    required this.text,
  });
}

class ActionResultOk extends ActionResult {
  ActionResultOk({required super.text});
}

class ActionResultError extends ActionResult {
  ActionResultError({required super.text});
}
