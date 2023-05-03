import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

@immutable
abstract class UserEvent extends Equatable {
  const UserEvent();

   List<Object?> get props => [];
}

class LoadUserEvent extends UserEvent {}
