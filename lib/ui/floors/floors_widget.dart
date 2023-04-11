import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FloorsWidget extends ConsumerWidget {
  const FloorsWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(title: const Text("Edit floors")),
      body: SingleChildScrollView(
        child: Align(
          alignment: Alignment.topCenter,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Wrap(
              children: List.generate(
                50,
                (index) => Padding(
                  padding: const EdgeInsets.all(2.0),
                  child: ChoiceChip(
                    label: Text("$index"),
                    selected: index % 2 == 0,
                    onSelected: (selected) {},
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
