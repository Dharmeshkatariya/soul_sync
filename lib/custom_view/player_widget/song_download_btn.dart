import 'package:soul_sync/core/utils/string_file.dart';

import 'package:soul_sync/core/extension/text_style.dart';
import 'package:soul_sync/custom_view/custom_text_view.dart';

import 'package:audio_service/audio_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';

import '../../services/downloader.dart';
import '../custom_player/player_controller.dart';
import 'loader.dart';
import 'snackbar.dart';

class SongDownloadButton extends StatelessWidget {
  const SongDownloadButton({
    super.key,
    this.calledFromPlayer = false,
    this.song_,
    this.isDownloadingDoneCallback,
  });
  final bool calledFromPlayer;
  final MediaItem? song_;
  final void Function(bool)? isDownloadingDoneCallback;

  @override
  Widget build(BuildContext context) {
    final downloader = Get.find<Downloader>();
    final playerController = Get.find<PlayerController>();
    return Obx(() {
      final song =
          calledFromPlayer ? playerController.currentSong.value : song_;
      if (song == null && calledFromPlayer) return const SizedBox.shrink();
      final isDownloadingDone = (downloader.songQueue.contains(song) &&
          downloader.currentSong == song &&
          downloader.songDownloadingProgress.value == 100);
      if (isDownloadingDoneCallback != null) {
        isDownloadingDoneCallback!(isDownloadingDone);
      }

      return (isDownloadingDone ||
              Hive.box("SongDownloads").containsKey(song!.id))
          ? Icon(Icons.download_done, color: context.titleMedium!.color)
          : downloader.songQueue.contains(song) &&
                  downloader.isJobRunning.isTrue &&
                  downloader.currentSong == song
              ? Obx(
                  () => Stack(
                    alignment: Alignment.center,
                    children: [
                      Align(
                        alignment: Alignment.center,
                        child: CustomTextView(
                          "${downloader.songDownloadingProgress.value}%",
                          style:
                              Theme.of(context).textTheme.titleMedium!.copyWith(
                                    fontSize: 10,
                                    fontWeight: FontWeight.bold,
                                  ),
                        ),
                      ),
                      LoadingIndicator(
                        dimension: 30,
                        strokeWidth: 4,
                        value: (downloader.songDownloadingProgress.value) / 100,
                      ),
                    ],
                  ),
                )
              : downloader.songQueue.contains(song)
                  ? const LoadingIndicator()
                  : IconButton(
                      icon: Icon(Icons.download,
                          color: context.titleMedium!.color),
                      onPressed: () {
                        (Hive.openBox("SongsCache").then((box) {
                          if (box.containsKey(song.id)) {
                            if (!context.mounted) return;
                            Navigator.of(context).pop();
                            ScaffoldMessenger.of(context).showSnackBar(
                              snackbar(
                                context,
                                StringFile.songAlreadyOfflineAlert,
                                size: SanckBarSize.BIG,
                              ),
                            );
                          } else {
                            downloader.download(song);
                          }
                        }));
                      },
                    );
    });
  }
}
