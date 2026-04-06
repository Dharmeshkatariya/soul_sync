import 'package:soul_sync/core/utils/toast_util.dart';
import 'package:soul_sync/core/utils/string_file.dart';

import 'package:soul_sync/core/extension/text_style.dart';
import 'package:soul_sync/custom_view/custom_text_view.dart';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:html/parser.dart' as html_parser;

import '../../app/playlist/playlist_screen_controller.dart';
import 'common_dialog_widget.dart';

class PlaylistExportDialog extends StatelessWidget {
  const PlaylistExportDialog({
    super.key,
    required this.controller,
    required this.parentContext,
  });

  final PlaylistScreenController controller;
  final BuildContext parentContext;

  @override
  Widget build(BuildContext context) {
    return CommonDialog(
      child: Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Title
            Padding(
              padding: const EdgeInsets.only(bottom: 20, top: 10),
              child: CustomTextView(
                StringFile.exportPlaylist,
                style: context.titleLarge,
                textAlign: TextAlign.center,
              ),
            ),
            // Button 1: Export to JSON
            _ExportButton(
              icon: Icons.save,
              title: StringFile.exportPlaylistJson,
              subtitle: StringFile.exportPlaylistJsonSubtitle,
              onTap: () {
                Navigator.of(context).pop();
                controller.exportPlaylistToJson(parentContext);
              },
            ),
            const SizedBox(height: 12),
            // Button 2: Export to CSV
            _ExportButton(
              icon: Icons.table_chart,
              title: StringFile.exportPlaylistCsv,
              subtitle: StringFile.exportPlaylistCsvSubtitle,
              onTap: () {
                Navigator.of(context).pop();
                controller.exportPlaylistToCsv(parentContext);
              },
            ),
            const SizedBox(height: 12),
            // Button 3: Export to YouTube Music (split button)
            _SplitExportButton(
              icon: Icons.open_in_new,
              title: StringFile.exportToYouTubeMusic,
              subtitle: StringFile.exportToYouTubeMusicSubtitle,
              onMainTap: () {
                Navigator.of(context).pop();
                _openInYouTubeMusic();
              },
              onCopyTap: () {
                Navigator.of(context).pop();
                _copyYouTubeMusicLink();
              },
            ),
            const SizedBox(height: 20),
            // Close button
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: CustomTextView(
                  StringFile.close,
                  style: context.titleMedium,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _openInYouTubeMusic() async {
    final videoIds = controller.songList.map((song) => song.id).join(',');
    final url = 'https://www.youtube.com/watch_videos?video_ids=$videoIds';
    final ytmUrl = await _generateYTMUrl(url);

    launchUrl(Uri.parse(ytmUrl ?? url), mode: LaunchMode.externalApplication);
  }

  Future<String?> _generateYTMUrl(String ytSimpleUrl) async {
    if (controller.generatedYtmPlaylistUrl.isNotEmpty) {
      return controller.generatedYtmPlaylistUrl;
    }

    try {
      final x = (await Dio().get(ytSimpleUrl)).data;
      final document = html_parser.parse(x);

      // Find the <link> element with rel="canonical"
      final canonicalLink = document.querySelector('link[rel="canonical"]');

      // Extract its href attribute
      String? href = canonicalLink?.attributes['href'];
      href = href?.replaceAll('www', 'music');
      if (href != null) {
        controller.generatedYtmPlaylistUrl = href;
        return href;
      }
      // ignore: empty_catches
    } catch (e) {}
    return null;
  }

  Future<void> _copyYouTubeMusicLink() async {
    final videoIds = controller.songList.map((song) => song.id).join(',');
    final url = 'https://www.youtube.com/watch_videos?video_ids=$videoIds';
    final ytmUrl = await _generateYTMUrl(url);

    Clipboard.setData(ClipboardData(text: ytmUrl ?? url)).then((_) {
      if (parentContext.mounted) {
        ToastUtil.successWithSize(
          size: ToastSize.medium,
          message: StringFile.linkCopied,
        );
      }
    });
  }
}

class _ExportButton extends StatelessWidget {
  const _ExportButton({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Theme.of(context).cardColor,
      borderRadius: BorderRadius.circular(10),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(10),
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            border: Border.all(
              color: Theme.of(context).dividerColor.withOpacity(0.2),
            ),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            children: [
              Icon(icon, color: context.titleMedium!.color),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomTextView(title, style: context.titleMedium),
                    const SizedBox(height: 4),
                    CustomTextView(
                      subtitle,
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _SplitExportButton extends StatelessWidget {
  const _SplitExportButton({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onMainTap,
    required this.onCopyTap,
  });

  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onMainTap;
  final VoidCallback onCopyTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Theme.of(context).cardColor,
      borderRadius: BorderRadius.circular(10),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: Theme.of(context).dividerColor.withOpacity(0.2),
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        child: IntrinsicHeight(
          child: Row(
            children: [
              // Main button part (80%)
              Expanded(
                flex: 8,
                child: InkWell(
                  onTap: onMainTap,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(10),
                    bottomLeft: Radius.circular(10),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Row(
                      children: [
                        Icon(icon, color: context.titleMedium!.color),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CustomTextView(title, style: context.titleMedium),
                              const SizedBox(height: 4),
                              CustomTextView(
                                subtitle,
                                style: Theme.of(context).textTheme.bodySmall,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              // Divider
              VerticalDivider(
                width: 1,
                thickness: 1,
                color: Theme.of(context).dividerColor.withOpacity(0.2),
              ),
              // Copy button part (20%)
              Expanded(
                flex: 2,
                child: InkWell(
                  onTap: onCopyTap,
                  borderRadius: const BorderRadius.only(
                    topRight: Radius.circular(10),
                    bottomRight: Radius.circular(10),
                  ),
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    child: Icon(
                      Icons.copy,
                      color: context.titleMedium!.color,
                      size: 20,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
