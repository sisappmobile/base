import "package:base/base.dart";
import "package:flutter/material.dart";

class BaseBottomBar extends StatelessWidget {
  final List<Widget> children;
  final bool removeBottomInset;
  final Color? backgroundColor;
  final Color? borderColor;

  const BaseBottomBar({
    required this.children,
    this.removeBottomInset = false,
    this.backgroundColor,
    this.borderColor,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(
          Dimensions.size15,
          Dimensions.size15,
          Dimensions.size15,
          Dimensions.size15 + (removeBottomInset ? 0 : MediaQuery.paddingOf(context).bottom),
      ),
      decoration: BoxDecoration(
        color: backgroundColor ?? AppColors.surfaceContainerLowest(),
        border: Border(
          top: BorderSide(
            color: borderColor ?? AppColors.outline(),
          ),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: children,
      ),
    );
  }
}