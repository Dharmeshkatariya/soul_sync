import 'package:flutter/foundation.dart';

// Log levels
enum LogLevel {
  debug,
  info,
  warning,
  error,
  verbose,
  wtf,
}

class LoggerUtil {
  // Singleton instance
  static final LoggerUtil _instance = LoggerUtil._internal();

  factory LoggerUtil() => _instance;

  LoggerUtil._internal();

  // Configuration
  static bool isEnabled = true;
  static bool showTimeStamp = true;
  static bool showEmojis = true;
  static int maxLineLength = 120;

  // Color codes for console output
  static const String _reset = '\x1B[0m';
  static const String _red = '\x1B[31m';
  static const String _green = '\x1B[32m';
  static const String _yellow = '\x1B[33m';
  static const String _blue = '\x1B[34m';
  static const String _magenta = '\x1B[35m';
  static const String _cyan = '\x1B[36m';
  static const String _white = '\x1B[37m';
  static const String _bold = '\x1B[1m';

  // Emojis for different log types
  static const Map<LogLevel, String> _emojis = {
    LogLevel.debug: '🐛',
    LogLevel.info: 'ℹ️',
    LogLevel.warning: '⚠️',
    LogLevel.error: '❌',
    LogLevel.verbose: '📢',
    LogLevel.wtf: '💀',
  };

  // Main logging method
  static void log(
    dynamic message, {
    LogLevel level = LogLevel.debug,
    String tag = 'Harmony Music',
    dynamic error,
    StackTrace? stackTrace,
  }) {
    if (!isEnabled) return;
    if (kReleaseMode && level != LogLevel.error) return;

    final timestamp = showTimeStamp ? _getTimestamp() : '';
    final emoji = showEmojis ? _emojis[level] ?? '📝' : '';
    final color = _getColorForLevel(level);
    final levelName = level.name.toUpperCase().padRight(7);

    String output = '';

    // Build log header
    if (timestamp.isNotEmpty) {
      output += '$color$timestamp $_reset';
    }

    output += '$color$emoji [$tag] $levelName: $_reset';

    // Add main message
    output += '$color$message$_reset';

    // Add error if present
    if (error != null) {
      output += '\n${_red}Error: $error$_reset';
    }

    // Add stack trace if present
    if (stackTrace != null) {
      output += '\n${_cyan}StackTrace:$_reset\n$stackTrace';
    }

    // Split long lines
    final lines = _splitLongLines(output);

    // Print to console
    for (var line in lines) {
      debugPrint(line);
    }
  }

  // Convenience methods
  static void debug(dynamic text, {String tag = 'Harmony Music'}) {
    log(text, level: LogLevel.debug, tag: tag);
  }

  static void info(dynamic text, {String tag = 'Harmony Music'}) {
    log(text, level: LogLevel.info, tag: tag);
  }

  static void warning(dynamic text, {String tag = 'Harmony Music'}) {
    log(text, level: LogLevel.warning, tag: tag);
  }

  static void error(dynamic text,
      {String tag = 'Harmony Music', dynamic error, StackTrace? stackTrace}) {
    log(text,
        level: LogLevel.error, tag: tag, error: error, stackTrace: stackTrace);
  }

  static void verbose(dynamic text, {String tag = 'Harmony Music'}) {
    log(text, level: LogLevel.verbose, tag: tag);
  }

  static void wtf(dynamic text,
      {String tag = 'Harmony Music', dynamic error, StackTrace? stackTrace}) {
    log(text,
        level: LogLevel.wtf, tag: tag, error: error, stackTrace: stackTrace);
  }

  // Method-specific logs for Harmony Music
  static void logSongPlay(String songTitle, {String tag = 'Player'}) {
    info('🎵 Playing: "$songTitle"', tag: tag);
  }

  static void logSongPause(String songTitle, {String tag = 'Player'}) {
    info('⏸️ Paused: "$songTitle"', tag: tag);
  }

  static void logSongResume(String songTitle, {String tag = 'Player'}) {
    info('▶️ Resumed: "$songTitle"', tag: tag);
  }

  static void logSongComplete(String songTitle, {String tag = 'Player'}) {
    info('✅ Completed: "$songTitle"', tag: tag);
  }

  static void logPlaylistCreated(String playlistName,
      {String tag = 'Playlist'}) {
    info('📋 Playlist created: "$playlistName"', tag: tag);
  }

