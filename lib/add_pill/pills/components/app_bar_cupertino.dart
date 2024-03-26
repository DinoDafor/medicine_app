import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:medicine_app/add_pill/pills/components/appbar_mode.dart';
import 'package:medicine_app/add_pill/pills/widget/customButton.dart';

class AppBarCupertino extends StatelessWidget {
  AppBarCupertino({required this.mode});

  final AppBarMode mode;

  @override
  Widget build(BuildContext context) {
    return PreferredSize(
        preferredSize: Size.fromHeight(50),
        child: Container(
          padding: const EdgeInsets.only(left: 20.0, right: 20.0),
          height: 79,
          color: mode == AppBarMode.ALARM
              ? const Color(0xFFFFFFFF)
              : const Color(0xFF0EBE7E),
          child: mode == AppBarMode.LIST
              ? _contentListMode()
              : _contentAddMode(context),
        ));
  }

  Widget _contentAddMode(context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Row(
          children: [
            CupertinoButton(
              child: Icon(
                Icons.arrow_back_ios,
                color: mode == AppBarMode.ALARM
                    ? CupertinoColors.black
                    : CupertinoColors.white,
              ),
              onPressed: () {
                CustomButton.days = [];
                Navigator.pop(context);
              },
            ),
            GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Text(
                'Назад',
                style: TextStyle(
                    color: mode == AppBarMode.ALARM
                        ? CupertinoColors.black
                        : CupertinoColors.white,
                    fontSize: 18.0),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

Widget _contentListMode() {
  return const Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      Text(
        'График приёма',
        style: TextStyle(color: CupertinoColors.white, fontSize: 18.0),
      ),
    ],
  );
}

// Widget _contentAddMode() {
//   return Row(
//     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//     crossAxisAlignment: CrossAxisAlignment.center,
//     children: [
//       Row(
//         children: [
//           CupertinoButton(
//             child: const Icon(
//               Icons.arrow_back_ios,
//               color: Colors.white,
//             ),
//             onPressed: () {},
//           ),
//           const Text(
//             'Рецепт',
//             style: TextStyle(color: Colors.white, fontSize: 18.0),
//           ),
//         ],
//       ),
//       Row(
//         children: [
//           CupertinoButton(
//               child: Container(
//                   width: 25.0,
//                   height: 25.0,
//                   decoration: const BoxDecoration(
//                       shape: BoxShape.circle, color: Color(0xFF037C50)),
//                   child: const Center(
//                     child: SvgIcon(
//                       size: 15,
//                       icon: SvgIconData("assets/icons/notification_bell.svg"),
//                       color: Colors.white,
//                     ),
//                   )),
//               // color: Color(0xFF037C50),
//               onPressed: () {}),
//           CupertinoButton(
//               child: const SvgIcon(
//                   icon: SvgIconData("assets/icons/options.svg"),
//                   color: Colors.white,
//                   size: 15),
//               onPressed: () {})
//         ],
//       ),
//     ],
//   );
// }
// }
