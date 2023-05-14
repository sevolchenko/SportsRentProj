import 'package:client/common/values/colors.dart';
import 'package:flutter/material.dart';



final ButtonStyle secondaryButtonStyle = ElevatedButton.styleFrom(
    minimumSize: const Size(202, 58),
    backgroundColor: Colors.white,
    elevation: 0,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.all(
        Radius.circular(20),
      ),
      side: BorderSide(
                    color: kPrimaryColor, width: 3),
    ));