import 'dart:html' as html;

import 'package:get/get.dart';
import 'package:soul_sync/core/utils/query_params.dart';
import 'package:soul_sync/custom_view/custom_horizontal_pager.dart';
import 'package:soul_sync/models/pagination.dart';

class BookmarkUtils {
  static void updateQueryParams(String key, String value) {
    final uri = Uri.parse(html.window.location.href);

    // If the URL contains a hash (#), preserve it.
    final baseUrl = uri.toString().split('#')[0];
    final hashFragment = uri.fragment; // This is everything after the '#'.

    // Parse query parameters from the fragment if any.
    final fragmentUri = Uri.parse(hashFragment);
    final queryParams = Map<String, String>.from(fragmentUri.queryParameters);

    // Update or add the query parameter.
    queryParams[key] = value;

    // Reconstruct the fragment with the updated query parameters.
    final newFragment =
        fragmentUri.replace(queryParameters: queryParams).toString();

    // Construct the new URL.
    final newUrl = baseUrl + '#' + newFragment;

    // Update the browser's address bar without refreshing the pages.
    html.window.history.pushState(null, '', newUrl);
  }

  static Map<String, String> getQueryParams() {
    final fragment = Uri.base.fragment; // Get the part after the `#`.

    if (fragment.isEmpty || !fragment.contains('?')) {
      return {};
    }

    // Split the fragment to isolate the query string and parse it.
    final queryPart = fragment.split('?').last;
    return Uri.parse('?$queryPart').queryParameters;
  }

  static void clearQueryParams() {
    final uri = Uri.base;

    // Rebuild the URI without query parameters
    final newUri = Uri(
      scheme: uri.scheme,
      host: uri.host,
      path: uri.path,
      port: uri.port,
      fragment: uri.fragment, // Preserve the fragment if needed
    );

    // Update the browser's history
    html.window.history.pushState(null, '', newUri.toString());
  }

  static void removeQueryParam(String key) {
    final uri = Uri.parse(html.window.location.href);

    final baseUrl = uri.toString().split('#')[0];
    final hashFragment = uri.fragment; // This is everything after the '#'.

    final fragmentUri = Uri.parse(hashFragment);
    final queryParams = Map<String, String>.from(fragmentUri.queryParameters);
    queryParams.remove(key);
    final newFragment =
        fragmentUri.replace(queryParameters: queryParams).toString();
    final newUrl = baseUrl + '#' + newFragment;
    html.window.history.pushState(null, '', newUrl);
  }

  static Pagination getPaginationFromParams({
    int defaultPage = 1,
    int defaultPerPage = 10,
  }) {
    Pagination pagination = Pagination();
    final page = BookmarkUtils.getQueryParams()[QueryParams.page];
    final perPage = BookmarkUtils.getQueryParams()[QueryParams.perPage];
    pagination.page = _parseIntParam(page, defaultPage);
    pagination.perPage = _parseIntParam(perPage, defaultPerPage);
    return pagination;
  }

  static int _parseIntParam(String? value, int defaultValue) {
    if (value == null) return defaultValue;
    return int.tryParse(value) ?? defaultValue;
  }

  static void updatePaginationParams(Pagination pagination) {
    BookmarkUtils.updateQueryParams(
      QueryParams.page,
      pagination.page.toString(),
    );
    BookmarkUtils.updateQueryParams(
      QueryParams.perPage,
      pagination.perPage.toString(),
    );
  }

  static void updatePageValue({required int page, required int perPage}) {
    BookmarkUtils.updateQueryParams(QueryParams.page, page.toString());
    BookmarkUtils.updateQueryParams(QueryParams.perPage, perPage.toString());
  }

  static PagerModel getTabPagerModel({
    required RxList<PagerModel> pagerList,
    required Rx<PagerModel> selectedPager,
  }) {
    if (pagerList.isNotEmpty) {
      final isSelectedTab = BookmarkUtils.getQueryParams()[QueryParams.isTab];
      if (isSelectedTab != null && isSelectedTab.isNotEmpty) {
        final tabIndex = int.tryParse(isSelectedTab) ?? 0;
        selectedPager.value = tabIndex >= 0 && tabIndex < pagerList.length
            ? pagerList[tabIndex]
            : pagerList[0];
      } else {
        selectedPager.value = pagerList[0];
      }
      return selectedPager.value;
    }
    return PagerModel();
  }
}

/// --------------------------------------------------------------------------
/// Bookmarking Guidelines (For Developers)
///
/// Use `BookmarkUtils.updateQueryParams()` to keep the browser URL in sync
/// with the application state for deep linking and bookmarking purposes.
///
/// Recommended Events to Capture (Update URL on These Actions):

/// Pagination:
/// - When switching pages in a paginated list (e.g., `pages=2`)
/// search Input:
/// - On performing a search or filter action (e.g., `search=John`)
/// Tab Changes:
/// - When switching between tabs (e.g., `tab=details`)
/// Sorting:
/// - When changing sort field or order (e.g., `sort=asc_name`)
/// Filter Selections:
/// - When selecting or removing filters (e.g., `status=active`)
/// Modal/Dialog Open:
/// - When opening a modal that should be shareable or bookmarkable (e.g., `modal=feedback`)
/// Dropdown or Selection Changes:
/// - If it affects visible state (e.g., `category=books`)
/// Date Range Pickers:
/// - On selecting from/to dates (e.g., `from=2024-01-01&to=2024-01-31`)
///  Tree/Drill-down Navigation:
///  - When expanding or navigating hierarchical views (e.g., `path=node1/node2`)
///  Step Changes in Multi-Step Forms:
///  - When progressing through steps (e.g., `step=3`)
///  Toggle Switches:
///     - If the toggle affects persistent UI state (e.g., `showHidden=true`)
///
/// --------------------------------------------------------------------------
