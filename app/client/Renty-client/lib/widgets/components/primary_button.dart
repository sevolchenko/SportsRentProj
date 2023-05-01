import 'package:client/constants.dart';
import 'package:flutter/material.dart';



final ButtonStyle primaryButtonStyle = ElevatedButton.styleFrom(
    minimumSize: const Size(202, 58),
    backgroundColor: kPrimaryColor,
    elevation: 0,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.all(
        Radius.circular(20),
      ),
    ));
