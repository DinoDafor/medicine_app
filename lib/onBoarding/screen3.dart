import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Screen3 extends StatelessWidget {
  const Screen3({super.key});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return Material(
      child: Column(
        //crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Stack(children: [
            Align(
                alignment: AlignmentDirectional.topStart,
                child: Image.asset('assets/images/el3.jpg')),
            const Align(
              alignment: AlignmentDirectional.topCenter,
              child: Padding(
                padding: EdgeInsets.only(top: 91.0),
                child: Image(
                  image: AssetImage('assets/images/pic3.png'),
                ),
              ),
            )
          ]),
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              "Безопасно и удобно",
              style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 26,
                  fontFamily: "Rubik"),
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(right: 16.0, left: 16),
            child: Text(
              "Благодаря нашему приложению все Ваши записи всегда будут в вашем смартфоне и в абсолютной безопасности. Вы всегда можете следить за своим здоровьем, а приложение будет вам помогать.",
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 14,
                  fontFamily: "Rubik",
                  fontWeight: FontWeight.w300,
                  color: Color.fromARGB(246, 103, 114, 148)),
            ),
          ),
          Expanded(
              child: Align(
                  alignment: AlignmentDirectional.bottomEnd,
                  child: Image.asset('assets/images/bg2.jpg'))),
        ],
      ),
    );
  }
}
