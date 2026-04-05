import 'package:soul_sync/core/extension/text_style.dart';
import 'package:soul_sync/custom_view/custom_text_view.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../models/playlist.dart';
import '../../custom_view/player_widget/content_list_widget_item.dart';
import '../../custom_view/player_widget/list_widget.dart';
import '../../custom_view/player_widget/modification_list.dart';
import '../../custom_view/player_widget/piped_sync_widget.dart';
import '../../custom_view/player_widget/sort_widget.dart';
import 'library_controller.dart';
import '../Settings/settings_screen_controller.dart';

class SongsLibraryWidget extends StatelessWidget {
  const SongsLibraryWidget({super.key, this.isBottomNavActive = false});

  final bool isBottomNavActive;

  @override
  Widget build(BuildContext context) {
    final topPadding = context.isLandscape ? 50.0 : 90.0;
    return Padding(
      padding: isBottomNavActive
          ? const EdgeInsets.only(left: 15)
          : EdgeInsets.only(left: 5.0, top: topPadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          isBottomNavActive
              ? const SizedBox(height: 10)
              : Align(
                  alignment: Alignment.centerLeft,
                  child: CustomTextView(
                    "libSongs".tr,
                    style: context.titleLarge,
                  ),
                ),
          Obx(() {
            final libSongsController = Get.find<LibrarySongsController>();
            return SortWidget(
              tag: "LibSongSort",
              screenController: libSongsController,
              itemCountTitle: "${libSongsController.librarySongsList.length}",
              itemIcon: Icons.music_note,
              titleLeftPadding: 9,
              requiredSortTypes: buildSortTypeSet(true, true),
              isSearchFeatureRequired: true,
              isSongDeletetioFeatureRequired: true,
              onSort: (type, ascending) {
                libSongsController.onSort(type, ascending);
              },
              onSearch: libSongsController.onSearch,
              onSearchClose: libSongsController.onSearchClose,
              onSearchStart: libSongsController.onSearchStart,
              startAdditionalOperation:
                  libSongsController.startAdditionalOperation,
              selectAll: libSongsController.selectAll,
              performAdditionalOperation:
                  libSongsController.performAdditionalOperation,
              cancelAdditionalOperation:
                  libSongsController.cancelAdditionalOperation,
            );
          }),
          GetX<LibrarySongsController>(
            builder: (controller) {
              return controller.librarySongsList.isNotEmpty
                  ? (controller.additionalOperationMode.value ==
                            OperationMode.none
                        ? ListWidget(
                            controller.librarySongsList,
                            "library Songs",
                            true,
                            isPlaylistOrAlbum: true,
                            playlist: Playlist(
                              title: "library Songs",
                              playlistId: "SongsDownloads",
                              thumbnailUrl: "",
                              isCloudPlaylist: false,
                            ),
                          )
                        : ModificationList(
                            mode: controller.additionalOperationMode.value,
                            screenController: controller,
                          ))
                  : Expanded(
                      child: Center(
                        child: CustomTextView(
                          "noOfflineSong".tr,
                          style: context.titleMedium,
                        ),
                      ),
                    );
            },
          ),
        ],
      ),
    );
  }
}

class PlaylistNAlbumLibraryWidget extends StatelessWidget {
  const PlaylistNAlbumLibraryWidget({
    super.key,
    this.isAlbumContent = true,
    this.isBottomNavActive = false,
  });

  final bool isAlbumContent;
  final bool isBottomNavActive;

