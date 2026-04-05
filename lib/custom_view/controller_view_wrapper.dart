import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

typedef ControllerBuilder<T extends GetxController> =
    Widget Function(T controller);

class ControllerViewWrapper<T extends GetxController> extends StatelessWidget {
  final T Function() initController;
  final void Function(GetBuilderState<T>)? onInitState;
  final void Function(GetBuilderState<T>)? onDidChangeDependencies;
  final void Function(GetBuilderState<T>)? onDispose;
  final ControllerBuilder<T> builder;
  final String? tag;

  const ControllerViewWrapper({
    Key? key,
    required this.initController,
    required this.builder,
    this.onInitState,
    this.onDidChangeDependencies,
    this.onDispose,
    this.tag,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<T>(
      init: initController(),
      initState: onInitState,
      tag: tag,
      didChangeDependencies: onDidChangeDependencies,
      dispose: (state) {
        onDispose?.call(state);
        Get.delete<T>();
      },
      builder: (controller) => builder(controller),
    );
  }
}
