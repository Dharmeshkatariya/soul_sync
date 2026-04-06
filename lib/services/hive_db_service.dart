import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';
import '../core/utils/logger_utils.dart';

// ==================== Hive Box Keys Constants ====================
class HiveBoxKeys {
  // Box Names
  static const String songsCache = 'SongsCache';
  static const String songDownloads = 'SongDownloads';
  static const String songsUrlCache = 'SongsUrlCache';
  static const String appPrefs = 'AppPrefs';
  static const String libraryPlaylists = 'LibraryPlaylists';
  static const String libraryAlbums = 'LibraryAlbums';
  static const String libraryArtists = 'LibraryArtists';
  static const String blacklistedPlaylist = 'blacklistedPlaylist';
  static const String recentSearches = 'RecentSearches';
  static const String playbackHistory = 'PlaybackHistory';
  static const String userPreferences = 'UserPreferences';
  static const String offlineQueue = 'OfflineQueue';

  // Private constructor to prevent instantiation
  HiveBoxKeys._();
}

// ==================== App Preferences Keys ====================
class AppPrefsKeys {
  // Theme & UI
  static const String themeModeType = 'themeModeType';
  static const String themePrimaryColor = 'themePrimaryColor';
  static const String currentAppLanguageCode = 'currentAppLanguageCode';

  // Playback Settings
  static const String cacheSongs = 'cacheSongs';
  static const String skipSilenceEnabled = 'skipSilenceEnabled';
  static const String streamingQuality = 'streamingQuality';
  static const String defaultPlaybackSpeed = 'defaultPlaybackSpeed';
  static const String crossFadeDuration = 'crossFadeDuration';
  static const String audioNormalization = 'audioNormalization';

  // Content Settings
  static const String discoverContentType = 'discoverContentType';
  static const String cacheHomeScreenData = 'cacheHomeScreenData';
  static const String newVersionVisibility = 'newVersionVisibility';
  static const String autoCheckForUpdates = 'autoCheckForUpdates';

  // Privacy & Data
  static const String enableAnalytics = 'enableAnalytics';
  static const String enableCrashReporting = 'enableCrashReporting';
  static const String clearCacheOnExit = 'clearCacheOnExit';

  // Network
  static const String downloadOnlyOnWifi = 'downloadOnlyOnWifi';
  static const String streamOnlyOnWifi = 'streamOnlyOnWifi';
  static const String maxCacheSize = 'maxCacheSize';

  // Piped Account
  static const String pipedUsername = 'pipedUsername';
  static const String pipedToken = 'pipedToken';
  static const String pipedIsLoggedIn = 'pipedIsLoggedIn';
  static const String pipedUserId = 'pipedUserId';

  // Desktop Specific
  static const String windowWidth = 'windowWidth';
  static const String windowHeight = 'windowHeight';
  static const String windowPositionX = 'windowPositionX';
  static const String windowPositionY = 'windowPositionY';
  static const String isWindowMaximized = 'isWindowMaximized';

  AppPrefsKeys._();
}

// ==================== Song Cache Keys ====================
class SongCacheKeys {
  static const String videoId = 'videoId';
  static const String title = 'title';
  static const String artist = 'artist';
  static const String album = 'album';
  static const String duration = 'duration';
  static const String url = 'url';
  static const String thumbnail = 'thumbnail';
  static const String dateAdded = 'dateAdded';
  static const String lastPlayed = 'lastPlayed';
  static const String playCount = 'playCount';

  SongCacheKeys._();
}

// ==================== Hive Database Service ====================
class HiveDatabaseService {
  // Singleton pattern
  static final HiveDatabaseService _instance = HiveDatabaseService._internal();

  // Private constructor
  HiveDatabaseService._internal();

  // Factory constructor
  factory HiveDatabaseService() {
    return _instance;
  }

  static HiveDatabaseService get instance => _instance;

  // Box cache for faster access
  final Map<String, Box> _boxCache = {};

  // Initialization flag
  bool _isInitialized = false;

