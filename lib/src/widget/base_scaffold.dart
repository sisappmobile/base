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

// PENTING (performa): dulu kelas ini extends Scaffold dan meng-override `body`
// sebagai getter yang memanggil contentBuilder(). ScaffoldState rebuild pada
// setiap perubahan viewInsets (setiap frame animasi keyboard), sehingga getter
// tersebut membangun ulang seluruh pohon widget halaman per frame. Sekarang
// body dibangun sekali di build() dan diberikan ke Scaffold sebagai instance
// widget yang stabil, sehingga rebuild internal Scaffold tidak menyentuh isi
// halaman.
class BaseScaffold extends StatelessWidget {
  final BuildContext context;
  final Widget Function() contentBuilder;
  final BaseBodyStatus Function()? statusBuilder;
  final RefreshCallback? onRefresh;
  final BaseInset? top;
  final BaseInset? bottom;
  final PreferredSizeWidget? appBar;
  final Widget? bottomNavigationBar;
  final Widget? floatingActionButton;
  final FloatingActionButtonLocation? floatingActionButtonLocation;
  final Color? backgroundColor;
  final bool? resizeToAvoidBottomInset;

  const BaseScaffold({
    required this.context,
    required this.contentBuilder,
    this.statusBuilder,
    this.onRefresh,
    this.top,
    this.bottom,
    this.appBar,
    this.bottomNavigationBar,
    this.floatingActionButton,
    this.floatingActionButtonLocation,
    this.backgroundColor,
    this.resizeToAvoidBottomInset,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    Color resolvedBackgroundColor = backgroundColor ?? AppColors.surface();

    BaseBodyStatus status = statusBuilder?.call() ?? BaseBodyStatus.loaded;

    Widget content;

    if (status == BaseBodyStatus.loaded) {
      content = contentBuilder();
    } else if (status == BaseBodyStatus.fail) {
      content = BaseWidgets.loadingFail(onRefresh: onRefresh);
    } else if (status == BaseBodyStatus.empty) {
      content = BaseWidgets.noData(onRefresh: onRefresh);
    } else {
      content = BaseWidgets.shimmer();
    }

    return Scaffold(
      appBar: appBar,
      bottomNavigationBar: bottomNavigationBar,
      floatingActionButton: floatingActionButton,
      floatingActionButtonLocation: floatingActionButtonLocation,
      backgroundColor: resolvedBackgroundColor,
      resizeToAvoidBottomInset: resizeToAvoidBottomInset,
      body: _BaseScaffoldBody(
        top: top,
        bottom: bottom,
        backgroundColor: resolvedBackgroundColor,
        child: content,
      ),
    );
  }
}

// Strip pewarna status bar / navigation bar. Dependensi MediaQuery didaftarkan
// di sini (bukan di context halaman) dan hanya pada aspek padding, sehingga
// perubahan viewInsets saat keyboard beranimasi tidak me-rebuild halaman.
// `child` diterima sebagai instance jadi; saat widget ini rebuild karena
// padding berubah, subtree child yang identik akan dilewati oleh framework.
class _BaseScaffoldBody extends StatelessWidget {
  final BaseInset? top;
  final BaseInset? bottom;
  final Color backgroundColor;
  final Widget child;

  const _BaseScaffoldBody({
    required this.top,
    required this.bottom,
    required this.backgroundColor,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    Widget topWidget() {
      if (top != null) {
        return Container(
          height: MediaQuery.paddingOf(context).top,
          color: top!.color,
        );
      }

      return const SizedBox.shrink();
    }

    Widget bottomWidget() {
      if (bottom != null) {
        return Container(
          height: MediaQuery.paddingOf(context).bottom,
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
          Expanded(
            child: Material(
              color: backgroundColor,
              child: child,
            ),
          ),
          bottomWidget(),
        ],
      ),
    );
  }
}
