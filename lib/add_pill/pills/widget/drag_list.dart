import 'dart:developer';

import 'package:calendar_timeline/calendar_timeline.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medicine_app/add_pill/pills/data/bloc/pill_bloc.dart';
import 'package:medicine_app/add_pill/pills/data/model/pill_entity.dart';

import '../pages/addPillsPage.dart';
import 'list_item.dart';

class DragList extends StatefulWidget {
  @override
  _DragListState createState() => _DragListState();
  static late DateTime selectedDate;
}

class _DragListState extends State<DragList> {
  final _scrollController = ScrollController();

  //final _myBox = Hive.box('pillBox');
  //// PillDatabase pillDatabase = PillDatabase();
  List<PillEntity> pills = [];
  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _resetSelectedDate();

    //// pills = pillDatabase.loadData(); /// вот это непонятно как работает
  }

  void _resetSelectedDate() {
    DragList.selectedDate = DateTime.now();
  }

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<PillBloc>(context, listen: false)
        .add(LoadPillBloc(date: DragList.selectedDate));

    return BlocBuilder<PillBloc, PillBlocState>(builder: (context, state) {
      if (state is PillLoaded) {
        pills = state.pillList;
      }
      return pills.isEmpty
          ? Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                _calenarTimeLine(),
                _blankList(),
              ],
            )
          : LayoutBuilder(
              builder: (BuildContext context, BoxConstraints constraints) {
              return SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      _calenarTimeLine(),
                      const SizedBox(
                        height: 10,
                      ),
                      Container(
                        height: MediaQuery.of(context).size.height / 1.5,
                        child: ListView.builder(
                          controller: _scrollController,
                          shrinkWrap: true,
                          scrollDirection: Axis.vertical,
                          itemCount: pills.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 8.0, horizontal: 50.0),
                              child: ListItem(pill: pills[index]),
                            );
                          },
                        ),
                      )
                    ],
                  ));
            });
    });
  }

  Widget _calenarTimeLine() {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: CalendarTimeline(
        initialDate: DragList.selectedDate,
        firstDate: DateTime(DateTime.now().year),
        lastDate: DateTime(DateTime.now().year, DateTime.december, 31),
        onDateSelected: (date) => setState(() => DragList.selectedDate = date),
        monthColor: CupertinoColors.label,
        dayColor: const Color(0xFF0EBE7E),
        dayNameColor: CupertinoColors.white,
        activeDayColor: CupertinoColors.white,
        activeBackgroundDayColor: const Color(0xFF0EBE7E),
        dotsColor: CupertinoColors.white,
        locale: 'ru',
      ),
    );
  }
}

Widget _blankList() {
  return Builder(builder: (context) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(
            height: 53,
          ),
          Container(
            width: 238.0,
            height: 238.0,
            decoration: const BoxDecoration(
                shape: BoxShape.circle, color: Color(0xFFF2ECEC)),
            child: Center(
              child: Image.asset("assets/images/drag_empty_list.png"),
            ),
          ),
          const SizedBox(
            height: 11,
          ),
          const Text(
            'На сегодня у вас нет напоминаний',
            style: TextStyle(color: CupertinoColors.black, fontSize: 17.0),
          ),
          const SizedBox(
            height: 43.0,
          ),
          CupertinoButton(
            color: const Color(0xFF0EBE7E),
            onPressed: () {
              Route route = CupertinoPageRoute(
                  builder: (context) => const AddPhilsPage());
              Navigator.push(context, route);
            },
            child: const Text(
              'Добавить',
              style: TextStyle(color: CupertinoColors.white, fontSize: 15.0),
            ),
          ),
        ],
      ),
    );
  });
}
