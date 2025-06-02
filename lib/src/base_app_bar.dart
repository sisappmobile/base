import "package:base/base.dart";
import "package:basic_utils/basic_utils.dart";
import "package:flutter/material.dart";
import "package:go_router/go_router.dart";

class BaseAppBar extends StatelessWidget {
  final String title;
  String? subtitle;
  List<Widget>? trailing;

  BaseAppBar({
    required this.title,
    this.subtitle,
    this.trailing,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    Widget backButton() {
      if (context.canPop()) {
        return Container(
          margin: EdgeInsets.only(
            right: Dimensions.size5,
          ),
          child: IconButton(
            onPressed: () {
              context.pop();
            },
            icon: const Icon(
              Icons.turn_left,
            ),
          ),
        );
      }

      return Container(
        margin: EdgeInsets.only(
          right: Dimensions.size10,
        ),
      );
    }

    Widget subtitleWidget() {
      if (StringUtils.isNotNullOrEmpty(subtitle)) {
        return Text(
          subtitle!,
          style: TextStyle(
            fontSize: Dimensions.text12,
            fontWeight: FontWeight.w500,
          ),
        );
      }

      return const SizedBox.shrink();
    }

    return Container(
      padding: EdgeInsets.all(
        Dimensions.size15,
      ),
      decoration: BoxDecoration(
        color: AppColors.surfaceContainerLowest(),
        border: Border(
          bottom: BorderSide(
            color: AppColors.outline(),
          ),
        ),
      ),
      child: Row(
        children: [
          backButton(),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: Dimensions.text16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                subtitleWidget(),
              ],
            ),
          ),
          ...(trailing ?? []),
        ],
      ),
    );
  }
}