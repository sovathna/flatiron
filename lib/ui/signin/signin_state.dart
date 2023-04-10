import 'package:flatiron/const.dart';
import 'package:flutter/foundation.dart';

@immutable
class SigninState {
  final String phone;
  final bool isLoading;
  final bool isInit;
  final String? error;
  final bool isSuccess;

  const SigninState({
    this.phone = "",
    this.isLoading = false,
    this.isInit = true,
    this.error,
    this.isSuccess = false,
  });

  SigninState copyWith({
    String? phone,
    bool? isLoading,
    bool? isInit,
    String? error,
    bool? isSuccess,
  }) {
    return SigninState(
      phone: phone ?? this.phone,
      isLoading: isLoading ?? this.isLoading,
      isInit: isInit ?? this.isInit,
      error: error,
      isSuccess: isSuccess ?? this.isSuccess,
    );
  }

  int get maxLength {
    final found = Const.phones.where((element) {
      final prefix = element['prefix'] as String;
      return phone.startsWith(prefix);
    });
    if (found.isNotEmpty) {
      return (found.first['len'] as int) + 3;
    }
    return 10;
  }
}
