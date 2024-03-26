import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:medicine_app/add_pill/pills/components/app_bar_cupertino.dart';
import 'package:medicine_app/add_pill/pills/components/appbar_mode.dart';
import 'package:medicine_app/add_pill/pills/components/tab_layout.dart';
import 'package:medicine_app/add_pill/pills/widget/drag_list.dart';

import 'addTime.dart';

class DragListScreen extends StatelessWidget {
  DragListScreen() {
    timeList = [null, null, null, null];
    log("call constructor", name: "in DragListScreen");
  }
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
        child: SafeArea(
            child: Stack(children: [
      Column(
        children: [
          AppBarCupertino(mode: AppBarMode.LIST),
          Flexible(child: DragList())
        ],
      ),
      Positioned(
        child: TabLayout(),
        bottom: 0.0,
        left: 0.0,
        right: 0.0,
      )
    ])));
  }
}
