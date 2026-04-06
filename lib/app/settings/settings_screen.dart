import 'package:soul_sync/core/utils/string_file.dart';

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
            child: CustomTextView(
              StringFile.settings,
              style: context.titleLarge,
            ),
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
                              title: CustomTextView(
                                StringFile.newVersionAvailable,
                              ),
                              visualDensity: const VisualDensity(
                                horizontal: -2,
                              ),
                              subtitle: CustomTextView(
                                StringFile.goToDownloadPage,
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
                  title: StringFile.personalisation,
                  icon: Icons.palette,
                  children: [
                    ListTile(
                      contentPadding: const EdgeInsets.only(left: 5, right: 10),
                      title: CustomTextView(StringFile.themeMode),
                      subtitle: Obx(
                        () => CustomTextView(
                          settingsController.themeModetype.value ==
                                  ThemeType.dynamic
                              ? StringFile.dynamic
                              : settingsController.themeModetype.value ==
                                    ThemeType.system
                              ? StringFile.systemDefault
                              : settingsController.themeModetype.value ==
                                    ThemeType.dark
                              ? StringFile.dark
                              : StringFile.light,
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
                      title: CustomTextView(StringFile.language),
                      subtitle: CustomTextView(
                        StringFile.languageDes,
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
                        title: CustomTextView(StringFile.playerUi),
                        subtitle: CustomTextView(
                          StringFile.playerUiDes,
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
                                child: CustomTextView(StringFile.standard),
                              ),
                              DropdownMenuItem(
                                value: 1,
                                child: CustomTextView(StringFile.gesture),
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
                        title: CustomTextView(StringFile.enableBottomNav),
                        subtitle: CustomTextView(
                          StringFile.enableBottomNavDes,
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
                      title: CustomTextView(
                        StringFile.disableTransitionAnimation,
                      ),
                      subtitle: CustomTextView(
                        StringFile.disableTransitionAnimationDes,
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
                      title: CustomTextView(StringFile.enableSlidableAction),
                      subtitle: CustomTextView(
                        StringFile.enableSlidableActionDes,
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
                  title: StringFile.content,
                  icon: Icons.music_video,
                  children: [
                    ListTile(
                      contentPadding: const EdgeInsets.only(left: 5, right: 10),
                      title: CustomTextView(StringFile.setDiscoverContent),
                      subtitle: Obx(
                        () => CustomTextView(
                          settingsController.discoverContentType.value == "QP"
                              ? StringFile.quickpicks
                              : settingsController.discoverContentType.value ==
                                    "TMV"
                              ? StringFile.topmusicvideos
                              : settingsController.discoverContentType.value ==
                                    "TR"
                              ? StringFile.trending
                              : StringFile.basedOnLast,
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
                      title: CustomTextView(StringFile.homeContentCount),
                      subtitle: CustomTextView(
                        StringFile.homeContentCountDes,
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
                      title: CustomTextView(StringFile.cacheHomeScreenData),
                      subtitle: CustomTextView(
                        StringFile.cacheHomeScreenDataDes,
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
                      title: CustomTextView(StringFile.piped),
                      subtitle: CustomTextView(
                        StringFile.linkPipedDes,
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                      trailing: TextButton(
                        child: Obx(
                          () => CustomTextView(
                            settingsController.isLinkedWithPiped.value
                                ? StringFile.unLink
                                : StringFile.link,
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
                                StringFile.resetblacklistedplaylist,
                              ),
                              subtitle: CustomTextView(
                                StringFile.resetblacklistedplaylistDes,
                                style: Theme.of(context).textTheme.bodyMedium,
                              ),
                              trailing: TextButton(
                                child: CustomTextView(
                                  StringFile.reset,
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
                                      StringFile.blacklistPlstResetAlert,
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
                      title: CustomTextView(StringFile.clearImgCache),
                      subtitle: CustomTextView(
                        StringFile.clearImgCacheDes,
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                      isThreeLine: true,
                      onTap: () {
                        settingsController.clearImagesCache().then(
                          (value) =>
                              ScaffoldMessenger.of(Get.context!).showSnackBar(
                                snackbar(
                                  Get.context!,
                                  StringFile.clearImgCacheAlert,
                                  size: SanckBarSize.BIG,
                                ),
                              ),
                        );
                      },
                    ),
                  ],
                ),
                CustomExpansionTile(
                  title: StringFile.musicAndPlayback,
                  icon: Icons.music_note,
                  children: [
                    ListTile(
                      contentPadding: const EdgeInsets.only(left: 5, right: 10),
                      title: CustomTextView(StringFile.streamingQuality),
                      subtitle: CustomTextView(
                        StringFile.streamingQualityDes,
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
                              child: CustomTextView(StringFile.low),
                            ),
                            DropdownMenuItem(
                              value: AudioQuality.High,
                              child: CustomTextView(StringFile.high),
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
                        title: CustomTextView(StringFile.loudnessNormalization),
                        subtitle: CustomTextView(
                          StringFile.loudnessNormalizationDes,
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
                        title: CustomTextView(StringFile.cacheSongs),
                        subtitle: CustomTextView(
                          StringFile.cacheSongsDes,
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
                        title: CustomTextView(StringFile.skipSilence),
                        subtitle: CustomTextView(
                          StringFile.skipSilenceDes,
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
                        title: CustomTextView(StringFile.backgroundPlay),
                        subtitle: CustomTextView(
                          StringFile.backgroundPlayDes,
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
                      title: CustomTextView(
                        StringFile.keepScreenOnWhilePlaying,
                      ),
                      subtitle: CustomTextView(
                        StringFile.keepScreenOnWhilePlayingDes,
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
                      title: CustomTextView(
                        StringFile.restoreLastPlaybackSession,
                      ),
                      subtitle: CustomTextView(
                        StringFile.restoreLastPlaybackSessionDes,
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
                      title: CustomTextView(StringFile.autoOpenPlayer),
                      subtitle: CustomTextView(
                        StringFile.autoOpenPlayerDes,
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
                        title: CustomTextView(StringFile.equalizer),
                        subtitle: CustomTextView(
                          StringFile.equalizerDes,
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
                        title: CustomTextView(StringFile.stopMusicOnTaskClear),
                        subtitle: CustomTextView(
                          StringFile.stopMusicOnTaskClearDes,
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
                              title: CustomTextView(StringFile.ignoreBatOpt),
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
                                        "${StringFile.status}: ${settingsController.isIgnoringBatteryOptimizations.isTrue ? StringFile.enabled : StringFile.disabled}\n",
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium!
                                        .copyWith(fontWeight: FontWeight.bold),
                                    children: <TextSpan>[
                                      TextSpan(
                                        text: StringFile.ignoreBatOptDes,
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
                  title: StringFile.download,
                  icon: Icons.download,
                  children: [
                    ListTile(
                      contentPadding: const EdgeInsets.only(left: 5, right: 10),
                      title: CustomTextView(StringFile.autoDownFavSong),
                      subtitle: CustomTextView(
                        StringFile.autoDownFavSongDes,
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
                      title: CustomTextView(StringFile.downloadingFormat),
                      subtitle: CustomTextView(
                        StringFile.downloadingFormatDes,
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
                          StringFile.reset,
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
                      title: CustomTextView(StringFile.downloadLocation),
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
                        title: CustomTextView(StringFile.exportDowloadedFiles),
                        subtitle: CustomTextView(
                          StringFile.exportDowloadedFilesDes,
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
                        title: CustomTextView(StringFile.exportedFileLocation),
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
                  title: "${StringFile.backup} & ${StringFile.restore}",
                  icon: Icons.restore,
                  children: [
                    ListTile(
                      contentPadding: const EdgeInsets.only(left: 5, right: 10),
                      title: CustomTextView(StringFile.backupAppData),
                      subtitle: CustomTextView(
                        StringFile.backupSettingsAndPlaylistsDes,
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
                      title: CustomTextView(StringFile.restoreAppData),
                      subtitle: CustomTextView(
                        StringFile.restoreSettingsAndPlaylistsDes,
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
                  title: StringFile.misc,
                  children: [
                    ListTile(
                      contentPadding: const EdgeInsets.only(left: 5, right: 10),
                      title: CustomTextView(StringFile.resetToDefault),
                      subtitle: CustomTextView(
                        StringFile.resetToDefaultDes,
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                      onTap: () {
                        settingsController.resetAppSettingsToDefault().then((
                          _,
                        ) {
                          ScaffoldMessenger.of(Get.context!).showSnackBar(
                            snackbar(
                              Get.context!,
                              StringFile.resetToDefaultMsg,
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
                  title: StringFile.appInfo,
                  children: [
                    ListTile(
                      contentPadding: const EdgeInsets.only(left: 5, right: 10),
                      title: CustomTextView(StringFile.github),
                      subtitle: CustomTextView(
                        "${StringFile.githubDes}${((Get.find<PlayerController>().playerPanelMinHeight.value) == 0 || !isBottomNavActive) ? "" : "\n\n${settingsController.currentVersion} ${StringFile.by} anandnet"}",
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
              "${settingsController.currentVersion} ${StringFile.by} anandnet",
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
                  StringFile.themeMode,
                  style: context.titleLarge,
                ),
              ),
            ),
            radioWidget(
              label: StringFile.dynamic,
              controller: settingsController,
              value: ThemeType.dynamic,
            ),
            radioWidget(
              label: StringFile.systemDefault,
              controller: settingsController,
              value: ThemeType.system,
            ),
            radioWidget(
              label: StringFile.dark,
              controller: settingsController,
              value: ThemeType.dark,
            ),
            radioWidget(
              label: StringFile.light,
              controller: settingsController,
              value: ThemeType.light,
            ),
            Align(
              alignment: Alignment.centerRight,
              child: InkWell(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CustomTextView(StringFile.cancel),
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
                  StringFile.setDiscoverContent,
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
                      label: StringFile.quickpicks,
                      controller: settingsController,
                      value: "QP",
                    ),
                    radioWidget(
                      label: StringFile.topmusicvideos,
                      controller: settingsController,
                      value: "TMV",
                    ),
                    radioWidget(
                      label: StringFile.trending,
                      controller: settingsController,
                      value: "TR",
                    ),
                    radioWidget(
                      label: StringFile.basedOnLast,
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
                  child: CustomTextView(StringFile.cancel),
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
