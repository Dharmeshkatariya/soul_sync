import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:soul_sync/custom_view/custom_player/widget/lyrics_switch.dart';
import 'package:soul_sync/custom_view/custom_player/widget/lyrics_widget.dart';
import 'common_dialog_widget.dart';

class LyricsDialog extends StatelessWidget {
  const LyricsDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return const CommonDialog(
      maxWidth: 700,
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(bottom: 10.0, top: 20),
            child: LyricsSwitch(),
          ),
          Expanded(
            child: LyricsWidget(padding: EdgeInsets.symmetric(vertical: 40)),
          ),
        ],
      ),
    );
  }
}
