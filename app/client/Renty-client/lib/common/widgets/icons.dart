import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

Widget buildTrashIcon(context, void Function() func, ) {
  return GestureDetector(
    onTap: () {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text("Подтверждение удаления"),
              content: const Text("Вы действительно хотите удалить?"),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Text("Отмена"),
                ),
                TextButton(
                  onPressed: () => func(),
                  child: const Text("Удалить"),
                ),
              ],
            );
          });
    },
    child: const Icon(
      FontAwesomeIcons.trash,
      size: 35,
    ),
  );
}
