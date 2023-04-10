import 'dart:async';
import 'dart:convert';

import 'package:async/async.dart';
import 'package:flatiron/const.dart';
import 'package:flatiron/data/app_service.dart';
import 'package:flatiron/main.dart';
import 'package:flatiron/ui/otp_verification/otp_verification_state.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/adapters.dart';

class OtpVerificationViewModel extends StateNotifier<OtpVerificationState> {
  OtpVerificationViewModel(this._service, this._box)
      : super(const OtpVerificationState()) {
    startTimer();
  }

  final AppService _service;
  final Box _box;

  final FocusNode focusNode = FocusNode();

  void setPhone(String phone) {
    state = state.copyWith(phone: phone);
  }

  void setOtp(String otp) {
    state = state.copyWith(otp: otp, error: "");
  }

  void verifyOtp() async {
    try {
      state = state.copyWith(isLoading: true, error: "");
      final res = await _service.verifyOTP(state.phone, state.otp);
      if (!mounted) return;
      logger.d("${res.statusCode}");
      if (res.statusCode == 200) {
        final maps = jsonDecode(res.body) as Map;
        await _box.put("otp_verification_response", maps);
        if (!mounted) return;
        state = state.copyWith(isSuccess: true);
      } else if (res.statusCode == 403) {
        final data = jsonDecode(res.body) as Map<String, dynamic>;
        if ((data['status'] as int) == 412) {
          state = state.copyWith(
            isLoading: false,
            error: "Incorrect OTP!",
          );
        } else {
          state = state.copyWith(
            isLoading: false,
            error: "An error has occurred! [${res.statusCode}]",
          );
        }
      } else {
        state = state.copyWith(
          isLoading: false,
          error: "An error has occurred! [${res.statusCode}]",
        );
      }
    } on Exception catch (e) {
      logger.e(e);
      state = state.copyWith(
        isLoading: false,
        error: "An error has occurred!",
      );
    }
  }

  void getOtp() async {
    state = state.copyWith(isOtp: true, error: "");

    await Future.delayed(const Duration(seconds: 2));

    state = state.copyWith(timer: kOtpTimer, isOtp: false);
    startTimer();
  }

  Timer? otpTimer;

  void startTimer() {
    otpTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (!mounted) _cancelOtpTimer();
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
    logger.d("dispose");
    focusNode.dispose();
    _cancelOtpTimer();
    super.dispose();
  }
}
