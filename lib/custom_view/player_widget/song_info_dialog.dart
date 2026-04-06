import 'package:soul_sync/core/utils/string_file.dart';

import 'package:soul_sync/core/extension/text_style.dart';
import 'package:soul_sync/custom_view/custom_text_view.dart';

import 'package:audio_service/audio_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';

import 'common_dialog_widget.dart';

class SongInfoDialog extends StatelessWidget {
  final MediaItem song;
  const SongInfoDialog({super.key, required this.song});

  @override
  Widget build(BuildContext context) {
    Map<dynamic, dynamic> streamInfo = _getStreamInfo(song.id);
    return CommonDialog(
      child: SizedBox(
        height: Get.mediaQuery.size.height * .7,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10.0),
              child: CustomTextView(
                StringFile.songInfo,
                style: context.titleLarge,
              ),
            ),
            const Divider(),
            Expanded(
              child: ListView(
                children: [
                  InfoItem(title: StringFile.id, value: song.id),
                  InfoItem(title: StringFile.title, value: song.title),
                  InfoItem(title: StringFile.album, value: song.album ?? "NA"),
                  InfoItem(
                    title: StringFile.artists,
                    value: song.artist ?? "NA",
                  ),
                  InfoItem(
                    title: StringFile.duration,
                    value:
                        "${streamInfo["approxDurationMs"] ?? song.duration?.inMilliseconds ?? "NA"} ms",
                  ),
                  InfoItem(
                    title: StringFile.audioCodec,
                    value: streamInfo["audioCodec"] ?? "NA",
                  ),
                  InfoItem(
                    title: StringFile.bitrate,
                    value: "${streamInfo["bitrate"] ?? "NA"}",
                  ),
                  InfoItem(
                    title: StringFile.loudnessDb,
                    value: "${streamInfo["loudnessDb"] ?? "NA"}",
                  ),
                ],
              ),
            ),
            const Divider(),
            SizedBox(
              height: 50,
              child: Align(
                alignment: Alignment.center,
                child: InkWell(
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 10.0,
                      horizontal: 25,
                    ),
                    child: CustomTextView(StringFile.close),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Map<dynamic, dynamic> _getStreamInfo(String id) {
    Map<dynamic, dynamic> tempstreamInfo;
    final nullVal = {
      "audioCodec": null,
      "bitrate": null,
      "loudnessDb": null,
      "approxDurationMs": null,
    };
    if (Hive.box("SongDownloads").containsKey(id)) {
      final song = Hive.box("SongDownloads").get(id);

      tempstreamInfo = song["streamInfo"] == null
          ? nullVal
          : song["streamInfo"][1];
    } else {
      final dbStreamData = Hive.box("SongsUrlCache").get(id);
      tempstreamInfo =
          dbStreamData != null &&
              dbStreamData.runtimeType.toString().contains("Map")
          ? dbStreamData[Hive.box('AppPrefs').get('streamingQuality') == 0
                ? 'lowQualityAudio'
                : "highQualityAudio"]
          : nullVal;
    }
    return tempstreamInfo;
  }
}

class InfoItem extends StatelessWidget {
  final String title;
  final String value;
  const InfoItem({super.key, required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomTextView(title, textAlign: TextAlign.start),
          TextSelectionTheme(
            data: Theme.of(context).textSelectionTheme,
            child: SelectableText(value, style: context.titleMedium),
          ),
        ],
      ),
    );
  }
}
