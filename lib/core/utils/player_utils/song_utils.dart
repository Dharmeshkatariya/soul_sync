import '../../../custom_view/player_widget/sort_widget.dart';

class SongUtils {
  // Private constructor
  SongUtils._internal();

  // Singleton instance
  static final SongUtils _instance = SongUtils._internal();

  // Factory constructor to return the same instance
  factory SongUtils() {
    return _instance;
  }

  // Public getter to access the instance
  static SongUtils get instance => _instance;

  static void sortSongsNVideos(
      {required List songlist,
      required SortType sortType,
      required bool isAscending}) {
    Comparator compareFunction;

    switch (sortType) {
      case SortType.Date:
        compareFunction = (a, b) {
          if (a.extras!['date'] == null || b.extras!['date'] == null) {
            return 0.compareTo(0);
          }
          return a.extras!['date'].compareTo(b.extras!['date']);
        };
        break;
      case SortType.Duration:
        compareFunction = (a, b) => (a.duration ?? Duration.zero)
            .compareTo(b.duration ?? Duration.zero);
      case SortType.Name:
      default:
        compareFunction =
            (a, b) => a.title.toLowerCase().compareTo(b.title.toLowerCase());
        break;
    }

    songlist.sort(compareFunction);

    if (!isAscending) {
      List reversed = songlist.reversed.toList();
      songlist.clear();
      songlist.addAll(reversed);
    }
  }

  static void sortAlbumNSingles(
      {required List albumList,
      required SortType sortType,
      required bool isAscending}) {
    Comparator compareFunction;

    switch (sortType) {
      case SortType.Date:
        compareFunction =
            (a, b) => a.title.toLowerCase().compareTo(b.title.toLowerCase());
        break;
      case SortType.Name:
      default:
        compareFunction = (a, b) {
          if (a.year == null || b.year == null) {
            return 0.compareTo(0);
          }
          return a.year!.compareTo(b.year!);
        };
        break;
    }

    albumList.sort(compareFunction);

    if (!isAscending) {
      List reversed = albumList.reversed.toList();
      albumList.clear();
      albumList.addAll(reversed);
    }
  }

  static void sortPlayLists(
      {required List playlists,
      required SortType sortType,
      required bool isAscending}) {
    Comparator compareFunction;
    int titleSort(a, b) =>
        a.title.toLowerCase().compareTo(b.title.toLowerCase());

    switch (sortType) {
      case SortType.RecentlyPlayed:
        compareFunction = (a, b) {
          DateTime? alp = a.lastPlayed;
          DateTime? blp = b.lastPlayed;
          if (alp == null && blp == null) {
            return titleSort(a, b);
          }
          if (alp == null) {
            return 1;
          }
          if (blp == null) {
            return -1;
          }
          return blp.compareTo(alp);
        };
        break;
      case SortType.Name:
      default:
        compareFunction = titleSort;
        break;
    }

    playlists.sort(compareFunction);

    if (!isAscending) {
      List reversed = playlists.reversed.toList();
      playlists.clear();
      playlists.addAll(reversed);
    }
  }

  static void sortArtist(
      {required List artistList,
      required SortType sortType,
      required bool isAscending}) {
    Comparator compareFunction;

    switch (sortType) {
      case SortType.Name:
      default:
        compareFunction =
            (a, b) => a.name.toLowerCase().compareTo(b.name.toLowerCase());
        break;
    }

    artistList.sort(compareFunction);

    if (!isAscending) {
      List reversed = artistList.reversed.toList();
      artistList.clear();
      artistList.addAll(reversed);
    }
  }
}
