import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_time_picker_spinner/flutter_time_picker_spinner.dart';

/// диалоговое окно для установки времени
class TimeDialog extends StatelessWidget {
  final DateTime timeDefolt;

  const TimeDialog({Key? key, required this.timeDefolt}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    DateTime myTime = timeDefolt;
    final height = MediaQuery.of(context).size.height * 0.45;
    final width = MediaQuery.of(context).size.width * 0.8;

    // TODO: implement build
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(40)),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Выбери время приема",
              style: TextStyle(fontSize: 24),
              textAlign: TextAlign.center,
            ),
            TimePickerSpinner(
              time: timeDefolt,
              onTimeChange: (time) {
                myTime = time;
              },
              itemHeight: height * 0.15,
            ),
            Container(
              height: height * 0.2 - 16,
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    CupertinoButton(
                        child: Text("Отменить"),
                        onPressed: () {
                          Navigator.of(context).pop(myTime);
                        },
                        padding: EdgeInsets.symmetric(
                            vertical: 10, horizontal: width * 0.06),
                        color: Colors.grey),
                    CupertinoButton(
                        child: Text("Подтвердить"),
                        onPressed: () {
                          log(myTime.toString(), name: "mytime in TimeDialog");
                          Navigator.of(context).pop(myTime);
                        },
                        padding: EdgeInsets.symmetric(
                            vertical: 10, horizontal: width * 0.06),
                        color: Colors.green),
                  ]),
            )
          ],
        ),
      ),
    );
  }
}
