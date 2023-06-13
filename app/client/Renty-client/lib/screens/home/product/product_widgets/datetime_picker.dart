import 'package:client/common/widgets/auxiliary_wigets.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class MyDateTimePicker extends StatefulWidget {
  final void Function(DateTime) onSaved;
  final DateTime? startDateTime;

  const MyDateTimePicker({required this.onSaved, this.startDateTime});
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
          lastDate: DateTime.now().add(const Duration(days: 30)),
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
                if (widget.startDateTime == null) {
                  if (DateTime.now().isAfter(result)) {
                    result = DateTime.now().add(Duration(minutes: 5));
                    TimeOfDay timeOfDay = TimeOfDay.fromDateTime(result);
                    DateTime date =
                        DateTime(result.year, result.month, result.day);
                    Duration duration =
                        Duration(hours: result.hour, minutes: result.minute);
                    DateTime time = DateTime(date.year, date.month, date.day,
                        timeOfDay.hour, timeOfDay.minute);

                    DateTime combined = DateTimeField.combine(date, timeOfDay);
                    widget.onSaved(result);
                    toastInfo(
                        msg: "Некорректное время! Изменнено на ${result}");
                    return combined;
                  }
                }
                if (widget.startDateTime != null) {
                  if (widget.startDateTime!.isAfter(result)) {
                    result =
                        widget.startDateTime!.add(const Duration(hours: 1));
                    TimeOfDay timeOfDay = TimeOfDay.fromDateTime(result);
                    DateTime date =
                        DateTime(result.year, result.month, result.day);
                    DateTime combined = DateTimeField.combine(date, timeOfDay);
                    widget.onSaved(result);
                    toastInfo(
                        msg:
                            "Некорректное время окончания аренды! Добавлен 1 час от начала аренды");
                    return combined;
                  }
                }
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
