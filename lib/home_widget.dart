import 'package:flatiron/floor/floor_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeWidget extends ConsumerWidget {
  const HomeWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(title: const Text("Flatiron")),
      body: ListView(
        children: const [
          SizedBox(height: 400, child: FloorWidget(18)),
        ],
      ),
    );
  }
}
