import 'package:flatiron/data/app_service.dart';
import 'package:flatiron/main.dart';
import 'package:flatiron/ui/signin/signin_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SigninViewModel extends StateNotifier<SigninState> {
  SigninViewModel(this._service) : super(const SigninState());

  final AppService _service;

  final TextEditingController phoneInputController =
      TextEditingController(text: "");
  final phoneInputFocusNode = FocusNode();
  void signin() async {
    try {
      state = state.copyWith(isLoading: true);
      final res = await _service.signin(state.phone);
      if (res.statusCode == 200 && res.body == "OK") {
        state = state.copyWith(isSuccess: true);
      } else if (res.statusCode == 412) {
        state = state.copyWith(
          isLoading: false,
          error: "Number is not registered!",
        );
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

  void reset() {
    state = state.copyWith(isLoading: false, isSuccess: false);
  }

  void setPhone(String value) {
    if (value.isEmpty) phoneInputController.clear();
    state = state.copyWith(phone: value, error: null);
  }

  void setValidationError() {
    state = state.copyWith(error: "Invalid phone number!");
  }

  void clearValidationError() {
    state = state.copyWith(error: null);
  }

  @override
  void dispose() {
    phoneInputFocusNode.dispose();
    phoneInputController.dispose();
    super.dispose();
  }
}
