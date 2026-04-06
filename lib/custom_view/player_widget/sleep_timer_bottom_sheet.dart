import 'package:soul_sync/core/utils/string_file.dart';

import 'package:soul_sync/core/extension/text_style.dart';
import 'package:soul_sync/custom_view/custom_text_view.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../custom_player/player_controller.dart';
import 'snackbar.dart';

class SleepTimerBottomSheet extends StatelessWidget {
  const SleepTimerBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    final playerController = Get.find<PlayerController>();
    return Padding(
      padding: EdgeInsets.only(bottom: Get.mediaQuery.padding.bottom),
      child: Obx(
        () => Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.timer),
              title: CustomTextView(StringFile.sleepTimer),
            ),
            const Divider(),
            if (playerController.isSleepTimerActive.isTrue)
              SizedBox(
                height: 90,
                child: Container(
                  width: 180,
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.secondary,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Align(
                    alignment: Alignment.center,
                    child: Obx(() {
                      final leftDurationInSec =
                          playerController.timerDurationLeft.value;
                      final hrs = (leftDurationInSec ~/ 3600)
                          .toString()
                          .padLeft(2, '0');
                      final min = ((leftDurationInSec % 3600) ~/ 60)
                          .toString()
                          .padLeft(2, '0');
                      final sec = ((leftDurationInSec % 3600) % 60)
                          .toString()
                          .padLeft(2, '0');

                      return CustomTextView(
                        "$hrs:$min:$sec",
                        style: Theme.of(
                          context,
                        ).textTheme.titleLarge!.copyWith(fontSize: 35),
                      );
                    }),
                  ),
                ),
              ),
            if (playerController.isSleepTimerActive.isFalse)
              Column(children: getTimeListWidget(context)),
            if (playerController.isSleepTimerActive.isTrue)
              Padding(
                padding: const EdgeInsets.only(bottom: 20.0, top: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    if (playerController.isSleepEndOfSongActive.isFalse)
                      OutlinedButton(
                        onPressed: playerController.addFiveMinutes,
                        style: OutlinedButton.styleFrom(
                          foregroundColor: context.titleMedium!.color!,
                          side: BorderSide(
                            color: Theme.of(
                              context,
                            ).textTheme.titleMedium!.color!,
                          ),
                        ),
                        child: CustomTextView(StringFile.add5Minutes),
                      ),
                    OutlinedButton(
                      onPressed: () {
                        Future.delayed(
                          const Duration(milliseconds: 200),
                          playerController.cancelSleepTimer,
                        );
                        Navigator.of(context).pop();
                        ScaffoldMessenger.of(context).showSnackBar(
                          snackbar(
                            context,
                            StringFile.cancelTimerAlert,
                            size: SanckBarSize.BIG,
                          ),
                        );
                      },
                      style: OutlinedButton.styleFrom(
                        foregroundColor: context.titleMedium!.color!,
                        side: BorderSide(color: context.titleMedium!.color!),
                      ),
                      child: CustomTextView(StringFile.cancelTimer),
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }

  List<Widget> getTimeListWidget(BuildContext context) {
    final playerController = Get.find<PlayerController>();
    final List<Widget> widgets = [];
    widgets.addAll(
      [5, 10, 15, 30, 45, 60]
          .map(
            (dur) => ListTile(
              onTap: () {
                Navigator.of(context).pop();
                Future.delayed(const Duration(milliseconds: 200), () {
                  playerController.startSleepTimer(dur);
                });
                ScaffoldMessenger.of(context).showSnackBar(
                  snackbar(
                    context,
                    StringFile.sleepTimeSetAlert,
                    size: SanckBarSize.BIG,
                  ),
                );
              },
              leading: Padding(
                padding: const EdgeInsets.only(left: 10.0),
                child: CustomTextView(
                  "$dur ${StringFile.minutes}",
                  style: context.titleMedium,
                ),
              ),
            ),
          )
          .toList(),
    );
    widgets.add(
      ListTile(
        onTap: () {
          Navigator.of(context).pop();
          playerController.sleepEndOfSong();
        },
        leading: Padding(
          padding: const EdgeInsets.only(left: 10.0),
          child: CustomTextView(
            StringFile.endOfThisSong,
            style: context.titleMedium,
          ),
        ),
      ),
    );
    return widgets;
  }
}
