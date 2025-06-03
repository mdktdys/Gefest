import 'package:flutter/material.dart';

import 'package:go_router/go_router.dart';

import 'package:gefest/presentation/shared/base_elevated_button.dart';
import 'package:gefest/presentation/shared/base_textfield.dart';
import 'package:gefest/theme.dart';

class NewSynonymBody extends StatelessWidget {
  const NewSynonymBody({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final TextEditingController controller = TextEditingController();
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text("Новый синоним",style: Fa.medium,),
        SizedBox(height: 10,),
        BaseTextField(
          autofocus: true,
          controller: controller
        ),
        SizedBox(height: 10,),
        BaseElevatedButton(
          height: 40,
          text: "Добавить",
          onTap: () {
            context.pop(controller.text);
          },
        )
      ],
    );
  }
}
