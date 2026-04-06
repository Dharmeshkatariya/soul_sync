import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../core/utils/logger_utils.dart';
import '../../core/utils/player_utils/song_utils.dart';
import '../../custom_view/player_widget/sort_widget.dart';
import '../Home/home_screen_controller.dart';
import '../Settings/settings_screen_controller.dart';
import '/services/music_service.dart';

class SearchResultScreenController extends GetxController
    with GetTickerProviderStateMixin {
  final navigationRailCurrentIndex = 0.obs;
  final isResultContentFetced = false.obs;
  final isSeparatedResultContentFetced = false.obs;
  final resultContent = <String, dynamic>{}.obs;
  final separatedResultContent = <String, dynamic>{}.obs;
  final musicServices = Get.find<MusicServices>();
  final queryString = ''.obs;
  final railItems = <String>[].obs;
  final railitemHeight = Get.size.height.obs;
  final additionalParamNext = {};
  bool continuationInProgress = false;
  TabController? tabController;
  bool isTabTransitionReversed = false;
  //ScrollContollers List
  final Map<String, ScrollController> scrollControllers = {};

  @override
  void onReady() {
    _getInitSearchResult();
    Get.find<HomeScreenController>().whenHomeScreenOnTop();
    super.onReady();
  }

  Future<void> onDestinationSelected(
    int value, {
    bool ignoreTabCommand = false,
  }) async {
    if (railItems.isEmpty) {
      return;
    }

    isTabTransitionReversed = value > navigationRailCurrentIndex.value;

    isSeparatedResultContentFetced.value = false;
    navigationRailCurrentIndex.value = value;

    if (tabController != null && !ignoreTabCommand) {
      tabController?.animateTo(value);
    }

    if (value > 0 &&
        (!separatedResultContent.containsKey(railItems[value - 1]) ||
            separatedResultContent[railItems[value - 1]].isEmpty)) {
      final tabName = railItems[value - 1];
      final itemCount = (tabName == 'Songs' || tabName == 'Videos') ? 25 : 10;
      final x = await musicServices.search(
        queryString.value,
        filter: tabName.replaceAll(" ", "_").toLowerCase(),
        limit: itemCount,
        filterParams: resultContent['searchEndpoint'][tabName],
      );
      separatedResultContent[tabName] = x[tabName];
      additionalParamNext[tabName] = x['params'];
      isSeparatedResultContentFetced.value = true;
      final scrollController = scrollControllers[tabName];
      (scrollController)!.addListener(() {
        double maxScroll = scrollController.position.maxScrollExtent;
        double currentScroll = scrollController.position.pixels;
        if (currentScroll >= maxScroll / 2 &&
            additionalParamNext[tabName]['additionalParams'] !=
                '&ctoken=null&continuation=null') {
          if (!continuationInProgress) {
            LoggerUtil.info("Acchhsk");
            continuationInProgress = true;
            getContinuationContents();
          }
        }
      });
    }
    isSeparatedResultContentFetced.value = true;
  }

  Future<void> getContinuationContents() async {
    final tabName = railItems[navigationRailCurrentIndex.value - 1];

    final x = await musicServices.getSearchContinuation(
      additionalParamNext[tabName],
    );
    (separatedResultContent[tabName]).addAll(x[tabName]);
    additionalParamNext[tabName] = x['params'];
    separatedResultContent.refresh();

    continuationInProgress = false;
  }

  void viewAllCallback(String text) {
    onDestinationSelected(railItems.indexOf(text) + 1);
  }

  Future<void> _getInitSearchResult() async {
    isResultContentFetced.value = false;
    final args = Get.arguments;
    if (args != null) {
      queryString.value = args;
      resultContent.value = await musicServices.search(args);
      final allKeys = resultContent.keys.where(
        (element) => ([
          "Songs",
          "Videos",
          "Albums",
          "Featured playlists",
          "Community playlists",
          "artists",
        ]).contains(element),
      );
      railItems.value = List<String>.from(allKeys);
      final len =
          railItems.where((element) => element.contains("playlists")).length;
      final calH = 30 + (railItems.length + 1 - len) * 123 + len * 150.0;
      railitemHeight.value =
          calH >= railitemHeight.value ? calH : railitemHeight.value;

      //ScrollControlers for list Continuation callback implementarion
      for (String item in railItems) {
        scrollControllers[item] = ScrollController();
      }

      //Case if bottom nav used
      if (GetPlatform.isDesktop ||
          Get.find<SettingsScreenController>().isBottomNavBarEnabled.isTrue) {
        // assiging init val
        for (var element in railItems) {
          separatedResultContent[element] = [];
        }

        //tab controller for v2
        tabController = TabController(
          length: railItems.length + 1,
          vsync: this,
        );

        tabController?.animation?.addListener(() {
          int indexChange = tabController!.offset.round();
          int index = tabController!.index + indexChange;

          if (index != navigationRailCurrentIndex.value) {
            onDestinationSelected(index, ignoreTabCommand: true);
          }
        });
      }
      isResultContentFetced.value = true;
    }
  }

  void onSort(SortType sortType, bool isAscending, String title) {
    if (title == "Songs" || title == "Videos") {
      final songList = separatedResultContent[title].toList();
      SongUtils.sortSongsNVideos(
          songlist: songList, sortType: sortType, isAscending: isAscending);
      separatedResultContent[title] = songList;
    } else if (title.contains('playlists')) {
      final playlists = separatedResultContent[title].toList();
      SongUtils.sortPlayLists(
          playlists: playlists, sortType: sortType, isAscending: isAscending);
      separatedResultContent[title] = playlists;
    } else if (title == "artists") {
      final artistList = separatedResultContent[title].toList();
      SongUtils.sortArtist(
          artistList: artistList, sortType: sortType, isAscending: isAscending);
      separatedResultContent[title] = artistList;
    } else if (title == "Albums") {
      final albumList = separatedResultContent[title].toList();
      SongUtils. sortAlbumNSingles(
          albumList:
          albumList, sortType: sortType,isAscending: isAscending);
      separatedResultContent[title] = albumList;
    }
  }

  @override
  void onClose() {
    for (String item in railItems) {
      (scrollControllers[item])!.dispose();
    }
    Get.find<HomeScreenController>().whenHomeScreenOnTop();
    tabController?.dispose();
    super.onClose();
  }
}
