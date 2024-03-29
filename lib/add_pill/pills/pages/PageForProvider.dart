import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:medicine_app/add_pill/pills/data/bloc/pill_bloc.dart';
import 'package:medicine_app/add_pill/pills/widget/Pill_Icon.dart';
import 'package:medicine_app/add_pill/pills/widget/customButton.dart';

import '../../service_locator.dart';
import '../data/model/enums/dayForDrink_enum.dart';
import '../data/model/enums/form_enum.dart';
import 'addTime.dart';

/// класс для отображения интерфейса добавления таблетки
class PageForProvider extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _PageForProviderState();
  }
}

class _PageForProviderState extends State<PageForProvider> {
  /// переменные для работы радиокнопки
  int selectedDayButton = 0;
  int selectedSchedButton = 0;

  ///переменная для выбора количества повторений
  static String selectedDay = "";
  List<String> paths = [
    "assets/images/diasepam.png",
    'assets/images/ibuprofen.png',
    'assets/images/clonasepam.png',
    'assets/images/phenobarbital.png'
  ];
  FormEnum form = FormEnum.DIASEPAM;

  /// изначальная иконка - диазепам

  final _nameController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _focusNode = FocusNode();
  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    // TODO: implement dispose
    super.dispose();
  }

  /// кастомная радио кнопка
  /// используется, чтобы выбрать один вариант
  Widget DayButton(String text, int index, bool flag) {
    int selected;

    Color selectedSchedDayButtonBack = Colors.green;
    Color selectedSchedDayButtonFont = Colors.white;

    Color selectedDayButtonBack = Colors.green;
    Color selectedDayButtonFont = Colors.white;

    return Container(
      decoration: BoxDecoration(
          border: Border.all(),
          borderRadius: BorderRadius.circular(50),
          color: Colors.green),
      child: CupertinoButton(
        ///disabledColor: Colors.white,
        color: (flag == false)
            ? (selectedDayButton == index)
                ? selectedDayButtonBack
                : selectedDayButtonFont
            : (selectedSchedButton == index)
                ? selectedSchedDayButtonBack
                : selectedSchedDayButtonFont,
        child: Text(
          text,
          style: TextStyle(
              color: (flag == false)
                  ? (selectedDayButton == index)
                      ? selectedDayButtonFont
                      : selectedDayButtonBack
                  : (selectedSchedButton == index)
                      ? selectedSchedDayButtonFont
                      : selectedSchedDayButtonBack,
              fontSize: 14),
        ),
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        onPressed: () {
          _focusNode.unfocus();
          setState(() {
            if (flag == false) {
              if (selectedDayButton == index) {
                selectedDay = "";
                selectedDayButton = 0;
                selectedDayButtonBack = Colors.white;
                selectedDayButtonFont = Colors.green;
              } else {
                selectedDayButton = index;
                selected = selectedDayButton;

                switch (index) {
                  case 1:
                    {
                      selectedDay = "Каждый день";
                      break;
                    }

                  case 2:
                    {
                      selectedDay = "Через день";
                      break;
                    }
                }
              }
            } else {
              if (selectedSchedButton == index) {
                ///selectedDay ="";
                selectedSchedButton = 0;
                selectedSchedDayButtonBack = Colors.white;
                selectedSchedDayButtonFont = Colors.green;
              } else {
                selectedSchedButton = index;
                selected = selectedSchedButton;
              }
            }
          });
        },
        borderRadius: BorderRadius.circular(50),
      ),
    );
  }

