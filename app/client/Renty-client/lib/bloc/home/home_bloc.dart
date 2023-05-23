import 'package:client/bloc/home/home_event.dart';
import 'package:client/bloc/home/home_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(const HomeState()) {
    on<HomeProductProjectionItem>(_homeProductProjectionUtem);
  }

  void _homeProductProjectionUtem(HomeProductProjectionItem event, Emitter<HomeState> emit){
    emit(state.copyWith(productProjectionItem: event.productProjectionItem));  
  }
}
