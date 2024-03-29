import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Screen2 extends StatelessWidget {
  const Screen2({super.key});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    // TODO: implement build
    return Material(
      child: Column(
        children: [
          Stack(
            children: [
              Align(
                alignment: AlignmentDirectional.topEnd,
                child: Image.asset(
                  'assets/images/el2.jpg',
                  //scale: 1.1,
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(top: 91.0),
                child: Align(
                  alignment: AlignmentDirectional.topCenter,
                  child: Image(
                    image: AssetImage('assets/images/pic2.png'),
                  ),
                ),
              ),
            ],
          ),
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              "Следите за здоровьем",
              style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 26,
                  fontFamily: "Rubik"),
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(right: 24.0, left: 24),
            child: Text(
              "В приложении вы можете быстро оставлять информацию о своём самочувствии, оставлять напоминания, планировать записи к врачу и получать обратную связь о своём здоровье и его изменениях. ",
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
                child: Image.asset('assets/images/bg.jpg')),
          )
        ],
      ),
    );
  }
}
