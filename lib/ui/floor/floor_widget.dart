import 'package:cached_network_image/cached_network_image.dart';
import 'package:flatiron/data/data_module.dart';
import 'package:flatiron/ui/floor/floor_state.dart';
import 'package:flatiron/ui/floor/floor_view_model.dart';
import 'package:flatiron/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final _viewModel = StateNotifierProvider.autoDispose
    .family<FloorViewModel, FloorState, String>(
  (ref, args) => FloorViewModel(
    args,
    ref.watch(appServiceProvider),
    ref.watch(appPreferencesProvider),
  ),
);

class FloorWidget extends ConsumerWidget {
  final String _floor;

  const FloorWidget(this._floor, {super.key});

  void _getFloor(WidgetRef ref) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      if (!ref.read(_viewModel(_floor)).isInit) return;
      ref.read(_viewModel(_floor).notifier).getFloor();
    });
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    logger.d("build");
    _getFloor(ref);
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        children: [
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  _floor == "00" ? "G" : "${int.parse(_floor)}",
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                _QrImageWidget(_floor),
                _RetryWidget(_floor),
                _FooterWidget(_floor),
                _ErrorWidget(_floor),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _RetryWidget extends ConsumerWidget {
  const _RetryWidget(this._floor);
  final String _floor;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isLoading =
        ref.watch(_viewModel(_floor).select((value) => value.isLoading));
    final isValue =
        ref.watch(_viewModel(_floor).select((value) => value.value)).isNotEmpty;
    if (isLoading && !isValue) return const SizedBox.shrink();
    return Padding(
      padding: const EdgeInsets.only(top: 16.0),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(shape: const CircleBorder()),
        onPressed:
            isLoading ? null : ref.read(_viewModel(_floor).notifier).getFloor,
        child: const Icon(Icons.refresh),
      ),
    );
  }
}

class _ErrorWidget extends ConsumerWidget {
  const _ErrorWidget(this._floor);

  final String _floor;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final error = ref.watch(_viewModel(_floor).select((value) => value.error));

    if (error.isEmpty) {
      return const SizedBox.shrink();
    }
    final value = ref.watch(_viewModel(_floor).select((value) => value.value));
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
                  onPressed: ref.read(_viewModel(_floor).notifier).getFloor,
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
    final state = ref.watch(_viewModel(_floor));
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
                      onPressed: ref.read(_viewModel(_floor).notifier).refresh,
                      child: state.isLoading
                          ? const SizedBox(
                              width: 18,
                              height: 18,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                              ),
                            )
                          : const Text("Refresh session"),
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
    final value = ref.watch(_viewModel(_floor).select((value) => value.value));
    final color =
        Theme.of(context).brightness == Brightness.light ? "1C1B1F" : "1A1C19";
    final backColor =
        Theme.of(context).brightness == Brightness.light ? "FCFDF7" : "1A1C19";
    final child = value.isNotEmpty
        ? CachedNetworkImage(
            imageUrl:
                "https://qrcode.tec-it.com/API/QRCode?backcolor=$backColor&color=$color&data=$value",
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
        ref.watch(_viewModel(_floor).select((value) => value.elapse));
    return Text(
      "Session elapsed ${elapse}s",
      style: Theme.of(context).textTheme.bodySmall,
    );
  }
}
