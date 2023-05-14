import 'package:client/bloc/profile/profile_event.dart';
import 'package:client/bloc/profile/profile_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileBloc() : super(const ProfileState()) {
    on<EmailEvent>(_emailEvent);
    on<NameEvent>(_nameEvent);
  }

  void _nameEvent(NameEvent event, Emitter<ProfileState> emit) {
    emit(state.copyWith(name: event.name));
  }

  void _emailEvent(EmailEvent event, Emitter<ProfileState> emit) {
    // print("my email is ${event.email}");
    emit(state.copyWith(email: event.email));
  }

  
}