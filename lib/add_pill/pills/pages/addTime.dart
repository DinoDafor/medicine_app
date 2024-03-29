import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medicine_app/add_pill/pills/data/bloc/pill_bloc.dart';
import 'package:medicine_app/add_pill/pills/data/model/pill_model.dart';
import 'package:medicine_app/add_pill/pills/widget/TimeCard.dart';
import 'package:uuid/uuid.dart';

import '../../service_locator.dart';
import '../data/model/enums/dayForDrink_enum.dart';
import '../data/model/enums/form_enum.dart';
import '../data/model/enums/status_enum.dart';
import '../widget/customButton.dart';
import 'drag_list_screen.dart';

/// страница, где пользователь выбирает время приема
/// для этого нужно нажать на серую кнопку с временем и появится диалоговое окно
/// также отсюда при нажатии кнопки "Зарегистрировать", данные будут отправляться на сервер
class AddTimePage extends StatefulWidget {
  final String name;
  final int countOfPills;
  final int countOfDays;
  final String repetition;
  final int specificToDrink;
  final String description;
  final List partOfTheDay;
  final FormEnum image;

  AddTimePage(
      {required this.name,
      required this.countOfPills,
      required this.countOfDays,
      required this.repetition,
      required this.specificToDrink,
      required this.description,
      required this.partOfTheDay,
      required this.image});

  @override
  State<AddTimePage> createState() => _AddTimePageState();
}

List timeList = [null, null, null, null];

class _AddTimePageState extends State<AddTimePage> {
  _AddTimePageState() {
    timeList = [null, null, null, null];
  }

  @override
  void dispose() {
    log("Dispose");

    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: SafeArea(
        child: Scrollbar(
          child: CupertinoPageScaffold(
            navigationBar: CupertinoNavigationBar(),
            child: Padding(
              padding: const EdgeInsets.only(top: 0.0),
              child: Scrollbar(
                child: Container(
                  color: const Color.fromARGB(255, 226, 226, 226),
                  width: MediaQuery.of(context).size.width,

                  /// height: MediaQuery.of(context).size.height * 0.895,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        height: 76,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text("${widget.name}",
                            style: TextStyle(fontSize: 24)),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          height: 88,
                          //child: Center(
                          child: Center(
                              child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                                "Выберите лучшее время для приема лекарств"),
                          )),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.blue),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        ///color: Colors.red,
                        height: MediaQuery.of(context).size.height * 0.49,

                        ///height: 100,
                        child: ListView.builder(
                          itemCount: widget.partOfTheDay.length,
                          itemBuilder: (context, index) {
                            log("In ListView builder ${widget.partOfTheDay.length}");
                            switch (widget.partOfTheDay[index]) {
                              case 0:
                                {
                                  return Container(

                                      ///height: 300,
                                      child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                        Text("Утро",
                                            style: TextStyle(
                                                color: Colors.orange,
                                                fontSize: 17)),
                                        TimeCard(
                                            DayForDrink.morning,
                                            widget.name,
                                            widget.countOfDays,
                                            widget.repetition),
                                      ]));
                                }

                              case 1:
                                {
                                  return Container(

                                      ///height: 300,
                                      child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                        Text(
                                          "День",
                                          style: TextStyle(
                                              color: Colors.green,
                                              fontSize: 17),
                                        ),
                                        TimeCard(
                                            DayForDrink.day,
                                            widget.name,
                                            widget.countOfDays,
                                            widget.repetition),
                                      ]));
                                }

                              case 2:
                                {
                                  return Container(

                                      ///height: 300,
                                      child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                        Text(
                                          "Вечер",
                                          style: TextStyle(
                                              color: Color.fromARGB(
                                                  255, 176, 128, 59),
                                              fontSize: 17),
                                        ),
                                        TimeCard(
                                            DayForDrink.evening,
                                            widget.name,
                                            widget.countOfDays,
                                            widget.repetition),
                                      ]));
                                }

                              case 3:
                                {
                                  return Container(

                                      ///height: 300,
                                      child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                        Text(
                                          "Ночь",
                                          style: TextStyle(
                                              color: Colors.purple,
                                              fontSize: 17),
                                        ),
                                        TimeCard(
                                            DayForDrink.night,
                                            widget.name,
                                            widget.countOfDays,
                                            widget.repetition),
                                      ]));
                                }
                            }
                          },
                          padding: EdgeInsets.all(8),
                        ),
                      ),
                      // SizedBox(
                      //   height: 2,
                      // ),
                      Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: CupertinoButton(
                          child: Text("Установить"),
                          onPressed: () async {
                            print(timeList);
                            for (int i = 0; i < 4; i++) {
                              for (int j = 0; j < widget.countOfDays; j++) {
                                var uuid = Uuid().v4();
                                log("UUiD $uuid");

                                // Route route = CupertinoPageRoute(builder: (context) => const AddPhilsPage());
                                //     Navigator.push(context, route);
                                ///идет заполнение сущности, чтобы затем ее кинуть в блок
                                log("widget.repet = ${widget.repetition}");
                                if (timeList[i] == null) continue;
                                if (widget.repetition == "Через день" &&
                                    (j % 2 == 1)) continue;
                                log("J is $j");
                                PillModel pill = PillModel(
                                  id: uuid.toString(),
                                  name: widget.name,
                                  image: widget.image,
                                  countOfPills: widget.countOfPills,
                                  ////durationToTake: widget._state.counterDays,
                                  repetition: widget.repetition,

                                  status: StatusEnum.ATTENTION,
                                  specificToDrink: widget.specificToDrink,
                                  timeToDrink:
                                      (widget.repetition == "Через день")
                                          ? timeList[i].add(Duration(days: j))
                                          : timeList[i].add(Duration(days: j)),
                                  description: widget.description,
                                );

                                BlocProvider.of<PillBloc>(context)
                                    .add(AddPillBloc(pill: pill));
                              }
                            }

                            timeList = [null, null, null, null];
                            log("Time List after for $timeList");
                            CustomButton.days = [];
                            Route route =
                                CupertinoPageRoute(builder: (context) {
                              return BlocProvider<PillBloc>(
                                  create: (context) => sl<PillBloc>(),
                                  child: DragListScreen());
                            });
                            Navigator.push(
                              context,
                              route,
                            );

                            ///return;
                            ///  widget._state.time = timeList;
                          },
                          color: Colors.green,
                          padding:
                              EdgeInsets.symmetric(vertical: 5, horizontal: 95),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

///width: 400,
