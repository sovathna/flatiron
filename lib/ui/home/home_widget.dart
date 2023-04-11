import 'package:flatiron/data/data_module.dart';
import 'package:flatiron/ui/floor/floor_widget.dart';
import 'package:flatiron/ui/floors/floors_widget.dart';
import 'package:flatiron/ui/home/home_state.dart';
import 'package:flatiron/ui/home/home_view_model.dart';
import 'package:flatiron/ui/profile/profile_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final _viewModel = StateNotifierProvider<HomeViewModel, HomeState>(
    (ref) => HomeViewModel(ref.watch(appPreferencesProvider)));

class HomeWidget extends ConsumerWidget {
  const HomeWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      if (ref.read(_viewModel.select((value) => value.isInit))) {
        ref.read(_viewModel.notifier).init();
      }
    });
    return Scaffold(
      appBar: AppBar(
        title: const Text("Flatiron"),
        actions: [_ProfileIconWidget()],
      ),
      body: Column(
        children: [
          _FloorWidget(),
          const Spacer(),
          _FloorsChoiceWidget(),
        ],
      ),
    );
  }
}

class _FloorsChoiceWidget extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final floors = ref.watch(_viewModel.select((value) => value.floors));
    if (floors.isEmpty) return const SizedBox.shrink();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: const EdgeInsets.only(right: 16.0),
          child: IconButton(
            onPressed: () {
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => FloorsWidget()));
            },
            icon: const Icon(Icons.edit),
            iconSize: 16.0,
            tooltip: "Edit floors",
          ),
        ),
        SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(16, 0, 16, 32),
          scrollDirection: Axis.horizontal,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
              floors.length,
              (index) => Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: ChoiceChip(
                  onSelected: (selected) {
                    ref.read(_viewModel.notifier).setMainFloor(floors[index]);
                  },
                  selected: floors[index] == ref.watch(_viewModel).mainFloor,
                  label: Text(
                    floors[index] == "00" ? "G" : "${int.parse(floors[index])}",
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _FloorWidget extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final mainFloor = ref.watch(_viewModel.select((value) => value.mainFloor));
    if (mainFloor == null) return const SizedBox.shrink();
    return FloorWidget(mainFloor);
  }
}

class _ProfileIconWidget extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final name = ref.watch(_viewModel.select((value) => value.name));
    if (name == null) return const SizedBox.shrink();
    return Padding(
      padding: const EdgeInsets.only(right: 8.0),
      child: IconButton(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => const ProfileWidget(),
            ),
          );
        },
        icon: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              name.toUpperCase(),
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Theme.of(context).colorScheme.primary,
                  ),
            ),
            const SizedBox(width: 4),
            Icon(
              Icons.account_circle,
              color: Theme.of(context).colorScheme.primary,
              size: 24.0,
            ),
          ],
        ),
      ),
    );
  }
}
