import 'package:flutter/material.dart';

@immutable
class ProfileState {
  final bool isInit;
  final String? name;
  final String? phone;

  const ProfileState({
    this.isInit = true,
    this.name,
    this.phone,
  });

  ProfileState copyWith({
    bool? isInit,
    String? name,
    String? phone,
  }) {
    return ProfileState(
      isInit: isInit ?? this.isInit,
      name: name ?? this.name,
      phone: phone ?? this.phone,
    );
  }

  bool get hasData => name?.isNotEmpty == true && phone?.isNotEmpty == true;
}
