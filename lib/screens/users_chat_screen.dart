import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:medicine_app/add_pill/pills/pages/PageForProvider.dart';
import 'package:medicine_app/add_pill/pills/pages/drag_list_screen.dart';
import 'package:intl/intl.dart';
import 'package:medicine_app/bloc/navigation_bloc.dart';
import 'package:medicine_app/giga/pages/gigachat_page.dart';

import 'package:medicine_app/screens/lock_screens/lock_screen.dart';
import 'package:medicine_app/utils/conversation.dart';

import '../bloc/chat_bloc.dart';
import '../bloc/chats_bloc.dart';
import '../models/chat_model.dart';
import '../utils/user.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  @override
  void initState() {
    BlocProvider.of<ChatsBloc>(context).add(ChatsLoadingEvent());
    super.initState();
  }

  final List<Widget> pages = [
    DragListScreen(),
    GigaChatPage(),
    ScrollableChats(),
  ];
  int _selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SafeArea(
        child: Scaffold(
          body: pages[_selectedIndex],
          bottomNavigationBar: BottomNavigationBar(
            onTap: _onItemTapped,
            type: BottomNavigationBarType.fixed,
            unselectedItemColor: Colors.grey,
            selectedItemColor: const Color(0xFF0EBE7E),
            currentIndex: _selectedIndex,
            items: [
              BottomNavigationBarItem(
                icon: SvgPicture.asset('assets/icons/home_icon.svg'),
                label: 'Главная',
                activeIcon: SvgPicture.asset(
                  'assets/icons/home_icon.svg',
                  colorFilter: const ColorFilter.mode(
                      Color(0xFF0EBE7E), BlendMode.srcIn),
                ),
              ),
              BottomNavigationBarItem(
                icon: SvgPicture.asset('assets/icons/bot.svg'),
                label: 'ИИ-помощник',
                activeIcon: SvgPicture.asset(
                  'assets/icons/bot.svg',
                  colorFilter: const ColorFilter.mode(
                      Color(0xFF0EBE7E), BlendMode.srcIn),
                ),
              ),
              BottomNavigationBarItem(
                icon: SvgPicture.asset('assets/icons/document_icon.svg'),
                label: 'Чаты',
                activeIcon: SvgPicture.asset(
                  'assets/icons/document_icon.svg',
                  colorFilter: const ColorFilter.mode(
                      Color(0xFF0EBE7E), BlendMode.srcIn),
                ),
              ),
              BottomNavigationBarItem(
                icon: SvgPicture.asset('assets/icons/paper_icon.svg'),
                label: 'Статьи',
                activeIcon: SvgPicture.asset(
                  'assets/icons/paper_icon.svg',
                  colorFilter: const ColorFilter.mode(
                      Color(0xFF0EBE7E), BlendMode.srcIn),
                ),
              ),
              BottomNavigationBarItem(
                icon: SvgPicture.asset('assets/icons/profile_icon.svg'),
                label: 'Профиль',
                activeIcon: SvgPicture.asset(
                  'assets/icons/profile_icon.svg',
                  colorFilter: const ColorFilter.mode(
                      Color(0xFF0EBE7E), BlendMode.srcIn),
                ),
              ),
            ],
            //todo надо бы вынести это в константу по проекту
          ),
        ),
      ),
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
//   @override
//   Widget build(BuildContext context) {
//     return const MaterialApp(
//       home: Scaffold(
//         body: SafeArea(
//           child: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: <Widget>[
//               Padding(
//                 padding: EdgeInsets.symmetric(horizontal: 10.0),
//                 child: NavBar(),
//               ),
//               SizedBox(
//                 height: 10,
//               ),
//               HorizontalTab(),
//               context.go()
//               MyBottomNavigationBar()
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
}

