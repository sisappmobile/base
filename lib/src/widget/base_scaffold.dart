import "package:base/base.dart";
import "package:flutter/material.dart";
import "package:flutter/services.dart";

enum BaseBodyStatus {
  loading,
  loaded,
  empty,
  fail,
}

class BaseScaffold extends Scaffold {
  final BuildContext context;
  final Widget Function() contentBuilder;
  final BaseBodyStatus Function()? statusBuilder;
  final RefreshCallback? onRefresh;
  final Color? bodyColor;
  final Brightness? statusBarIconBrightness;
  final Brightness? systemNavigationBarIconBrightness;

  const BaseScaffold({
    required this.context,
    required this.contentBuilder,
    this.statusBuilder,
    this.onRefresh,
    this.bodyColor,
    this.statusBarIconBrightness,
    this.systemNavigationBarIconBrightness,
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
      return AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle(
            statusBarIconBrightness: statusBarIconBrightness,
            systemNavigationBarIconBrightness: systemNavigationBarIconBrightness,
        ),
        child: Container(
          height: double.infinity,
          color: bodyColor ?? AppColors.surface(),
          padding: MediaQuery.of(context).viewPadding,
          child: Material(child: widget),
        ),
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