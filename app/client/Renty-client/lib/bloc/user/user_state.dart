import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

@immutable
abstract class UserState extends Equatable {
  const UserState();

  List<Object?> get props => [];
}

class UserInitState extends UserState {}

class UserLoadingState extends UserState {}
