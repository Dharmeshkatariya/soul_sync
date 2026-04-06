import 'package:soul_sync/core/utils/string_file.dart';

import 'package:soul_sync/core/extension/text_style.dart';
import 'package:soul_sync/custom_view/custom_text_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../app/library/library_controller.dart';
import 'additional_operation_dialog.dart';
import 'modified_text_field.dart';

enum OperationMode { arrange, delete, addToPlaylist, none }

enum SortType { Name, Date, Duration, RecentlyPlayed }

Set<SortType> buildSortTypeSet([
  bool dateRequired = false,
  bool durationRequired = false,
  bool recentlyPlayedRequired = false,
]) {
  Set<SortType> requiredSortTypes = {};
  if (dateRequired) {
    requiredSortTypes.add(SortType.Date);
  }
  if (durationRequired) {
    requiredSortTypes.add(SortType.Duration);
  }
  if (recentlyPlayedRequired) {
    requiredSortTypes.add(SortType.RecentlyPlayed);
  }
  return requiredSortTypes;
}

class SortWidget extends StatelessWidget {
  /// Additional operations - Delete Multiple songs, Rearrage offline playlist, Add Multiple songs to playlist
  const SortWidget({
    super.key,
    required this.tag,
    this.itemCountTitle = '',
    this.titleLeftPadding = 18,
    this.isAdditionalOperationRequired = true,
    this.requiredSortTypes = const <SortType>{SortType.Name},
    this.isSearchFeatureRequired = false,
    this.isPlaylistRearrageFeatureRequired = false,
    this.isSongDeletetioFeatureRequired = false,
    required this.screenController,
    this.onSearchStart,
    this.onSearch,
    this.onSearchClose,
    this.itemIcon,
    this.startAdditionalOperation,
    this.selectAll,
    this.performAdditionalOperation,
    this.cancelAdditionalOperation,
    this.isImportFeatureRequired = false,
    required this.onSort,
  });

  /// unique identifier for each sortwidget
  final String tag;
  final String itemCountTitle;
  final IconData? itemIcon;
  final bool isAdditionalOperationRequired;
  final double titleLeftPadding;
  final Set<SortType> requiredSortTypes;
  final bool isSearchFeatureRequired;
  final bool isSongDeletetioFeatureRequired;
  final bool isPlaylistRearrageFeatureRequired;
  final dynamic screenController;
  final Function(SortWidgetController, OperationMode)? startAdditionalOperation;
  final Function(bool)? selectAll;
  final Function()? performAdditionalOperation;
  final Function()? cancelAdditionalOperation;
  final Function(String?)? onSearchStart;
  final Function(String, String?)? onSearch;
  final Function(String?)? onSearchClose;
  final Function(SortType, bool) onSort;
  final bool isImportFeatureRequired;

