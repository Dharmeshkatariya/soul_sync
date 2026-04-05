import 'package:get/get.dart';
import 'package:soul_sync/core/utils/common.dart';
import 'app_locale.dart';
import 'globals.dart';

class StringFile {
  static final String _regionCode = appLocale.locale.value.countryCode ?? 'US';
  static String appName = "Soul Sync";
  static String label = "label";
  static String more = "More";
  static String phoneHint = "Phone number";
  static String noDataFound = "No data found";
  static String data = "Data";
  static String found = "found";
  static String no = "No";
  static String addedYet = "added yet";
  static String click = "Click";
  static String startByAddingYourFirst = "Start by adding your first";
  static String toManageAndMonitorEverythingFromOnePlace =
      "to manage and monitor everything from one place";
  static String belowToGetStarted = "below to get started";
  static String accordingToYourSpecifiedSearchCriteriaNoSuitable =
      "According to your specified search criteria, no suitable";
  static String pleaseConsiderRefiningYourFiltersSearchParameters =
      "Please consider refining your filters or trying alternative search parameters.";

  static String invalidEmailAddress = "Invalid Email Address";
  static String invalidUrl = "Invalid URL";
  static String invalidMobileNumber = "Invalid Mobile Number";
  static String mandatoryField = "This field is mandatory";
  static String home = "home";
  static String songs = "Songs";
  static String playlists = "Playlists";
  static String albums = "Albums";
  static String album = "album";
  static String singles = "Singles";
  static String artists = "artists";
  static String settings = "settings";
  static String library = "library";
  static String libSongs = "library Songs";
  static String libPlaylists = "library Playlists";
  static String libAlbums = "library Albums";
  static String libArtists = "library artists";
  static String communityplaylists = "Community Playlists";
  static String featuredplaylists = "Featured Playlists";
  static String items = "items";
  static String networkError1 = "Oops network error!";
  static String retry = "Retry!";
  static String noOfflineSong = "No offline songs!";
  static String recentlyPlayed = "Recently Played";
  static String favorites = "Favorites";
  static String cachedOrOffline = "Cached/Offline";
  static String downloads = "Downloads";
  static String emptyPlaylist = "Empty playlist!";
  static String enqueueAll = "Enqueue all";
  static String renamePlaylist = "Rename playlist";
  static String removePlaylist = "Remove playlist";
  static String createNewPlaylist = "Create new playlist";
  static String reArrangePlaylist = "Rearrange playlist";
  static String reArrangeSongs = "Rearrange songs";
  static String selectSongs = "Select songs";
  static String selectAll = "Select All";
  static String removeMultiple = "Remove multiple songs";
  static String addMultipleSongs = "Add songs to playlist";
  static String cancel = "Cancel";
  static String create = "Create";
  static String rename = "Rename";
  static String createNAdd = "Create & add";
  static String noBookmarks = "No bookmarks!";
  static String startRadio = "Start radio";
  static String playNext = "Play next";
  static String addToPlaylist = "Add to playlist";
  static String noLibPlaylist = "You don't have any lib playlist!";
  static String enqueueSong = "Enqueue this song";
  static String goToAlbum = "Go to album";
  static String viewArtist = "View Artist";
  static String openIn = "Open in";
  static String shareSong = "Share this song";
  static String removeFromPlaylist = "Remove from playlist";
  static String removeFromQueue = "Remove from queue";
  static String queueShufflingDeniedMsg =
      "Queue can't be shuffled when shuffle mode is enabled";
  static String queuerearrangingDeniedMsg =
      "Queue can't be rearranged when shuffle mode is enabled";
  static String songNotPlayable =
      "Song is not playable due to server restriction!";
  static String upNext = "Up Next";
  static String playingfromAlbum = "PLAYING FROM ALBUM";
  static String playingfromPlaylist = "PLAYING FROM PLAYLIST";
  static String playingfromSelection = "PLAYING FROM SELECTION";
  static String playingfromArtist = "PLAYING FROM ARTIST";
  static String randomSelection = "Random Selection";
  static String randomRadio = "Random Radio";
  static String playnextMsg = "Upcoming";
  static String shuffleQueue = "Shuffle Queue";
  static String queueLoop = "Queue loop";
  static String queueLoopNotDisMsg1 =
      "Queue loop mode cannot be disabled when shuffle mode is enabled.";
  static String queueLoopNotDisMsg2 =
      "Queue loop mode cannot be enabled in radio mode.";
  static String removeFromLib = "Remove from library Songs";
  static String sleepTimer = "Sleep Timer";
  static String add5Minutes = "Add 5 minutes";
  static String cancelTimer = "Cancel timer";
  static String deleteDownloadData = "Remove from downloads";
  static String minutes = "minutes";
  static String endOfThisSong = "End of this song";
  static String appInfo = "App Info";
  static String download = "Download";
  static String misc = "Misc";
  static String autoDownFavSong = "Auto download favorite songs";
  static String autoDownFavSongDes =
      "Automatically download favorite songs when added to favorites";
  static String networkError = "Network error! Check your network connection.";
  static String downloadError2 =
      "Requested song is not downloadable due to server restriction. You may try again";
  static String downloadError3 =
      "Downloading failed due to network/stream error! Please try again";
  static String musicAndPlayback = "Music & Playback";
  static String content = "Content";
  static String personalisation = "Personalisation";
  static String themeMode = "Theme Mode";
  static String dynamic = "Dynamic";
  static String systemDefault = "System default";
  static String dark = "Dark";
  static String light = "Light";
  static String language = "Language";
  static String playerUi = "Player Ui";
  static String playerUiDes = "Select player user interface";
  static String standard = "Standard";
  static String gesture = "Gesture";
  static String languageDes = "Set App language";
  static String setDiscoverContent = "Set discover content";
  static String quickpicks = "Quick Picks";
  static String discover = "Discover";
  static String trending = "Trending";
  static String topmusicvideos = "Top Music Videos";
  static String basedOnLast = "Based on last interaction";
  static String restoreLastPlaybackSession = "Restore last playback session";
  static String restoreLastPlaybackSessionDes =
      "Automatically restore the last playback session on app start";
  static String autoOpenPlayer = "Auto open player screen";
  static String autoOpenPlayerDes =
      "Enable/disable auto opening of player full screen on selection of song for play";
  static String homeContentCount = "home content count";
  static String homeContentCountDes =
      "Select the number of initial homescreen-content(approx). Lesser results faster loading";
  static String enableBottomNav = "Bottom navigation bar";
  static String enableBottomNavDes = "Switch to bottom navigation bar";
  static String cacheSongs = "Cache Songs";
  static String cacheSongsDes =
      "Caching songs while playing for future/offline playback, it will take additional space on your device";
  static String skipSilence = "Skip silence";
  static String skipSilenceDes = "Silence will be skipped in music playback";
  static String loudnessNormalization = "Loudness normalization";
  static String loudnessNormalizationDes =
      "Sets same lavel of loudness for all songs (Experimental) (Will not work on songs downloaded on previous version(< v1.10.0))";
  static String streamingQuality = "Streaming quality";
  static String streamingQualityDes = "Quality of music stream";
  static String disableTransitionAnimation = "Disable transition animation";
  static String disableTransitionAnimationDes =
      "Enable this option to disable tab transition animation";
  static String enableSlidableAction = "Enable slidable actions";
  static String enableSlidableActionDes =
      "Enable slidable actions on song tile";
  static String high = "High";
  static String low = "Low";
  static String backgroundPlay = "Background music play";
  static String backgroundPlayDes =
      "Enable/Disable music playing in background (App can be accessed from system tray when app is running in background)";
  static String downloadLocation = "Download Location";
  static String cacheHomeScreenData = "Cache home screen content data";
  static String cacheHomeScreenDataDes =
      "Enable Caching home screen content data, home screen will load instantly if this option is enabled";
  static String downloadingFormat = "Downloading File Format";
  static String downloadingFormatDes =
      "Select downloading file format. \"Opus\" will provide best quality";
  static String exportDowloadedFiles = "Export downloaded files";
  static String exportDowloadedFilesDes =
      "Click here to export downloaded file from inApp dir to external dir";
  static String exportedFileLocation = "Downloaded file export location";
  static String export = "Export";
  static String exporting = "Exporting...";
  static String scanning = "Scanning...";
  static String downFilesFound = "downloaded files found";
  static String close = "Close";
  static String exportMsg = "Files successfully exported";
  static String equalizer = "Equalizer";
  static String equalizerDes = "Open system equalizer";
  static String clearImgCache = "Clear images cache";
  static String clearImgCacheAlert = "Images cache cleared successfully";
  static String clearImgCacheDes =
      "Click here to clear cached thumbnails/images. (Not recommended unless want to refresh cached images data)";
  static String ignoreBatOpt = "Ignore battery optimization";
  static String ignoreBatOptDes =
      "If you are facing notification issues or playback stopped by system optimization, please enable this option";
  static String status = "Status";
  static String enabled = "Enabled";
  static String disabled = "Disabled";
  static String resetToDefault = "Restore default settings";
  static String resetToDefaultDes =
      "Reset app settings to default (Restart required)";
  static String resetToDefaultMsg =
      "settings reset to default completed, Please restart app";
  static String github = "GitHub";
  static String githubDes =
      "View GitHub source code \nif you like this project, don't forget to give a ⭐";
  static String by = "by";
  static String urlSearchDes =
      "Url detected click on it to open/play associated content";
  static String search = "search";
  static String searchDes = "Songs, playlist, album or Artist";
  static String searchRes = "search results";
  static String for1 = "for";
  static String videos = "Videos";
  static String viewAll = "View all";
  static String results = "Results";
  static String nomatch = "No Match found for";
  static String subscribers = "subscribers";
  static String about = "About";
  static String synced = "Synced";
  static String plain = "Plain";
  static String songInfo = "Song Info";
  static String id = "Id";
  static String title = "Title";
  static String duration = "Duration";
  static String audioCodec = "Audio Codec";
  static String bitrate = "Bitrate";
  static String loudnessDb = "LoudnessDb";
  static String deleteDownloadedDataAlert = "Successfully removed from downloads!";
  static String cancelTimerAlert = "Sleep timer cancelled";
  static String sleepTimeSetAlert = "Your sleep timer is set";
  static String radioNotAvailable = "Radio not available for this artist!";
  static String songRemovedfromQueue = "Removed from queue!";
  static String songRemovedfromQueueCurrSong =
      "You can't remove currently playing song";
  static String songAddedToPlaylistAlert = "Song added to playlist!";
  static String songAlreadyExists = "Song already exists!";
  static String songAlreadyOfflineAlert = "Song already offline in cache";
  static String songEnqueueAlert = "Song enqueued!";
  static String songRemovedAlert = "Removed from";
  static String errorOccuredAlert = "Some error occured!";
  static String pipedplstSyncAlert = "Piped playlist synced!";
  static String playlistCreatedAlert = "playlist created!";
  static String playlistCreatednsongAddedAlert = "playlist created & song added!";
  static String playlistRenameAlert = "Renamed successfully!";
  static String playlistRemovedAlert = "playlist removed!";
  static String playlistBookmarkAddAlert = "playlist bookmarked!";
  static String playlistBookmarkRemoveAlert = "playlist bookmark removed!";
  static String albumBookmarkAddAlert = "album bookmarked!";
  static String albumBookmarkRemoveAlert = "album bookmark removed!";
  static String artistBookmarkAddAlert = "Artist bookmarked!";
  static String artistBookmarkRemoveAlert = "Artist bookmark removed!";
  static String lyricsNotAvailable = "Lyrics not available!";
  static String syncedLyricsNotAvailable = "Synced lyrics not available!";
  static String artistDesNotAvailable = "Description not available!";
  static String newVersionAvailable = "New version available!";
  static String dontShowInfoAgain = "Don't show this info again";
  static String dismiss = "Dismiss";
  static String notaSongVideo = "Not a Song/Music-Video!";
  static String notaValidLink = "Not a valid link!";
  static String operationFailed = "Operation failed";
  static String goToDownloadPage = "Click here to go to download page";
  static String local = "Local";
  static String piped = "Piped";
  static String link = "Link";
  static String unLink = "Unlink";
  static String hintApiUrl = "API URL to Piped instance";
  static String customIns = "Custom Instance";
  static String customInsSelectMsg = "Please select Custom Instance";
  static String selectAuthInsMsg = "Please select Authentication instance!";
  static String allFieldsReqMsg = "All fields required";
  static String linkPipedDes = "Link with piped for playlists";
  static String selectAuthIns = "Select Auth Instance";
  static String username = "Username";
  static String password = "Password";
  static String linkAlert = "Linked successfully!";
  static String unlinkAlert = "Unlinked successfully!";
  static String playlistBlacklistAlert = "playlist blacklisted!";
  static String reset = "Reset";
  static String blacklistPlstResetAlert = "Reset successfully!";
  static String resetblacklistedplaylist = "Reset blacklisted playlists";
  static String resetblacklistedplaylistDes =
      "Reset all the piped blacklisted playlists";
  static String stopMusicOnTaskClear = "Stop music on task clear";
  static String stopMusicOnTaskClearDes =
      "Music playback will stop when App being swiped away from the task manager";
  static String backupAppData = "Backup App data";
  static String androidBackupWarning =
      "Not tested: Selecting the checkbox after downloading more than 60 files, process may consume a large amount of memory and could cause the phone or app to crash. Proceed at your own risk.";
  static String backupSettingsAndPlaylistsDes =
      "Saves all settings, playlists and login data in a backup file";
  static String backup = "Backup";
  static String letsStrart = "Let's start..";
  static String processFiles = "Processing files...";
  static String includeDownloadedFiles = "Include downloded songs files";
  static String backupInProgress = "Backup in progress...";
  static String restoreAppData = "Restore App data";
  static String restoreSettingsAndPlaylistsDes =
      "Restores all settings, login data and playlists from a backup file. Overwrites all current data";
  static String backupMsg = "Backup successfully saved!";
  static String backFilesFound = "databases found";
  static String restoreMsg = "Successfully restored!\nChanges are applied on restart";
  static String restoring = "Restoring...";
  static String restore = "Restore";
  static String closeApp = "Close App";
  static String restartApp = "Restart App";
  static String exportPlaylist = "Export playlist";
  static String exportPlaylistCsv = "Export playlist as CSV";
  static String exportingPlaylist = "Exporting playlist...";
  static String playlistExportedMsg = "playlist exported successfully to";
  static String exportError = "Error exporting playlist";
  static String exportErrorPermission = "Permission denied while exporting";
  static String exportErrorStorage = "Not enough storage space";
  static String exportErrorFormat = "Error formatting playlist data";
  static String importPlaylist = "Import playlist";
  static String importingPlaylist = "Importing playlist...";
  static String importPlaylistDesc =
      "Select a previously exported playlist JSON file to import";
  static String selectFile = "Select File";
  static String playlistImportedMsg = "playlist imported successfully";
  static String importError = "Error importing playlist";
  static String importErrorFileAccess = "Could not access the selected file";
  static String importErrorFormat = "Invalid file format";
  static String invalidPlaylistFile = "Invalid playlist file structure";
  static String importErrorDatabase = "Error saving to database";
  static String fileNotFound = "File not found";
  static String importLargeFileNote =
      "Note: Large playlists may take longer to import";
  static String exportPlaylistJson = "Export playlist to JSON";
  static String exportPlaylistJsonSubtitle = "This format can be imported";
  static String exportPlaylistCsvSubtitle = "Can't be imported here";
  static String exportToYouTubeMusic = "Export to Youtube music";
  static String exportToYouTubeMusicSubtitle =
      "It will push your playlist (songs < 50) to current queue, don't forget to add to playlist/save after opening in YtMusic";
  static String linkCopied = "Link copied to clipboard";
  static String keepScreenOnWhilePlaying = "Keep screen on while playing";
  static String keepScreenOnWhilePlayingDes =
      "If enabled, the device screen will stay awake while music is playing";



  static String somethingWentWrong ="Something went wrong";


}