  static void logPlaylistDeleted(String playlistName,
      {String tag = 'Playlist'}) {
    warning('🗑️ Playlist deleted: "$playlistName"', tag: tag);
  }

  static void logSongAddedToPlaylist(String songTitle, String playlistName,
      {String tag = 'Playlist'}) {
    info('➕ Added "$songTitle" to playlist: "$playlistName"', tag: tag);
  }

  static void logSongRemovedFromPlaylist(String songTitle, String playlistName,
      {String tag = 'Playlist'}) {
    info('➖ Removed "$songTitle" from playlist: "$playlistName"', tag: tag);
  }

  static void logFavoriteAdded(String songTitle, {String tag = 'Favorite'}) {
    info('❤️ Added to favorites: "$songTitle"', tag: tag);
  }

  static void logFavoriteRemoved(String songTitle, {String tag = 'Favorite'}) {
    info('💔 Removed from favorites: "$songTitle"', tag: tag);
  }

  static void logSearchPerformed(String query, int resultsCount,
      {String tag = 'Search'}) {
    info('🔍 Searched: "$query" (Found $resultsCount results)', tag: tag);
  }

  static void logDatabaseOperation(String operation,
      {String tag = 'Database', dynamic error}) {
    if (error != null) {
      error('Database $operation failed', tag: tag, error: error);
    } else {
      debug('Database $operation completed successfully', tag: tag);
    }
  }

  static void logNetworkRequest(String url,
      {String tag = 'Network', dynamic error}) {
    if (error != null) {
      error('Network request failed: $url', tag: tag, error: error);
    } else {
      debug('Network request: $url', tag: tag);
    }
  }

  static void logCacheHit(String key, {String tag = 'Cache'}) {
    debug('💾 Cache hit: $key', tag: tag);
  }

  static void logCacheMiss(String key, {String tag = 'Cache'}) {
    debug('💿 Cache miss: $key', tag: tag);
  }

  static void logPermissionGranted(String permission,
      {String tag = 'Permission'}) {
    info('✅ Permission granted: $permission', tag: tag);
  }

  static void logPermissionDenied(String permission,
      {String tag = 'Permission'}) {
    error('❌ Permission denied: $permission', tag: tag);
  }

  static void logInitialization(String component, {String tag = 'Init'}) {
    info('🚀 Initialized: $component', tag: tag);
  }

  static void logDisposal(String component, {String tag = 'Cleanup'}) {
    debug('♻️ Disposed: $component', tag: tag);
  }

  // Performance logging
  static void logPerformance(String operation, Duration duration,
      {String tag = 'Performance'}) {
    final ms = duration.inMilliseconds;
    if (ms > 100) {
      warning('⚠️ Slow operation: $operation took ${ms}ms', tag: tag);
    } else {
      debug('⏱️ $operation completed in ${ms}ms', tag: tag);
    }
  }

  // Batch log for multiple items
  static void logBatch(String title, List<String> items,
      {LogLevel level = LogLevel.debug, String tag = 'Batch'}) {
    log('$title (${items.length} items):', level: level, tag: tag);
    for (var i = 0; i < items.length; i++) {
      log('  ${i + 1}. ${items[i]}', level: level, tag: tag);
    }
  }


  // Clear console (works in some environments)
  static void clearConsole() {
    if (!kReleaseMode) {
      debugPrint('\x1B[2J\x1B[0;0H');
    }
  }

  // Private helper methods
  static String _getTimestamp() {
    final now = DateTime.now();
    return '${now.hour.toString().padLeft(2, '0')}:${now.minute.toString().padLeft(2, '0')}:${now.second.toString().padLeft(2, '0')}.${now.millisecond.toString().padLeft(3, '0')}';
  }

  static String _getColorForLevel(LogLevel level) {
    switch (level) {
      case LogLevel.debug:
        return _cyan;
      case LogLevel.info:
        return _green;
      case LogLevel.warning:
        return _yellow;
      case LogLevel.error:
        return _red;
      case LogLevel.verbose:
        return _blue;
      case LogLevel.wtf:
        return _magenta;
    }
  }

  static List<String> _splitLongLines(String text) {
    final lines = <String>[];
    if (text.length <= maxLineLength) {
      lines.add(text);
    } else {
      var start = 0;
      while (start < text.length) {
        var end = start + maxLineLength;
        if (end > text.length) end = text.length;
        lines.add(text.substring(start, end));
        start = end;
      }
    }
    return lines;
  }
}