  // Initialize Hive database
  Future<void> init() async {
    if (_isInitialized) return;

    try {
      String applicationDataDirectoryPath;
      if (GetPlatform.isDesktop) {
        applicationDataDirectoryPath = "${(await getApplicationSupportDirectory()).path}/db";
      } else {
        applicationDataDirectoryPath = (await getApplicationDocumentsDirectory()).path;
      }

      await Hive.initFlutter(applicationDataDirectoryPath);

      // Register adapters if needed
      // Hive.registerAdapter(PlaylistAdapter());
      // Hive.registerAdapter(AlbumAdapter());
      // Hive.registerAdapter(ArtistAdapter());

      // Open all required boxes
      await _openAllBoxes();

      _isInitialized = true;
      LoggerUtil.info('✅ Hive Database initialized successfully', tag: 'Database');
    } catch (e) {
      LoggerUtil.error('Failed to initialize Hive Database', tag: 'Database', error: e);
      rethrow;
    }
  }

  // Open all required boxes
  Future<void> _openAllBoxes() async {
    final boxesToOpen = [
      HiveBoxKeys.songsCache,
      HiveBoxKeys.songDownloads,
      HiveBoxKeys.songsUrlCache,
      HiveBoxKeys.appPrefs,
      HiveBoxKeys.libraryPlaylists,
      HiveBoxKeys.libraryAlbums,
      HiveBoxKeys.libraryArtists,
      HiveBoxKeys.blacklistedPlaylist,
      HiveBoxKeys.recentSearches,
      HiveBoxKeys.playbackHistory,
      HiveBoxKeys.userPreferences,
      HiveBoxKeys.offlineQueue,
    ];

    for (final boxName in boxesToOpen) {
      await openBox(boxName);
    }
  }

  // Open a specific box
  Future<Box> openBox(String boxName) async {
    if (_boxCache.containsKey(boxName)) {
      return _boxCache[boxName]!;
    }

    final box = await Hive.openBox(boxName);
    _boxCache[boxName] = box;
    return box;
  }

  // Get a box (must be opened first)
  Box getBox(String boxName) {
    if (!_boxCache.containsKey(boxName)) {
      throw Exception('Box "$boxName" is not opened. Call openBox first.');
    }
    return _boxCache[boxName]!;
  }

  // Check if box is open
  bool isBoxOpen(String boxName) {
    return _boxCache.containsKey(boxName);
  }

  // Close a specific box
  Future<void> closeBox(String boxName) async {
    final box = _boxCache.remove(boxName);
    if (box != null && !box.isOpen) {
      await box.close();
    }
  }

  // Close all boxes
  Future<void> closeAllBoxes() async {
    for (final box in _boxCache.values) {
      if (box.isOpen) {
        await box.close();
      }
    }
    _boxCache.clear();
  }

  // ==================== CRUD Operations ====================

  // Generic Put operation
  Future<void> put(String boxName, dynamic key, dynamic value) async {
    try {
      final box = getBox(boxName);
      await box.put(key, value);
      LoggerUtil.debug('📦 Put data in $boxName with key: $key', tag: 'Database');
    } catch (e) {
      LoggerUtil.error('Error putting data in $boxName', tag: 'Database', error: e);
      rethrow;
    }
  }

  // Generic Put All operation
  Future<void> putAll(String boxName, Map<dynamic, dynamic> values) async {
    try {
      final box = getBox(boxName);
      await box.putAll(values);
      LoggerUtil.debug('📦 Put ${values.length} items in $boxName', tag: 'Database');
    } catch (e) {
      LoggerUtil.error('Error putting all data in $boxName', tag: 'Database', error: e);
      rethrow;
    }
  }

  // Generic Get operation
  dynamic get(String boxName, dynamic key, {dynamic defaultValue}) {
    try {
      final box = getBox(boxName);
      return box.get(key, defaultValue: defaultValue);
    } catch (e) {
      LoggerUtil.error('Error getting data from $boxName', tag: 'Database', error: e);
      return defaultValue;
    }
  }

  // Generic Get At operation (by index)
  dynamic getAt(String boxName, int index) {
    try {
      final box = getBox(boxName);
      return box.getAt(index);
    } catch (e) {
      LoggerUtil.error('Error getting data at index $index from $boxName', tag: 'Database', error: e);
      return null;
    }
  }

  // Generic Delete operation
  Future<void> delete(String boxName, dynamic key) async {
    try {
      final box = getBox(boxName);
      await box.delete(key);
      LoggerUtil.debug('🗑️ Deleted from $boxName with key: $key', tag: 'Database');
    } catch (e) {
      LoggerUtil.error('Error deleting from $boxName', tag: 'Database', error: e);
      rethrow;
    }
  }

