import "package:base/src/app_colors.dart";
import "package:base/src/base_app_bar.dart";
import "package:base/src/dimensions.dart";
import "package:base/src/navigators.dart";
import "package:flutter/material.dart";
import "package:get/get.dart";
import "package:smooth_corner/smooth_corner.dart";

class BaseSideSheet {
  static Future<dynamic> left({
    required Widget body,
    String? title,
    double? width,
  }) async {
    return _showSideSheet(
      title: title,
      body: body,
      width: width,
      rightSide: false,
    );
  }

  static Future<dynamic> right({
    required Widget body,
    String? title,
    double? width,
  }) async {
    return _showSideSheet(
      title: title,
      body: body,
      width: width,
      rightSide: true,
    );
  }

  static Future<dynamic> leftFlow({
    required Widget initialBody,
    double? width,
  }) async {
    return _showSideSheetFlow(
      initialBody: initialBody,
      width: width,
      rightSide: false,
    );
  }

  static Future<dynamic> rightFlow({
    required Widget initialBody,
    double? width,
  }) async {
    if (Navigators.sideSheetNavigatorState.currentContext != null) {
      return Navigators.push(
        initialBody,
        context: Navigators.sideSheetNavigatorState.currentContext!,
      );
    } else {
      return _showSideSheetFlow(
        initialBody: initialBody,
        width: width,
        rightSide: true,
      );
    }
  }

  static Future<dynamic> _showSideSheet({
    required Widget body,
    required bool rightSide,
    String? title,
    double? width,
  }) async {
    if (Get.context != null) {
      return showGeneralDialog(
        barrierLabel: body.runtimeType.toString(),
        barrierDismissible: true,
        transitionDuration: const Duration(milliseconds: 300),
        context: Get.context!,
        pageBuilder: (context, animation1, animation2) {
          return SafeArea(
            child: Align(
              alignment: (rightSide ? Alignment.centerRight : Alignment.centerLeft),
              child: Container(
                margin: Dimensions.isMobile() ? EdgeInsets.zero : EdgeInsets.all(Dimensions.size15),
                child: SmoothClipRRect(
                  smoothness: 1,
                  borderRadius: Dimensions.isMobile() ? BorderRadius.zero : BorderRadius.circular(Dimensions.size20),
                  side: Dimensions.isMobile() ? BorderSide.none : BorderSide(color: AppColors.outline()),
                  child: SizedBox(
                    height: double.infinity,
                    width: Dimensions.isMobile() ? null : (width ?? Dimensions.size100 * 4),
                    child: SafeArea(
                      child: Scaffold(
                        body: Column(
                          children: [
                            BaseAppBar(title: title ?? ""),
                            Expanded(child: body),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );
        },
        transitionBuilder: (context, animation1, animation2, child) {
          return SlideTransition(
            position: Tween(
              begin: Offset((rightSide ? 1 : -1), 0),
              end: const Offset(0, 0),
            ).animate(animation1),
            child: child,
          );
        },
      );
    }
  }

  static Future<dynamic> _showSideSheetFlow({
    required Widget initialBody,
    required bool rightSide,
    double? width,
  }) async {
    if (Get.context != null) {
      return await showGeneralDialog(
        barrierLabel: initialBody.runtimeType.toString(),
        barrierDismissible: true,
        transitionDuration: const Duration(milliseconds: 300),
        context: Get.context!,
        pageBuilder: (context, animation1, animation2) {
          return SafeArea(
            child: Align(
              alignment: Alignment.centerRight,
              child: Container(
                margin: Dimensions.isMobile() ? EdgeInsets.zero : EdgeInsets.symmetric(
                  vertical: Dimensions.size20,
                  horizontal: Dimensions.size10,
                ),
                child: SmoothClipRRect(
                  smoothness: 1,
                  borderRadius: Dimensions.isMobile() ? BorderRadius.zero : BorderRadius.circular(Dimensions.size20),
                  side: Dimensions.isMobile() ? BorderSide.none : BorderSide(color: AppColors.outline()),
                  child: SizedBox(
                    height: double.infinity,
                    width: Dimensions.isMobile() ? null : (width ?? Dimensions.size100 * 4),
                    child: Navigator(
                      key: Navigators.sideSheetNavigatorState,
                      initialRoute: "/",
                      onGenerateRoute: (settings) {
                        if (settings.name == "/") {
                          return MaterialPageRoute(
                            builder: (context) {
                              return initialBody;
                            },
                          );
                        }

                        return null;
                      },
                    ),
                  ),
                ),
              ),
            ),
          );
        },
        transitionBuilder: (context, animation1, animation2, child) {
          return SlideTransition(
            position: Tween(
              begin: const Offset(1, 0),
              end: const Offset(0, 0),
            ).animate(animation1),
            child: child,
          );
        },
      );
    }
  }
}