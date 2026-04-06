import 'package:soul_sync/core/utils/toast_util.dart';
import 'package:soul_sync/core/utils/string_file.dart';

import 'package:soul_sync/custom_view/custom_text_view.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:share_plus/share_plus.dart';
import 'package:soul_sync/core/extension/text_style.dart';
import '../../custom_view/custom_player/player_controller.dart';
import '../../custom_view/player_widget/animated_screen_transition.dart';
import '../../custom_view/player_widget/image_widget.dart';
import '../../custom_view/player_widget/loader.dart';
import '../../custom_view/player_widget/separate_tab_item_widget.dart';
import '../Settings/settings_screen_controller.dart';
import '../screen_navigation.dart';
import 'artist_screen_controller.dart';
import 'artist_screen_v2.dart';

class ArtistScreen extends StatelessWidget {
  const ArtistScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final playerController = Get.find<PlayerController>();
    final tag = key.hashCode.toString();
    final ArtistScreenController artistScreenController =
        Get.isRegistered<ArtistScreenController>(tag: tag)
            ? Get.find<ArtistScreenController>(tag: tag)
            : Get.put(ArtistScreenController(), tag: tag);
    return Scaffold(
      floatingActionButton: Obx(
        () => Padding(
          padding: EdgeInsets.only(
            bottom: playerController.playerPanelMinHeight.value,
          ),
          child: SizedBox(
            height: 60,
            width: 60,
            child: FittedBox(
              child: FloatingActionButton(
                focusElevation: 0,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(14)),
                ),
                elevation: 0,
                onPressed: () async {
                  final radioId = artistScreenController.artist_.radioId;
                  if (radioId == null) {
                    ToastUtil.successWithSize(
                      size: ToastSize.big,
                      message: StringFile.radioNotAvailable,
                    );

                    return;
                  }
                  playerController.startRadio(
                    null,
                    playlistid: artistScreenController.artist_.radioId,
                  );
                },
                child: const Icon(Icons.sensors),
              ),
            ),
          ),
        ),
      ),
      body: GetPlatform.isDesktop ||
              Get.find<SettingsScreenController>().isBottomNavBarEnabled.value
          ? ArtistScreenBN(
              artistScreenController: artistScreenController,
              tag: tag,
            )
          : Row(
              children: [
                Align(
                  alignment: Alignment.topCenter,
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.only(bottom: 80),
                    child: IntrinsicHeight(
                      child: Obx(
                        () => NavigationRail(
                          onDestinationSelected:
                              artistScreenController.onDestinationSelected,
                          minWidth: 60,
                          destinations: [
                            StringFile.about,
                            StringFile.songs,
                            StringFile.videos,
                            StringFile.albums,
                            StringFile.singles,
                          ].map((e) => railDestination(e)).toList(),
                          leading: Column(
                            children: [
                              SizedBox(
                                height: context.isLandscape ? 20.0 : 45.0,
                              ),
                              IconButton(
                                icon: Icon(
                                  Icons.arrow_back_ios_new,
                                  color: Theme.of(
                                    context,
                                  ).textTheme.titleMedium!.color,
                                ),
                                onPressed: () {
                                  Get.nestedKey(
                                    ScreenNavigationSetup.id,
                                  )!
                                      .currentState!
                                      .pop();
                                },
                              ),
                              const SizedBox(height: 10),
                            ],
                          ),
                          labelType: NavigationRailLabelType.all,
                          selectedIndex: artistScreenController
                              .navigationRailCurrentIndex.value,
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Obx(
                    () => AnimatedScreenTransition(
                      enabled: Get.find<SettingsScreenController>()
                          .isTransitionAnimationDisabled
                          .isFalse,
                      resverse: artistScreenController.isTabTransitionReversed,
                      child: Center(
                        key: ValueKey<int>(
                          artistScreenController
                              .navigationRailCurrentIndex.value,
                        ),
                        child: Body(tag: tag),
                      ),
                    ),
                  ),
                ),
              ],
            ),
    );
  }

  NavigationRailDestination railDestination(String label) {
    return NavigationRailDestination(
      icon: const SizedBox.shrink(),
      label: RotatedBox(quarterTurns: -1, child: CustomTextView(label)),
    );
  }
}

class Body extends StatelessWidget {
  const Body({super.key, required this.tag});

  final String tag;

