import 'dart:async';

import 'package:flutter/cupertino.dart';

import '../../pills/pages/addPillsPage.dart';

class TabLayout extends StatefulWidget {
  @override
  _TabLoyoutState createState() => _TabLoyoutState();
}

class _TabLoyoutState extends State<TabLayout> {
  final int _ROUTE_LIST = 0;
  final int _ROUTE_ADD = 1;

  final String _LIST_TITLE = 'График приёма';
  final String _ADD_TITLE = 'Добавить напоминание';

  int _currentIndex = 0;

  void _onItemTaped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  void _routeToAddScreen(BuildContext context) {
    Route route = CupertinoPageRoute(builder: (context) => AddPhilsPage());
    Navigator.push(context, route);

    // Navigator.pushNamed(context, '/addPill');
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 40,
        color: const Color.fromRGBO(14, 190, 126, 0.3),
        child: _contentOfTabLayout());
  }

  Widget _contentOfTabLayout() {
    return Flex(direction: Axis.vertical, children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          GestureDetector(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(10, 8, 0, 8),
                child: Row(
                  children: [
                    Icon(
                      CupertinoIcons.list_bullet,
                      color: _currentIndex == _ROUTE_LIST
                          ? const Color(0xFF1C76AA)
                          : const Color(0xFFAAB2AD),
                    ),
                    Text(
                      _LIST_TITLE,
                      style: TextStyle(
                        color: _currentIndex == _ROUTE_LIST
                            ? const Color(0xFF1C76AA)
                            : const Color(0xFFAAB2AD),
                      ),
                    )
                  ],
                ),
              ),
              onTap: () => _onItemTaped(_ROUTE_LIST)),
          GestureDetector(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(10, 8, 19, 8),
                child: Row(
                  children: [
                    Icon(
                      CupertinoIcons.add_circled,
                      color: _currentIndex == _ROUTE_ADD
                          ? const Color(0xFF1C76AA)
                          : const Color(0xFFAAB2AD),
                    ),
                    Text(
                      _ADD_TITLE,
                      style: TextStyle(
                        color: _currentIndex == _ROUTE_ADD
                            ? const Color(0xFF1C76AA)
                            : const Color(0xFFAAB2AD),
                      ),
                    )
                  ],
                ),
              ),
              onTap: () {
                _onItemTaped(_ROUTE_ADD);
                _routeToAddScreen(context);
                Timer(Duration(milliseconds: 500), () {
                  setState(() {
                    _currentIndex = 0;
                  });
                });
              }),
        ],
      ),
    ]);
  }
}
