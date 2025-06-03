import 'package:flutter/material.dart';

import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:gefest/core/api/api.dart';
import 'package:gefest/core/extensions/context_extension.dart';
import 'package:gefest/presentation/screens/groups/providers/groups_screen_provider.dart';
import 'package:gefest/presentation/screens/groups/widgets/group_tile_widget.dart';
import 'package:gefest/presentation/shared/base_elevated_button.dart';
import 'package:gefest/presentation/shared/base_textfield.dart';
import 'package:gefest/routes.dart';
import 'package:gefest/theme/spacing.dart';


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
        Text(
          'Группы',
          textAlign: TextAlign.left,
          style: context.styles.ubuntu20
        ),
        SizedBox(height: Spacing.list),
        Row(
          spacing: 10,
          children: [
            Flexible(
              child: BaseTextField(
                hintText: 'Поиск группы...',
                controller: controller,
                onChanged: (String p0) {
                  ref.read(searchStringProvider.notifier).state = p0;
                },
              ),
            ),
            BaseElevatedButton(
              text: 'Добавить',
              onTap: () {
                context.go(Uri(path: Routes.newGroup).toString());
              },
            )
          ],
        ),
        SizedBox(height: 20),
        Builder(
          builder: (context) {
            final List<Group> groups =  ref.watch(filteredGroupsProvider);
            return ListView.builder(
              shrinkWrap: true,
              itemCount: groups.length,
              prototypeItem: GroupTileWidget(group: Group.mock()),
              itemBuilder: (context, index) {
                final Group group = groups[index];
                return GroupTileWidget(group: group);
              },
            );
          },
        ),
      ],
    );
  }
}
