import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class Screen1 extends StatelessWidget {
  const Screen1({super.key});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    // TODO: implement build
    return Material(
      child: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Stack(children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 19, left: 21),
                child: Image.asset(
                  'assets/images/el1.jpg',
                  alignment: Alignment.topLeft,
                ),
              ),
              Padding(
                padding:
                    EdgeInsets.only(left: 33, top: 96, right: width * 0.10),
                child: Image(
                  image: AssetImage('assets/images/pic1.png'),
                ),
              )
            ]),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                "Здоровье под защитой",
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 26,
                  fontFamily: "Rubik",
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 16.0, left: 16.0),
              child: Text(
                " Приложение создано под руководством медицинского персонала с учётом пожеланий и рекомендаций на основе новейших научных достижений.",
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 14,
                    fontFamily: "Rubik",
                    fontWeight: FontWeight.w300,
                    color: Color.fromARGB(246, 103, 114, 148)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
