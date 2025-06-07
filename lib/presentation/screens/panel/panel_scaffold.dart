import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:sidebarx/sidebarx.dart';

import 'package:gefest/configs/images.dart';
import 'package:gefest/core/extensions/context_extension.dart';
import 'package:gefest/presentation/shared/base_icon_button.dart';
import 'package:gefest/theme.dart';
import 'package:gefest/theme/spacing.dart';

class CustomSideBarX extends StatelessWidget {
  final SidebarXController controller;
  final List<SidebarXItem> items;
  final bool showToggleButton;

  const CustomSideBarX({
    required this.controller,
    required this.items,
    this.showToggleButton = true,
    super.key
  });

  @override
  Widget build(BuildContext context) {
    return SidebarX(
      showToggleButton: showToggleButton,
      controller: controller,
      items: items,
      theme: SidebarXTheme(
        selectedIconTheme: const IconThemeData(color: Ca.primary),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
          border: Border(right: BorderSide(width: 2, color: Theme.of(context).colorScheme.outlineVariant))
        )
      ),
    );
  }
}

class PanelScaffold extends ConsumerStatefulWidget {
  final Widget child;

  const PanelScaffold({
    required this.child,
    super.key,
  });

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
              CustomSideBarX(
                showToggleButton: false,
                controller: controller,
                items: _buildItems(context),
              ),
              Expanded(
                child: Column(
                  children: [
                    Container(
                      height: 60,
                      padding: EdgeInsets.all(Spacing.list),
                      decoration: BoxDecoration(
                        border: Border(bottom: BorderSide(color: Theme.of(context).colorScheme.outlineVariant))
                      ),
                      child: Row(
                        spacing: Spacing.list,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            'Уразаева А.A.',
                            style: context.styles.ubuntu14,
                          ),
                          CircleAvatar(
                            foregroundImage: NetworkImage('https://ojbsikxdqcbuvamygezd.supabase.co/storage/v1/object/sign/zamenas/photo_2025-05-23_21-30-46.jpg?token=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCIsImtpZCI6InN0b3JhZ2UtdXJsLXNpZ25pbmcta2V5XzE2ODE2ZWUyLWFjZWUtNDI1NS1iYjU0LTFlOWY3ZWIxMDViZCJ9.eyJ1cmwiOiJ6YW1lbmFzL3Bob3RvXzIwMjUtMDUtMjNfMjEtMzAtNDYuanBnIiwiaWF0IjoxNzQ4MDE3ODY2LCJleHAiOjE3Nzk1NTM4NjZ9.YrePuzVZitpgUU48C2tC4uu9GAtVPy6SDJDPqgCHDII'),
                          )
                        ],
                      )
                    ),
                    Expanded(child: widget.child),
                  ],
                ),
              )
            ],
          )
        );
    } else {
      return Scaffold(
        key: _key,
        drawer: CustomSideBarX(
          controller: controller,
          items: _buildItems(context)
        ),
        body: Column(
          children: [
            Container(
              height: 65,
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(border: Border(bottom: BorderSide(color: Theme.of(context).colorScheme.outlineVariant))),
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
        )
      );
    }
  }


  List<SidebarXItem> _buildItems(BuildContext context) {
    final items = [
      ("assets/icons/home.svg","/dashboard","Home"),
      ("assets/icons/calendar.svg","/schedule","Home"),
      (Images.teacher,"/teachers","teachers"),
      ("assets/icons/persons.svg","/groups","groups"),
      ("assets/icons/cabinets.svg","/cabinets","cabinets"),
      // ("assets/icons/persons.svg","/load","load"),
      ("assets/icons/settings.svg", '/settings', 'settings')
    ];

    return items.map((item){
      return SidebarXItem(
        iconBuilder: (selected, hovered) {
          bool selected = GoRouter.of(context).routeInformationProvider.value.uri.toString() == item.$2;
          return SizedBox(
            width: 44,
            height: 44,
            child: BaseIconButton(
              icon: item.$1,
              iconColor: selected
                ? Theme.of(context).colorScheme.primary
                : Theme.of(context).colorScheme.primary.withAlpha(100),
              onTap: () {
                controller.selectIndex(items.indexOf(item));
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