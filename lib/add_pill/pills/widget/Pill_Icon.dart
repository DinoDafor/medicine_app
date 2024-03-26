import 'dart:developer' as developer;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../data/model/enums/form_enum.dart';

///диалоговое окно для выбора иконки

class PillIcon extends StatelessWidget {
  final _controller = PageController();

  List paths = [
    'assets/images/diasepam.png',
    'assets/images/ibuprofen.png',
    'assets/images/clonasepam.png',
    'assets/images/phenobarbital.png'
  ];

  int imageIndex = 0;

  String? result = 'assets/images/diasepam.png';
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
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                height: height * 0.5,
                width: width,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CupertinoButton(
                        child: Icon(CupertinoIcons.left_chevron),
                        onPressed: () {
                          if (imageIndex > 0) {
                            imageIndex = imageIndex - 1;
                            _controller.jumpToPage(imageIndex);
                          }
                        }),
                    Container(
                      height: height * 0.6,
                      width: width * 0.6,
                      child: PageView.builder(
                        controller: _controller,
                        itemBuilder: (context, index) {
                          onPageChanged(index);

                          return Image.asset(paths[index], scale: 0.5);
                        },

                        /// onPageChanged: _onPageChanged(index),
                        itemCount: paths.length,
                      ),
                    ),
                    CupertinoButton(
                        child: Icon(CupertinoIcons.right_chevron),
                        onPressed: () {
                          if (imageIndex < 3) {
                            imageIndex = imageIndex + 1;

                            ///developer.log("inddex $screenIndex");
                            _controller.jumpToPage(imageIndex);
                          }
                        }),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: Container(
                    width: width,
                    height: height * 0.3 - 16,
                    child: Center(
                        child: Text(
                      "Выберите комфортную лекарственную форму",
                      style: TextStyle(fontSize: 18),
                      textAlign: TextAlign.center,
                    ))),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  height: height * 0.2 - 16,
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
                          Navigator.of(context).pop();
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
                          
                          switch (imageIndex) {
                            case 0:
                              {
                                developer.log(
                                    "Diasepam index is ${FormEnum.DIASEPAM.index}");
                                Navigator.of(context).pop(FormEnum.DIASEPAM);
                                break;
                              }

                            case 1:
                              {
                                
                                Navigator.of(context).pop(FormEnum.IBUPROFEN);
                                break;
                              }

                            case 2:
                              {
                                
                                Navigator.of(context).pop(FormEnum.KLONASEPAM);
                                break;
                              }

                            case 3:
                              {
                                
                                Navigator.of(context)
                                    .pop(FormEnum.PHENOBARBITAL);
                                break;
                              }
                          }

                          ;
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

  onPageChanged(int index) {
    developer.log(index.toString(), name: "pageIndex in PillIcon");
     
    imageIndex = index;
    result = paths[imageIndex];
  }
}
