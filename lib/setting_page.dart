import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'main.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({Key? key}) : super(key: key);

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  DateTime _currentdate = DateTime.now();
  late DateTime pickeddate;
  late TimeOfDay pickedtime;
  TimeOfDay? time;
  TimeOfDay _currenttime = TimeOfDay.now();
  DateTime? date;
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: EdgeInsets.all(28),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Date"),
                Text("$date"),
              ],
            ),
          ),
          Container(
            height: 50,
            width: MediaQuery.of(context).size.width - 45,
            child: SizedBox.expand(
              child: ElevatedButton(
                child: const Text("Change Date"),
                style: ElevatedButton.styleFrom(
                  primary: const Color(0xff54759E),
                ),
                onPressed: () async {
                  (isIOS == false)
                      ? pickeddate = (await showDatePicker(
                          context: context,
                          initialDate: _currentdate,
                          firstDate: DateTime(1999),
                          lastDate: DateTime(2025),
                          selectableDayPredicate: (DateTime day) {
                            return (day.isBefore(DateTime.now()
                                        .add(const Duration(days: 10))) &&
                                    day.isAfter(DateTime.now()
                                        .subtract(const Duration(days: 1))))
                                ? true
                                : false;
                          }))!
                      : await showCupertinoModalPopup(
                          context: context,
                          builder: (context) {
                            return Container(
                              height: 250,
                              color: Colors.white,
                              child: CupertinoDatePicker(
                                mode: CupertinoDatePickerMode.date,
                                initialDateTime: _currentdate,
                                maximumYear: 2030,
                                minimumYear: 1990,
                                onDateTimeChanged: (val) {
                                  setState(() {
                                    _currentdate = val;
                                  });
                                  print(_currentdate);
                                },
                              ),
                            );
                          });

                  setState(() {
                    date = ((isIOS)
                            ? DateFormat("d, MMMM y").format(_currentdate)
                            : DateFormat("d, MMMM y").format(pickeddate))
                        as DateTime;
                  });
                },
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(28),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Time"),
                Text("$time"),
              ],
            ),
          ),
          Container(
            height: 50,
            width: MediaQuery.of(context).size.width - 45,
            child: SizedBox.expand(
              child: ElevatedButton(
                child: const Text("Change Time"),
                style: ElevatedButton.styleFrom(
                  primary: const Color(0xff54759E),
                ),
                onPressed: () async {
                  (isIOS == false)
                      ? pickedtime = (await showTimePicker(
                          context: context,
                          initialTime: _currenttime,
                          confirmText: "Confirm",
                          cancelText: "Dismiss",
                          helpText: "Choose your desired time",
                          initialEntryMode: TimePickerEntryMode.dial,
                          errorInvalidText: "Enter proper time",
                        ))!
                      : await showCupertinoModalPopup(
                          context: context,
                          builder: (context) {
                            return Container(
                              height: 250,
                              color: Colors.white,
                              child: CupertinoDatePicker(
                                mode: CupertinoDatePickerMode.time,
                                initialDateTime: _currentdate,
                                maximumYear: 2030,
                                minimumYear: 1990,
                                onDateTimeChanged: (val) {
                                  setState(() {
                                    _currentdate = val;
                                  });
                                },
                              ),
                            );
                          });

                  (isIOS)
                      ? setState(() {
                          time = ((_currentdate.hour > 12)
                                  ? "${_currentdate.hour - 12}:${_currentdate.minute}:${DateTime.now().second} ${(_currentdate.hour > 12) ? 'PM' : 'AM'}"
                                  : "${_currentdate.hour}:${_currentdate.minute}:${DateTime.now().second} ${(_currentdate.hour > 12) ? 'PM' : 'AM'}")
                              as TimeOfDay;
                        })
                      : setState(() {
                          time = ((pickedtime.periodOffset == 12)
                                  ? "${pickedtime.hour - 12}:${pickedtime.minute}:${DateTime.now().second} ${pickedtime.period.name}"
                                  : "${pickedtime.hour}:${pickedtime.minute}:${DateTime.now().second} ${pickedtime.period.name}")
                              as TimeOfDay;
                        });
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
