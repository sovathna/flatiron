import 'package:flutter/material.dart';

@immutable
class ProfileState {
  final bool isInit;
  final String? name;
  final String? phone;
  final String? company;
  final String? mainFloor;

  const ProfileState(
      {this.isInit = true,
      this.name,
      this.phone,
      this.company,
      this.mainFloor});

  ProfileState copyWith(
      {bool? isInit,
      String? name,
      String? phone,
      String? company,
      String? mainFloor}) {
    return ProfileState(
        isInit: isInit ?? this.isInit,
        name: name ?? this.name,
        phone: phone ?? this.phone,
        company: company ?? this.company,
        mainFloor: mainFloor ?? this.mainFloor);
  }

  bool get hasData => name?.isNotEmpty == true && phone?.isNotEmpty == true;
}
