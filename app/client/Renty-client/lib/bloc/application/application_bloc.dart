import 'package:client/bloc/application/application_event.dart';
import 'package:client/bloc/application/application_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ApplicationBloc extends Bloc<ApplicationEvent, ApplicationState> {
  ApplicationBloc() : super(const ApplicationState()) {
    on<TriggerAppEvent>((event, emit) {
      print("index ${event.index}");
      emit(ApplicationState(index: event.index));
    });
  }
}
