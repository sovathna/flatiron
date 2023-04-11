import 'package:flatiron/data/data_module.dart';
import 'package:flatiron/ui/home/home_widget.dart';
import 'package:flatiron/ui/signin/signin_widget.dart';
import 'package:flatiron/ui/splash/splash_state.dart';
import 'package:flatiron/ui/splash/splash_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final _viewModel =
    StateNotifierProvider.autoDispose<SplashViewModel, SplashState>(
  (ref) => SplashViewModel(ref.watch(appPreferencesProvider)),
);

class SplashWidget extends ConsumerWidget {
  const SplashWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      if (ref.read(_viewModel.select((value) => value.isInit))) {
        ref.read(_viewModel.notifier).init();
      }
    });
    ref.listen(
      _viewModel.select((value) => value.isSuccess),
      (previous, next) {
        if (next == null || previous == next) return;
        final widget = next ? const HomeWidget() : const SigninWidget();
        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => widget),
          (route) => false,
        );
      },
    );
    return Scaffold(
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            const Spacer(),
            Text(
              "FLATIRON",
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const Spacer(flex: 2),
            const CircularProgressIndicator(),
            const Spacer(flex: 2),
          ],
        ),
      ),
    );
  }
}
