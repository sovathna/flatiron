import 'package:flatiron/const.dart';
import 'package:flutter/foundation.dart';

@immutable
class OtpVerificationState {
  final String phone;
  final String otp;
  final bool isLoading;
  final String error;
  final bool isSuccess;
  final int timer;
  final bool isOtp;

  const OtpVerificationState({
    this.phone = "",
    this.otp = "",
    this.isLoading = false,
    this.error = "",
    this.isSuccess = false,
    this.timer = kOtpTimer,
    this.isOtp = false,
  });

  OtpVerificationState copyWith({
    String? phone,
    String? otp,
    bool? isLoading,
    bool? isInit,
    String? error,
    bool? isSuccess,
    int? timer,
    bool? isOtp,
  }) {
    return OtpVerificationState(
      phone: phone ?? this.phone,
      otp: otp ?? this.otp,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
      isSuccess: isSuccess ?? this.isSuccess,
      timer: timer ?? this.timer,
      isOtp: isOtp ?? this.isOtp,
    );
  }

  bool get isConfirmEnabled {
    return !isOtp &&
        !isLoading &&
        (otp
                .trim()
                .replaceAll("-", "")
                .replaceAll(".", "")
                .replaceAll(",", "")
                .length ==
            4);
  }

  bool get isResendEnabled {
    return !isOtp && !isLoading && timer == 0;
  }

  bool get isPinEnabled {
    return !isOtp && !isLoading;
  }

  String get maskPhone => _mask(phone);

  String _mask(String phone) {
    if (phone.isEmpty) return phone;
    final start = phone.substring(0, 3);
    final end = phone.substring(phone.length - 2);
    return phone.length == 9 ? "$start****$end" : "$start*****$end";
  }
}
