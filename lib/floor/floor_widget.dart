import 'package:flatiron/data/data_module.dart';
import 'package:flatiron/floor/floor_state.dart';
import 'package:flatiron/floor/floor_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final _floorViewModel = StateNotifierProvider<FloorViewModel, FloorState>(
  (ref) => FloorViewModel(ref.watch(appServiceProvider)),
);

class FloorWidget extends ConsumerWidget {
  final int floor;

  const FloorWidget(this.floor, {super.key});

  void _getFloor(WidgetRef ref) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      if (!ref.watch(_floorViewModel).isInit) return;
      ref.read(_floorViewModel.notifier).getFloor(floor);
    });
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    _getFloor(ref);
    return Column(
      children: [
        Text("Floor $floor"),
        Expanded(child: Center(child: _QrImageWidget())),
      ],
    );
  }
}

class _QrImageWidget extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final imageData =
        ref.watch(_floorViewModel.select((value) => value.imageData));
    final widget = imageData != null
        ? FittedBox(
            fit: BoxFit.fitWidth,
            child: Image.memory(imageData),
          )
        : const Center(
            child: Icon(
              Icons.image,
              size: 56,
            ),
          );
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 300),
      transitionBuilder: (child, animation) {
        return FadeTransition(
          opacity: animation,
          child: child,
        );
      },
      child: widget,
    );
  }
}
