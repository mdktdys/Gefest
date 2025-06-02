
import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:gefest/configs/images.dart';
import 'package:gefest/theme.dart';

import '../../core/api/api.dart';

import 'shared.dart';

class BaseTextFieldSelector extends ConsumerStatefulWidget {
  final Function? itemSelected;
  final List<SearchItem> items;
  final String? hint;
  final String? header;
  final SearchItem? initial;
  const BaseTextFieldSelector(
      {super.key,
      this.hint,
      this.itemSelected,
      this.initial,
      required this.items,
      this.header});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _BaseTextFieldSelectorState();
}

class _BaseTextFieldSelectorState extends ConsumerState<BaseTextFieldSelector> {
  SearchItem? choosed;
  TextEditingController controller = TextEditingController();
  List<SearchItem> filtered = [];
  bool fieldActivated = false;
  bool fieldLocked = false;

  @override
  void initState() {
    super.initState();
    filtered = widget.items;
    choosed = widget.initial;

    if (choosed != null) {
      controller.text = choosed!.searchText;
      fieldLocked = true;
    }
  }

  _filterSearch(text) {
    setState(() {
      filtered = widget.items.where((x) => x.searchText.toLowerCase().contains(text)).toList();
    });
  }

  _onSelect(SearchItem item) {
    setState(() {
      choosed = item;
      controller.text = item.searchText;
      fieldLocked = true;
      widget.itemSelected?.call(choosed);
    });
  }

  _clearField() {
    setState(() {
      choosed = null;
      fieldActivated = false;
      filtered = widget.items;
      controller.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Expanded(
              child: BaseTextField(
                locked: choosed != null ? true : false,
                onTap: () {
                  if (!fieldActivated && choosed == null) {
                    setState(() {
                      fieldActivated = true;
                    });
                  }
                },
                onChanged: (p0) => _filterSearch(p0.toLowerCase()),
                controller: controller,
                header: widget.header,
                hintText: widget.hint,
              ),
            ),
            const SizedBox(width: 5),
            SizedBox(
              width: 48,
              height: 48,
              child: BaseIconButton(
                icon: Images.trash,
                iconColor: Theme.of(context).colorScheme.onSurface,
                onTap: () {
                  _clearField();
                },
              ),
            )
          ],
        ),
        const SizedBox(height: 5),
        AnimatedSize(
            alignment: Alignment.topCenter,
            duration: const Duration(milliseconds: 300),
            child: (choosed == null && fieldActivated)
                ? ConstrainedBox(
                    constraints: const BoxConstraints(maxHeight: 600),
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Colors.black.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(10)
                      ),
                      child: filtered.isEmpty
                        ? SizedBox(
                            width: double.infinity,
                            child: Text(
                              "Ничего не найдено",
                              textAlign: TextAlign.center,
                              style: Fa.smedium,
                            ),
                          )
                        : ListView.separated(
                            separatorBuilder: (context, index) {
                              return Divider(
                                color: Theme.of(context).colorScheme.surface,
                                indent: 10,
                                endIndent: 10,
                              );
                            },
                            shrinkWrap: true,
                            itemCount: filtered.length,
                            itemBuilder: (context, index) {
                              final item = filtered[index];
                              return Material(
                                color: Theme.of(context).colorScheme.surface,
                                clipBehavior: Clip.antiAlias,
                                borderRadius: BorderRadius.circular(10),
                                child: InkWell(
                                  hoverColor: Theme.of(context)
                                      .colorScheme
                                      .surfaceContainerHigh,
                                  onTap: () {
                                    _onSelect(item);
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      item.searchText,
                                      style: Fa.smedium,
                                    ),
                                  )
                                ),
                              );
                            },
                          ),
                    ),
                  )
                : const SizedBox.shrink())
      ],
    );
  }
}
