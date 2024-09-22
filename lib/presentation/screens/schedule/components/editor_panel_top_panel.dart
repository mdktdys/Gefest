import 'package:flutter/material.dart';
import 'package:flutter_portal/flutter_portal.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gefest/core/api/data/data.dart';
import 'package:gefest/core/extensions.dart';
import 'package:gefest/presentation/screens/schedule/providers/schedule_provider.dart';
import 'package:gefest/theme.dart';
import 'package:get_it/get_it.dart';
import 'package:talker_flutter/talker_flutter.dart';

import '../../../shared/shared.dart';

class ScheduleEditorTopPanel extends ConsumerStatefulWidget {
  const ScheduleEditorTopPanel({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _ScheduleEditorTopPanelState();
}

class _ScheduleEditorTopPanelState
    extends ConsumerState<ScheduleEditorTopPanel> {
  TextEditingController searchController = TextEditingController(text: "");
  bool searchPanelVisible = false;

  @override
  Widget build(BuildContext context) {
    final navigationDate = ref.watch(scheduleProvider).navigationDate;

    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
          border: Border(
              bottom:
                  BorderSide(color: Theme.of(context).colorScheme.onSurface))),
      child: Column(
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Row(
              children: [
                Text(
                  "${navigationDate.weekday.toWeekName()} ${navigationDate.formatDDMMYY()}",
                  style: Fa.big,
                ),
                const SizedBox(
                  width: 10,
                ),
                SizedBox(
                    width: 38,
                    height: 38,
                    child: BaseIconButton(
                      icon: "assets/icons/arrow_left.svg",
                      onTap: () {},
                    )),
                const SizedBox(
                  width: 10,
                ),
                SizedBox(
                    width: 38,
                    height: 38,
                    child: BaseIconButton(
                        icon: "assets/icons/arrow_right.svg", onTap: () {})),
              ],
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          Row(
            children: [
              PortalTarget(
                visible: searchPanelVisible,
                anchor: const Aligned(
                    follower: Alignment.topLeft,
                    target: Alignment.bottomLeft,
                    offset: Offset(0, 15)),
                portalFollower: OutlineArea(
                  backgroundFilled: true,
                  child: Builder(builder: (context) {
                    final items = ref.watch(searchProvider);
                    return Row(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ConstrainedBox(
                          constraints: const BoxConstraints(
                              maxWidth: 350, maxHeight: 600),
                          child: ListView.separated(
                            separatorBuilder: (context, index) {
                              return Divider(
                                endIndent: 10,
                                indent: 10,
                                color: Theme.of(context).colorScheme.onSurface,
                              );
                            },
                            shrinkWrap: true,
                            itemCount: items.length,
                            itemBuilder: (context, index) {
                              final item = items[index];
                              return InkWell(
                                onTap: () {
                                  GetIt.I.get<Talker>().debug("msg");
                                  ref.read(scheduleProvider).selectItem(item, context);
                                },
                                child: Text(
                                  item.searchText,
                                  style: Fa.smedium,
                                ),
                              );
                            },
                          ),
                        ),
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                                onPressed: () {
                                  setState(() {
                                    searchPanelVisible = false;
                                  });
                                },
                                icon: const Icon(Icons.close))
                          ],
                        )
                      ],
                    );
                  }),
                ),
                child: SizedBox(
                  width: 160,
                  child: BaseTextField(
                    controller: searchController,
                    onChanged: (p0) {
                      ref.read(searchProvider.notifier).search(p0);
                    },
                    hintText: "Поиск",
                    onTap: () {
                      if (!searchPanelVisible) {
                        setState(() {
                          searchPanelVisible = true;
                        });
                      }
                    },
                  ),
                ),
              ),
              const SizedBox(
                width: 10,
              ),
            ],
          )
        ],
      ),
    );
  }
}
