import 'dart:convert';

import 'package:flatiron/data/data_module.dart';
import 'package:flatiron/ui/floor/floor_state.dart';
import 'package:flatiron/ui/floor/floor_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

final _viewModel = StateNotifierProvider.autoDispose
    .family<FloorViewModel, FloorState, String>(
  (ref, args) => FloorViewModel(
    args,
    ref.watch(appServiceProvider),
    ref.watch(appPreferencesProvider),
  ),
);

final _refreshController = Provider.autoDispose<RefreshController>(
  (ref) {
    final controller = RefreshController();
    ref.onDispose(() {
      controller.dispose();
    });
    return controller;
  },
);

class FloorWidget extends ConsumerStatefulWidget {
  final String floor;

  const FloorWidget(this.floor, {super.key});
  @override
  ConsumerState<ConsumerStatefulWidget> createState() => FloorWidgetState();
}

class FloorWidgetState extends ConsumerState<FloorWidget>
    with WidgetsBindingObserver {
  String get _floor => widget.floor;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    if (state == AppLifecycleState.resumed) {
      ref.read(_viewModel(_floor).notifier).getFloor();
    }
  }

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      if (!ref.read(_viewModel(_floor)).isInit) return;
      ref.read(_viewModel(_floor).notifier).getFloor();
    });
    ref.listen(_viewModel(_floor), (prev, next) {
      if (!next.isLoading) {
        ref.read(_refreshController).refreshCompleted();
      }
    });

    return RefreshConfiguration(
      headerTriggerDistance: 42,
      child: SmartRefresher(
        controller: ref.watch(_refreshController),
        onRefresh: () => ref.read(_viewModel(_floor).notifier).getFloor(),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        _floor == "00"
                            ? "Ground Level"
                            : "Level ${int.parse(_floor)}",
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      _QrImageWidget(_floor),
                      _ErrorWidget(_floor),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
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
    final hasValue =
        ref.watch(_viewModel(_floor).select((value) => value.hasValue));
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
          !hasValue
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

class _QrImageWidget extends ConsumerWidget {
  const _QrImageWidget(this._floor);

  final String _floor;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final hasValue =
        ref.watch(_viewModel(_floor).select((value) => value.hasValue));
    final imageData =
        ref.watch(_viewModel(_floor).select((value) => value.data?.imageData));
    final child = hasValue
        ? Image.memory(
            const Base64Decoder().convert(imageData!.split("base64,")[1]),
            fit: BoxFit.cover,
          )
        : const Center(child: CircularProgressIndicator());
    return Padding(
      padding: const EdgeInsets.only(top: 32),
      child: FractionallySizedBox(
        widthFactor: 0.75,
        child: AspectRatio(aspectRatio: 1.0, child: child),
      ),
    );
  }
}
