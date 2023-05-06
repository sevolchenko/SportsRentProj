import 'package:client/bloc/sign_in/sign_in_bloc.dart';
import 'package:client/bloc/user/user_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppBlocProviders {
  static get allBlocProviders => [
        BlocProvider(create: (context) => UserBloc()),
        BlocProvider(create: (context) => SignInBloc()),
      ];
}
