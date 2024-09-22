// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gefest/theme.dart';

final messagesProvider = Provider<Messanger>((ref) {
  return Messanger(ref: ref);
});

class Messanger {
  Ref ref;
  Messanger({
    required this.ref,
  });

  showMessage(
      {required MesTypes type, required String header, required String body, required BuildContext context}) {
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
      padding: const EdgeInsets.all(0),
      backgroundColor: Colors.transparent,
      elevation: 0,
    ));
  }
}

enum MesTypes { success, error, warning, info, debug }

class MessageBlank extends StatelessWidget {
  final MesTypes type;
  final String header;
  final String body;
  const MessageBlank(
      {super.key,
      required this.type,
      required this.body,
      required this.header});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
          // borderRadius: BorderRadius.circular(10),
          color: Theme.of(context).colorScheme.surface,
          border: Border(
              top: BorderSide(
                  width: 1,
                  color: Colors.green.withOpacity(
                    0.6,
                  )))),
      // border: Border.all(width: 2, color: Colors.green.withOpacity(0.6))),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            header,
            style: Fa.medium,
          ),
          Text(
            body,
            style: Fa.small,
          )
        ],
      ),
    );
  }
}
