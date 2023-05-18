import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

Widget buildTrashIcon(void Function()? func) {
  return GestureDetector(
    onTap: func,
    child: const Icon(
      FontAwesomeIcons.trash,
      size: 35,
    ),
  );
}