  // Generic Delete At operation (by index)
  Future<void> deleteAt(String boxName, int index) async {
    try {
      final box = getBox(boxName);
      await box.deleteAt(index);
      LoggerUtil.debug('🗑️ Deleted at index $index from $boxName', tag: 'Database');
    } catch (e) {
      LoggerUtil.error('Error deleting at index $index from $boxName', tag: 'Database', error: e);
      rethrow;
    }
  }

  // Check if key exists
  bool containsKey(String boxName, dynamic key) {
    try {
      final box = getBox(boxName);
      return box.containsKey(key);
    } catch (e) {
      return false;
    }
  }

  // Get all keys
  List<dynamic> getKeys(String boxName) {
    try {
      final box = getBox(boxName);
      return box.keys.toList();
    } catch (e) {
      return [];
    }
  }

  // Get all values
  List<dynamic> getValues(String boxName) {
    try {
      final box = getBox(boxName);
      return box.values.toList();
    } catch (e) {
      return [];
    }
  }

  // Clear all data in a box
  Future<void> clearBox(String boxName) async {
    try {
      final box = getBox(boxName);
      await box.clear();
      LoggerUtil.info('🧹 Cleared box: $boxName', tag: 'Database');
    } catch (e) {
      LoggerUtil.error('Error clearing box $boxName', tag: 'Database', error: e);
      rethrow;
    }
  }

  // Get box size (number of entries)
  int getBoxSize(String boxName) {
    try {
      final box = getBox(boxName);
      return box.length;
    } catch (e) {
      return 0;
    }
  }

  // Check if box is empty
  bool isBoxEmpty(String boxName) {
    try {
      final box = getBox(boxName);
      return box.isEmpty;
    } catch (e) {
      return true;
    }
  }

  // ==================== App Preferences Methods ====================

  Future<void> setAppPreference(String key, dynamic value) async {
    await put(HiveBoxKeys.appPrefs, key, value);
  }

  dynamic getAppPreference(String key, {dynamic defaultValue}) {
    return get(HiveBoxKeys.appPrefs, key, defaultValue: defaultValue);
  }

  // Initialize default app preferences
  Future<void> initAppPreferences() async {
    final appPrefs = getBox(HiveBoxKeys.appPrefs);

    if (appPrefs.isEmpty) {
      final defaultPrefs = {
        AppPrefsKeys.themeModeType: 0,
        AppPrefsKeys.cacheSongs: false,
        AppPrefsKeys.skipSilenceEnabled: false,
        AppPrefsKeys.streamingQuality: 1,
        AppPrefsKeys.themePrimaryColor: 4278199603,
        AppPrefsKeys.discoverContentType: "QP",
        AppPrefsKeys.newVersionVisibility: true,
        AppPrefsKeys.cacheHomeScreenData: true,
        AppPrefsKeys.defaultPlaybackSpeed: 1.0,
        AppPrefsKeys.crossFadeDuration: 0,
        AppPrefsKeys.audioNormalization: false,
        AppPrefsKeys.autoCheckForUpdates: true,
        AppPrefsKeys.enableAnalytics: false,
        AppPrefsKeys.enableCrashReporting: true,
        AppPrefsKeys.downloadOnlyOnWifi: true,
        AppPrefsKeys.streamOnlyOnWifi: false,
        AppPrefsKeys.maxCacheSize: 1024, // 1GB in MB
      };

      await appPrefs.putAll(defaultPrefs);
      LoggerUtil.info('📝 Initialized default app preferences', tag: 'Database');
    }
  }

  // ==================== Song Management Methods ====================

  // Save song to cache
  Future<void> saveCachedSong(Map<String, dynamic> songData) async {
    final videoId = songData['videoId'];
    await put(HiveBoxKeys.songsCache, videoId, songData);
  }

  // Save multiple cached songs
  Future<void> saveCachedSongs(List<Map<String, dynamic>> songs) async {
    final box = getBox(HiveBoxKeys.songsCache);
    final batch = <dynamic, dynamic>{};
    for (final song in songs) {
      batch[song['videoId']] = song;
    }
    await putAll(HiveBoxKeys.songsCache, batch);
  }

  // Get cached song
  Map<String, dynamic>? getCachedSong(String videoId) {
    final song = get(HiveBoxKeys.songsCache, videoId);
    return song != null ? Map<String, dynamic>.from(song) : null;
  }

  // Check if song is cached
  bool isSongCached(String videoId) {
    return containsKey(HiveBoxKeys.songsCache, videoId);
  }

  // Get all cached songs
  List<Map<String, dynamic>> getAllCachedSongs() {
    return getValues(HiveBoxKeys.songsCache).cast<Map<String, dynamic>>();
  }

