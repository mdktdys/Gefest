import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:gefest/core/api/api.dart';
import 'package:gefest/core/extensions/context_extension.dart';
import 'package:gefest/presentation/screens/cabinets/cabinets_providers.dart';
import 'package:gefest/presentation/screens/cabinets/widgets/cabinet_list_tile.dart';
import 'package:gefest/presentation/shared/async_provider.dart';
import 'package:gefest/presentation/shared/base_elevated_button.dart';
import 'package:gefest/presentation/shared/base_textfield.dart';
import 'package:gefest/routes.dart';
import 'package:gefest/theme/spacing.dart';

class CabinetsScreen extends ConsumerStatefulWidget {
  const CabinetsScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _CabinetsScreenState();
}

class _CabinetsScreenState extends ConsumerState<CabinetsScreen> {
  late final TextEditingController controller;

  @override
  void initState() {
    super.initState();
    controller = TextEditingController();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(20.0),
      children: [
        Text(
          'Кабинеты',
          textAlign: TextAlign.left,
          style: context.styles.ubuntu20
        ),
        SizedBox(height: Spacing.list),
        Row(
          spacing: 10,
          children: [
            Expanded(
              child: BaseTextField(
                controller: controller,
                hintText: 'Поиск кабинета...',
                onChanged: (p0) {
                  ref.read(cabinetStringFilterProvider.notifier).state = controller.text;
                },
              ),
            ),
            BaseElevatedButton(
              text: 'Добавить',
              onTap: () {
                context.go(Uri(path: Routes.newCabinet).toString());
              },
            )
          ],
        ),
        SizedBox(height: 10),
        AsyncProvider<List<Cabinet>>(
          provider: filteredCabinetProvider,
          data: (cabinets) {
            return Column(
              children: cabinets.map((cabinet) {
                return CabinetListTile(cabinet);
              }).toList(),
            );
          },
        ),
      ],
    );
  }
}
