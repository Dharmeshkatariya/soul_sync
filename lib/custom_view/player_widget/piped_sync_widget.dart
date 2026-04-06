import 'package:soul_sync/core/utils/toast_util.dart';
import 'package:soul_sync/core/utils/string_file.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../app/Library/library_controller.dart';
import '../../core/utils/logger_utils.dart';

class PipedSyncWidget extends StatelessWidget {
  const PipedSyncWidget({super.key, required this.padding});

  final EdgeInsets padding;

  @override
  Widget build(BuildContext context) {
    final librplstCntrller = Get.find<LibraryPlaylistsController>();
    return Padding(
      padding: padding,
      child: RotationTransition(
        turns: Tween(begin: 0.0, end: 1.0).animate(librplstCntrller.controller),
        child: IconButton(
          splashRadius: 20,
          iconSize: 20,
          visualDensity: const VisualDensity(vertical: -4),
          icon: const Icon(Icons.sync),
          // <-- Icon
          onPressed: () async {
            try {
              //LoggerUtil.info(librplstCntrller.controller.status);
              librplstCntrller.controller.forward();
              librplstCntrller.controller.repeat();
              await librplstCntrller.syncPipedPlaylist();
              librplstCntrller.controller.stop();
              librplstCntrller.controller.reset();
              ToastUtil.infoWithSize(
                size: ToastSize.medium,
                message: StringFile.pipedplstSyncAlert,
              );
            } catch (e) {
              ToastUtil.errorWithSize(
                size: ToastSize.big,
                message: StringFile.errorOccuredAlert,
              );

               LoggerUtil.error(e);
            }
          },
        ),
      ),
    );
  }
}
