import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gefest/theme.dart';
import 'package:sidebarx/sidebarx.dart';

class DashBoardScreen extends ConsumerStatefulWidget {
  const DashBoardScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _DashBoardScreenState();
}

class _DashBoardScreenState extends ConsumerState<DashBoardScreen> {
  final SidebarXController controller =
      SidebarXController(selectedIndex: 0, extended: false);
  final GlobalKey<ScaffoldState> _key = GlobalKey();
  @override
  Widget build(BuildContext context) {
    if (MediaQuery.sizeOf(context).width > 640) {
      return Scaffold(
          key: _key,
          backgroundColor: Theme.of(context).colorScheme.surface,
          body: Row(
            children: [
              SidebarX(
                controller: SidebarXController(selectedIndex: 0),
                theme: SidebarXTheme(
                    selectedIconTheme: const IconThemeData(color: Ca.primary),
                    decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.surface,
                        border: Border(
                            right: BorderSide(
                                width: 2,
                                color:
                                    Theme.of(context).colorScheme.onSurface)))),
                items: [
                  SidebarXItem(
                      iconBuilder: (selected, hovered) {
                        return SvgPicture.asset(
                          "assets/icons/home.svg",
                          color: Colors.white,
                          width: 24,
                          height: 24,
                        );
                      },
                      label: 'Home'),
                  const SidebarXItem(icon: Icons.search, label: 'Search'),
                ],
              ),
              // Your app screen body
            ],
          ));
    } else {
      return Scaffold(
          key: _key,
          backgroundColor: Theme.of(context).colorScheme.surface,
          drawer: SidebarX(
            controller: controller,
            items: const [
              SidebarXItem(icon: Icons.home, label: 'Home'),
              SidebarXItem(icon: Icons.search, label: 'Search'),
            ],
          ),
          body: Column(
            children: [
              Container(
                height: 60,
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                    border: Border(
                        bottom: BorderSide(
                            color: Theme.of(context).colorScheme.onSurface))),
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        controller.setExtended(true);
                        _key.currentState!.openDrawer();
                      },
                      child: SvgPicture.asset(
                        "assets/icons/home.svg",
                        color: Colors.white,
                        width: 24,
                        height: 24,
                      ),
                    ),
                  ],
                ),
              ),
              const Center(
                child: Text("data"),
              )
            ],
          ));
    }
  }
}
