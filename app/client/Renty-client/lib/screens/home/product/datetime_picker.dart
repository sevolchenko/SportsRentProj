import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';

class MyDateTimePicker extends StatefulWidget {
  final void Function(DateTime) onSaved;

  const MyDateTimePicker({required this.onSaved});
  @override
  _MyDateTimePickerState createState() => _MyDateTimePickerState();
}

class _MyDateTimePickerState extends State<MyDateTimePicker> {
  final format = DateFormat("yyyy-MM-dd HH:mm:ss");
  DateTime selectedDate = DateTime.now();
  TimeOfDay selectedTime =
      TimeOfDay(hour: DateTime.now().hour, minute: DateTime.now().minute);

  @override
  Widget build(BuildContext context) {
    return DateTimeField(
      format: format,
      style:
          GoogleFonts.raleway(fontWeight: FontWeight.normal, fontSize: 20.sp),
      onShowPicker: (context, currentValue) async {
        selectedDate = currentValue ?? DateTime.now();
        selectedTime =
            TimeOfDay(hour: selectedDate.hour, minute: selectedDate.minute);

        return await showDatePicker(
          context: context,
          initialDate: selectedDate,
          firstDate: DateTime.now(),
          lastDate: DateTime.now().add(const Duration(days: 60)),
        ).then((date) async {
          if (date != null) {
            selectedDate = date;
            return await showTimePicker(
              context: context,
              initialTime: selectedTime,
              initialEntryMode: TimePickerEntryMode.dial,
            ).then((time) {
              if (time != null) {
                selectedTime = time;
                DateTime result =
                    DateTimeField.combine(selectedDate, selectedTime);
                widget.onSaved(result);
                return DateTimeField.combine(selectedDate, selectedTime);
              } else {
                return currentValue;
              }
            });
          } else {
            return currentValue;
          }
        });
      },
    );
  }
}