  @override
  Widget build(BuildContext context) {
    final libralbumCntrller = Get.find<LibraryAlbumsController>();
    final librplstCntrller = Get.find<LibraryPlaylistsController>();
    final settingscrnController = Get.find<SettingsScreenController>();
    final size = MediaQuery.of(context).size;

    const double itemHeight = 180;
    const double itemWidth = 130;
    final topPadding = context.isLandscape ? 50.0 : 90.0;

    return Padding(
      padding: isBottomNavActive
          ? const EdgeInsets.only(left: 15)
          : EdgeInsets.only(top: topPadding),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 5.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                isBottomNavActive
                    ? const SizedBox(height: 10)
                    : Align(
                        alignment: Alignment.centerLeft,
                        child: CustomTextView(
                          isAlbumContent ? "libAlbums".tr : "libPlaylists".tr,
                          style: context.titleLarge,
                        ),
                      ),
                (settingscrnController.isBottomNavBarEnabled.isTrue ||
                        isAlbumContent ||
                        settingscrnController.isLinkedWithPiped.isFalse)
                    ? const SizedBox.shrink()
                    : PipedSyncWidget(
                        padding: EdgeInsets.only(right: size.width * .05),
                      ),
              ],
            ),
          ),
          Obx(
            () => isAlbumContent
                ? SortWidget(
                    tag: "LibAlbumSort",
                    screenController: libralbumCntrller,
                    isAdditionalOperationRequired: false,
                    isSearchFeatureRequired: true,
                    itemCountTitle:
                        "${libralbumCntrller.libraryAlbums.length} ${"items".tr}",
                    requiredSortTypes: buildSortTypeSet(true),
                    onSort: (type, ascending) {
                      libralbumCntrller.onSort(type, ascending);
                    },
                    onSearch: libralbumCntrller.onSearch,
                    onSearchClose: libralbumCntrller.onSearchClose,
                    onSearchStart: libralbumCntrller.onSearchStart,
                  )
                : SortWidget(
                    tag: "LibPlaylistSort",
                    screenController: librplstCntrller,
                    isAdditionalOperationRequired: false,
                    isSearchFeatureRequired: true,
                    itemCountTitle:
                        "${librplstCntrller.libraryPlaylists.length} ${"items".tr}",
                    requiredSortTypes: buildSortTypeSet(),
                    onSort: (type, ascending) {
                      librplstCntrller.onSort(type, ascending);
                    },
                    onSearch: librplstCntrller.onSearch,
                    onSearchClose: librplstCntrller.onSearchClose,
                    onSearchStart: librplstCntrller.onSearchStart,
                    isImportFeatureRequired: true,
                  ),
          ),
          Expanded(
            child: Obx(
              () =>
                  (isAlbumContent
                      ? libralbumCntrller.libraryAlbums.isNotEmpty
                      : librplstCntrller.libraryPlaylists.isNotEmpty)
                  ? LayoutBuilder(
                      builder: (context, constraints) {
                        //Fix for grid in mobile screen
                        final availableWidth =
                            constraints.maxWidth > 300 &&
                                constraints.maxWidth < 394
                            ? 310.0
                            : constraints.maxWidth;
                        int columns = (availableWidth / itemWidth).floor();
                        return SizedBox(
                          width: availableWidth,
                          child: GridView.builder(
                            physics: const BouncingScrollPhysics(),
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: columns,
                                  childAspectRatio: (itemWidth / itemHeight),
                                ),
                            controller: ScrollController(
                              keepScrollOffset: false,
                            ),
                            shrinkWrap: true,
                            scrollDirection: Axis.vertical,
                            padding: const EdgeInsets.only(
                              bottom: 200,
                              top: 10,
                            ),
                            itemCount: isAlbumContent
                                ? libralbumCntrller.libraryAlbums.length
                                : librplstCntrller.libraryPlaylists.length,
                            itemBuilder: (context, index) => Center(
                              child: ContentListItem(
                                content: isAlbumContent
                                    ? libralbumCntrller.libraryAlbums[index]
                                    : librplstCntrller.libraryPlaylists[index],
                                isLibraryItem: true,
                              ),
                            ),
                          ),
                        );
                      },
                    )
                  : Center(
                      child: CustomTextView(
                        "noBookmarks".tr,
                        style: context.titleMedium,
                      ),
                    ),
            ),
          ),
        ],
      ),
    );
  }
}

class LibraryArtistWidget extends StatelessWidget {
  const LibraryArtistWidget({super.key, this.isBottomNavActive = false});

  final bool isBottomNavActive;

  @override
  Widget build(BuildContext context) {
    final cntrller = Get.find<LibraryArtistsController>();
    final topPadding = context.isLandscape ? 50.0 : 90.0;
    return Padding(
      padding: isBottomNavActive
          ? const EdgeInsets.only(left: 15)
          : EdgeInsets.only(left: 5, top: topPadding),
      child: Column(
        children: [
          isBottomNavActive
              ? const SizedBox(height: 10)
              : Align(
                  alignment: Alignment.centerLeft,
                  child: CustomTextView(
                    "libArtists".tr,
                    style: context.titleLarge,
                  ),
                ),
          Obx(
            () => SortWidget(
              tag: "LibArtistSort",
              screenController: cntrller,
              isAdditionalOperationRequired: false,
              isSearchFeatureRequired: true,
              itemCountTitle: "${cntrller.libraryArtists.length} ${"items".tr}",
              onSort: (type, ascending) {
                cntrller.onSort(type, ascending);
              },
              onSearch: cntrller.onSearch,
              onSearchClose: cntrller.onSearchClose,
              onSearchStart: cntrller.onSearchStart,
            ),
          ),
          Obx(
            () => cntrller.libraryArtists.isNotEmpty
                ? ListWidget(cntrller.libraryArtists, "library artists", true)
                : Expanded(
                    child: Center(
                      child: CustomTextView(
                        "noBookmarks".tr,
                        style: context.titleMedium,
                      ),
                    ),
                  ),
          ),
        ],
      ),
    );
  }
}
