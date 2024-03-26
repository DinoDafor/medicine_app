import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../data/model/enums/dayForDrink_enum.dart';

/// данный класс создает кнопку, которая используется для выбора времени приема.
/// Такая же кнопка НЕ используется для выбора ПОВТОРА применения и ОСОБЕННОСТЕЙ ПРИЕМА, так как в них нам важно отслеживать, что кнопка была нажата только в одном месте

class CustomButton extends StatefulWidget {
  static List days = [];
  DayForDrink dayForDrink = DayForDrink.day;

  CustomButton(DayForDrink dayForDrink) {
    this.dayForDrink = dayForDrink;
  }

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _CustomButtonState(dayForDrink);
  }
}

class _CustomButtonState extends State<CustomButton> {
  DayForDrink dayForDrink = DayForDrink.day;
  bool flag = false;
  Color backColor = Colors.green;
  Color textColor = Colors.white;
  String text = "";

  _CustomButtonState(DayForDrink dayForDrink) {
    this.dayForDrink = dayForDrink;

    switch (dayForDrink.index) {
      case 0:
        {
          text = "Утро";
          break;
        }

      case 1:
        {
          text = "День";
          break;
        }

      case 2:
        {
          text = "Вечер";
          break;
        }

      case 3:
        {
          text = "Ночь";
          break;
        }
    }
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.25 - 16,
      decoration: BoxDecoration(
          border: Border.all(), borderRadius: BorderRadius.circular(50)),
      child: CupertinoButton(
        ///disabledColor: Colors.white,
        color: (flag == true) ? backColor : textColor,
        child: Text(
          text,
          style: TextStyle(color: (flag == true) ? textColor : backColor),
          softWrap: false,
        ),
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        onPressed: () {
          setState(() {
            flag = !flag;
            if (flag == true) {
              CustomButton.days.add(dayForDrink.index);
            } else {
              CustomButton.days
                  .removeWhere((item) => item == dayForDrink.index);
            }
          });
        },
        borderRadius: BorderRadius.circular(50),
      ),
    );
  }
}