  void _showImportDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Theme.of(context).cardColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        title: CustomTextView(
          StringFile.importPlaylist,
          style: context.titleLarge,
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomTextView(
              StringFile.importPlaylistDesc,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: 12),
            CustomTextView(
              StringFile.importLargeFileNote,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    fontStyle: FontStyle.italic,
                    color: Theme.of(context).colorScheme.secondary,
                  ),
            ),
            const SizedBox(height: 24),
            Center(
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).colorScheme.secondary,
                  foregroundColor: Theme.of(context).colorScheme.onSecondary,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 12,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                icon: const Icon(Icons.file_open),
                label: CustomTextView(StringFile.selectFile),
                onPressed: () {
                  Get.find<LibraryPlaylistsController>().importPlaylistFromJson(
                    context,
                  );
                  Navigator.pop(context);
                  Navigator.pop(context);
                },
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            style: TextButton.styleFrom(
              foregroundColor: Theme.of(context).colorScheme.secondary,
            ),
            onPressed: () => Navigator.pop(context),
            child: CustomTextView(StringFile.close),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SortWidgetController(), tag: tag);
    return Padding(
      padding: const EdgeInsets.only(top: 10.0),
      child: SizedBox(
        height: 40,
        child: Obx(
          () => Stack(
            children: [
              if (controller.isSearchingEnabled.isFalse)
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: titleLeftPadding),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          CustomTextView(itemCountTitle),
                          if (itemIcon != null)
                            Icon(
                              Icons.music_note,
                              size: 15,
                              color: Theme.of(context).colorScheme.secondary,
                            ),
                        ],
                      ),
                    ),
                    Obx(
                      () => _customIconButton(
                        isSelected: controller.sortType.value == SortType.Name,
                        icon: Icons.sort_by_alpha,
                        tooltip: StringFile.sortByName,
                        onPressed: () {
                          controller.onSortByName(onSort);
                        },
                      ),
                    ),
                    requiredSortTypes.contains(SortType.Date)
                        ? Obx(
                            () => _customIconButton(
                              isSelected:
                                  controller.sortType.value == SortType.Date,
                              icon: Icons.calendar_month,
                              tooltip: StringFile.sortByDate,
                              onPressed: () {
                                controller.onSortByDate(onSort);
                              },
                            ),
                          )
                        : const SizedBox.shrink(),
                    requiredSortTypes.contains(SortType.Duration)
                        ? Obx(
                            () => _customIconButton(
                              isSelected: controller.sortType.value ==
                                  SortType.Duration,
                              tooltip: StringFile.sortByDuration,
                              icon: Icons.timer,
                              onPressed: () {
                                controller.onSortByDuration(onSort);
                              },
                            ),
                          )
                        : const SizedBox.shrink(),
                    const Expanded(child: SizedBox()),
                    Obx(
                      () => _customIconButton(
                        icon: controller.isAscending.value
                            ? Icons.arrow_downward
                            : Icons.arrow_upward,
                        tooltip: StringFile.sortAscendNDescend,
                        onPressed: () {
                          controller.onAscendNDescend(onSort);
                        },
                      ),
                    ),
                    if (isImportFeatureRequired)
                      _customIconButton(
                        icon: Icons.import_contacts,
                        tooltip: StringFile.importPlaylist,
                        onPressed: () => _showImportDialog(context),
                      ),
                    if (isSearchFeatureRequired)
                      _customIconButton(
                        icon: Icons.search,
                        tooltip: StringFile.search,
                        onPressed: () {
                          onSearchStart!(tag);
                          controller.toggleSearch();
                        },
                      ),
                    if (isAdditionalOperationRequired)
                      PopupMenuButton(
                        child: const Icon(Icons.more_vert, size: 20),
                        // Callback that sets the selected popup menu item.
                        onSelected: (mode) {
                          showDialog(
                            context: context,
                            builder: (context) => AdditionalOperationDialog(
                              operationMode: mode,
                              screenController: screenController,
                              controller: controller,
                            ),
                          );

                          controller.setActiveMode(mode);
                          startAdditionalOperation!(controller, mode);
                        },
                        itemBuilder: (BuildContext context) => <PopupMenuEntry>[
                          if (isPlaylistRearrageFeatureRequired)
                            PopupMenuItem(
                              value: OperationMode.arrange,
                              child: CustomTextView(
                                StringFile.reArrangePlaylist,
                              ),
                            ),
                          if (isSongDeletetioFeatureRequired)
                            PopupMenuItem(
                              value: OperationMode.delete,
                              child: CustomTextView(StringFile.removeMultiple),
                            ),
                          PopupMenuItem(
                            value: OperationMode.addToPlaylist,
                            child: CustomTextView(StringFile.addMultipleSongs),
                          ),
                        ],
                      ),
                    const SizedBox(width: 15),
                  ],
                ),
              if (controller.isSearchingEnabled.value)
                Container(
                  height: 40,
                  padding: const EdgeInsets.only(left: 5, right: 20),
                  // color:
                  //     Theme.of(context).scaffoldBackgroundColor.withAlpha(125),
                  child: ColoredBox(
                    color: Theme.of(
                      context,
                    ).scaffoldBackgroundColor.withAlpha(125),
                    child: ModifiedTextField(
                      controller: controller.textEditingController,
                      textAlignVertical: TextAlignVertical.center,
                      autofocus: true,
                      onChanged: (value) {
                        onSearch!(value, tag);
                      },
                      cursorColor: context.titleSmall!.color,
                      decoration: InputDecoration(
                        isDense: true,
                        contentPadding: const EdgeInsets.all(8),
                        filled: true,
                        border: const OutlineInputBorder(),
                        hintText: StringFile.search,
                        suffixIconColor: Theme.of(
                          context,
                        ).colorScheme.secondary,
                        suffixIcon: IconButton(
                          splashRadius: 10,
                          iconSize: 20,
                          icon: const Icon(Icons.cancel),
                          onPressed: () {
                            controller.toggleSearch();
                            onSearchClose!(tag);
                          },
                        ),
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _customIconButton({
    required IconData icon,
    required String tooltip,
    bool? isSelected,
    Function()? onPressed,
  }) {
    return IconButton(
      icon: Icon(icon),
      padding: const EdgeInsets.all(0),
      color: isSelected == null || isSelected == true
          ? Theme.of(Get.context!).textTheme.bodySmall!.color
          : Theme.of(Get.context!).colorScheme.secondary,
      iconSize: 20,
      splashRadius: 20,
      visualDensity: const VisualDensity(horizontal: -3, vertical: -3),
      onPressed: onPressed,
      tooltip: tooltip,
    );
  }
}

class SortWidgetController extends GetxController {
  final Rx<SortType> sortType = SortType.Name.obs;
  final isAscending = true.obs;
  final isSearchingEnabled = false.obs;
  final isRearraningEnabled = false.obs;
  final isDeletionEnabled = false.obs;
  final isAddtoPlaylistEnabled = false.obs;
  final isAllSelected = false.obs;
  TextEditingController textEditingController = TextEditingController();

  void setActiveMode(OperationMode mode) {
    isAddtoPlaylistEnabled.value = OperationMode.addToPlaylist == mode;
    isDeletionEnabled.value = OperationMode.delete == mode;
    isRearraningEnabled.value = OperationMode.arrange == mode;
  }

  void toggleSelectAll(bool val) {
    isAllSelected.value = val;
  }

  void onSortByName(Function onSort) {
    sortType.value = SortType.Name;
    onSort(sortType.value, isAscending.value);
  }

  void onSortByDuration(Function onSort) {
    sortType.value = SortType.Duration;
    onSort(sortType.value, isAscending.value);
  }

  void onSortByDate(Function onSort) {
    sortType.value = SortType.Date;
    onSort(sortType.value, isAscending.value);
  }

  void onAscendNDescend(Function onSort) {
    isAscending.value = !isAscending.value;
    onSort(sortType.value, isAscending.value);
  }

  void toggleSearch() {
    isSearchingEnabled.value = !isSearchingEnabled.value;
  }
}
