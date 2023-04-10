import 'package:flatiron/ui/floor/floor_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final _homeViewModel = StateProvider<String>((ref) => "18");

const _floors = ["00", "03", "18", "19", "25"];

class HomeWidget extends ConsumerWidget {
  const HomeWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(title: const Text("Flatiron")),
      body: Column(
        children: [
          FloorWidget(ref.watch(_homeViewModel)),
          const Spacer(),
          SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 32),
            scrollDirection: Axis.horizontal,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                _floors.length,
                (index) => Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: ChoiceChip(
                    onSelected: (selected) {
                      ref.read(_homeViewModel.notifier).state = _floors[index];
                    },
                    selected: _floors[index] == ref.watch(_homeViewModel),
                    label: Text(
                      _floors[index],
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
