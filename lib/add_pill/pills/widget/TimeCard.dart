import 'dart:developer';

import 'package:alarm/alarm.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:medicine_app/add_pill/pills/widget/drag_list.dart';

import '../data/model/enums/dayForDrink_enum.dart';
import '../pages/TimeDialog.dart';
import '../pages/addTime.dart';

/// карточка для выбора времени и установления уведомлений (пока не реализовано)
class TimeCard extends StatefulWidget {
  final DayForDrink my_day;
  final String title;
  final String repetition;
  final int duration;
  TimeCard(this.my_day, this.title, this.duration, this.repetition) {}

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _TimeCardState(my_day);
  }
}

class _TimeCardState extends State<TimeCard> {
  DayForDrink dayForDrink;
  DragList selectedDate = DragList();
  _TimeCardState(this.dayForDrink) {
    if (dayForDrink.index == 0) {
      time = DateTime(DragList.selectedDate.year, DragList.selectedDate.month,
          DragList.selectedDate.day, 9, 0);
    }

    if (dayForDrink.index == 1) {
      time = DateTime(DragList.selectedDate.year, DragList.selectedDate.month,
          DragList.selectedDate.day, 12, 0);
    }

    if (dayForDrink.index == 2) {
      time = DateTime(DragList.selectedDate.year, DragList.selectedDate.month,
          DragList.selectedDate.day, 18, 0);
    }

    if (dayForDrink.index == 3) {
      time = DateTime(DragList.selectedDate.year, DragList.selectedDate.month,
          DragList.selectedDate.day, 21, 0);
    }
  }

  DateTime time = DragList.selectedDate;
  bool SwitchValue = false;
  Color iconColor = Colors.grey;

  @override
  Widget build(BuildContext context) {
    timeList[dayForDrink.index] = time;

    double width = MediaQuery.of(context).size.width * 0.7;
    // TODO: implement build
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
          width: width,
          height: 130,

          ///color: Colors.white,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20), color: Colors.white),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    width: width,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text("Время"),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 16.0),
                          child: Icon(
                            CupertinoIcons.bell_circle_fill,
                            color: iconColor,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    width: width,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CupertinoButton(
                          child: Text("${time.hour}:${time.minute}"),
                          onPressed: () async {
                            var timeNew = await _dialogBuilder(context, time) ??
                                DateTime.now();

                            if (time != timeNew) {
                              setState(() {
                                time = timeNew;
                              });
                            }

                            switch (dayForDrink.index) {
                              case 0:
                                {
                                  timeList[0] = time;
                                  if (SwitchValue == true) {
                                    for (int i = 0; i < widget.duration; i++) {
                                      if (widget.repetition == "Каждый день") {
                                        await _setAlarm(time);
                                      } else {
                                        if (i % 2 == 0) {
                                          await _setAlarm(time);
                                        }
                                      }
                                    }
                                  } else {
                                    break;
                                  }
                                }

                              case 1:
                                {
                                  timeList[1] = time;
                                  if (SwitchValue == true) {
                                    for (int i = 0; i < widget.duration; i++) {
                                      if (widget.repetition == "Каждый день") {
                                        await _setAlarm(time);
                                      } else {
                                        if (i % 2 == 0) {
                                          await _setAlarm(time);
                                        }
                                      }
                                    }
                                  } else {
                                    break;
                                  }
                                }

                              case 2:
                                {
                                  timeList[2] = time;
                                  if (SwitchValue == true) {
                                    for (int i = 0; i < widget.duration; i++) {
                                      if (widget.repetition == "Каждый день") {
                                        await _setAlarm(time);
                                      } else {
                                        if (i % 2 == 0) {
                                          await _setAlarm(time);
                                        }
                                      }
                                    }
                                  } else {
                                    break;
                                  }
                                }

                              case 3:
                                {
                                  timeList[3] = time;
                                  if (SwitchValue == true) {
                                    for (int i = 0; i < widget.duration; i++) {
                                      if (widget.repetition == "Каждый день") {
                                        await _setAlarm(time);
                                      } else {
                                        if (i % 2 == 0) {
                                          await _setAlarm(time);
                                        }
                                      }
                                    }
                                  } else {
                                    break;
                                  }
                                }
                            }

                            // print("My time is $time");
                            log(time.toString(), name: "time in TimeCard");
                          },
                          padding: EdgeInsets.symmetric(
                              vertical: 10, horizontal: 30),
                          color: Colors.grey,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        CupertinoSwitch(
                            value: SwitchValue,
                            onChanged: (bool? flag) {
                              setState(() {
                                SwitchValue = flag ?? false;
                                if (flag == true) {
                                  iconColor = Colors.green;

                                  /// widget.needNotification=true;
                                } else {
                                  iconColor = Colors.grey;

                                  ///  widget.needNotification=false;
                                }
                              });
                            }),
                      ],
                    ),
                  ),
                ),
              ])),
    );
  }

  Future<DateTime?> _dialogBuilder(BuildContext context, DateTime time) {
    return showDialog<DateTime?>(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
              insetPadding: EdgeInsets.all(20),
              child: TimeDialog(
                timeDefolt: time,
              ));
        });
  }

  Future<bool> _setAlarm(DateTime time) {
    return Alarm.set(
        alarmSettings: AlarmSettings(
      id: 3,
      dateTime: time,
      assetAudioPath: 'assets/alarm.mp3',
      loopAudio: true,
      vibrate: true,
      volumeMax: true,
      fadeDuration: 3.0,
      notificationTitle: widget.title,
      notificationBody: 'Время принимать таблетку',
      enableNotificationOnKill: true,
    ));
  }
}
