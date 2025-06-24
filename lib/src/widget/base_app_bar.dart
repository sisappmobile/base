import "package:base/base.dart";
import "package:base/src/base_settings.dart";
import "package:basic_utils/basic_utils.dart";
import "package:easy_localization/easy_localization.dart";
import "package:flutter/material.dart";
import "package:go_router/go_router.dart";
import "package:smooth_corner/smooth_corner.dart";

class BaseAppBar extends AppBar {
  final BuildContext context;
  final String name;
  final dynamic description;
  final TextEditingController? tecSearch;
  final ValueChanged<String>? onChanged;
  final List<Widget>? trailings;

  BaseAppBar({
    required this.context,
    required this.name,
    this.description,
    this.tecSearch,
    this.onChanged,
    this.trailings,
    super.leading,
    super.shape,
    super.bottom,
    super.key,
  });

  @override
  Widget? get leading {
    bool canPop = false;

    if (BaseSettings.navigatorType == BaseNavigatorType.legacy) {
      canPop = Navigators.canPop();
    } else {
      canPop = context.canPop();
    }

    if (canPop) {
      return IconButton(
        onPressed: () {
          if (BaseSettings.navigatorType == BaseNavigatorType.legacy) {
            Navigators.pop();
          } else {
            context.pop();
          }
        },
        icon: const Icon(
          Icons.turn_left,
        ),
      );
    }

    return super.leading ?? SizedBox(width: Dimensions.size15);
  }

  @override
  double? get leadingWidth {
    if (super.leading != null || context.canPop()) {
      return null;
    }

    return Dimensions.size15;
  }

  @override
  Widget? get title {
    Widget titleWidget() {
      return Text(
        name,
        style: TextStyle(
          color: AppColors.onSurface(),
          fontSize: Dimensions.text16,
          fontWeight: FontWeight.bold,
          fontFamily: "Manrope",
        ),
      );
    }

    Widget descriptionWidget() {
      if (description != null) {
        if (description is String) {
          if (StringUtils.isNotNullOrEmpty(description)) {
            return Text(
              description!,
              style: TextStyle(
                fontSize: Dimensions.text12,
                fontWeight: FontWeight.w500,
              ),
            );
          }
        } else if (description is Widget) {
          return description;
        }
      }

      return const SizedBox.shrink();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        titleWidget(),
        descriptionWidget(),
      ],
    );
  }

  @override
  bool? get centerTitle => false;

  @override
  double? get titleSpacing => 0;

  @override
  ShapeBorder? get shape {
    return super.shape ?? Border(
      bottom: BorderSide(
        color: AppColors.outline(),
      ),
    );
  }

  @override
  Color? get backgroundColor => AppColors.surfaceContainerLowest();

  @override
  PreferredSizeWidget? get bottom {
    if (super.bottom != null) {
      return super.bottom;
    } else {
      if (tecSearch != null && onChanged != null) {
        return PreferredSize(
          preferredSize: Size.fromHeight(Dimensions.size70),
          child: Container(
            margin: EdgeInsets.fromLTRB(Dimensions.size15, 0, Dimensions.size15, Dimensions.size15),
            child: SearchBar(
              controller: tecSearch,
              shape: WidgetStatePropertyAll(
                SmoothRectangleBorder(
                  smoothness: 1,
                  borderRadius: BorderRadius.circular(Dimensions.size15),
                  side: BorderSide(color: AppColors.outline()),
                ),
              ),
              elevation: const WidgetStatePropertyAll(0),
              backgroundColor: WidgetStatePropertyAll(AppColors.surfaceContainerLow()),
              leading: const Icon(Icons.search),
              padding: WidgetStatePropertyAll(
                EdgeInsets.symmetric(
                  vertical: 0,
                  horizontal: Dimensions.size15,
                ),
              ),
              hintText: "${"search".tr()}...",
              onChanged: onChanged,
            ),
          ),
        );
      }
    }

    return null;
  }

  @override
  Size get preferredSize {
    if (tecSearch != null && onChanged != null) {
      return Size(super.preferredSize.width, super.preferredSize.height + Dimensions.size70);
    }

    return super.preferredSize;
  }

  @override
  double? get scrolledUnderElevation => 0;

  @override
  List<Widget>? get actions {
    if (trailings != null && trailings!.isNotEmpty) {
      return [
        ...trailings!,
        SizedBox(width: Dimensions.size15),
      ];
    }

    return null;
  }
}