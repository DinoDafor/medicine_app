import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.0),
              child: NavBar(),
            ),
            SizedBox(
              height: 10,
            ),
            HorizontalTab(),
            ScrollableChats(),
            MyBottomNavigationBar()
          ],
        ),
      ),
    );
  }
}

class MyBottomNavigationBar extends StatelessWidget {
  const MyBottomNavigationBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      unselectedItemColor: Colors.grey,
      selectedItemColor: const Color(0xFF0EBE7E),
      currentIndex: 2,
      items: [
        BottomNavigationBarItem(
          icon: SvgPicture.asset('assets/icons/home_icon.svg'),
          label: 'Главная',
          activeIcon: SvgPicture.asset(
            'assets/icons/home_icon.svg',
            colorFilter:
                const ColorFilter.mode(Color(0xFF0EBE7E), BlendMode.srcIn),
          ),
        ),
        BottomNavigationBarItem(
          icon: SvgPicture.asset('assets/icons/calendar_icon.svg'),
          label: 'Календарь',
          activeIcon: SvgPicture.asset(
            'assets/icons/calendar_icon.svg',
            colorFilter:
                const ColorFilter.mode(Color(0xFF0EBE7E), BlendMode.srcIn),
          ),
        ),
        BottomNavigationBarItem(
          icon: SvgPicture.asset('assets/icons/document_icon.svg'),
          label: 'Чаты',
          activeIcon: SvgPicture.asset(
            'assets/icons/document_icon.svg',
            colorFilter:
                const ColorFilter.mode(Color(0xFF0EBE7E), BlendMode.srcIn),
          ),
        ),
        BottomNavigationBarItem(
          icon: SvgPicture.asset('assets/icons/paper_icon.svg'),
          label: 'Статьи',
          activeIcon: SvgPicture.asset(
            'assets/icons/paper_icon.svg',
            colorFilter:
                const ColorFilter.mode(Color(0xFF0EBE7E), BlendMode.srcIn),
          ),
        ),
        BottomNavigationBarItem(
          icon: SvgPicture.asset('assets/icons/profile_icon.svg'),
          label: 'Профиль',
          activeIcon: SvgPicture.asset(
            'assets/icons/profile_icon.svg',
            colorFilter:
                const ColorFilter.mode(Color(0xFF0EBE7E), BlendMode.srcIn),
          ),
        ),
      ],
      //todo надо бы вынести это в константу по проекту

      // onTap: (){},
    );
  }
}

class ScrollableChats extends StatelessWidget {
  const ScrollableChats({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
          itemBuilder: (context, index) => ListTile(
                onTap: () {
                  context.go("/chats/chat");
                },
                title: const Text(
                  "Doctor name",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                leading: const CircleAvatar(
                  backgroundImage: AssetImage("assets/images/doctor_image.png"),
                  //todo можно добавить фото-заглушку, если у доктора не будет аватарки
                  backgroundColor: Colors.deepOrange,
                ),
                subtitle: const Text(
                  "Всего наилучшего...",
                  style: TextStyle(
                    color: Color(0xFF616161),
                  ),
                ),
                trailing: const Column(
                  children: [
                    Text(
                      "20/08/2023" + ",",
                      style: TextStyle(
                        color: Color(0xFF616161),
                      ),
                    ),
                    Text(
                      "15:30",
                      style: TextStyle(
                        color: Color(0xFF616161),
                      ),
                    ),
                  ],
                ),
              )),
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
    return SizedBox(
      height: 40,
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: lst.length,
          itemBuilder: (context, index) => SizedBox(
                width: 140,
                child: GestureDetector(
                  onTap: () {
                    number = index;
                    setState(() {});
                  },
                  child: ListTile(
                    // tileColor: Colors.red,
                    title: Column(
                      children: [
                        Text(
                          lst[index],
                          style: TextStyle(
                              color: number == index
                                  ? Colors.green
                                  : Colors.black),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Container(
                          height: 3,
                          width: 105,
                          decoration: BoxDecoration(
                              color:
                                  number == index ? Colors.green : Colors.black,
                              borderRadius: const BorderRadius.all(
                                Radius.circular(20),
                              )),
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
