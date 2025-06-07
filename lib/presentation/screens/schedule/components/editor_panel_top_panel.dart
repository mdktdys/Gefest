import 'dart:ui';

import 'package:flutter/material.dart';

import 'package:flutter_portal/flutter_portal.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:gefest/core/api/data/data.dart';
import 'package:gefest/core/extensions.dart';
import 'package:gefest/core/extensions/context_extension.dart';
import 'package:gefest/presentation/screens/schedule/providers/schedule_provider.dart';
import 'package:gefest/presentation/screens/schedule/providers/search_provider.dart';
import 'package:gefest/theme.dart';

import '../../../shared/shared.dart';

class ScheduleEditorTopPanel extends ConsumerStatefulWidget {
  const ScheduleEditorTopPanel({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ScheduleEditorTopPanelState();
}

class _ScheduleEditorTopPanelState extends ConsumerState<ScheduleEditorTopPanel> {
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
                  style: context.styles.ubuntu20,
                ),
                const SizedBox(width: 10),
                SizedBox(
                    width: 38,
                    height: 38,
                    child: BaseIconButton(
                      icon: "assets/icons/arrow_left.svg",
                      onTap: () {
                        ref.read(scheduleProvider).setNavigationDate(navigationDate.subtract(const Duration(days: 7)),context);
                      },
                    )),
                const SizedBox(
                  width: 10,
                ),
                SizedBox(
                    width: 38,
                    height: 38,
                    child: BaseIconButton(
                        icon: "assets/icons/arrow_right.svg",
                        onTap: () {
                          ref.read(scheduleProvider).setNavigationDate(
                              navigationDate.add(const Duration(days: 7)),
                              context);
                        })),
                const SizedBox(
                  width: 10,
                ),
                SizedBox(
                    width: 38,
                    height: 38,
                    child: BaseIconButton(
                        icon: "assets/icons/refresh.svg",
                        onTap: () {
                          ref.read(scheduleProvider).setNavigationDate(
                              navigationDate.add(const Duration(days: 0)),
                              context);
                        })),
                const SizedBox(
                  width: 10,
                ),
                // SizedBox(
                //     width: 38,
                //     height: 38,
                //     child: BaseIconButton(
                //         icon: "assets/icons/refresh.svg",
                //         onTap: () {
                //           ref.read(scheduleProvider).setNavigationDate(
                //               navigationDate.add(const Duration(days: 0)),
                //               context);
                //         })),
                // const SizedBox(
                //   width: 10,
                // ),
                // BaseOutlinedButton(
                //   color: const Color.fromARGB(255, 143, 39, 32),
                //   width: 100,
                //   text: "Вид",
                //   onTap: () {
                //     ref.read(scheduleProvider).switchView();
                //   },
                // )
              ],
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          Row(
            children: [
              PortalTarget(
                visible: ref.watch(searchPanelProvider).searchPanelVisible,
                anchor: const Aligned(
                  follower: Alignment.topLeft,
                  target: Alignment.bottomLeft,
                  offset: Offset(0, 15)
                ),
                portalFollower: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 1, sigmaY: 1),
                  child: const SearchFlyoutPanel()
                ),
                child: SizedBox(
                  width: 160,
                  child: BaseTextField(
                    controller: searchController,
                    onChanged: (p0) {
                      ref.read(searchProvider.notifier).search(p0);
                    },
                    onTapOutside: (p0) {
                      FocusManager.instance.primaryFocus?.unfocus();
                      ref.watch(searchPanelProvider).closePanel();
                    },
                    hintText: "Поиск",
                    onTap: () {
                      if (!searchPanelVisible) {
                        ref.read(searchPanelProvider).openPanel();
                      }
                    },
                  ),
                ),
              ),
              const SizedBox(width: 10),
            ],
          )
        ],
      ),
    );
  }
}

class SearchFlyoutPanel extends ConsumerStatefulWidget {
  const SearchFlyoutPanel({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _SearchFlyoutPanelState();
}

class _SearchFlyoutPanelState extends ConsumerState<SearchFlyoutPanel> {
  @override
  Widget build(BuildContext context) {
    return OutlineArea(
      backgroundFilled: true,
      boxShadow: [
        BoxShadow(color: Theme.of(context).colorScheme.primary, blurRadius: 2),
      ],
      child: Builder(builder: (context) {
        final items = ref.watch(searchProvider);
        return ref.watch(searchItemsProvider).when(
          data: (data) {
            return Row(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AnimatedSize(
                  alignment: Alignment.topCenter,
                  duration: const Duration(milliseconds: 300),
                  child: ConstrainedBox(
                    constraints:
                        const BoxConstraints(maxWidth: 350, maxHeight: 600),
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
                        return Material(
                          color: Theme.of(context).colorScheme.surface,
                          clipBehavior: Clip.antiAlias,
                          borderRadius: BorderRadius.circular(10),
                          child: InkWell(
                              hoverColor:
                                  Theme.of(context).colorScheme.onSurface,
                              onTap: () {
                                FocusManager.instance.primaryFocus?.unfocus();
                                ref
                                    .read(scheduleProvider)
                                    .selectItem(item, context);
                                ref.read(searchPanelProvider).closePanel();
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  item.searchText,
                                  style: Fa.smedium,
                                ),
                              )),
                        );
                      },
                    ),
                  ),
                ),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                        onPressed: () {
                          ref.read(searchPanelProvider).closePanel();
                        },
                        icon: const Icon(Icons.close))
                  ],
                )
              ],
            );
          },
          error: (e, o) {
            return Center(
              child: Text("Ошибка ${e.toString()} ${o.toString()}"),
            );
          },
          loading: () {
            return const Center(
              child: CircularProgressIndicator(),
            );
          },
        );
      }),
    );
  }
}
