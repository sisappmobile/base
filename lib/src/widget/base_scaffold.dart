import "package:base/base.dart";
import "package:flutter/material.dart";
import "package:flutter/services.dart";

enum BaseBodyStatus {
  loading,
  loaded,
  empty,
  fail,
}

class BaseInset {
  final Brightness brightness;
  final Color color;

  BaseInset({
    required this.brightness,
    required this.color,
  });
}

class BaseScaffold extends Scaffold {
  final BuildContext context;
  final Widget Function() contentBuilder;
  final BaseBodyStatus Function()? statusBuilder;
  final RefreshCallback? onRefresh;
  final BaseInset? top;
  final BaseInset? bottom;

  const BaseScaffold({
    required this.context,
    required this.contentBuilder,
    this.statusBuilder,
    this.onRefresh,
    this.top,
    this.bottom,
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
      Widget topWidget() {
        if (top != null) {
          return Container(
            height: MediaQuery.of(context).padding.top,
            color: top!.color,
          );
        }

        return const SizedBox.shrink();
      }

      Widget bottomWidget() {
        if (bottom != null) {
          return Container(
            height: MediaQuery.of(context).padding.bottom,
            color: bottom!.color,
          );
        }

        return const SizedBox.shrink();
      }

      return AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle(
          statusBarIconBrightness: top?.brightness,
          systemNavigationBarIconBrightness: bottom?.brightness,
        ),
        child: Column(
          children: [
            topWidget(),
            Expanded(child: Material(child: widget)),
            bottomWidget(),
          ],
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