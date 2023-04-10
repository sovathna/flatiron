import 'package:flutter/foundation.dart';

@immutable
class SplashState {
  final bool isLoading;
  final bool isInit;
  final String? error;
  final bool? isSuccess;

  const SplashState({
    this.isLoading = false,
    this.isInit = true,
    this.error,
    this.isSuccess = false,
  });

  SplashState copyWith({
    String? phone,
    bool? isLoading,
    bool? isInit,
    String? error,
    bool? isSuccess,
  }) {
    return SplashState(
      isLoading: isLoading ?? this.isLoading,
      isInit: isInit ?? this.isInit,
      error: error,
      isSuccess: isSuccess,
    );
  }
}
