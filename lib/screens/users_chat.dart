import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  @override
  Widget build(BuildContext context) {
    return const Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        SizedBox(
          height: 50,
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.0),
          child: NavBar(),
        ),
        SizedBox(
          height: 10,
        ),
        HorizontalTab(),
      ],
    );
  }
}

class HorizontalTab extends StatefulWidget {
  const HorizontalTab({
    super.key,
  });

  @override
  State<HorizontalTab> createState() => _HorizontalTabState();
}

class _HorizontalTabState extends State<HorizontalTab> {
  final List<String> lst = ['Сообщение', 'Звонки', 'Видеозвонки'];
  int number = 0;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: lst.length,
          itemBuilder: (context, index) => SizedBox(
                width: 80,
                child: GestureDetector(
                  onTap: () {
                    number = index;
                    print('index:${index}');
                    print('number:${number}');
                    setState(() {});
                  },
                  child: ListTile(
                    tileColor: Colors.red,
                    title: Column(
                      children: [
                        Text(
                          lst[index],
                          style: TextStyle(
                              color: number == index ? Colors.green : Colors.black),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Container(
                          height: 3,
                          width: 105,
                          decoration: BoxDecoration(
                            color: number == index ? Colors.green : Colors.black,
                            borderRadius: const BorderRadius.all(
                              Radius.circular(20),
                            )
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              )),
    );
  }
}

class NavBar extends StatelessWidget {
  const NavBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        const Expanded(
          child: Text(
            "Чаты",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 24.0,
            ),
          ),
        ),
        SvgPicture.asset(
          "assets/icons/Search.svg",
        ),
        const SizedBox(width: 10),
        SvgPicture.asset(
          "assets/icons/More Circle.svg",
        ),
      ],
    );
  }
}
