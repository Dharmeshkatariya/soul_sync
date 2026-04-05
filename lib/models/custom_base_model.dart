import 'package:soul_sync/core/utils/toast_util.dart';

import '../core/utils/common.dart';
import '../core/utils/string_file.dart';

abstract class CustomBaseModel {
  bool isEmpty();

  // Add these static utility methods to your existing class
  static T fromJsonSafe<T extends CustomBaseModel>(
    Map<String, dynamic>? json,
    T Function(Map<String, dynamic>) fromJson,
  ) {
    if (json == null) {
      Common().printLog('Exception: ', 'Null JSON provided');
      ToastUtil.show(message: StringFile.somethingWentWrong);
      throw Exception('Null JSON provided');
    }

    try {
      return fromJson(json);
    } catch (e) {
      Common().printLog('Exception: ', e.toString());
      ToastUtil.show(message: StringFile.somethingWentWrong);
      throw FormatException(
        'Failed to parse JSON for ${T.toString()}: ${e.toString()}',
      );
    }
  }

  static List<T> listFromJson<T extends CustomBaseModel>(
    List<dynamic>? jsonList,
    T Function(Map<String, dynamic>) fromJson,
  ) {
    if (jsonList == null) return [];

    List<T> result = [];
    for (var item in jsonList) {
      if (item is Map<String, dynamic>) {
        try {
          result.add(fromJsonSafe(item, fromJson));
        } catch (e) {
          // Continue processing other items
        }
      }
    }
    return result;
  }

  static Map<String, dynamic> toJsonSafe(Map<String, dynamic> json) {
    Map<String, dynamic> cleanedJson = {};

    json.forEach((key, value) {
      // Handle nested maps recursively
      if (value is Map<String, dynamic>) {
        Map<String, dynamic> cleanedNested = toJsonSafe(value);
        if (cleanedNested.isNotEmpty) {
          cleanedJson[key] = cleanedNested;
        }
      }
      // Handle lists - check each item for maps that need cleaning
      else if (value is List) {
        List cleanedList = _cleanList(value);
        if (cleanedList.isNotEmpty) {
          cleanedJson[key] = cleanedList;
        }
      }
      // Skip null values and empty strings
      else if ((value is! String || value.isNotEmpty)) {
        cleanedJson[key] = value;
      }
    });

    return cleanedJson;
  }

  static List _cleanList(List list) {
    List result = [];

    for (var item in list) {
      if (item is Map<String, dynamic>) {
        Map<String, dynamic> cleanedItem = toJsonSafe(item);
        if (cleanedItem.isNotEmpty) {
          result.add(cleanedItem);
        }
      } else if (item is List) {
        List cleanedNestedList = _cleanList(item);
        if (cleanedNestedList.isNotEmpty) {
          result.add(cleanedNestedList);
        }
      } else if (item != null && (item is! String || item.isNotEmpty)) {
        result.add(item);
      }
    }

    return result;
  }
}
