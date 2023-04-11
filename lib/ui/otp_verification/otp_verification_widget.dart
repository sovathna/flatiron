import 'package:flatiron/data/data_module.dart';
import 'package:flatiron/ui/home/home_widget.dart';
import 'package:flatiron/ui/otp_verification/otp_verification_state.dart';
import 'package:flatiron/ui/otp_verification/otp_verification_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pinput/pinput.dart';

final _viewModel = StateNotifierProvider.autoDispose<OtpVerificationViewModel,
    OtpVerificationState>(
  (ref) => OtpVerificationViewModel(
    ref.watch(appServiceProvider),
    ref.watch(appPreferencesProvider),
  ),
);

class OtpVerificationWidget extends ConsumerWidget {
  const OtpVerificationWidget(this.phone, {super.key});

  final String phone;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(_viewModel.notifier).setPhone(phone);
    });

    ref.listen(
      _viewModel.select((value) => value.isSuccess),
      (prev, next) {
        if (prev != next && next) {
          Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => const HomeWidget()),
            (route) => false,
          );
        }
      },
    );
    return Scaffold(
      appBar: AppBar(title: const Text("OTP Verification")),
      body: const _OtpWidget(),
    );
  }
}

class _TitleWidget extends ConsumerWidget {
  const _TitleWidget();
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Text(
      "OTP has been sent to number\n${ref.watch(_viewModel.select((value) => value.phone))}",
      textAlign: TextAlign.center,
      style: Theme.of(context).textTheme.titleMedium,
    );
  }
}

class _OtpWidget extends ConsumerWidget {
  const _OtpWidget();
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Row(
      children: [
        Expanded(
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: const [
                      _IconWidget(),
                      _TitleWidget(),
                      SizedBox(height: 16),
                      _OtpInputWidget(),
                      SizedBox(height: 32),
                      _ResendWidget()
                    ],
                  ),
                ),
              ),
              const _ConfirmButtonWidget()
            ],
          ),
        ),
      ],
    );
  }
}

class _ResendWidget extends ConsumerWidget {
  const _ResendWidget();
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final timer = ref.watch(_viewModel.select((value) => value.timer));
    return Row(
      children: [
        const Spacer(),
        Expanded(
            child: ElevatedButton(
                onPressed: ref.watch(
                        _viewModel.select((value) => value.isResendEnabled))
                    ? () {
                        ref.read(_viewModel.notifier).getOtp();
                      }
                    : null,
                child: ref.watch(_viewModel.select((value) => value.isOtp))
                    ? const SizedBox(
                        width: 18,
                        height: 18,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                        ),
                      )
                    : const Text("Resend OTP"))),
        timer > 0
            ? Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 16.0),
                  child: Text("${timer}s"),
                ),
              )
            : const Spacer(),
      ],
    );
  }
}

class _ConfirmButtonWidget extends ConsumerWidget {
  const _ConfirmButtonWidget();
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        children: [
          Expanded(
            child: ElevatedButton(
              onPressed: ref.watch(
                      _viewModel.select((value) => value.isConfirmEnabled))
                  ? () {
                      ref.read(_viewModel.notifier).verifyOtp();
                    }
                  : null,
              child: ref.watch(_viewModel.select((value) => value.isLoading))
                  ? const SizedBox(
                      width: 18,
                      height: 18,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                      ),
                    )
                  : const Text("Confirm"),
            ),
          ),
        ],
      ),
    );
  }
}

class _IconWidget extends StatelessWidget {
  const _IconWidget();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: FractionallySizedBox(
          widthFactor: 0.25,
          child: AspectRatio(
            aspectRatio: 1.0,
            child: FittedBox(
              child: Icon(
                Icons.pin_rounded,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
          )),
    );
  }
}

class _OtpInputWidget extends ConsumerWidget {
  const _OtpInputWidget();
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      ref.read(_viewModel.notifier).focusNode.requestFocus();
    });
    final color = Theme.of(context).colorScheme.primary;
    final textStyle = Theme.of(context)
        .textTheme
        .titleLarge
        ?.copyWith(color: color, fontSize: 23, fontWeight: FontWeight.bold);
    final decoration = BoxDecoration(
      border: Border.all(color: color, width: 1.2),
      borderRadius: BorderRadius.circular(16),
    );
    final defaultPinTheme = PinTheme(
      width: 56,
      height: 56,
      textStyle: textStyle,
      decoration: decoration,
    );

    final focusedPinTheme = defaultPinTheme.copyDecorationWith(
      border: Border.all(color: color, width: 2),
    );

    final errorTheme = defaultPinTheme.copyWith(
        decoration: decoration.copyWith(
          border: Border.all(
              color: Theme.of(context).colorScheme.error, width: 1.2),
        ),
        textStyle:
            textStyle?.copyWith(color: Theme.of(context).colorScheme.error));

    final disabledTheme = defaultPinTheme.copyWith(
        decoration: decoration.copyWith(
          border: Border.all(color: color, width: 1.2),
        ),
        textStyle: textStyle?.copyWith(
            color: Theme.of(context).colorScheme.secondary));

    final submittedPinTheme = defaultPinTheme.copyWith(
      decoration: defaultPinTheme.decoration?.copyWith(
        color: Theme.of(context).colorScheme.secondaryContainer,
      ),
    );

    return Pinput(
      defaultPinTheme: defaultPinTheme,
      focusedPinTheme: focusedPinTheme,
      submittedPinTheme: submittedPinTheme,
      errorTextStyle: Theme.of(context)
          .textTheme
          .bodySmall
          ?.copyWith(color: Theme.of(context).colorScheme.error),
      errorPinTheme: errorTheme,
      enabled: ref.watch(_viewModel.select((value) => value.isPinEnabled)),
      focusNode: ref.read(_viewModel.notifier).focusNode,
      showCursor: false,
      forceErrorState:
          ref.watch(_viewModel.select((value) => value.error)).isNotEmpty,
      errorText: ref.watch(_viewModel.select((value) => value.error)),
      onChanged: (value) {
        ref.read(_viewModel.notifier).setOtp(value);
      },
      onCompleted: (value) {
        ref.read(_viewModel.notifier).verifyOtp();
      },
    );
  }
}
