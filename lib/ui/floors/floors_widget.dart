import 'package:flatiron/data/data_module.dart';
import 'package:flatiron/main.dart';
import 'package:flatiron/ui/floors/floors_state.dart';
import 'package:flatiron/ui/floors/floors_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final _viewModel = StateNotifierProvider<FloorsViewModel, FloorsState>(
    (ref) => FloorsViewModel(ref.watch(appPreferencesProvider)));

class FloorsWidget extends ConsumerWidget {
  const FloorsWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      if (ref.read(_viewModel.select((value) => value.isInit))) {
        ref.read(_viewModel.notifier).init();
      }
    });

    final state = ref.watch(_viewModel);
    return Scaffold(
      appBar: AppBar(title: const Text("Edit floors")),
      body: SingleChildScrollView(
        child: Align(
          alignment: Alignment.topCenter,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Wrap(
              children: List.generate(
                state.floors.length,
                (index) => Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: ChoiceChip(
                    label: Text(
                      state.floors[index] == "00"
                          ? "G"
                          : "${int.parse(state.floors[index])}",
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    selected: state.enableds.contains(state.floors[index]),
                    onSelected: (selected) {
                      logger.d("$selected");
                      ref
                          .read(_viewModel.notifier)
                          .selectOrDeselect(selected, state.floors[index]);
                    },
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
