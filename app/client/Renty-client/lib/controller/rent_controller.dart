import 'dart:math';

import 'package:client/bloc/rent/rent_bloc.dart';
import 'package:client/bloc/rent/rent_event.dart';
import 'package:client/bloc/rent/rent_state.dart';
import 'package:client/screens/profile/employee/rental_completion/rental_comletion.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RentController {
  final BuildContext context;
  RentController({required this.context});

  void handleSearchByEmail(String email) async {
    context.read<RentBloc>().add(SearchUserRentsEvent(email));
    // final state = context.read<RentBloc>().state;
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => RentalCompletionScreen(
          userEmail: email,
        ),
      ),
    );
  }
}
