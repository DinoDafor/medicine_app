import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:medicine_app/add_pill/pills/components/app_bar_cupertino.dart';
import 'package:medicine_app/add_pill/pills/components/appbar_mode.dart';

import 'PageForProvider.dart';

/// класс обертка, чтобы использовать провайдер (иначе ругается)
/// на данном этапе провайдер нужен, как хранилище, чтобы передавать данные между экранами
class AddPhilsPage extends StatelessWidget {
  const AddPhilsPage({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Material(
      child: CupertinoPageScaffold(
        child: SafeArea(
          child: SingleChildScrollView(
            physics: ScrollPhysics(),
            child: Column(
              children: [
                AppBarCupertino(mode: AppBarMode.ADD),

                ///CustomButton("dfd"),

                new PageForProvider()
              ],
            ),
          ),
        ),
      ),
    );
  }
}
