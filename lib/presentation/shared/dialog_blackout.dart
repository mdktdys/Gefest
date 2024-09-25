import 'package:flutter/material.dart';
import 'package:gefest/core/api/api.dart';
import 'package:go_router/go_router.dart';

class DialogBlackout extends StatelessWidget {
  const DialogBlackout({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: () {
          context.pop(ActionResultError(text: "Cancel"));
        },
        child: Container(
          width: double.infinity,
          height: double.infinity,
          color: Colors.transparent,
        )
      ),
    );
  }
}