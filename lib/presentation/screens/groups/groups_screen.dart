import 'package:flutter/material.dart';

import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:gefest/core/api/api.dart';
import 'package:gefest/core/api/data/providers/department_provider.dart';
import 'package:gefest/core/api/models/department_model.dart';
import 'package:gefest/core/extensions/context_extension.dart';
import 'package:gefest/presentation/screens/groups/providers/groups_screen_provider.dart';
import 'package:gefest/presentation/screens/groups/widgets/group_tile_widget.dart';
import 'package:gefest/presentation/shared/base_elevated_button.dart';
import 'package:gefest/presentation/shared/base_textfield.dart';


class GroupsScreen extends ConsumerStatefulWidget {
  const GroupsScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _GroupsScreenState();
}

class _GroupsScreenState extends ConsumerState<GroupsScreen> {
  TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(20.0),
      children: [
        Row(
          spacing: 10,
          children: [
            // Text(
            //   "Группы",
            //   style: context.styles.ubuntuBold24,
            // ),
            Flexible(
              child: BaseTextField(
                hintText: 'Поиск...',
                controller: controller,
                onChanged: (String p0) {
                  ref.read(searchStringProvider.notifier).state = p0;
                },
              ),
            ),
            BaseElevatedButton(
              text: 'Добавить',
            )
          ],
        ),
        SizedBox(height: 20),
        Builder(builder: (context) {
          return Column(
            children: AnimateList(
              interval: 100.ms,
              effects: [FadeEffect(duration: 300.ms)],
              children: ref.watch(filteredGroupsProvider).map((Group group) {
                return GroupTileWidget(group: group);
              }).toList(),
            ) 
          );
        })
      ],
    );
  }
}