class ScrollableChats extends StatelessWidget {
  const ScrollableChats({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(child: BlocBuilder<ChatsBloc, ChatsState>(
      builder: (context, state) {
        //todo можно по-другому?
        var chatsBloc = BlocProvider.of<ChatsBloc>(context);
        ChatsState chatsBlocState = chatsBloc.state;
        //todo сделать состояние загрузки и показывать индикатор загрузки при другом стейте
        if (chatsBlocState is ChatsInitialLoadedSuccessfulState) {
          return ListView.builder(
              itemCount: chatsBlocState.chats.length,
              itemBuilder: (context, index) {
                //todo: мы должны передавать сортированные данные для ListView.builder
                Chat chat = chatsBlocState.chats[index];
                return ListTile(
                  onTap: () {
                    chatsBloc.add(ChatsClickEvent(chatId: chat.id));
                    BlocProvider.of<NavigationBloc>(context).add(
                        NavigationToChatScreenEvent(
                            context: context, chatId: chat.id));
                    BlocProvider.of<ChatBloc>(context).add(ChatLoadingEvent(
                        chatId: chat.id,
                        interlocutorId: User.id == chat.firstParticipantId
                            ? chat.secondParticipantId
                            : chat.firstParticipantId));
                  },
                  title: Text(
                    Conversation.idName[User.id == chat.firstParticipantId
                            ? chat.secondParticipantId
                            : chat.firstParticipantId]
                        .toString(),
                    // chat.chatName,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  leading: const CircleAvatar(
                    backgroundImage:
                        AssetImage("assets/images/doctor_image.png"),
                    backgroundColor: Colors.deepOrange,
                  ),
                  subtitle: Text(
                    chat.messages.last.text,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      color: Color(0xFF616161),
                    ),
                  ),
                  trailing: Column(
                    children: [
                      //TODO:
                      Text(
                        DateFormat('dd/MM/yyyy').format(
                            DateTime.fromMillisecondsSinceEpoch(
                                chat.messages.last.sendTimestamp)),
                        style: const TextStyle(
                          color: Color(0xFF616161),
                        ),
                      ),
                      // Text(
                      //   chat.lastDate,
                      //   style: const TextStyle(
                      //     color: Color(0xFF616161),
                      //   ),
                      // ),
                    ],
                  ),
                );
              });
        }
        // return const Text("Где чат?");
        return const Center(child: CircularProgressIndicator());
      },
    ));
  }
}

class MyBottomNavigationBar extends StatefulWidget {
  const MyBottomNavigationBar({
    super.key,
  });

  @override
  State<MyBottomNavigationBar> createState() => _MyBottomNavigationBarState();
}

class _MyBottomNavigationBarState extends State<MyBottomNavigationBar> {
  int _selectedIndex = 1;

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      onTap: _onItemTapped,
      type: BottomNavigationBarType.fixed,
      unselectedItemColor: Colors.grey,
      selectedItemColor: const Color(0xFF0EBE7E),
      currentIndex: _selectedIndex,
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
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      // if (index == 1) {
      //   log("HEEEEEEEEEEEEEEEEEEEEEEEEEEEElp");
      //   context.go("/chatGPT");
      // }
    });
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
  final List<String> lst = ['Сообщения', 'ИИ-помощник'];
  int number = 0;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: lst.length,
          itemBuilder: (context, index) => SizedBox(
                width: MediaQuery.of(context).size.width / 2,
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
                        const SizedBox(
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

  void _onItemTapped(int index) {
    setState(() {
      number = index;

      // if (index == 1) {
      //   log("Go to chat gpt");
      //   context.go("/chatGPT");
      // } else {
      //   log("Go to scrolable chat");
      //   context.go("/chats");
      // }
    });
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
        GestureDetector(
          child: SvgPicture.asset(
            "assets/icons/Search.svg",
          ),
          onTap: () {},
        ),
        const SizedBox(width: 10),
        SvgPicture.asset(
          "assets/icons/More Circle.svg",
        ),
      ],
    );
  }
}
