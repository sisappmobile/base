// ignore_for_file: always_specify_types, use_build_context_synchronously

import "package:base/base.dart";
import "package:base/src/base_settings.dart";
import "package:easy_localization/easy_localization.dart";
import "package:flutter/material.dart";
import "package:go_router/go_router.dart";

class CheckableItem {
  final dynamic identity;
  final String description;
  final String? selectedDescription;
  final dynamic tag;
  bool selected;

  CheckableItem({
    required this.identity,
    required this.description,
    this.selectedDescription,
    this.tag,
    this.selected = false,
  });
}

class BaseCheckablePage extends StatefulWidget {
  final String title;
  final List<CheckableItem> checkableItems;

  const BaseCheckablePage({
    required this.title,
    required this.checkableItems,
    super.key,
  });

  @override
  BaseCheckablePageState createState() => BaseCheckablePageState();
}

class BaseCheckablePageState extends State<BaseCheckablePage> with WidgetsBindingObserver {
  TextEditingController tecSearch = TextEditingController();

  bool selectedAll = false;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addObserver(this);

    selectedAll = !widget.checkableItems.any((element) => !element.selected);
  }

  @override
  Widget build(BuildContext context) {
    Theme.of(context);

    return BaseScaffold(
      context: context,
      appBar: BaseAppBar(
        context: context,
        name: widget.title,
        tecSearch: tecSearch,
        onChanged: (value) {
          setState(() {});
        },
        trailings: [
          BaseWidgets.check(
            label: "select_all".tr(),
            value: selectedAll,
            readonly: false,
            onChanged: (value) {
              selectedAll = !selectedAll;

              for (CheckableItem checkableItem in widget.checkableItems) {
                checkableItem.selected = selectedAll;
              }

              setState(() {});
            },
          ),
        ],
      ),
      contentBuilder: body,
      bottomNavigationBar: bottomBar(),
    );
  }

  @override
  void dispose() {
    super.dispose();

    WidgetsBinding.instance.removeObserver(this);
  }

  @override
  void didChangePlatformBrightness() {
    super.didChangePlatformBrightness();

    setState(() {});
  }

  Iterable<CheckableItem> filteredItems() {
    return widget.checkableItems.where((element) => element.description.toLowerCase().contains(tecSearch.text.toLowerCase()));
  }

  Widget body() {
    Iterable<CheckableItem> checkableItems = filteredItems();

    return ListView.separated(
      itemCount: checkableItems.length,
      itemBuilder: (BuildContext context, int index) {
        CheckableItem checkableItem = checkableItems.elementAt(index);

        return CheckboxListTile(
          value: checkableItem.selected,
          onChanged: (value) {
            setState(() {
              checkableItem.selected = value ?? false;
            });
          },
          title: Text(
            checkableItem.description,
            style: TextStyle(
              color: checkableItem.selected ? AppColors.primary() : AppColors.onSurface(),
              fontWeight: checkableItem.selected ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        );
      },
      separatorBuilder: (BuildContext context, int index) {
        return const Divider(
          height: 0,
        );
      },
    );
  }

  Widget bottomBar() {
    return BaseBottomBar(
      children: [
        FilledButton(
          onPressed: () async {
            if (BaseSettings.navigatorType == BaseNavigatorType.legacy) {
              Navigators.pop(result: widget.checkableItems.where((element) => element.selected).toList());
            } else {
              context.pop(widget.checkableItems.where((element) => element.selected).toList());
            }
          },
          child: Text("apply".tr()),
        ),
      ],
    );
  }
}
