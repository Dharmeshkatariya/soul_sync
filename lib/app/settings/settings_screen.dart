import 'package:soul_sync/core/extension/text_style.dart';
import 'package:soul_sync/custom_view/custom_text_view.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../core/utils/player_utils/helper.dart';
import '../../core/utils/player_utils/lang_mapping.dart';
import '../../core/utils/theme_controller.dart';
import '../../custom_view/custom_player/player_controller.dart';
import '../../custom_view/player_widget/backup_dialog.dart';
import '../../custom_view/player_widget/common_dialog_widget.dart';
import '../../custom_view/player_widget/cust_switch.dart';
import '../../custom_view/player_widget/export_file_dialog.dart';
import '../../custom_view/player_widget/link_piped.dart';
import '../../custom_view/player_widget/restore_dialog.dart';
import '../../custom_view/player_widget/snackbar.dart';
import '../Library/library_controller.dart';
import '/services/music_service.dart';
import 'components/custom_expansion_tile.dart';
import 'settings_screen_controller.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key, this.isBottomNavActive = false});
  final bool isBottomNavActive;

  @override
  Widget build(BuildContext context) {
    final settingsController = Get.find<SettingsScreenController>();
    final topPadding = context.isLandscape ? 50.0 : 90.0;
    final isDesktop = GetPlatform.isDesktop;
    return Padding(
      padding: isBottomNavActive
          ? EdgeInsets.only(left: 20, top: topPadding, right: 15)
          : EdgeInsets.only(top: topPadding, left: 5, right: 5),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: CustomTextView("settings".tr, style: context.titleLarge),
          ),
          Expanded(
            child: ListView(
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.only(bottom: 200, top: 20),
              children: [
                Obx(
                  () => settingsController.isNewVersionAvailable.value
                      ? Padding(
                          padding: const EdgeInsets.only(
                            top: 8.0,
                            right: 10,
                            bottom: 8.0,
                          ),
                          child: Material(
                            type: MaterialType.transparency,
                            child: ListTile(
                              onTap: () {
                                launchUrl(
                                  Uri.parse(
                                    'https://github.com/anandnet/Harmony-Music/releases/latest',
                                  ),
                                  mode: LaunchMode.externalApplication,
                                );
                              },
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              tileColor: Theme.of(
                                context,
                              ).colorScheme.secondary,
                              contentPadding: const EdgeInsets.only(
                                left: 8,
                                right: 10,
                              ),
                              leading: const CircleAvatar(
                                child: Icon(Icons.download),
                              ),
                              title: CustomTextView("newVersionAvailable".tr),
                              visualDensity: const VisualDensity(
                                horizontal: -2,
                              ),
                              subtitle: CustomTextView(
                                "goToDownloadPage".tr,
                                style: Theme.of(context).textTheme.bodyMedium!
                                    .copyWith(
                                      color: Colors.white70,
                                      fontSize: 13,
                                    ),
                              ),
                            ),
                          ),
                        )
                      : const SizedBox.shrink(),
                ),
                CustomExpansionTile(
                  title: "personalisation".tr,
                  icon: Icons.palette,
                  children: [
                    ListTile(
                      contentPadding: const EdgeInsets.only(left: 5, right: 10),
                      title: CustomTextView("themeMode".tr),
                      subtitle: Obx(
                        () => CustomTextView(
                          settingsController.themeModetype.value ==
                                  ThemeType.dynamic
                              ? "dynamic".tr
                              : settingsController.themeModetype.value ==
                                    ThemeType.system
                              ? "systemDefault".tr
                              : settingsController.themeModetype.value ==
                                    ThemeType.dark
                              ? "dark".tr
                              : "light".tr,
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      ),
                      onTap: () => showDialog(
                        context: context,
                        builder: (context) => const ThemeSelectorDialog(),
                      ),
                    ),
                    ListTile(
                      contentPadding: const EdgeInsets.only(left: 5, right: 10),
                      title: CustomTextView("language".tr),
                      subtitle: CustomTextView(
                        "languageDes".tr,
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                      trailing: Obx(
                        () => DropdownButton(
                          menuMaxHeight: Get.height - 250,
                          dropdownColor: Theme.of(context).cardColor,
                          underline: const SizedBox.shrink(),
                          style: context.titleSmall,
                          value:
                              settingsController.currentAppLanguageCode.value,
                          items: langMap.entries
                              .map(
                                (lang) => DropdownMenuItem(
                                  value: lang.key,
                                  child: CustomTextView(lang.value),
                                ),
                              )
                              .whereType<DropdownMenuItem<String>>()
                              .toList(),
                          selectedItemBuilder: (context) =>
                              langMap.entries.map<Widget>((item) {
                                return Container(
                                  alignment: Alignment.centerRight,
                                  constraints: const BoxConstraints(
                                    minWidth: 50,
                                  ),
                                  child: CustomTextView(item.value),
                                );
                              }).toList(),
                          onChanged: settingsController.setAppLanguage,
                        ),
                      ),
                    ),
                    if (!isDesktop)
                      ListTile(
                        contentPadding: const EdgeInsets.only(
                          left: 5,
                          right: 10,
                        ),
                        title: CustomTextView("playerUi".tr),
                        subtitle: CustomTextView(
                          "playerUiDes".tr,
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                        trailing: Obx(
                          () => DropdownButton(
                            dropdownColor: Theme.of(context).cardColor,
                            underline: const SizedBox.shrink(),
                            value: settingsController.playerUi.value,
                            items: [
                              DropdownMenuItem(
                                value: 0,
                                child: CustomTextView("standard".tr),
                              ),
                              DropdownMenuItem(
                                value: 1,
                                child: CustomTextView("gesture".tr),
                              ),
                            ],
                            onChanged: settingsController.setPlayerUi,
                          ),
                        ),
                      ),
                    if (!isDesktop)
                      ListTile(
                        contentPadding: const EdgeInsets.only(
                          left: 5,
                          right: 10,
                        ),
                        title: CustomTextView("enableBottomNav".tr),
                        subtitle: CustomTextView(
                          "enableBottomNavDes".tr,
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                        trailing: Obx(
                          () => CustSwitch(
                            value:
                                settingsController.isBottomNavBarEnabled.isTrue,
                            onChanged: settingsController.enableBottomNavBar,
                          ),
                        ),
                      ),
                    ListTile(
                      contentPadding: const EdgeInsets.only(left: 5, right: 10),
                      title: CustomTextView("disableTransitionAnimation".tr),
                      subtitle: CustomTextView(
                        "disableTransitionAnimationDes".tr,
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                      trailing: Obx(
                        () => CustSwitch(
                          value: settingsController
                              .isTransitionAnimationDisabled
                              .isTrue,
                          onChanged:
                              settingsController.disableTransitionAnimation,
                        ),
                      ),
                    ),
                    ListTile(
                      contentPadding: const EdgeInsets.only(left: 5, right: 10),
                      title: CustomTextView("enableSlidableAction".tr),
                      subtitle: CustomTextView(
                        "enableSlidableActionDes".tr,
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                      trailing: Obx(
                        () => CustSwitch(
                          value:
                              settingsController.slidableActionEnabled.isTrue,
                          onChanged: settingsController.toggleSlidableAction,
                        ),
                      ),
                    ),
                  ],
                ),
                CustomExpansionTile(
                  title: "content".tr,
                  icon: Icons.music_video,
                  children: [
                    ListTile(
                      contentPadding: const EdgeInsets.only(left: 5, right: 10),
                      title: CustomTextView("setDiscoverContent".tr),
                      subtitle: Obx(
                        () => CustomTextView(
                          settingsController.discoverContentType.value == "QP"
                              ? "quickpicks".tr
                              : settingsController.discoverContentType.value ==
                                    "TMV"
                              ? "topmusicvideos".tr
                              : settingsController.discoverContentType.value ==
                                    "TR"
                              ? "trending".tr
                              : "basedOnLast".tr,
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      ),
                      onTap: () => showDialog(
                        context: context,
                        builder: (context) =>
                            const DiscoverContentSelectorDialog(),
                      ),
                    ),
                    ListTile(
                      contentPadding: const EdgeInsets.only(left: 5, right: 10),
                      title: CustomTextView("homeContentCount".tr),
                      subtitle: CustomTextView(
                        "homeContentCountDes".tr,
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                      trailing: Obx(
                        () => DropdownButton(
                          dropdownColor: Theme.of(context).cardColor,
                          underline: const SizedBox.shrink(),
                          value: settingsController.noOfHomeScreenContent.value,
                          items: ([3, 5, 7, 9, 11])
                              .map(
                                (e) => DropdownMenuItem(
                                  value: e,
                                  child: CustomTextView("$e"),
                                ),
                              )
                              .toList(),
                          onChanged: settingsController.setContentNumber,
                        ),
                      ),
                    ),
                    ListTile(
                      contentPadding: const EdgeInsets.only(left: 5, right: 10),
                      title: CustomTextView("cacheHomeScreenData".tr),
                      subtitle: CustomTextView(
                        "cacheHomeScreenDataDes".tr,
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                      trailing: Obx(
                        () => CustSwitch(
                          value: settingsController.cacheHomeScreenData.value,
                          onChanged:
                              settingsController.toggleCacheHomeScreenData,
                        ),
                      ),
                    ),
                    ListTile(
                      contentPadding: const EdgeInsets.only(
                        left: 5,
                        right: 10,
                        top: 0,
                      ),
                      title: CustomTextView("Piped".tr),
                      subtitle: CustomTextView(
                        "linkPipedDes".tr,
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                      trailing: TextButton(
                        child: Obx(
                          () => CustomTextView(
                            settingsController.isLinkedWithPiped.value
                                ? "unLink".tr
                                : "link".tr,
                            style: Theme.of(
                              context,
                            ).textTheme.titleMedium!.copyWith(fontSize: 15),
                          ),
                        ),
                        onPressed: () {
                          if (settingsController.isLinkedWithPiped.isFalse) {
                            showDialog(
                              context: context,
                              builder: (context) => const LinkPiped(),
                            ).whenComplete(
                              () => Get.delete<PipedLinkedController>(),
                            );
                          } else {
                            settingsController.unlinkPiped();
                          }
                        },
                      ),
                    ),
                    Obx(
                      () => (settingsController.isLinkedWithPiped.isTrue)
                          ? ListTile(
                              contentPadding: const EdgeInsets.only(
                                left: 5,
                                right: 10,
                                top: 0,
                              ),
                              title: CustomTextView(
                                "resetblacklistedplaylist".tr,
                              ),
                              subtitle: CustomTextView(
                                "resetblacklistedplaylistDes".tr,
                                style: Theme.of(context).textTheme.bodyMedium,
                              ),
                              trailing: TextButton(
                                child: CustomTextView(
                                  "reset".tr,
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleMedium!
                                      .copyWith(fontSize: 15),
                                ),
                                onPressed: () async {
                                  await Get.find<LibraryPlaylistsController>()
                                      .resetBlacklistedPlaylist();
                                  ScaffoldMessenger.of(
                                    Get.context!,
                                  ).showSnackBar(
                                    snackbar(
                                      Get.context!,
                                      "blacklistPlstResetAlert".tr,
                                      size: SanckBarSize.MEDIUM,
                                    ),
                                  );
                                },
                              ),
                            )
                          : const SizedBox.shrink(),
                    ),
                    ListTile(
                      contentPadding: const EdgeInsets.only(left: 5, right: 10),
                      title: CustomTextView("clearImgCache".tr),
                      subtitle: CustomTextView(
                        "clearImgCacheDes".tr,
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                      isThreeLine: true,
                      onTap: () {
                        settingsController.clearImagesCache().then(
                          (value) =>
                              ScaffoldMessenger.of(Get.context!).showSnackBar(
                                snackbar(
                                  Get.context!,
                                  "clearImgCacheAlert".tr,
                                  size: SanckBarSize.BIG,
                                ),
                              ),
                        );
                      },
                    ),
                  ],
                ),
                CustomExpansionTile(
                  title: "music&Playback".tr,
                  icon: Icons.music_note,
                  children: [
                    ListTile(
                      contentPadding: const EdgeInsets.only(left: 5, right: 10),
                      title: CustomTextView("streamingQuality".tr),
                      subtitle: CustomTextView(
                        "streamingQualityDes".tr,
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                      trailing: Obx(
                        () => DropdownButton(
                          dropdownColor: Theme.of(context).cardColor,
                          underline: const SizedBox.shrink(),
                          value: settingsController.streamingQuality.value,
                          items: [
                            DropdownMenuItem(
                              value: AudioQuality.Low,
                              child: CustomTextView("low".tr),
                            ),
                            DropdownMenuItem(
                              value: AudioQuality.High,
                              child: CustomTextView("high".tr),
                            ),
                          ],
                          onChanged: settingsController.setStreamingQuality,
                        ),
                      ),
                    ),
                    if (GetPlatform.isAndroid)
                      ListTile(
                        contentPadding: const EdgeInsets.only(
                          left: 5,
                          right: 10,
                        ),
                        title: CustomTextView("loudnessNormalization".tr),
                        subtitle: CustomTextView(
                          "loudnessNormalizationDes".tr,
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                        trailing: Obx(
                          () => CustSwitch(
                            value: settingsController
                                .loudnessNormalizationEnabled
                                .value,
                            onChanged:
                                settingsController.toggleLoudnessNormalization,
                          ),
                        ),
                      ),
                    if (!isDesktop)
                      ListTile(
                        contentPadding: const EdgeInsets.only(
                          left: 5,
                          right: 10,
                        ),
                        title: CustomTextView("cacheSongs".tr),
                        subtitle: CustomTextView(
                          "cacheSongsDes".tr,
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                        trailing: Obx(
                          () => CustSwitch(
                            value: settingsController.cacheSongs.value,
                            onChanged:
                                settingsController.toggleCachingSongsValue,
                          ),
                        ),
                      ),
                    if (!isDesktop)
                      ListTile(
                        contentPadding: const EdgeInsets.only(
                          left: 5,
                          right: 10,
                        ),
                        title: CustomTextView("skipSilence".tr),
                        subtitle: CustomTextView(
                          "skipSilenceDes".tr,
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                        trailing: Obx(
                          () => CustSwitch(
                            value: settingsController.skipSilenceEnabled.value,
                            onChanged: settingsController.toggleSkipSilence,
                          ),
                        ),
                      ),
                    if (isDesktop)
                      ListTile(
                        contentPadding: const EdgeInsets.only(
                          left: 5,
                          right: 10,
                        ),
                        title: CustomTextView("backgroundPlay".tr),
                        subtitle: CustomTextView(
                          "backgroundPlayDes".tr,
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                        trailing: Obx(
                          () => CustSwitch(
                            value:
                                settingsController.backgroundPlayEnabled.value,
                            onChanged: settingsController.toggleBackgroundPlay,
                          ),
                        ),
                      ),
                    ListTile(
                      contentPadding: const EdgeInsets.only(left: 5, right: 10),
                      title: CustomTextView("keepScreenOnWhilePlaying".tr),
                      subtitle: CustomTextView(
                        "keepScreenOnWhilePlayingDes".tr,
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                      trailing: Obx(
                        () => CustSwitch(
                          value: settingsController.keepScreenAwake.value,
                          onChanged: settingsController.toggleKeepScreenAwake,
                        ),
                      ),
                    ),
                    ListTile(
                      contentPadding: const EdgeInsets.only(left: 5, right: 10),
                      title: CustomTextView("restoreLastPlaybackSession".tr),
                      subtitle: CustomTextView(
                        "restoreLastPlaybackSessionDes".tr,
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                      trailing: Obx(
                        () => CustSwitch(
                          value:
                              settingsController.restorePlaybackSession.value,
                          onChanged:
                              settingsController.toggleRestorePlaybackSession,
                        ),
                      ),
                    ),
                    ListTile(
                      contentPadding: const EdgeInsets.only(left: 5, right: 10),
                      title: CustomTextView("autoOpenPlayer".tr),
                      subtitle: CustomTextView(
                        "autoOpenPlayerDes".tr,
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                      trailing: Obx(
                        () => CustSwitch(
                          value: settingsController.autoOpenPlayer.value,
                          onChanged: settingsController.toggleAutoOpenPlayer,
                        ),
                      ),
                    ),
                    if (!isDesktop)
                      ListTile(
                        contentPadding: const EdgeInsets.only(
                          left: 5,
                          right: 10,
                          top: 0,
                        ),
                        title: CustomTextView("equalizer".tr),
                        subtitle: CustomTextView(
                          "equalizerDes".tr,
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                        onTap: () async {
                          try {
                            await Get.find<PlayerController>().openEqualizer();
                          } catch (e) {
                            printERROR(e);
                          }
                        },
                      ),
                    if (!isDesktop)
                      ListTile(
                        contentPadding: const EdgeInsets.only(
                          left: 5,
                          right: 10,
                        ),
                        title: CustomTextView("stopMusicOnTaskClear".tr),
                        subtitle: CustomTextView(
                          "stopMusicOnTaskClearDes".tr,
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                        trailing: Obx(
                          () => CustSwitch(
                            value: settingsController
                                .stopPlyabackOnSwipeAway
                                .value,
                            onChanged: settingsController
                                .toggleStopPlyabackOnSwipeAway,
                          ),
                        ),
                      ),
                    GetPlatform.isAndroid
                        ? Obx(
                            () => ListTile(
                              contentPadding: const EdgeInsets.only(
                                left: 5,
                                right: 10,
                              ),
                              title: CustomTextView("ignoreBatOpt".tr),
                              onTap:
                                  settingsController
                                      .isIgnoringBatteryOptimizations
                                      .isFalse
                                  ? settingsController
                                        .enableIgnoringBatteryOptimizations
                                  : null,
                              subtitle: Obx(
                                () => RichText(
                                  text: TextSpan(
                                    text:
                                        "${"status".tr}: ${settingsController.isIgnoringBatteryOptimizations.isTrue ? "enabled".tr : "disabled".tr}\n",
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium!
                                        .copyWith(fontWeight: FontWeight.bold),
                                    children: <TextSpan>[
                                      TextSpan(
                                        text: "ignoreBatOptDes".tr,
                                        style: Theme.of(
                                          context,
                                        ).textTheme.bodyMedium,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          )
                        : const SizedBox.shrink(),
                  ],
                ),
                CustomExpansionTile(
                  title: "download".tr,
                  icon: Icons.download,
                  children: [
                    ListTile(
                      contentPadding: const EdgeInsets.only(left: 5, right: 10),
                      title: CustomTextView("autoDownFavSong".tr),
                      subtitle: CustomTextView(
                        "autoDownFavSongDes".tr,
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                      trailing: Obx(
                        () => CustSwitch(
                          value: settingsController
                              .autoDownloadFavoriteSongEnabled
                              .value,
                          onChanged:
                              settingsController.toggleAutoDownloadFavoriteSong,
                        ),
                      ),
                    ),
                    ListTile(
                      contentPadding: const EdgeInsets.only(left: 5, right: 10),
                      title: CustomTextView("downloadingFormat".tr),
                      subtitle: CustomTextView(
                        "downloadingFormatDes".tr,
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                      trailing: Obx(
                        () => DropdownButton(
                          dropdownColor: Theme.of(context).cardColor,
                          underline: const SizedBox.shrink(),
                          value: settingsController.downloadingFormat.value,
                          items: const [
                            DropdownMenuItem(
                              value: "opus",
                              child: CustomTextView("Opus/Ogg"),
                            ),
                            DropdownMenuItem(
                              value: "m4a",
                              child: CustomTextView("M4a"),
                            ),
                          ],
                          onChanged: settingsController.changeDownloadingFormat,
                        ),
                      ),
                    ),
                    ListTile(
                      trailing: TextButton(
                        child: CustomTextView(
                          "reset".tr,
                          style: Theme.of(
                            context,
                          ).textTheme.titleMedium!.copyWith(fontSize: 15),
                        ),
                        onPressed: () {
                          settingsController.resetDownloadLocation();
                        },
                      ),
                      contentPadding: const EdgeInsets.only(
                        left: 5,
                        right: 10,
                        top: 0,
                      ),
                      title: CustomTextView("downloadLocation".tr),
                      subtitle: Obx(
                        () => CustomTextView(
                          settingsController.isCurrentPathsupportDownDir
                              ? "In App storage directory"
                              : settingsController.downloadLocationPath.value,
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      ),
                      onTap: () async {
                        settingsController.setDownloadLocation();
                      },
                    ),
                    if (GetPlatform.isAndroid)
                      ListTile(
                        contentPadding: const EdgeInsets.only(
                          left: 5,
                          right: 10,
                        ),
                        title: CustomTextView("exportDowloadedFiles".tr),
                        subtitle: CustomTextView(
                          "exportDowloadedFilesDes".tr,
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                        isThreeLine: true,
                        onTap: () =>
                            showDialog(
                              context: context,
                              builder: (context) => const ExportFileDialog(),
                            ).whenComplete(
                              () => Get.delete<ExportFileDialogController>(),
                            ),
                      ),
                    if (GetPlatform.isAndroid)
                      ListTile(
                        contentPadding: const EdgeInsets.only(
                          left: 5,
                          right: 10,
                          top: 0,
                        ),
                        title: CustomTextView("exportedFileLocation".tr),
                        subtitle: Obx(
                          () => CustomTextView(
                            settingsController.exportLocationPath.value,
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                        ),
                        onTap: () async {
                          settingsController.setExportedLocation();
                        },
                      ),
                  ],
                ),
                CustomExpansionTile(
                  title: "${"backup".tr} & ${"restore".tr}",
                  icon: Icons.restore,
                  children: [
                    ListTile(
                      contentPadding: const EdgeInsets.only(left: 5, right: 10),
                      title: CustomTextView("backupAppData".tr),
                      subtitle: CustomTextView(
                        "backupSettingsAndPlaylistsDes".tr,
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                      isThreeLine: true,
                      onTap: () =>
                          showDialog(
                            context: context,
                            builder: (context) => const BackupDialog(),
                          ).whenComplete(
                            () => Get.delete<BackupDialogController>(),
                          ),
                    ),
                    ListTile(
                      contentPadding: const EdgeInsets.only(left: 5, right: 10),
                      title: CustomTextView("restoreAppData".tr),
                      subtitle: CustomTextView(
                        "restoreSettingsAndPlaylistsDes".tr,
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                      isThreeLine: true,
                      onTap: () =>
                          showDialog(
                            context: context,
                            builder: (context) => const RestoreDialog(),
                          ).whenComplete(
                            () => Get.delete<RestoreDialogController>(),
                          ),
                    ),
                  ],
                ),
                CustomExpansionTile(
                  icon: Icons.miscellaneous_services,
                  title: "misc".tr,
                  children: [
                    ListTile(
                      contentPadding: const EdgeInsets.only(left: 5, right: 10),
                      title: CustomTextView("resetToDefault".tr),
                      subtitle: CustomTextView(
                        "resetToDefaultDes".tr,
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                      onTap: () {
                        settingsController.resetAppSettingsToDefault().then((
                          _,
                        ) {
                          ScaffoldMessenger.of(Get.context!).showSnackBar(
                            snackbar(
                              Get.context!,
                              "resetToDefaultMsg".tr,
                              size: SanckBarSize.BIG,
                              duration: const Duration(seconds: 2),
                            ),
                          );
                        });
                      },
                    ),
                  ],
                ),
                CustomExpansionTile(
                  icon: Icons.info,
                  title: "appInfo".tr,
                  children: [
                    ListTile(
                      contentPadding: const EdgeInsets.only(left: 5, right: 10),
                      title: CustomTextView("github".tr),
                      subtitle: CustomTextView(
                        "${"githubDes".tr}${((Get.find<PlayerController>().playerPanelMinHeight.value) == 0 || !isBottomNavActive) ? "" : "\n\n${settingsController.currentVersion} ${"by".tr} anandnet"}",
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                      isThreeLine: true,
                      onTap: () {
                        launchUrl(
                          Uri.parse(
                            'https://github.com/anandnet/Harmony-Music',
                          ),
                          mode: LaunchMode.externalApplication,
                        );
                      },
                    ),
                    const Divider(),
                    SizedBox(
                      child: Column(
                        children: [
                          CustomTextView(
                            "Harmony Music",
                            style: context.titleLarge,
                          ),
                          CustomTextView(
                            settingsController.currentVersion,
                            style: context.titleMedium,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 20.0),
            child: CustomTextView(
              "${settingsController.currentVersion} ${"by".tr} anandnet",
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ),
        ],
      ),
    );
  }
}

class ThemeSelectorDialog extends StatelessWidget {
  const ThemeSelectorDialog({super.key});

  @override
  Widget build(BuildContext context) {
    final settingsController = Get.find<SettingsScreenController>();
    return CommonDialog(
      child: Container(
        height: 300,
        //color: Theme.of(context).cardColor,
        padding: const EdgeInsets.only(top: 30, left: 5, right: 30, bottom: 10),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 20.0, bottom: 5),
              child: Align(
                alignment: Alignment.centerLeft,
                child: CustomTextView(
                  "themeMode".tr,
                  style: context.titleLarge,
                ),
              ),
            ),
            radioWidget(
              label: "dynamic".tr,
              controller: settingsController,
              value: ThemeType.dynamic,
            ),
            radioWidget(
              label: "systemDefault".tr,
              controller: settingsController,
              value: ThemeType.system,
            ),
            radioWidget(
              label: "dark".tr,
              controller: settingsController,
              value: ThemeType.dark,
            ),
            radioWidget(
              label: "light".tr,
              controller: settingsController,
              value: ThemeType.light,
            ),
            Align(
              alignment: Alignment.centerRight,
              child: InkWell(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CustomTextView("cancel".tr),
                ),
                onTap: () => Navigator.of(context).pop(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class DiscoverContentSelectorDialog extends StatelessWidget {
  const DiscoverContentSelectorDialog({super.key});

  @override
  Widget build(BuildContext context) {
    final settingsController = Get.find<SettingsScreenController>();
    return CommonDialog(
      child: Container(
        height: 300,
        //color: Theme.of(context).cardColor,
        padding: const EdgeInsets.only(top: 30, left: 5, right: 30, bottom: 10),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 20.0, bottom: 5),
              child: Align(
                alignment: Alignment.centerLeft,
                child: CustomTextView(
                  "setDiscoverContent".tr,
                  style: context.titleLarge,
                ),
              ),
            ),
            SizedBox(
              height: 180,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    radioWidget(
                      label: "quickpicks".tr,
                      controller: settingsController,
                      value: "QP",
                    ),
                    radioWidget(
                      label: "topmusicvideos".tr,
                      controller: settingsController,
                      value: "TMV",
                    ),
                    radioWidget(
                      label: "trending".tr,
                      controller: settingsController,
                      value: "TR",
                    ),
                    radioWidget(
                      label: "basedOnLast".tr,
                      controller: settingsController,
                      value: "BOLI",
                    ),
                  ],
                ),
              ),
            ),
            const Expanded(child: SizedBox()),
            Align(
              alignment: Alignment.centerRight,
              child: InkWell(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CustomTextView("cancel".tr),
                ),
                onTap: () => Navigator.of(context).pop(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Widget radioWidget({
  required String label,
  required SettingsScreenController controller,
  required value,
}) {
  return Obx(
    () => ListTile(
      visualDensity: const VisualDensity(vertical: -4),
      onTap: () {
        if (value.runtimeType == ThemeType) {
          controller.onThemeChange(value);
        } else {
          controller.onContentChange(value);
          Navigator.of(Get.context!).pop();
        }
      },
      leading: Radio(
        value: value,
        groupValue: value.runtimeType == ThemeType
            ? controller.themeModetype.value
            : controller.discoverContentType.value,
        onChanged: value.runtimeType == ThemeType
            ? controller.onThemeChange
            : controller.onContentChange,
      ),
      title: CustomTextView(label),
    ),
  );
}
