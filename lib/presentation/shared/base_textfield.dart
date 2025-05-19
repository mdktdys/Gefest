import 'package:flutter/material.dart';

import 'package:flutter_svg/flutter_svg.dart';

import 'package:gefest/theme.dart';

class BaseTextField extends StatefulWidget {
  final bool hidable;
  final Iterable<String>? autofillHints;
  final String? hintText;
  final String? header;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final Function(PointerDownEvent)? onTapOutside;
  final Function()? onEditingComplete;
  final Function(String)? onChanged;
  final Function()? onTap;
  final Function(String)? onFieldSubmitted;
  final bool locked;
  final bool autofocus;

  const BaseTextField(
      {super.key,
      this.autofillHints,
      this.hintText,
      this.header,
      this.controller,
      this.validator,
      this.onChanged,
      this.autofocus = false,
      this.onTap,
      this.onTapOutside,
      this.onEditingComplete,
      this.onFieldSubmitted,
      this.locked = false,
      this.hidable = false});

  @override
  State<BaseTextField> createState() => _BaseTextFieldState();
}

class _BaseTextFieldState extends State<BaseTextField> {
  late bool hided;

  @override
  void initState() {
    super.initState();
    hided = widget.hidable;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.header != null) ...[
          Text(
            widget.header!,
            style: Fa.smedium,
          ),
          const SizedBox(
            height: 10,
          )
        ],
        TextFormField(
          enabled: !widget.locked,
          style: Fa.smedium,
          autofocus: widget.autofocus,
          obscureText: hided,
          controller: widget.controller,
          validator: widget.validator,
          onTapOutside: widget.onTapOutside,
          onEditingComplete: widget.onEditingComplete,
          onChanged: widget.onChanged,
          onTap: widget.onTap,
          onFieldSubmitted: widget.onFieldSubmitted,
          decoration: InputDecoration(
              suffixIcon: widget.hidable
                  ? GestureDetector(
                      onTap: () {
                        setState(() {
                          hided = !hided;
                        });
                      },
                      child: SizedBox(
                          height: 24,
                          width: 24,
                          child: FittedBox(
                            fit: BoxFit.scaleDown,
                            child: SvgPicture.asset(
                              hided
                                  ? "assets/icons/eye_closed.svg"
                                  : "assets/icons/eye_open.svg",
                              width: 24,
                              height: 24,
                              color: const Color(0xFF7d858c),
                            ),
                          )),
                    )
                  : null,
              hintStyle: Fa.smedium,
              filled: true,
              fillColor: Theme.of(context).colorScheme.surfaceContainerLow,
              enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Theme.of(context).colorScheme.outlineVariant),borderRadius: BorderRadius.circular(10)),
              border:OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: BorderSide(color: Colors.red)),
              focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Theme.of(context).colorScheme.primary ),borderRadius: BorderRadius.circular(10)),
              disabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                color: Theme.of(context).colorScheme.onSurface
              ),
                borderRadius: BorderRadius.circular(10)
              ),
              contentPadding: const EdgeInsets.all(10.0),
              hintText: widget.hintText),
          autofillHints: widget.autofillHints,
        ),
      ],
    );
  }
}
