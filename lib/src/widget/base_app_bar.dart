import "package:base/base.dart";
import "package:basic_utils/basic_utils.dart";
import "package:easy_localization/easy_localization.dart";
import "package:flutter/material.dart";
import "package:go_router/go_router.dart";
import "package:smooth_corner/smooth_corner.dart";

class SearchOption {
  final TextEditingController controller;
  final ValueChanged<String> onChanged;

  SearchOption({
    required this.controller,
    required this.onChanged,
  });
}

class BaseAppBar extends AppBar {
  final BuildContext context;
  final String name;
  final dynamic description;
  final SearchOption? searchOption;
  final List<Widget>? trailings;
  final Color? borderColor;

  BaseAppBar({
    required this.context,
    required this.name,
    this.description,
    this.searchOption,
    this.trailings,
    this.borderColor,
    super.leading,
    super.shape,
    super.bottom,
    super.primary,
    super.backgroundColor,
    super.foregroundColor,
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
    bool canPop = false;

    if (BaseSettings.navigatorType == BaseNavigatorType.legacy) {
      canPop = Navigators.canPop();
    } else {
      canPop = context.canPop();
    }

    if (super.leading != null || canPop) {
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
          color: foregroundColor,
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
        color: borderColor ?? AppColors.outline(),
      ),
    );
  }

  @override
  Color? get backgroundColor => super.backgroundColor ?? AppColors.surfaceContainerLowest();

  @override
  PreferredSizeWidget? get bottom {
    if (super.bottom != null) {
      return super.bottom;
    } else {
      if (searchOption != null) {
        return PreferredSize(
          preferredSize: Size.fromHeight(Dimensions.size50),
          child: Container(
            height: Dimensions.size50,
            margin: EdgeInsets.fromLTRB(Dimensions.size15, 0, Dimensions.size15, Dimensions.size15),
            child: SearchBar(
              controller: searchOption!.controller,
              shape: WidgetStatePropertyAll(
                SmoothRectangleBorder(
                  smoothness: 1,
                  borderRadius: BorderRadius.circular(Dimensions.size15),
                  side: BorderSide(color: borderColor ?? AppColors.outline()),
                ),
              ),
              elevation: const WidgetStatePropertyAll(0),
              backgroundColor: WidgetStatePropertyAll(backgroundColor),
              leading: const Icon(Icons.search),
              padding: WidgetStatePropertyAll(
                EdgeInsets.symmetric(
                  vertical: 0,
                  horizontal: Dimensions.size15,
                ),
              ),
              hintText: "${"search".tr()}...",
              onChanged: searchOption!.onChanged,
            ),
          ),
        );
      }
    }

    return null;
  }

  @override
  Size get preferredSize {
    Size size = super.preferredSize;

    if (super.bottom == null && bottom != null) {
      size = Size(size.width, size.height + (bottom!.preferredSize.height + Dimensions.size10));
    }

    if (!primary) {
      size = Size(size.width, size.height - Dimensions.size25);
    }

    return size;
  }

  @override
  double? get scrolledUnderElevation => 0;

  @override
  List<Widget>? get actions {
    List<Widget> actions = [];

    if (trailings != null && trailings!.isNotEmpty) {
      actions.addAll(trailings!);
    }

    if (actions.isNotEmpty) {
      actions.add(SizedBox(width: Dimensions.size15));
    }

    return actions;
  }
}