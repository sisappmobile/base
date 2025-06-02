import "package:base/base.dart";
import "package:flutter/material.dart";

enum BaseBodyStatus {
  loading,
  loaded,
  empty,
  fail,
}

class BaseScaffold extends Scaffold {
  final BaseBodyStatus Function()? statusBuilder;
  final RefreshCallback? onRefresh;
  final Color? bodyColor;

  const BaseScaffold({
    this.statusBuilder,
    this.onRefresh,
    this.bodyColor,
    super.appBar,
    super.body,
    super.bottomNavigationBar,
    super.floatingActionButton,
    super.floatingActionButtonLocation,
    super.key,
  });

  @override
  Color? get backgroundColor => AppColors.surfaceContainerLowest();

  @override
  Widget? get body {
    BaseBodyStatus status = BaseBodyStatus.loaded;

    if (statusBuilder != null) {
      status = statusBuilder!();
    }

    if (status == BaseBodyStatus.loaded) {
      return Container(
        color: bodyColor ?? AppColors.surface(),
        child: super.body,
      );
    } else if (status == BaseBodyStatus.fail) {
      return BaseWidgets.loadingFail(onRefresh: onRefresh);
    } else if (status == BaseBodyStatus.empty) {
      return BaseWidgets.noData(onRefresh: onRefresh);
    }

    return BaseWidgets.shimmer();
  }
}