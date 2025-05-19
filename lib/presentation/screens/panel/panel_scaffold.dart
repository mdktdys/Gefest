// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:developer';

import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:sidebarx/sidebarx.dart';

import 'package:gefest/presentation/shared/theme_button.dart';
import 'package:gefest/theme.dart';

import '../../shared/shared.dart';

class PanelScaffold extends ConsumerStatefulWidget {
  final Widget child;
  const PanelScaffold({super.key, required this.child});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _PanelScaffoldState();
}

class _PanelScaffoldState extends ConsumerState<PanelScaffold> {
  final SidebarXController controller = SidebarXController(selectedIndex: 0, extended: false);
  final GlobalKey<ScaffoldState> _key = GlobalKey();

  @override
  void dispose() {
    controller.dispose();  
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (MediaQuery.sizeOf(context).width > 640) {
      return Scaffold(
          key: _key,
          body: Row(
            children: [
              SidebarX(
                showToggleButton: false,
                controller: controller,
                theme: SidebarXTheme(
                    selectedIconTheme: const IconThemeData(color: Ca.primary),
                    decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.surface,
                        border: Border(
                            right: BorderSide(
                                width: 2,
                                color:
                                    Theme.of(context).colorScheme.onSurface)))),
                items: _buildItems(context),
                footerItems: [
                  SidebarXItem(
                      iconBuilder: (selected, hovered) {
                        return SizedBox(
                            width: 44,
                            height: 44,
                            child: ThemeButton(
                              color: Theme.of(context).colorScheme.onSurface,
                            ));
                      },
                      label: 'Theme'),
                ],
              ),
              Expanded(child: widget.child)
            ],
          ));
    } else {
      return Scaffold(
          key: _key,
          drawer: SidebarX(
            theme: SidebarXTheme(
                    selectedIconTheme: const IconThemeData(color: Ca.primary),
                    decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.surface,
                        border: Border(
                            right: BorderSide(
                                width: 2,
                                color:
                                    Theme.of(context).colorScheme.onSurface)))),
            controller: controller,
            items: _buildItems(context)
          ),
          body: Column(
            children: [
              Container(
                height: 65,
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                    border: Border(
                        bottom: BorderSide(
                            color: Theme.of(context).colorScheme.onSurface))),
                child: Row(
                  children: [
                    BaseIconButton(
                      icon: "assets/icons/home.svg",
                      onTap: () {
                        controller.setExtended(false);
                        _key.currentState!.openDrawer();
                      },
                    ),
                    SizedBox(width: 5),
                    Expanded(child: Text(GoRouter.of(context).routeInformationProvider.value.uri.toString()))
                  ],
                ),
              ),
              Expanded(child: widget.child)
            ],
          ));
    }
  }


  List<SidebarXItem> _buildItems(BuildContext context) {
    final items = [
      ("assets/icons/home.svg","/dashboard","Home"),
      ("assets/icons/calendar.svg","/schedule","Home"),
      ("assets/icons/persons.svg","/teachers","teachers"),
      ("assets/icons/persons.svg","/groups","groups"),
      ("assets/icons/persons.svg","/load","load"),
      ("assets/icons/settings.svg", '/settings', 'settings')
    ];
    return items.map((item){
      return SidebarXItem(
        iconBuilder: (_, __) {
          bool selected = GoRouter.of(context).routeInformationProvider.value.uri.toString() == item.$2; 
          return SizedBox(
            width: 44,
            height: 44,
            child: BaseIconButton(
              icon: item.$1,
              color: selected
                  ? Theme.of(context).colorScheme.primary
                  : Theme.of(context).colorScheme.onSurface,
              onTap: () {
                controller.selectIndex(0);
                context.go(item.$2);
                _key.currentState!.closeDrawer();
              },
            ),
          );
        },
      label: item.$3);
    }).toList();
  }
}