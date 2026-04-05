import 'package:flutter/material.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';

import '../custom_horizontal_pager.dart';

class VerticalPagerScrolling {
  static void getSectionHeightAsync(
    GlobalKey key,
    Function(double) onHeightReady,
  ) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final context = key.currentContext;
      if (context != null) {
        final RenderBox renderBox = context.findRenderObject() as RenderBox;
        onHeightReady(renderBox.size.height);
      } else {
        onHeightReady(0.0);
      }
    });
  }

  static double getSectionHeight(GlobalKey key) {
    final context = key.currentContext;
    if (context != null) {
      final RenderBox renderBox = context.findRenderObject() as RenderBox;
      return renderBox.size.height;
    }
    return 0.0;
  }

  static verticalPageScrolling({
    required List<GlobalKey> globalKeyList,
    required ScrollController scrollController,
    required double gapHeightBetweenWidget,
    required RxList<PagerModel> pagerDataList,
    required Rx<PagerModel> selectedPagerData,
  }) {
    double scrollPosition = scrollController.position.pixels;
    List<GlobalKey> sectionKeys = globalKeyList;
    List<double> sectionHeights = sectionKeys
        .map((key) => getSectionHeight(key))
        .toList();
    double gapHeight = gapHeightBetweenWidget;
    double cumulativeHeight = 0.0;
    for (int i = 0; i < sectionHeights.length; i++) {
      cumulativeHeight += sectionHeights[i] + gapHeight;
      if (scrollPosition < cumulativeHeight) {
        selectedPagerData.value = pagerDataList[i];
        break;
      }
    }
  }

  static void verticalPageScrollingDynamicType<T>({
    required List<GlobalKey> globalKeyList,
    required ScrollController scrollController,
    required double gapHeightBetweenWidget,
    required RxList<T> pagerDataList,
    required Rx<T> selectedPagerData,
  }) {
    double scrollPosition = scrollController.position.pixels;
    List<GlobalKey> sectionKeys = globalKeyList;
    List<double> sectionHeights = sectionKeys
        .map((key) => getSectionHeight(key))
        .toList();
    double gapHeight = gapHeightBetweenWidget;
    double cumulativeHeight = 0.0;
    for (int i = 0; i < sectionHeights.length; i++) {
      cumulativeHeight += sectionHeights[i] + gapHeight;
      if (scrollPosition < cumulativeHeight) {
        selectedPagerData.value = pagerDataList[i];
        break;
      }
    }
  }

  static verticalPageScrollingForIndex<T>({
    required List<GlobalKey> globalKeyList,
    required ScrollController scrollController,
    required double gapHeightBetweenWidget,
    required RxList<T> pagerDataList,
    required Rx<int> selectedIndex,
  }) {
    double scrollPosition = scrollController.position.pixels;
    List<double> sectionHeights = globalKeyList
        .map((key) => getSectionHeight(key))
        .toList();
    double cumulativeHeight = 0.0;
    for (int i = 0; i < sectionHeights.length; i++) {
      cumulativeHeight += sectionHeights[i] + gapHeightBetweenWidget;
      if (scrollPosition < cumulativeHeight) {
        selectedIndex.value = i;
        break;
      }
    }
  }

  handleScrollUsingContextKey() {
    // var referredFromContext = referredFromFormKey.currentContext;
    // var referredToContext = referredToFormKey.currentContext;
    // if (referredFromContext != null && referredToContext != null) {
    //   var referredFromBox = referredFromContext.findRenderObject() as RenderBox;
    //   var referredToBox = referredToContext.findRenderObject() as RenderBox;
    //   double scrollPosition = referralScrollController.position.pixels;
    //   if (scrollPosition >= referredFromBox
    //       .localToGlobal(Offset.zero)
    //       .dy &&
    //       scrollPosition < referredToBox
    //           .localToGlobal(Offset.zero)
    //           .dy) {
    //     selectedReferralSourcePagerData.value = referralSourcePagersData[0];
    //   } else if (scrollPosition >= referredToBox
    //       .localToGlobal(Offset.zero)
    //       .dy) {
    //     selectedReferralSourcePagerData.value = referralSourcePagersData[1];
    //   }
    // }
  }

  /// Scroll to a specific section using its [GlobalKey]
  static Future<void> scrollToSection({
    required GlobalKey sectionKey,
    required ScrollController scrollController,
    Duration duration = const Duration(milliseconds: 300),
    Curve curve = Curves.easeInOutCubic,
  }) async {
    final context = sectionKey.currentContext;
    if (context != null) {
      final RenderBox renderBox = context.findRenderObject() as RenderBox;
      final offset =
          renderBox.localToGlobal(Offset.zero).dy + scrollController.offset;
      await scrollController.animateTo(
        offset,
        duration: duration,
        curve: curve,
      );
    }
  }

  static scrollToTabPosition({required GlobalKey global}) {
    Scrollable.ensureVisible(
      global.currentContext!,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
  }
}
