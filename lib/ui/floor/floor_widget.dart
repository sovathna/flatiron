import 'package:cached_network_image/cached_network_image.dart';
import 'package:flatiron/data/data_module.dart';
import 'package:flatiron/ui/floor/floor_state.dart';
import 'package:flatiron/ui/floor/floor_view_model.dart';
import 'package:flatiron/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final _floorViewModel = StateNotifierProvider.autoDispose
    .family<FloorViewModel, FloorState, String>(
  (ref, args) => FloorViewModel(args, ref.watch(appServiceProvider)),
);

class FloorWidget extends ConsumerWidget {
  final String _floor;

  const FloorWidget(this._floor, {super.key});

  void _getFloor(WidgetRef ref) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      if (!ref.read(_floorViewModel(_floor)).isInit) return;
      ref.read(_floorViewModel(_floor).notifier).getFloor();
    });
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    logger.d("build");
    _getFloor(ref);
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            "Floor $_floor",
            style: Theme.of(context).textTheme.titleLarge,
          ),
          _QrImageWidget(_floor),
          _ErrorWidget(_floor),
          _FooterWidget(_floor),
          ElevatedButton(
            onPressed: ref.read(_floorViewModel(_floor).notifier).getFloor,
            child: const Text("Refresh"),
          )
        ],
      ),
    );
  }
}

class _ErrorWidget extends ConsumerWidget {
  const _ErrorWidget(this._floor);

  final String _floor;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final error =
        ref.watch(_floorViewModel(_floor).select((value) => value.error));

    if (error.isEmpty) {
      return const SizedBox.shrink();
    }
    final value =
        ref.watch(_floorViewModel(_floor).select((value) => value.value));
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            error,
            textAlign: TextAlign.center,
            style: Theme.of(context)
                .textTheme
                .bodyLarge
                ?.copyWith(color: Theme.of(context).colorScheme.error),
          ),
          value.isEmpty
              ? ElevatedButton(
                  onPressed:
                      ref.read(_floorViewModel(_floor).notifier).getFloor,
                  child: const Text("Retry"),
                )
              : const SizedBox.shrink()
        ],
      ),
    );
  }
}

class _FooterWidget extends ConsumerWidget {
  const _FooterWidget(this._floor);

  final String _floor;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(_floorViewModel(_floor));
    return state.value.isNotEmpty
        ? Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
            child: Row(
              children: [
                Expanded(
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: _ElapseWidget(_floor),
                  ),
                ),
                Expanded(
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: ElevatedButton(
                      onPressed:
                          ref.read(_floorViewModel(_floor).notifier).refresh,
                      child: const Text("Refresh session"),
                    ),
                  ),
                ),
              ],
            ),
          )
        : const SizedBox.shrink();
  }
}

class _QrImageWidget extends ConsumerWidget {
  const _QrImageWidget(this._floor);

  final String _floor;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final value =
        ref.watch(_floorViewModel(_floor).select((value) => value.value));
    final color =
        Theme.of(context).brightness == Brightness.light ? "1C1B1F" : "E6E1E5";
    final child = value.isNotEmpty
        ? CachedNetworkImage(
            imageUrl:
                "https://qrcode.tec-it.com/API/QRCode?color=$color&istransparent=True&data=$value",
            fit: BoxFit.cover,
          )
        : const Center(child: CircularProgressIndicator());
    return Padding(
      padding: const EdgeInsets.only(top: 32),
      child: FractionallySizedBox(
        widthFactor: 0.7,
        child: AspectRatio(aspectRatio: 1.0, child: child),
      ),
    );
  }
}

class _ElapseWidget extends ConsumerWidget {
  const _ElapseWidget(this._floor);

  final String _floor;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final elapse =
        ref.watch(_floorViewModel(_floor).select((value) => value.elapse));
    return Text(
      "Session elapsed ${elapse}s",
      style: Theme.of(context).textTheme.bodySmall,
    );
  }
}
