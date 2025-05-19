// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';

import 'package:gefest/core/extensions/context_extension.dart';
import 'package:gefest/theme.dart';

final messagesProvider = Provider<Messanger>((ref) {
  return Messanger(ref: ref);
});

class Messanger {
  Ref ref;
  Messanger({
    required this.ref,
  });

  showMessage({
    required MesTypes type,
    required String header,
    required String body,
    required BuildContext context
  }) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      dismissDirection: DismissDirection.horizontal,
      // margin: EdgeInsets.only(
      //   bottom: MediaQuery.of(context).size.height - 100,
      //   right: 20,
      // ),
      // behavior: SnackBarBehavior.floating,
      content: MessageBlank(
        type: type,
        body: body,
        header: header,
      ),
      padding: const EdgeInsets.all(20),
      backgroundColor: Colors.transparent,
      elevation: 0,
    ));
  }
}

enum MesTypes {
  success(
    color: Color(0xFF4CAF50),
    iconPath: 'assets/icons/success.svg',
  ),
  error(
    color: Color(0xFFF44336),
    iconPath: 'assets/icons/error.svg',
  ),
  warning(
    color: Color(0xFFFFC107),
    iconPath: 'assets/icons/warning.svg',
  ),
  info(
    color: Color(0xFF2196F3),
    iconPath: 'assets/icons/info.svg',
  ),
  debug(
    color: Color(0xFF9E9E9E),
    iconPath: 'assets/icons/debug.svg',
  );

  final Color color;
  final String iconPath;

  const MesTypes({required this.color, required this.iconPath});
}

class MessageBlank extends StatelessWidget {
  final MesTypes type;
  final String header;
  final String body;

  const MessageBlank({
    super.key,
    required this.type,
    required this.header,
    required this.body,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: Theme.of(context).colorScheme.surface,
        border: Border.all(
          width: 1.5,
          color: type.color
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SvgPicture.asset(
            type.iconPath,
            width: 24,
            height: 24,
            colorFilter: ColorFilter.mode(type.color, BlendMode.srcIn),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  header,
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium
                      ?.copyWith(color: type.color),
                ),
                const SizedBox(height: 4),
                Text(
                  body,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
