import 'package:chopper/chopper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gefest/core/api/data/schedule/repository/test.dart';
import 'package:gefest/presentation/shared/outline_area.dart';
import 'package:gefest/theme.dart';
import 'package:get_it/get_it.dart';

import 'providers/test_provider.dart';

class DashBoardScreen extends ConsumerStatefulWidget {
  const DashBoardScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _DashBoardScreenState();
}

class _DashBoardScreenState extends ConsumerState<DashBoardScreen> {
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(40),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Text(
            //   "Обзор",
            //   style: Fa.big,
            // ),
            const SizedBox(
              height: 20,
            ),
            Text(
              "Инфраструктура",
              style: Fa.big,
            ),
            const SizedBox(
              height: 5,
            ),
            Builder(builder: (context) {
              return ref.watch(testProvider).when(data: (data){
                  return Column(
                          children: data!
                              .map((e) => Text(e.name))
                              .toList());
              },error: (e,o){
                return Center(child: Text(e.toString()),);
              },loading: (){
                return CircularProgressIndicator();
              });
            }),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                    child: AspectRatio(
                  aspectRatio: 1 / 1,
                  child: OutlineArea(
                      child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Telegram",
                        style: Fa.big,
                      ),
                      Text(
                        "Online",
                        style: Fa.smedium.copyWith(color: Colors.green),
                      )
                    ],
                  )),
                )),
                const SizedBox(
                  width: 20,
                ),
                Expanded(
                    child: OutlineArea(
                        child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "PostgreSQL",
                      style: Fa.big,
                    ),
                    Text(
                      "Online",
                      style: Fa.smedium.copyWith(color: Colors.green),
                    )
                  ],
                ))),
                const SizedBox(
                  width: 20,
                ),
                Expanded(
                    child: OutlineArea(
                        child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Rabbit MQ",
                      style: Fa.big,
                    ),
                    Text(
                      "Online",
                      style: Fa.smedium.copyWith(color: Colors.green),
                    )
                  ],
                ))),
                const SizedBox(
                  width: 20,
                ),
                Expanded(
                    child: OutlineArea(
                        child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Fast API",
                      style: Fa.big,
                    ),
                    Text(
                      "Online",
                      style: Fa.smedium.copyWith(color: Colors.green),
                    )
                  ],
                ))),
                const SizedBox(
                  width: 20,
                ),
                Expanded(
                    child: OutlineArea(
                        child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Redis",
                      style: Fa.big,
                    ),
                    Text(
                      "Online",
                      style: Fa.smedium.copyWith(color: Colors.green),
                    )
                  ],
                ))),
                const SizedBox(
                  width: 20,
                ),
                Expanded(
                    child: OutlineArea(
                        child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Parser",
                      style: Fa.big,
                    ),
                    Text(
                      "Online",
                      style: Fa.smedium.copyWith(color: Colors.green),
                    ),
                    Text(
                      "Последняя проверка ??:??",
                      style: Fa.smedium,
                    )
                  ],
                ))),
                const SizedBox(
                  width: 20,
                ),
                Expanded(
                    child: OutlineArea(
                        child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Supabase",
                      style: Fa.big,
                    ),
                    Text(
                      "Online",
                      style: Fa.smedium.copyWith(color: Colors.green),
                    )
                  ],
                ))),
              ],
            ),
          ],
        ));
  }

  // @override
  // Widget build(BuildContext context) {
  //   if (MediaQuery.sizeOf(context).width > 640) {
  //     return Scaffold(
  //         key: _key,
  //         backgroundColor: Theme.of(context).colorScheme.surface,
  //         body: Row(
  //           children: [
  //             SidebarX(
  //               showToggleButton: false,
  //               controller: SidebarXController(selectedIndex: 0),
  //               theme: SidebarXTheme(
  //                   selectedIconTheme: const IconThemeData(color: Ca.primary),
  //                   decoration: BoxDecoration(
  //                       color: Theme.of(context).colorScheme.surface,
  //                       border: Border(
  //                           right: BorderSide(
  //                               width: 2,
  //                               color:
  //                                   Theme.of(context).colorScheme.onSurface)))),
  //               items: [
  //                 SidebarXItem(
  //                     iconBuilder: (selected, hovered) {
  //                       return SizedBox(
  //                         width: 44,
  //                         height: 44,
  //                         child: BaseIconButton(
  //                           icon: "assets/icons/home.svg",
  //                           onTap: () {
  //                             context.go('/dashboard');
  //                           },
  //                         ),
  //                       );
  //                     },
  //                     label: 'Home'),
  //                 SidebarXItem(
  //                     iconBuilder: (selected, hovered) {
  //                       return SizedBox(
  //                         width: 44,
  //                         height: 44,
  //                         child: BaseIconButton(
  //                           icon: "assets/icons/calendar.svg",
  //                           onTap: () {
  //                             context.go('/schedule');
  //                           },
  //                         ),
  //                       );
  //                     },
  //                     label: 'Home'),
  //               ],
  //             ),
  //           ],
  //         ));
  //   } else {
  //     return Scaffold(
  //         key: _key,
  //         backgroundColor: Theme.of(context).colorScheme.surface,
  //         drawer: SidebarX(
  //           controller: controller,
  //           items: const [
  //             SidebarXItem(icon: Icons.home, label: 'Home'),
  //             SidebarXItem(icon: Icons.search, label: 'Search'),
  //           ],
  //         ),
  //         body: Column(
  //           children: [
  //             Container(
  //               height: 65,
  //               padding: const EdgeInsets.all(10),
  //               decoration: BoxDecoration(
  //                   border: Border(
  //                       bottom: BorderSide(
  //                           color: Theme.of(context).colorScheme.onSurface))),
  //               child: Row(
  //                 children: [
  //                   BaseIconButton(
  //                     icon: "assets/icons/home.svg",
  //                     onTap: () {
  //                       controller.setExtended(true);
  //                       _key.currentState!.openDrawer();
  //                     },
  //                   ),
  //                 ],
  //               ),
  //             ),
  //             const Center(
  //               child: Text("data"),
  //             )
  //           ],
  //         ));
  //   }
  // }
}
