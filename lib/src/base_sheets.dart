// ignore_for_file: always_specify_types, use_build_context_synchronously, cascade_invocations, always_put_required_named_parameters_first, constant_identifier_names, avoid_print

import "dart:io";

import "package:base/src/app_colors.dart";
import "package:base/src/base_overlays.dart";
import "package:base/src/base_preferences.dart";
import "package:base/src/base_side_sheet.dart";
import "package:base/src/dimensions.dart";
import "package:base/src/navigators.dart";
import "package:basic_utils/basic_utils.dart";
import "package:easy_localization/easy_localization.dart" as el;
import "package:flutter/material.dart";
import "package:get/get.dart";
import "package:jiffy/jiffy.dart";
import "package:photo_view/photo_view.dart";
import "package:syncfusion_flutter_datepicker/datepicker.dart";
import "package:video_player/video_player.dart";

class BaseSheets {
  static Future<dynamic> spinner({
    required String title,
    required List<SpinnerItem> spinnerItems,
    required void Function(SpinnerItem selectedItem) onSelected,
  }) async {
    TextEditingController textEditingController = TextEditingController();

    List<SpinnerItem> filteredSpinnerItems = [];

    filteredSpinnerItems.addAll(spinnerItems);

    return await BaseSideSheet.right(
      title: title,
      body: StatefulBuilder(
        builder: (BuildContext context, setState) {
          return Column(
            children: [
              Container(
                color: AppColors.primaryContainer().withOpacity(0.2),
                padding: EdgeInsets.symmetric(
                  vertical: Dimensions.size20,
                  horizontal: Dimensions.size20,
                ),
                child: TextField(
                  controller: textEditingController,
                  textInputAction: TextInputAction.search,
                  decoration: InputDecoration(
                    isDense: true,
                    filled: true,
                    prefixIcon: const Icon(
                      Icons.search,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(
                        Dimensions.size10,
                      ),
                      borderSide: BorderSide.none,
                    ),
                    hintText: el.tr("search"),
                  ),
                  onChanged: (String value) {
                    setState(() {
                      filteredSpinnerItems.clear();

                      if (StringUtils.isNotNullOrEmpty(textEditingController.text)) {
                        for (SpinnerItem spinnerItem in spinnerItems) {
                          if (spinnerItem.description.toLowerCase().contains(textEditingController.text.toLowerCase(),)) {
                            filteredSpinnerItems.add(spinnerItem);
                          }
                        }
                      } else {
                        filteredSpinnerItems.addAll(spinnerItems);
                      }
                    });
                  },
                ),
              ),
              Expanded(
                child: ListView.separated(
                  itemCount: filteredSpinnerItems.length,
                  itemBuilder: (BuildContext context, int index) {
                    SpinnerItem spinnerItem = filteredSpinnerItems[index];

                    return ListTile(
                      onTap: () {
                        Navigators.pop();

                        onSelected(spinnerItem);
                      },
                      title: Text(
                        spinnerItem.description,
                        style: TextStyle(
                          color: spinnerItem.selected ? AppColors.primary() : AppColors.onBackground(),
                          fontWeight: spinnerItem.selected ? FontWeight.bold : FontWeight.normal,
                        ),
                      ),
                    );
                  },
                  separatorBuilder: (BuildContext context, int index) {
                    return const Divider(
                      height: 0,
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  static Future<dynamic> checkable({
    required String title,
    required List<SpinnerItem> spinnerItems,
    required void Function(List<SpinnerItem> selectedItems) onSelected,
  }) async {
    TextEditingController textEditingController = TextEditingController();

    List<SpinnerItem> filteredSpinnerItems = [];

    filteredSpinnerItems.addAll(spinnerItems);

    bool selectedAll = !spinnerItems.any((element) => !element.selected);

    return await BaseSideSheet.right(
      title: title,
      body: StatefulBuilder(
        builder: (BuildContext context, setState) {
          return Column(
            children: [
              Container(
                color: AppColors.primaryContainer().withOpacity(0.2),
                padding: EdgeInsets.all(Dimensions.size20),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: textEditingController,
                        textInputAction: TextInputAction.search,
                        decoration: InputDecoration(
                          isDense: true,
                          filled: true,
                          prefixIcon: const Icon(
                            Icons.search,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(
                              Dimensions.size10,
                            ),
                            borderSide: BorderSide.none,
                          ),
                          hintText: el.tr("search"),
                        ),
                        onChanged: (String value) {
                          setState(() {
                            filteredSpinnerItems.clear();

                            if (StringUtils.isNotNullOrEmpty(textEditingController.text)) {
                              for (SpinnerItem spinnerItem in spinnerItems) {
                                if (spinnerItem.description.toLowerCase().contains(textEditingController.text.toLowerCase(),)) {
                                  filteredSpinnerItems.add(spinnerItem);
                                }
                              }
                            } else {
                              filteredSpinnerItems.addAll(spinnerItems);
                            }
                          });
                        },
                      ),
                    ),
                    SizedBox(width: Dimensions.size20),
                    SizedBox(
                      width: Dimensions.size20,
                      height: Dimensions.size20,
                      child: Checkbox(
                        value: selectedAll,
                        onChanged: (value) {
                          selectedAll = !selectedAll;

                          for (SpinnerItem spinnerItem in spinnerItems) {
                            spinnerItem.selected = selectedAll;
                          }

                          setState(() {});
                        },
                      ),
                    ),
                    SizedBox(width: Dimensions.size10),
                  ],
                ),
              ),
              Expanded(
                child: ListView.separated(
                  itemCount: filteredSpinnerItems.length,
                  itemBuilder: (BuildContext context, int index) {
                    SpinnerItem spinnerItem = filteredSpinnerItems[index];

                    return CheckboxListTile(
                      value: spinnerItem.selected,
                      onChanged: (value) {
                        setState(() {
                          spinnerItem.selected = value ?? false;
                        });
                      },
                      title: Text(
                        spinnerItem.description,
                        style: TextStyle(
                          color: spinnerItem.selected ? AppColors.primary() : AppColors.onBackground(),
                          fontWeight: spinnerItem.selected ? FontWeight.bold : FontWeight.normal,
                        ),
                      ),
                    );
                  },
                  separatorBuilder: (BuildContext context, int index) {
                    return const Divider(
                      height: 0,
                    );
                  },
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: Dimensions.size20,
                  vertical: Dimensions.size15,
                ),
                decoration: BoxDecoration(
                  border: Border(
                    top: BorderSide(
                      width: 0.2,
                      color: AppColors.outline(),
                    ),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    FilledButton(
                      onPressed: () async {
                        onSelected(spinnerItems.where((element) => element.selected).toList());

                        Navigators.pop();
                      },
                      style: FilledButton.styleFrom(
                        backgroundColor: AppColors.primary(),
                        foregroundColor: AppColors.onPrimary(),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(Dimensions.size5)),
                        ),
                        padding: EdgeInsets.symmetric(
                          vertical: Dimensions.size10,
                          horizontal: Dimensions.size10,
                        ),
                      ),
                      child: Text(el.tr("apply")),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  static Future<dynamic> menu({
    required List<MenuItem> menuItems,
  }) async {
    return await BaseSideSheet.right(
      title: el.tr("option"),
      body: ListView.separated(
        itemCount: menuItems.length,
        separatorBuilder: (context, index) {
          return Divider(
            color: AppColors.outline(),
            thickness: 0.2,
            height: 0,
          );
        },
        itemBuilder: (context, index) {
          MenuItem menuItem = menuItems[index];
          return ListTile(
            contentPadding: EdgeInsets.symmetric(
              horizontal: Dimensions.size20,
              vertical: Dimensions.size5,
            ),
            onTap: menuItem.onTap != null ? () {
              Navigators.pop();

              menuItem.onTap!();
            } : null,
            leading: menuItem.iconData != null ? Icon(
              menuItem.iconData,
              color: menuItem.onTap != null ? AppColors.onBackground() : AppColors.onBackground().withOpacity(0.3),
            ) : null,
            title: Text(
              menuItem.title,
              style: TextStyle(
                color: menuItem.onTap != null ? AppColors.onBackground() : AppColors.onBackground().withOpacity(0.3),
                fontWeight: FontWeight.bold,
                fontSize: Dimensions.text16,
              ),
            ),
          );
        },
      ),
    );
  }

  static Future<dynamic> dateRange({
    required Jiffy from,
    required Jiffy until,
    required void Function(Jiffy selectedFrom, Jiffy selectedUntil) onSelected,
    int? maxRangeInDays,
  }) async {
    return await BaseSideSheet.right(
      title: el.tr("select_period"),
      body: SafeArea(
        child: StatefulBuilder(
          builder: (BuildContext context, setState) {
            return SfDateRangePicker(
              view: DateRangePickerView.month,
              selectionMode: DateRangePickerSelectionMode.range,
              headerStyle: DateRangePickerHeaderStyle(
                textAlign: TextAlign.center,
                backgroundColor: AppColors.surface(),
              ),
              backgroundColor: AppColors.surface(),
              showActionButtons: true,
              initialDisplayDate: from.dateTime,
              initialSelectedRange: PickerDateRange(from.dateTime, until.dateTime),
              onCancel: () {
                Navigators.pop();
              },
              onSubmit: (Object? p0) {
                if (p0 != null) {
                  if (p0 is PickerDateRange) {
                    if (p0.startDate != null && p0.endDate != null) {
                      if (maxRangeInDays != null && p0.endDate!.difference(p0.startDate!).inDays > maxRangeInDays) {
                        BaseOverlays.error(message: "${el.tr("the_maximum_period_is")} $maxRangeInDays ${el.tr("days")}");
                      } else {
                        onSelected(
                          Jiffy.parseFromDateTime(p0.startDate!),
                          Jiffy.parseFromDateTime(p0.endDate!),
                        );

                        Navigators.pop();
                      }
                    }
                  }
                }
              },
            );
          },
        ),
      ),
    );
  }

  static Future<dynamic> date({
    required Jiffy? jiffy,
    Jiffy? min,
    Jiffy? max,
    required void Function(Jiffy jiffy) onSelected,
  }) async {
    if (Get.context != null) {
      jiffy ??= Jiffy.now();
      min ??= Jiffy.parseFromDateTime(DateTime(1900, 1, 1));
      max ??= Jiffy.now();

      DateTime? dateTime = await showDatePicker(
        context: Get.context!,
        initialDate: jiffy.dateTime,
        firstDate: min.dateTime,
        lastDate: max.dateTime,
      );

      if (dateTime != null) {
        onSelected(
          Jiffy.parseFromDateTime(
            DateTime(
              dateTime.year,
              dateTime.month,
              dateTime.day,
            ),
          ).startOf(Unit.day),
        );
      }
    }
  }

  static Future<dynamic> dateTime({
    required Jiffy jiffy,
    required Jiffy min,
    required Jiffy max,
    required void Function(Jiffy jiffy) onSelected,
  }) async {
    if (Get.context != null) {
      DateTime? dateTime = await showDatePicker(
        context: Get.context!,
        initialDate: jiffy.dateTime,
        firstDate: min.dateTime,
        lastDate: max.dateTime,
      );

      if (dateTime != null) {
        TimeOfDay? timeOfDay = await showTimePicker(
          context: Get.context!,
          initialTime: TimeOfDay.fromDateTime(jiffy.dateTime),
        );

        if (timeOfDay != null) {
          onSelected(
            Jiffy.parseFromDateTime(
              DateTime(
                dateTime.year,
                dateTime.month,
                dateTime.day,
                timeOfDay.hour,
                timeOfDay.minute,
              ),
            ),
          );
        }
      }
    }
  }

  static void imagePreview({
    required ImageProvider imageProvider,
  }) async {
    await BaseSideSheet.right(
      body: StatefulBuilder(
        builder: (context, setState) {
          return Material(
            child: Container(
              padding: EdgeInsets.only(
                top: MediaQuery.of(context).size.height * 0.04,
              ),
              child: Scaffold(
                appBar: AppBar(
                  centerTitle: true,
                  title: Text(el.tr("view_image")),
                ),
                body: PhotoView(
                  imageProvider: imageProvider,
                  backgroundDecoration: const BoxDecoration(
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  static void videoPreview({
    required File file,
  }) async {
    VideoPlayerController videoPlayerController = VideoPlayerController.file(file);

    await videoPlayerController.initialize();
    await videoPlayerController.setLooping(true);
    await videoPlayerController.play();

    await BaseSideSheet.right(
      body: StatefulBuilder(
        builder: (context, setState) {
          return Material(
            child: Container(
              padding: EdgeInsets.only(
                top: MediaQuery.of(context).size.height * 0.04,
              ),
              child: Scaffold(
                appBar: AppBar(
                  centerTitle: true,
                  title: Text(el.tr("view_video")),
                ),
                body: Center(
                  child: AspectRatio(
                    aspectRatio: videoPlayerController.value.aspectRatio,
                    child: VideoPlayer(videoPlayerController),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  static Future<dynamic> savedSetting() async {
    return await BaseSideSheet.right(
      title: el.tr("saved_setting"),
      body: ListView.separated(
        itemCount: BasePreferences.getInstance().all().length,
        itemBuilder: (BuildContext context, int index) {
          MapEntry<String, String> mapEntry = BasePreferences.getInstance().all().entries.elementAt(index);

          return ListTile(
            title: Text(
              mapEntry.key,
            ),
            subtitle: Text(
              mapEntry.value,
            ),
          );
        },
        separatorBuilder: (BuildContext context, int index) {
          return const Divider(
            height: 0,
          );
        },
      ),
    );
  }
}

class SpinnerItem {
  final dynamic identity;
  final String description;
  final String? selectedDescription;
  final dynamic tag;
  bool selected;

  SpinnerItem({
    required this.identity,
    required this.description,
    this.selectedDescription,
    this.tag,
    this.selected = false,
  });
}

class MenuItem {
  final IconData? iconData;
  final String title;
  final void Function()? onTap;

  MenuItem({
    this.iconData,
    required this.title,
    this.onTap,
  });
}