//////////////////////////////////////////////////////////////////////
  ///
  ///
  //////
  int countOfPills = 0;
  int countOfDays = 0;

  bool read = false;
  @override
  Widget build(BuildContext context) {
    ///  PillProvider _state = Provider.of<PillProvider>(context);

    return Material(
      child: Container(
        height: MediaQuery.of(context).size.height * 0.79,
        width: MediaQuery.of(context).size.width,
        child: ListView(
          padding: EdgeInsets.all(6),
          shrinkWrap: true,
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: 50,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width * 0.6 - 6,
                    child: Text(
                      "Название нового лекарства",
                      style: TextStyle(
                          fontFamily: 'Poppins',
                          letterSpacing: 0.75,
                          fontWeight: FontWeight.w700),
                    ),
                  ),

                  Container(
                    width: MediaQuery.of(context).size.width * 0.4 - 20,
                    child: Text("Форма",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontFamily: 'Poppins',
                            letterSpacing: 0.75,
                            fontWeight: FontWeight.w700)),
                  ),

                  ////  SizedBox(width:1)
                ],
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width * 0.6,
                    child: CupertinoTextField(
                      focusNode: _focusNode,
                      //// readOnly: read,
                      // onSubmitted: (_) async {
                      //   _focusNode.unfocus();
                      //   setState(() {

                      //   });
                      ///  },
                      controller: _nameController,
                      padding:
                          EdgeInsets.symmetric(horizontal: 5, vertical: 10),
                      decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 233, 232, 232),
                          borderRadius: BorderRadius.circular(5),
                          boxShadow: [
                            BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 3,
                                blurRadius: 4,
                                offset: Offset(3, 3))
                          ]),

                      //     ]),
                    ),
                  ),
                  SizedBox(width: 8),
                  Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          border: Border.all(color: Colors.green)),
                      width: MediaQuery.of(context).size.width * 0.4 - 20,
                      child: CupertinoButton(
                        padding:
                            EdgeInsets.symmetric(horizontal: 8, vertical: 5),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Icon(CupertinoIcons.left_chevron),
                            Image.asset(
                              paths[form.index],
                              width: 60,
                              height: 60,
                            ),
                            Icon(CupertinoIcons.right_chevron),
                          ],
                        ),
                        onPressed: () async {
                          _focusNode.unfocus();
                          form = await _dialogBuilder(context) ??
                              FormEnum.DIASEPAM;
                          setState(() {});
                        },
                      ))
                ],
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Container(
              width: MediaQuery.of(context).size.width - 8,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width * 0.5 - 4,
                    child: Text(
                      "Дозировка в день",
                      style: TextStyle(
                          fontFamily: 'Poppins',
                          letterSpacing: 2,
                          fontWeight: FontWeight.w700,
                          fontSize: 14),
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.4,
                    child: Text(
                      "Длительность приема",
                      style: TextStyle(
                          fontFamily: 'Rubik',
                          letterSpacing: 2,
                          fontWeight: FontWeight.w700,
                          fontSize: 14),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Container(
              width: MediaQuery.of(context).size.width - 8,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.5 - 4,
                      child: Row(
                        children: [
                          CupertinoButton(
                            padding: EdgeInsets.symmetric(
                                vertical: 10, horizontal: 10),
                            child: Icon(
                              CupertinoIcons.minus,
                              color: Colors.black,
                            ),
                            color: Color.fromARGB(255, 227, 227, 227),
                            borderRadius: BorderRadius.circular(100),
                            onPressed: () {
                              _focusNode.unfocus();
                              setState(() {
                                if (countOfPills > 0) {
                                  countOfPills--;
                                  log("count of pills $countOfPills");
                                }
                              });
                            },
                            //minSize: 10,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              width: MediaQuery.of(context).size.width * 0.2,
                              child: Column(
                                children: [
                                  Text("${countOfPills}"),
                                  Text(
                                    "Таблетка",
                                    style: TextStyle(
                                        fontFamily: 'Rubik',
                                        letterSpacing: 2,
                                        fontWeight: FontWeight.w700,
                                        fontSize: 11.5),
                                  )
                                ],
                              ),
                            ),
                          ),
                          CupertinoButton(
                            padding: EdgeInsets.symmetric(
                                vertical: 10, horizontal: 10),
                            child: Icon(
                              CupertinoIcons.add,
                              color: Colors.black,
                            ),
                            color: Color.fromARGB(255, 227, 227, 227),
                            borderRadius: BorderRadius.circular(100),
                            onPressed: () {
                              _focusNode.unfocus();
                              setState(() {
                                countOfPills++;
                                log("count of pills $countOfPills");
                              });
                            },

                            //minSize: 10,
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 1),
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.5 - 25,
                      child: Row(
                        children: [
                          CupertinoButton(
                            padding: EdgeInsets.symmetric(
                                vertical: 10, horizontal: 10),
                            child: Icon(
                              CupertinoIcons.minus,
                              color: Colors.black,
                            ),
                            color: Color.fromARGB(255, 227, 227, 227),
                            borderRadius: BorderRadius.circular(100),
                            onPressed: () {
                              _focusNode.unfocus();
                              setState(() {
                                if (countOfDays > 0) {
                                  countOfDays--;
                                }
                              });
                            },
                            //minSize: 10,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(1.0),
                            child: Container(
                              width: MediaQuery.of(context).size.width * 0.15,
                              child: Column(
                                children: [
                                  Text("${countOfDays}"),
                                  Text(
                                    "День",
                                    style: TextStyle(
                                        fontFamily: 'Rubik',
                                        letterSpacing: 2,
                                        fontWeight: FontWeight.w700,
                                        fontSize: 11.5),
                                  )
                                ],
                              ),
                            ),
                          ),
                          CupertinoButton(
                            padding: EdgeInsets.symmetric(
                                vertical: 10, horizontal: 10),
                            child: Icon(
                              CupertinoIcons.add,
                              color: Colors.black,
                            ),
                            color: Color.fromARGB(255, 227, 227, 227),
                            borderRadius: BorderRadius.circular(100),
                            onPressed: () {
                              _focusNode.unfocus();
                              setState(() {
                                countOfDays++;
                              });
                            },
                            //minSize: 10,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Text(
              "Повтор",
              style: TextStyle(
                  fontFamily: 'Rubik',
                  letterSpacing: 2,
                  fontWeight: FontWeight.w700),
            ),
            SizedBox(
              height: 15,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                DayButton("Каждый день", 1, false),
                DayButton("Через день", 2, false),
              ],
            ),
            SizedBox(
              height: 15,
            ),
            Text(
              "Время приема",
              style: TextStyle(
                  fontFamily: 'Rubik',
                  letterSpacing: 2,
                  fontWeight: FontWeight.w700),
            ),
            SizedBox(
              height: 15,
            ),
            Container(
              /// width: 100,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  CustomButton(DayForDrink.morning),
                  CustomButton(DayForDrink.day),
                  CustomButton(DayForDrink.evening),
                  CustomButton(DayForDrink.night)
                ],
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Text("Особенности приема",
                style: TextStyle(
                    fontFamily: 'Rubik',
                    letterSpacing: 2,
                    fontWeight: FontWeight.w700)),
            SizedBox(
              height: 15,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                DayButton("До приема еды", 1, true),
                DayButton("После приема еды", 2, true),

                /// DayButton("Не имеет значение", 3, true)
              ],
            ),
            SizedBox(
              height: 15,
            ),
            Text(
              "Заметки врача",
              style: TextStyle(
                  fontSize: 14,
                  fontFamily: 'Poppins',
                  color: Colors.black,
                  letterSpacing: 2,
                  fontWeight: FontWeight.w500),
            ),
            SizedBox(
              height: 15,
            ),
            SingleChildScrollView(
              child: SafeArea(
                child: CupertinoTextFormFieldRow(
                  controller: _descriptionController,
                  maxLines: 3,
                  placeholder: "Написать заметку",
                  decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 233, 232, 232),
                      borderRadius: BorderRadius.circular(5),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 3,
                            blurRadius: 4,
                            offset: Offset(3, 3))
                      ]),
                ),
              ),
            ),
            SizedBox(
              height: 15,
            ),
            CupertinoButton(
                child: Text(
                  "Продолжить",
                  softWrap: false,
                ),
                onPressed: () {
                  _focusNode.unfocus();
                  // _state.name = _nameController.text;
                  // _state.form = form;
                  // _state.repetition = selectedDay;
                  // CustomButton.days.sort();
                  // _state.partOfTheDay = CustomButton.days;
                  // _state.specificToDrink = selectedSchedButton;
                  // _state.description = _descriptionController.text;
                  log(_nameController.text);
                  log(_descriptionController.text);
                  if (_nameController.text == "") {
                    Fluttertoast.showToast(
                        msg: "Добавьте название лекарства",
                        gravity: ToastGravity.BOTTOM);
                  } else {
                    if (countOfPills == 0) {
                      Fluttertoast.showToast(
                          msg: "Введите дозировку",
                          gravity: ToastGravity.BOTTOM);
                    } else {
                      if (countOfDays == 0) {
                        Fluttertoast.showToast(
                            msg: "Введите длительность приёма",
                            gravity: ToastGravity.BOTTOM);
                      } else {
                        if (selectedDay == "") {
                          Fluttertoast.showToast(
                              msg: "Выберите режим повтора приема",
                              gravity: ToastGravity.BOTTOM);
                        } else if (CustomButton.days.isEmpty) {
                          Fluttertoast.showToast(
                              msg: "Выберите время приёма",
                              gravity: ToastGravity.BOTTOM);
                        } else {
                          ///  developer.log(
                          ///  'Part of the day in AddPill${CustomButton.days.length}');
                          log(CustomButton.days.length.toString(),
                              name: "CustomButtom.days.length in PageProvider");

                          /// _state.form =
                          timeList = [null, null, null, null];
                          var list = CustomButton.days;
                          list.sort();
                          log(selectedDay.toString(),
                              name: "selectedDay(repetition) in PageProvider");
                          Route route = CupertinoPageRoute(builder: (context) {
                            return BlocProvider<PillBloc>(
                              create: (context) => sl<PillBloc>(),
                              child: AddTimePage(
                                name: _nameController.text,
                                countOfPills: countOfPills,
                                countOfDays: countOfDays,
                                repetition: (selectedDayButton == 2)
                                    ? "Через день"
                                    : "Каждый день",
                                specificToDrink: selectedSchedButton,
                                description: _descriptionController.text,
                                partOfTheDay: list,
                                image: form,
                              ),
                            );
                          });

                          Navigator.push(
                            context,
                            route,
                          );
                        }
                      }
                    }
                  }
                },
                color: Colors.green)
          ],
        ),
      ),
    );
  }

  Future<FormEnum?> _dialogBuilder(BuildContext context) {
    return showDialog<FormEnum?>(
        context: context,
        builder: (BuildContext context) {
          return Dialog(insetPadding: EdgeInsets.all(20), child: PillIcon());
        });
  }
}
