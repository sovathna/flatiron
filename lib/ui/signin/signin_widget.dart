import 'package:flatiron/const.dart';
import 'package:flatiron/data/data_module.dart';
import 'package:flatiron/main.dart';
import 'package:flatiron/ui/otp_verification/otp_verification_widget.dart';
import 'package:flatiron/ui/signin/signin_state.dart';
import 'package:flatiron/ui/signin/signin_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final _signinViewModel = StateNotifierProvider<SigninViewModel, SigninState>(
    (ref) => SigninViewModel(ref.watch(appServiceProvider)));

class SigninWidget extends ConsumerWidget {
  const SigninWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(title: const Text("Signin")),
      body: _PhoneEntryWidget(),
    );
  }
}

class _PhoneEntryWidget extends ConsumerWidget {
  void _onSubmitted(WidgetRef ref) {
    final value = ref.read(_signinViewModel).phone;
    final found = Const.phones.where((e) {
      final prefix = e["prefix"] as String;
      final len = e["len"] as int;
      return value.startsWith(prefix) && value.length == len + 3;
    });
    final viewModel = ref.read(_signinViewModel.notifier);
    if (found.isEmpty) {
      viewModel.setValidationError();
    } else {
      viewModel.signin();
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      ref.read(_signinViewModel.notifier).phoneInputFocusNode.requestFocus();
    });

    ref.listen(_signinViewModel.select((value) => value.isSuccess),
        (oldValue, newValue) {
      if (newValue) {
        Navigator.of(context)
            .push(
              MaterialPageRoute(
                builder: (context) =>
                    OtpVerificationWidget(ref.read(_signinViewModel).phone),
              ),
            )
            .then((value) => ref.read(_signinViewModel.notifier).reset());
      }
    });
    return Column(
      children: [
        Expanded(
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              children: [
                _IconWidget(),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: TextField(
                    focusNode:
                        ref.read(_signinViewModel.notifier).phoneInputFocusNode,
                    enabled: ref.watch(
                        _signinViewModel.select((value) => !value.isLoading)),
                    maxLength: ref.watch(
                        _signinViewModel.select((value) => value.maxLength)),
                    controller: ref
                        .read(_signinViewModel.notifier)
                        .phoneInputController,
                    textInputAction: TextInputAction.send,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      prefixIcon: Icon(
                        Icons.phone,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                      suffixIcon: const _SuffixIconWidget(),
                      border: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(12.0)),
                      ),
                      labelText: "Phone",
                      hintText: "Ex: 0123456789",
                      errorText: ref.watch(_signinViewModel).error,
                    ),
                    onChanged: ref.read(_signinViewModel.notifier).setPhone,
                    onSubmitted: (value) => _onSubmitted(ref),
                  ),
                ),
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              Expanded(
                child: ElevatedButton(
                  onPressed: ref.watch(
                          _signinViewModel.select((value) => value.isLoading))
                      ? null
                      : () => _onSubmitted(ref),
                  child: ref.watch(
                          _signinViewModel.select((value) => value.isLoading))
                      ? const SizedBox(
                          width: 18,
                          height: 18,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                          ),
                        )
                      : const Text("Signin"),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _IconWidget extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final phone = ref.watch(_signinViewModel).phone;
    final found = Const.phones.where((e) {
      final prefix = e["prefix"] as String;
      return phone.startsWith(prefix);
    });
    Widget widget = Icon(
      Icons.person,
      color: Theme.of(context).colorScheme.primary,
    );
    if (found.isNotEmpty) {
      final icon = found.first["icon"] as String;
      final network = found.first["network"] as String;
      if (icon.isNotEmpty) {
        widget = ClipOval(
            child: Image.asset(
          icon,
          fit: BoxFit.contain,
        ));
      } else {
        widget = Text(network);
      }
    }

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: FractionallySizedBox(
          widthFactor: 0.25,
          child: AspectRatio(
            aspectRatio: 1.0,
            child: FittedBox(
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 250),
                transitionBuilder: (child, animation) => FadeTransition(
                  opacity: animation,
                  child: child,
                ),
                child: widget,
              ),
            ),
          )),
    );
  }
}

class _SuffixIconWidget extends ConsumerWidget {
  const _SuffixIconWidget();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isInputEmpty =
        ref.watch(_signinViewModel.select((value) => value.phone)).isEmpty;
    final isLoading =
        ref.watch(_signinViewModel.select((value) => value.isLoading));
    if (isInputEmpty) return const SizedBox.shrink();

    return IconButton(
      onPressed: isLoading
          ? null
          : () {
              ref.read(_signinViewModel.notifier).setPhone("");
            },
      icon: const Icon(Icons.clear_rounded),
    );
  }
}