  // Delete cached song
  Future<void> deleteCachedSong(String videoId) async {
    await delete(HiveBoxKeys.songsCache, videoId);
  }

  // Clear all cached songs
  Future<void> clearAllCachedSongs() async {
    await clearBox(HiveBoxKeys.songsCache);
  }

  // ==================== Downloaded Song Methods ====================

  // Save downloaded song
  Future<void> saveDownloadedSong(Map<String, dynamic> songData) async {
    final videoId = songData['videoId'];
    await put(HiveBoxKeys.songDownloads, videoId, songData);
  }

  // Save multiple downloaded songs
  Future<void> saveDownloadedSongs(List<Map<String, dynamic>> songs) async {
    final batch = <dynamic, dynamic>{};
    for (final song in songs) {
      batch[song['videoId']] = song;
    }
    await putAll(HiveBoxKeys.songDownloads, batch);
  }

  // Get downloaded song
  Map<String, dynamic>? getDownloadedSong(String videoId) {
    final song = get(HiveBoxKeys.songDownloads, videoId);
    return song != null ? Map<String, dynamic>.from(song) : null;
  }

  // Check if song is downloaded
  bool isSongDownloaded(String videoId) {
    return containsKey(HiveBoxKeys.songDownloads, videoId);
  }

  // Get all downloaded songs
  List<Map<String, dynamic>> getAllDownloadedSongs() {
    return getValues(HiveBoxKeys.songDownloads).cast<Map<String, dynamic>>();
  }

  // Delete downloaded song
  Future<void> deleteDownloadedSong(String videoId) async {
    await delete(HiveBoxKeys.songDownloads, videoId);
  }

  // Clear all downloaded songs
  Future<void> clearAllDownloadedSongs() async {
    await clearBox(HiveBoxKeys.songDownloads);
  }

  // ==================== Playlist Methods ====================

  // Save playlist
  Future<void> savePlaylist(String playlistId, Map<String, dynamic> playlistData) async {
    await put(HiveBoxKeys.libraryPlaylists, playlistId, playlistData);
  }

  // Get playlist
  Map<String, dynamic>? getPlaylist(String playlistId) {
    final playlist = get(HiveBoxKeys.libraryPlaylists, playlistId);
    return playlist != null ? Map<String, dynamic>.from(playlist) : null;
  }

  // Get all playlists
  List<Map<String, dynamic>> getAllPlaylists() {
    return getValues(HiveBoxKeys.libraryPlaylists).cast<Map<String, dynamic>>();
  }

  // Delete playlist
  Future<void> deletePlaylist(String playlistId) async {
    await delete(HiveBoxKeys.libraryPlaylists, playlistId);
  }

  // ==================== Album Methods ====================

  Future<void> saveAlbum(String albumId, Map<String, dynamic> albumData) async {
    await put(HiveBoxKeys.libraryAlbums, albumId, albumData);
  }

  Map<String, dynamic>? getAlbum(String albumId) {
    final album = get(HiveBoxKeys.libraryAlbums, albumId);
    return album != null ? Map<String, dynamic>.from(album) : null;
  }

  List<Map<String, dynamic>> getAllAlbums() {
    return getValues(HiveBoxKeys.libraryAlbums).cast<Map<String, dynamic>>();
  }

  Future<void> deleteAlbum(String albumId) async {
    await delete(HiveBoxKeys.libraryAlbums, albumId);
  }

  // ==================== Artist Methods ====================

  Future<void> saveArtist(String artistId, Map<String, dynamic> artistData) async {
    await put(HiveBoxKeys.libraryArtists, artistId, artistData);
  }

  Map<String, dynamic>? getArtist(String artistId) {
    final artist = get(HiveBoxKeys.libraryArtists, artistId);
    return artist != null ? Map<String, dynamic>.from(artist) : null;
  }

  List<Map<String, dynamic>> getAllArtists() {
    return getValues(HiveBoxKeys.libraryArtists).cast<Map<String, dynamic>>();
  }

  Future<void> deleteArtist(String artistId) async {
    await delete(HiveBoxKeys.libraryArtists, artistId);
  }

  // ==================== Playback History Methods ====================

  Future<void> addToPlaybackHistory(Map<String, dynamic> songData) async {
    final historyBox = getBox(HiveBoxKeys.playbackHistory);
    await historyBox.add(songData);

    // Limit history to 100 items
    if (historyBox.length > 100) {
      await historyBox.deleteAt(0);
    }
  }

