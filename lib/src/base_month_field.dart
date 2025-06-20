import 'package:base/base.dart';
import 'package:basic_utils/basic_utils.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:jiffy/jiffy.dart';
import 'package:smooth_corner/smooth_corner.dart';

class BaseMonthField extends StatefulWidget {
  final bool mandatory;
  final bool readonly;
  final Jiffy? value;
  final void Function(Jiffy newValue)? onSelected;
  final String? label;

  const BaseMonthField({
    super.key,
    required this.mandatory,
    required this.readonly,
    required this.value,
    this.onSelected,
    this.label,
  });

  @override
  State<BaseMonthField> createState() => BaseMonthFieldState();
}

class BaseMonthFieldState extends State<BaseMonthField> {
  @override
  Widget build(BuildContext context) {
    return FormField<Jiffy>(
      initialValue: widget.value,
      enabled: !widget.readonly,
      validator: (value) {
        if (widget.mandatory) {
          if (widget.value == null) {
            return "this_field_is_required".tr();
          }
        }

        return null;
      },
      builder: (field) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            labelWidget(),
            Material(
              child: InkWell(
                onTap: !widget.readonly ? () async {
                  await BaseDialogs.month(
                    jiffy: widget.value,
                    onSelected: (newValue) {
                      if (widget.onSelected != null) {
                        widget.onSelected!(newValue);

                        setState(() {});
                      }
                    },
                  );
                } : null,
                customBorder: SmoothRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                  smoothness: 1,
                ),
                child: Ink(
                  width: double.infinity,
                  height: Dimensions.size55,
                  decoration: ShapeDecoration(
                    shape: SmoothRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                      smoothness: 1,
                      side: BorderSide(
                        color: borderColor(field),
                      ),
                    ),
                    color: AppColors.surfaceContainerLowest(),
                  ),
                  padding: EdgeInsets.symmetric(
                    horizontal: Dimensions.size15,
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          widget.value?.format(pattern: "MMMM yyyy") ?? "",
                          style: TextStyle(
                            fontSize: Dimensions.text16,
                          ),
                        ),
                      ),
                      SizedBox(width: Dimensions.size10),
                      Icon(
                        Icons.event,
                        size: Dimensions.size20,
                      )
                    ],
                  ),
                ),
              ),
            ),
            errorWidget(field),
          ],
        );
      },
    );
  }

  Widget labelWidget() {
    if (StringUtils.isNotNullOrEmpty(widget.label)) {
      return Container(
        margin: EdgeInsets.only(
          bottom: Dimensions.size5,
        ),
        child: Text(
          "${widget.label}${widget.mandatory ? "*" : ""}",
          style: TextStyle(
            fontSize: Dimensions.text12,
            fontWeight: FontWeight.w700,
            color: AppColors.onSurface().withValues(alpha: 80),
          ),
        ),
      );
    }

    return const SizedBox.shrink();
  }

  Widget errorWidget(FormFieldState field) {
    if (field.hasError) {
      return Container(
        margin: EdgeInsets.only(
          top: Dimensions.size5,
        ),
        child: Row(
          children: [
            Icon(
              Icons.error,
              color: AppColors.error(),
            ),
            SizedBox(width: Dimensions.size5),
            Expanded(
              child: Text(
                field.errorText ?? "",
                style: TextStyle(
                  fontSize: Dimensions.text12,
                  color: AppColors.error(),
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
      );
    }

    return const SizedBox.shrink();
  }

  Color borderColor(FormFieldState field) {
    if (widget.readonly) {
      return AppColors.surfaceDim();
    } else {
      if (field.hasError) {
        return AppColors.error();
      } else {
        return AppColors.outline();
      }
    }
  }
}