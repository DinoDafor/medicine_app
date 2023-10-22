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
        // HorizontalTab(),
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
  final List<String> lst = ['Hi!', 'alloha'];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: lst.length, itemBuilder: (context, index) => ListTile(
      title: Text(lst[index]),
    ));
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
