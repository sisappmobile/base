import "package:base/base.dart";
import "package:flutter/material.dart";

enum BaseBodyStatus {
  loading,
  loaded,
  empty,
  fail,
}

class BaseScaffold extends Scaffold {
  final Widget Function() contentBuilder;
  final BaseBodyStatus Function()? statusBuilder;
  final RefreshCallback? onRefresh;
  final Color? bodyColor;

  const BaseScaffold({
    required this.contentBuilder,
    this.statusBuilder,
    this.onRefresh,
    this.bodyColor,
    super.appBar,
    super.bottomNavigationBar,
    super.floatingActionButton,
    super.floatingActionButtonLocation,
    super.key,
  });

  @override
  Color? get backgroundColor => AppColors.surfaceContainerLowest();

  @override
  Widget? get body {
    Widget containerWidget(Widget? widget) {
      return Container(
        height: double.infinity,
        color: bodyColor ?? AppColors.surface(),
        child: Material(child: widget),
      );
    }

    BaseBodyStatus status = BaseBodyStatus.loaded;

    if (statusBuilder != null) {
      status = statusBuilder!();
    }

    if (status == BaseBodyStatus.loaded) {
      return containerWidget(contentBuilder());
    } else if (status == BaseBodyStatus.fail) {
      return containerWidget(BaseWidgets.loadingFail(onRefresh: onRefresh));
    } else if (status == BaseBodyStatus.empty) {
      return containerWidget(BaseWidgets.noData(onRefresh: onRefresh));
    }

    return containerWidget(BaseWidgets.shimmer());
  }
}