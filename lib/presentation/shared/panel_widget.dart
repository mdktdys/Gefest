import 'package:flutter/material.dart';

import 'package:gefest/presentation/shared/para_panel.dart';
import 'package:gefest/presentation/shared/shared.dart';

class Panel extends StatelessWidget {
  final String title;
  final List<Widget> chilren;
 
  const Panel({
    required this.title,
    required this.chilren,
    super.key
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Row(
        children: [
          const DialogBlackout(),
          ParaPanel(
            title: title,
            children: chilren,
          ),
        ],
      ),
    );
  }
}
