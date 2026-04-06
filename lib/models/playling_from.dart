import 'package:soul_sync/core/utils/string_file.dart';

// ignore_for_file: constant_identifier_names

class PlaylingFrom {
  PlaylingFromType type;
  String name;

  PlaylingFrom({required this.type, this.name = ""});

  get typeString {
    switch (type) {
      case PlaylingFromType.ALBUM:
        return StringFile.playingfromAlbum;
      case PlaylingFromType.PLAYLIST:
        return StringFile.playingfromPlaylist;
      case PlaylingFromType.SELECTION:
        return StringFile.playingfromSelection;
      case PlaylingFromType.ARTIST:
        return StringFile.playingfromArtist;
    }
  }

  get nameString {
    if (type == PlaylingFromType.SELECTION) return StringFile.randomSelection;
    return name;
  }
}

enum PlaylingFromType { ALBUM, PLAYLIST, SELECTION, ARTIST }
