import 'package:flatiron/data/data_module.dart';
import 'package:flatiron/main.dart';
import 'package:flatiron/ui/profile/profile_state.dart';
import 'package:flatiron/ui/profile/profile_view_model.dart';
import 'package:flatiron/ui/splash/splash_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final _viewModel =
    StateNotifierProvider.autoDispose<ProfileViewModel, ProfileState>(
        (ref) => ProfileViewModel(ref.watch(appPreferencesProvider)));

class ProfileWidget extends ConsumerWidget {
  const ProfileWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      if (ref.read(_viewModel.select((value) => value.isInit))) {
        ref.read(_viewModel.notifier).init();
      }
    });
    final state = ref.watch(_viewModel);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Profile"),
      ),
      body: state.hasData
          ? Row(
              children: [
                Expanded(
                  child: Column(
                    children: [
                      Expanded(
                        child: SingleChildScrollView(
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              children: [
                                FractionallySizedBox(
                                  widthFactor: 0.4,
                                  child: FittedBox(
                                    child: CircleAvatar(
                                      backgroundColor: Theme.of(context)
                                          .colorScheme
                                          .primaryContainer,
                                      child: Text(
                                        state.name![0].toUpperCase(),
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyLarge
                                            ?.copyWith(
                                                color: Theme.of(context)
                                                    .colorScheme
                                                    .onPrimaryContainer),
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 16),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 16.0),
                                  child: Text(
                                    state.name!.toUpperCase(),
                                    style:
                                        Theme.of(context).textTheme.titleLarge,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 16.0),
                                  child: Text(
                                    state.phone!,
                                    style:
                                        Theme.of(context).textTheme.titleLarge,
                                  ),
                                ),
                                const SizedBox(height: 16),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 4.0, horizontal: 16.0),
                                  child: Row(
                                    children: [
                                      const Expanded(child: Text("Company")),
                                      Expanded(child: Text(state.company!))
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 4.0, horizontal: 16.0),
                                  child: Row(
                                    children: [
                                      const Expanded(child: Text("Main floor")),
                                      Expanded(child: Text(state.mainFloor!))
                                    ],
                                  ),
                                ),
                                const SizedBox(height: 24),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 8.0, horizontal: 16.0),
                                  child: Row(
                                    children: [
                                      const Expanded(child: Text("Dark mode")),
                                      Switch(
                                        value: ref.watch(isDarkModeProvider),
                                        onChanged: (selected) {
                                          logger.d("clicked");
                                          ref
                                              .read(_viewModel.notifier)
                                              .changeThemeMode();
                                          ref
                                              .read(isDarkModeProvider.notifier)
                                              .state = selected;
                                        },
                                      )
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 16.0),
                        child: ElevatedButton.icon(
                          onPressed: () async {
                            showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    title: const Text("Logout!"),
                                    content: const Text(
                                        "Are you sure you want to logout?"),
                                    actions: [
                                      TextButton(
                                        onPressed: () {
                                          ref
                                              .read(_viewModel.notifier)
                                              .logout();
                                          Navigator.of(context)
                                              .pushAndRemoveUntil(
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          const SplashWidget()),
                                                  (route) => false);
                                        },
                                        child: Text(
                                          "Yes",
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyMedium
                                              ?.copyWith(
                                                  color: Theme.of(context)
                                                      .colorScheme
                                                      .error),
                                        ),
                                      ),
                                      TextButton(
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                          child: Text(
                                            "No",
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyMedium,
                                          )),
                                    ],
                                  );
                                });
                          },
                          icon: const Icon(Icons.logout),
                          label: const Text("Logout"),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            )
          : const SizedBox.shrink(),
    );
  }
}
