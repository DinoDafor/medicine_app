import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:medicine_app/add_pill/pills/data/model/pill_entity.dart';

class ItemDialog extends StatelessWidget {
  PillEntity pill;

  ItemDialog(this.pill);

  List paths = [
    'assets/images/diasepam.png',
    'assets/images/ibuprofen.png',
    'assets/images/clonasepam.png',
    'assets/images/phenobarbital.png'
  ];

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    final height = MediaQuery.of(context).size.height * 0.45;
    final width = MediaQuery.of(context).size.width * 0.8;
    return Container(
        height: height,
        width: width,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: Container(
                    width: width,
                    height: height * 0.2 - 16,
                    child: Center(
                        child: Text(
                      "Вы точно хотите удалить ${pill.name}",
                      style: TextStyle(fontSize: 18),
                      textAlign: TextAlign.center,
                    ))),
              ),
              Container(
                height: height * 0.4,
                width: width * 0.6,
                child: Image.asset(paths[pill.image.index], scale: 0.5),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  height: height * 0.3 - 16,
                  width: width,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CupertinoButton(
                        child: Padding(
                          padding: const EdgeInsets.all(3.0),
                          child: Text("Отменить"),
                        ),
                        onPressed: () {
                          Navigator.of(context).pop(false);
                        },
                        padding: EdgeInsets.symmetric(horizontal: width * 0.06),
                        color: Color.fromRGBO(158, 158, 158, 0.568),
                      ),
                      CupertinoButton(
                        child: Padding(
                          padding: const EdgeInsets.all(3.0),
                          child: Text("Подтвердить"),
                        ),
                        onPressed: () {
                          Navigator.of(context).pop(true);
                        },
                        color: Colors.green,
                        padding: EdgeInsets.symmetric(horizontal: width * 0.04),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ));
  }
}
