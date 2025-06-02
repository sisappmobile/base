import "package:base/base.dart";
import "package:flutter/material.dart";

class BaseBottomBar extends StatelessWidget {
  final List<Widget> children;

  const BaseBottomBar({
    required this.children,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(Dimensions.size15),
      decoration: BoxDecoration(
        color: AppColors.surfaceContainerLowest(),
        border: Border(
          top: BorderSide(
            color: AppColors.outline(),
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