import 'package:flutter/material.dart';
import 'package:gefest/theme.dart';

class BaseTextField extends StatelessWidget {
  final Iterable<String>? autofillHints;
  final String? hintText;
  final String? header;
  const BaseTextField(
      {super.key, this.autofillHints, this.hintText, this.header});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (header != null) ...[
          Text(
            header!,
            style: Fa.smedium,
          ),
          const SizedBox(
            height: 10,
          )
        ],
        TextField(
          style: Fa.smedium,
          decoration: InputDecoration(
              hintStyle: Fa.smedium,
              filled: true,
              fillColor:
                  Theme.of(context).colorScheme.onSurface.withOpacity(0.5),
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
              focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Ca.primary),
                  borderRadius: BorderRadius.circular(10)),
              disabledBorder: InputBorder.none,
              contentPadding: const EdgeInsets.all(10.0),
              hintText: hintText),
          autofillHints: autofillHints,
        ),
      ],
    );
  }
}