  List<Map<String, dynamic>> getPlaybackHistory() {
    return getValues(HiveBoxKeys.playbackHistory).cast<Map<String, dynamic>>();
  }

  Future<void> clearPlaybackHistory() async {
    await clearBox(HiveBoxKeys.playbackHistory);
  }

  // ==================== Recent Searches Methods ====================

  Future<void> addRecentSearch(String query) async {
    if (query.trim().isEmpty) return;

    final searchesBox = getBox(HiveBoxKeys.recentSearches);
    final searches = searchesBox.values.toList();

    // Remove if already exists
    if (searches.contains(query)) {
      final key = searchesBox.keys.firstWhere(
            (k) => searchesBox.get(k) == query,
        orElse: () => null,
      );
      if (key != null) await searchesBox.delete(key);
    }

    await searchesBox.add(query);

    // Limit to 20 recent searches
    while (searchesBox.length > 20) {
      await searchesBox.deleteAt(0);
    }
  }

  List<String> getRecentSearches() {
    return getValues(HiveBoxKeys.recentSearches).cast<String>().reversed.toList();
  }

  Future<void> clearRecentSearches() async {
    await clearBox(HiveBoxKeys.recentSearches);
  }

  // ==================== URL Cache Methods ====================

  Future<void> saveUrlCache(String key, Map<String, dynamic> urlData) async {
    await put(HiveBoxKeys.songsUrlCache, key, urlData);
  }

  Map<String, dynamic>? getUrlCache(String key) {
    final data = get(HiveBoxKeys.songsUrlCache, key);
    return data != null ? Map<String, dynamic>.from(data) : null;
  }

  List<Map<String, dynamic>> getAllUrlCache() {
    return getValues(HiveBoxKeys.songsUrlCache).cast<Map<String, dynamic>>();
  }

  Future<void> deleteUrlCache(String key) async {
    await delete(HiveBoxKeys.songsUrlCache, key);
  }

  Future<void> clearUrlCache() async {
    await clearBox(HiveBoxKeys.songsUrlCache);
  }

  // ==================== Blacklist Methods ====================

  Future<void> addToBlacklist(String playlistId) async {
    final blacklistBox = getBox(HiveBoxKeys.blacklistedPlaylist);
    await blacklistBox.add(playlistId);
  }

  List<String> getBlacklistedPlaylists() {
    return getValues(HiveBoxKeys.blacklistedPlaylist).cast<String>();
  }

  Future<void> removeFromBlacklist(String playlistId) async {
    final blacklistBox = getBox(HiveBoxKeys.blacklistedPlaylist);
    final keys = blacklistBox.keys.toList();
    for (final key in keys) {
      if (blacklistBox.get(key) == playlistId) {
        await blacklistBox.delete(key);
        break;
      }
    }
  }

  Future<void> clearBlacklist() async {
    await clearBox(HiveBoxKeys.blacklistedPlaylist);
  }

  // ==================== Utility Methods ====================

  // Get total database size information
  Future<Map<String, int>> getDatabaseStats() async {
    final stats = <String, int>{};

    for (final entry in _boxCache.entries) {
      stats[entry.key] = entry.value.length;
    }

    return stats;
  }

  // Compact all boxes to free up space
  Future<void> compactAllBoxes() async {
    for (final box in _boxCache.values) {
      if (box.isOpen) {
        await box.compact();
      }
    }
    LoggerUtil.info('🗜️ Compacted all database boxes', tag: 'Database');
  }

  // Export box data to JSON
  Future<Map<String, dynamic>> exportBoxData(String boxName) async {
    final box = getBox(boxName);
    final data = <String, dynamic>{};

    for (final key in box.keys) {
      data[key.toString()] = box.get(key);
    }

    return data;
  }

  // Import data to box
  Future<void> importBoxData(String boxName, Map<String, dynamic> data) async {
    final box = getBox(boxName);
    await box.putAll(data);
  }

  // Check if database is initialized
  bool get isInitialized => _isInitialized;

  // Delete entire database
  Future<void> deleteDatabase() async {
    await closeAllBoxes();
    await Hive.deleteFromDisk();
    _isInitialized = false;
    LoggerUtil.warning('🗑️ Database deleted from disk', tag: 'Database');
  }
}

// ==================== Extension for easier access ====================
extension HiveDatabaseExtension on GetInterface {
  HiveDatabaseService get database => HiveDatabaseService.instance;
}