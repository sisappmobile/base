// ignore_for_file: always_specify_types, use_build_context_synchronously

import "package:base/base.dart";
import "package:flutter/material.dart";
import "package:go_router/go_router.dart";

class SpinnerItem {
  final dynamic identity;
  final String description;
  final String? selectedDescription;
  final dynamic tag;
  bool selected;

  SpinnerItem({
    required this.identity,
    required this.description,
    this.selectedDescription,
    this.tag,
    this.selected = false,
  });
}

class BaseSpinnerPage extends StatefulWidget {
  final String title;
  final List<SpinnerItem> spinnerItems;
  final Widget Function(SpinnerItem spinnerItem)? customItemWidget;
  final Widget? separatorWidget;
  final EdgeInsets? padding;

  const BaseSpinnerPage({
    required this.title,
    required this.spinnerItems,
    this.customItemWidget,
    this.separatorWidget,
    this.padding,
    super.key,
  });

  @override
  BaseSpinnerPageState createState() => BaseSpinnerPageState();
}

class BaseSpinnerPageState extends State<BaseSpinnerPage> with WidgetsBindingObserver {
  TextEditingController tecSearch = TextEditingController();

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addObserver(this);
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
      ),
      contentBuilder: body,
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

  Iterable<SpinnerItem> filteredItems() {
    return widget.spinnerItems.where((element) => element.description.toLowerCase().contains(tecSearch.text.toLowerCase()));
  }

  Widget body() {
    Iterable<SpinnerItem> spinnerItems = filteredItems();

    return ListView.separated(
      padding: widget.padding,
      itemCount: spinnerItems.length,
      itemBuilder: (BuildContext context, int index) {
        SpinnerItem spinnerItem = spinnerItems.elementAt(index);

        if (widget.customItemWidget != null) {
          return widget.customItemWidget!(spinnerItem);
        } else {
          return ListTile(
            onTap: () {
              context.pop(spinnerItem);
            },
            title: Text(
              spinnerItem.description,
              style: TextStyle(
                color: spinnerItem.selected ? AppColors.primary() : AppColors.onSurface(),
                fontWeight: spinnerItem.selected ? FontWeight.bold : FontWeight.normal,
              ),
            ),
          );
        }
      },
      separatorBuilder: (BuildContext context, int index) {
        return widget.separatorWidget ?? const Divider(height: 0);
      },
    );
  }

}
