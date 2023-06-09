import 'package:flatiron/data/data_module.dart';
import 'package:flatiron/ui/floor/floor_widget.dart';
import 'package:flatiron/ui/floors/floors_widget.dart';
import 'package:flatiron/ui/home/home_state.dart';
import 'package:flatiron/ui/home/home_view_model.dart';
import 'package:flatiron/ui/profile/profile_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:showcaseview/showcaseview.dart';

final _viewModel = StateNotifierProvider<HomeViewModel, HomeState>(
    (ref) => HomeViewModel(ref.watch(appPreferencesProvider)));

final _key1 = GlobalKey();
final _key2 = GlobalKey();

class HomeWidget extends ConsumerWidget {
  const HomeWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final args = ModalRoute.of(context)!.settings.arguments as Map?;
    final shouldShowcase = (args?['shouldShowcase'] as bool?) == true;
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      if (ref.read(_viewModel.select((value) => value.isInit))) {
        ref.read(_viewModel.notifier).init();
      }

      if (shouldShowcase) {
        ShowCaseWidget.of(context).startShowCase([_key1, _key2]);
      }
    });
    return Scaffold(
      appBar: AppBar(
        title: const Text("Flatiron"),
        actions: [_ProfileIconWidget()],
      ),
      body: Row(
        children: [
          Expanded(
            child: Column(
              children: [
                Expanded(
                  child: shouldShowcase
                      ? Showcase(
                          key: _key1,
                          description: "Swipe down to refresh the QR code.",
                          child: _FloorWidget(),
                        )
                      : _FloorWidget(),
                ),
                _FloorsChoiceWidget(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _FloorsChoiceWidget extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final args = ModalRoute.of(context)!.settings.arguments as Map?;
    final shouldShowcase = (args?['shouldShowcase'] as bool?) == true;
    final floors = ref.watch(_viewModel.select((value) => value.floors));
    if (floors.isEmpty) return const SizedBox.shrink();
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Align(
          alignment: Alignment.centerRight,
          child: Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: shouldShowcase
                ? Showcase(
                    key: _key2,
                    description: "Select which floors to show on the Homepage.",
                    child: IconButton(
                      onPressed: () {
                        Navigator.of(context)
                            .push(
                              MaterialPageRoute(
                                builder: (context) => const FloorsWidget(),
                              ),
                            )
                            .then((value) =>
                                ref.read(_viewModel.notifier).refreshFloors());
                      },
                      icon: const Icon(Icons.edit),
                      iconSize: 18.0,
                      tooltip: "Edit",
                    ),
                  )
                : IconButton(
                    onPressed: () {
                      Navigator.of(context)
                          .push(
                            MaterialPageRoute(
                              builder: (context) => const FloorsWidget(),
                            ),
                          )
                          .then((value) =>
                              ref.read(_viewModel.notifier).refreshFloors());
                    },
                    icon: const Icon(Icons.edit),
                    iconSize: 18.0,
                    tooltip: "Edit",
                  ),
          ),
        ),
        SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
          scrollDirection: Axis.horizontal,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
              floors.length,
              (index) => Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4.0),
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
              style: Theme.of(context).textTheme.bodyMedium,
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
