////import 'dart:html';

import 'dart:developer' as developer;
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:medicine_app/add_pill/pills/pages/drag_list_screen.dart';
import 'package:medicine_app/add_pill/service_locator.dart';
import 'package:medicine_app/onBoarding/data/visitedData.dart';
import 'package:medicine_app/onBoarding/screen1.dart';
import 'package:medicine_app/onBoarding/screen2.dart';
import 'package:medicine_app/onBoarding/screen3.dart';
import 'package:medicine_app/screens/authentication_screen.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../add_pill/pills/data/bloc/pill_bloc.dart';

class GeneralScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _GeneralScreenState();
  // TODO: implement createState
}

class SpecialColor extends Color {
  const SpecialColor() : super(0x00000000);

  @override
  int get alpha => 0xFF;
}

/// данный класс представляет собой приветственное окно, которое должно открываться один раз при первом запуске приложения
/// используя кнопку "Продолжить" или смахивая влево экраны переключаются
/// после прохождения всех экранов должна идти форма с авторизацией
/// чтобы этот экран запускался один раз используем Hive.box, для хранения флага
class _GeneralScreenState extends State<GeneralScreen> {
  final _controller = PageController();
  final _myBox = Hive.box('mybox');

  ///перечисление экранов
  Screen1 screen1 = Screen1();
  Screen2 screen2 = Screen2();
  Screen3 screen3 = Screen3();
  List screens = [];

  VisitedIndicator visited = VisitedIndicator();
  bool flag = false;

  ///добавление экранов
  _GeneralScreenState() {
    screens.add(screen1);
    screens.add(screen2);
    screens.add(screen3);
  }
  @override
  void initState() {
    if (_myBox.get("FLAG") != null) flag = true;
    developer.log(flag.toString(), name: "Flag in GeneralScreenState");

    super.initState();
  }

  //// индекс экрана(используется для переключения)
  int screenIndex = 0;
  @override
  Widget build(BuildContext context) {
    if (flag == false) {
      // TODO: implement build
      return CupertinoPageScaffold(
        child: SafeArea(
          child: Stack(
            children: [
              PageView.builder(
                controller: _controller,
                itemBuilder: (context, index) {
                  onPageChanged(index);
                  return screens[index];
                },

                /// onPageChanged: _onPageChanged(index),
                itemCount: screens.length,
              ),

              /// Screen1(),
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: Container(
                  alignment: Alignment.bottomCenter,
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(28.0),
                          child: SmoothPageIndicator(
                            controller: _controller,
                            count: 3,
                            effect: SwapEffect(
                                activeDotColor: Colors.red,
                                radius: 10,
                                dotHeight: 10,
                                dotWidth: 10),
                          ),
                        ),
                        CupertinoButton(
                          child: Text("Продолжить"),
                          onPressed: () {
                            if (screenIndex < 2) {
                              screenIndex = screenIndex + 1;
                              log(screenIndex.toString(), name: 'screenIndex');
                              _controller.jumpToPage(screenIndex);
                            } else {
                              visited.updateData();
                              Navigator.of(context).push(CupertinoPageRoute(
                                  builder: (BuildContext context) {
                                return AuthenticationScreen();
                              }));

                              ///тут должен быть переход на авторизацию (когда пролистали три экрана и нажали кнопку:продолжить)
                            }
                          },
                          color: const Color.fromARGB(255, 14, 190, 127),
                        ),
                        CupertinoButton(
                            child: Text(
                              "Пропустить",
                              style: TextStyle(
                                  color: Color.fromARGB(255, 103, 114, 148)),
                            ),
                            onPressed: () {
                              Navigator.of(context).push(CupertinoPageRoute(
                                  builder: (BuildContext context) {
                                return AuthenticationScreen();
                              }));
                            })
                      ]),
                ),
              ),

              Padding(
                padding: const EdgeInsets.only(left: 20.0, top: 36),
                child: SizedBox(
                  width: 37,
                  height: 30,
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.all(0),
                          backgroundColor: Color.fromARGB(255, 242, 242, 244),
                          shape: RoundedRectangleBorder(
                              side: BorderSide(
                                color: Color.fromARGB(255, 103, 114, 148),
                              ),
                              borderRadius: BorderRadius.circular(10))),
                      onPressed: () {
                        if (screenIndex > 0) {
                          screenIndex = screenIndex - 1;
                          _controller.jumpToPage(screenIndex);
                        }
                      },
                      child: Center(
                        child: const Icon(
                          CupertinoIcons.left_chevron,
                          color: Color.fromARGB(255, 103, 114, 148),
                          size: 24,
                        ),
                      )),
                ),
              ),
            ],
          ),
        ),
      );
    } else {
      return BlocProvider<PillBloc>(
        create: (context) => sl<PillBloc>(),
        child: DragListScreen(),
      );
    }
  }

  onPageChanged(int index) {
    ///developer.log("Current page is $index");

    screenIndex = index;
  }
}
