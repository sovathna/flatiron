import 'dart:async';

import 'package:flatiron/const.dart';
import 'package:flatiron/data/app_service.dart';
import 'package:flatiron/ui/otp_verification/otp_verification_state.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class OtpVerificationViewModel extends StateNotifier<OtpVerificationState> {
  OtpVerificationViewModel(this._service)
      : super(const OtpVerificationState()) {
    startTimer();
  }

  final AppService _service;

  final FocusNode focusNode = FocusNode();

  void setPhone(String phone) {
    state = state.copyWith(phone: phone);
  }

  void setOtp(String otp) {
    state = state.copyWith(otp: otp, error: "");
  }

  void verifyOtp() async {
    state = state.copyWith(isLoading: true, error: "");

    await Future.delayed(const Duration(seconds: 2));

    state = state.copyWith(isLoading: false, error: "An error has occurred!");
  }

  void getOtp() async {
    state = state.copyWith(isOtp: true, error: "");

    await Future.delayed(const Duration(seconds: 2));

    state = state.copyWith(timer: kOtpTimer, isOtp: false);
    startTimer();
  }

  Timer? otpTimer;

  void startTimer() {
    _cancelOtpTimer();
    otpTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      final newTimer = state.timer - 1;
      state = state.copyWith(timer: newTimer);
      if (newTimer == 0) {
        _cancelOtpTimer();
      }
    });
  }

  void _cancelOtpTimer() {
    if (otpTimer?.isActive == true) {
      otpTimer?.cancel();
    }
  }

  @override
  void dispose() {
    focusNode.dispose();
    _cancelOtpTimer();
    super.dispose();
  }
}
