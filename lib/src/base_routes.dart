import "package:base/src/page/base_spinner_page.dart";
import "package:go_router/go_router.dart";

enum BaseRoute {
  spinner("/spinner");

  final String path;

  const BaseRoute(this.path);
}

final List<GoRoute> baseRoutes = [
  GoRoute(
    path: BaseRoute.spinner.path,
    builder: (context, state) {
      Map<String, dynamic> extra = state.extra as Map<String, dynamic>;

      return BaseSpinnerPage(
        title: extra["title"],
        spinnerItems: extra["spinnerItems"],
      );
    },
  ),
];