  @override
  Widget build(BuildContext context) {
    final ArtistScreenController artistScreenController =
        Get.find<ArtistScreenController>(tag: tag);

    final tabIndex = artistScreenController.navigationRailCurrentIndex.value;

    if (tabIndex == 0) {
      return Obx(
        () => artistScreenController.isArtistContentFetced.isTrue
            ? AboutArtist(artistScreenController: artistScreenController)
            : const Center(child: LoadingIndicator()),
      );
    } else {
      final separatedContent = artistScreenController.sepataredContent;
      final currentTabName = [
        "About",
        "Songs",
        "Videos",
        "Albums",
        "Singles",
      ][tabIndex];
      return Obx(() {
        if (artistScreenController.isSeparatedArtistContentFetced.isFalse &&
            artistScreenController.navigationRailCurrentIndex.value != 0) {
          return const Center(child: LoadingIndicator());
        }
        return SeparateTabItemWidget(
          artistControllerTag: tag,
          isResultWidget: false,
          items: separatedContent.containsKey(currentTabName)
              ? separatedContent[currentTabName]['results']
              : [],
          title: currentTabName,
          topPadding: context.isLandscape ? 50.0 : 80.0,
          scrollController: currentTabName == "Songs"
              ? artistScreenController.songScrollController
              : currentTabName == "Videos"
                  ? artistScreenController.videoScrollController
                  : currentTabName == "Albums"
                      ? artistScreenController.albumScrollController
                      : currentTabName == "Singles"
                          ? artistScreenController.singlesScrollController
                          : null,
        );
      });
    }
  }
}

class AboutArtist extends StatelessWidget {
  const AboutArtist({
    super.key,
    required this.artistScreenController,
    this.padding = const EdgeInsets.only(bottom: 90, top: 70),
  });

  final EdgeInsetsGeometry padding;
  final ArtistScreenController artistScreenController;

  @override
  Widget build(BuildContext context) {
    final artistData = artistScreenController.artistData;
    return Align(
      alignment: Alignment.topCenter,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          padding: padding,
          child: artistScreenController.isArtistContentFetced.value
              ? Column(
                  children: [
                    SizedBox(
                      height: 200,
                      width: 260,
                      child: Stack(
                        children: [
                          Center(
                            child: ImageWidget(
                              size: 200,
                              artist: artistScreenController.artist_,
                            ),
                          ),
                          Align(
                            alignment: Alignment.topRight,
                            child: Column(
                              children: [
                                InkWell(
                                  onTap: () {
                                    final bool add = artistScreenController
                                        .isAddedToLibrary.isFalse;
                                    artistScreenController
                                        .addNremoveFromLibrary(add: add)
                                        .then(
                                      (value) {
                                        if (context.mounted) {
                                          ToastUtil.infoWithSize(
                                            size: ToastSize.medium,
                                            message: value
                                                ? add
                                                    ? StringFile
                                                        .artistBookmarkAddAlert
                                                    : StringFile
                                                        .artistBookmarkRemoveAlert
                                                : StringFile.operationFailed,
                                          );
                                        }
                                      },
                                    );
                                  },
                                  child: Obx(
                                    () => artistScreenController
                                            .isArtistContentFetced.isFalse
                                        ? const SizedBox.shrink()
                                        : Icon(
                                            artistScreenController
                                                    .isAddedToLibrary.isFalse
                                                ? Icons.bookmark_add
                                                : Icons.bookmark_added,
                                          ),
                                  ),
                                ),
                                IconButton(
                                  icon: const Icon(Icons.share, size: 20),
                                  splashRadius: 18,
                                  onPressed: () => Share.share(
                                    "https://music.youtube.com/channel/${artistScreenController.artist_.browseId}",
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10, bottom: 10),
                      child: CustomTextView(
                        artistScreenController.artist_.name,
                        style: context.titleLarge,
                      ),
                    ),
                    (artistData.containsKey("description") &&
                            artistData["description"] != null)
                        ? Align(
                            alignment: Alignment.centerLeft,
                            child: CustomTextView(
                              "\"${artistData["description"]}\"",
                              style: context.titleSmall,
                            ),
                          )
                        : SizedBox(
                            height: 300,
                            child: Center(
                              child: CustomTextView(
                                StringFile.artistDesNotAvailable,
                                style: context.titleSmall,
                              ),
                            ),
                          ),
                  ],
                )
              : const SizedBox.shrink(),
        ),
      ),
    );
  }
}
