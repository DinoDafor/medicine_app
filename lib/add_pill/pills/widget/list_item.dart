import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../data/bloc/pill_bloc.dart';
import '../data/model/enums/form_enum.dart';
import '../data/model/enums/status_enum.dart';
import '../data/model/pill_entity.dart';
import 'list_item_dialog.dart';

class ListItem extends StatefulWidget {
  PillEntity pill;

  ListItem({required this.pill});

  @override
  _ListItemState createState() => _ListItemState();
}

class _ListItemState extends State<ListItem> {
  @override
  void initState() {
    super.initState();
    checkStatus();
  }

  _onTaped() {
    setState(() {
      if (widget.pill.status == StatusEnum.ATTENTION) {
        BlocProvider.of<PillBloc>(context, listen: false).add(
            UpdatePillBloc(pillId: widget.pill.id, status: StatusEnum.OKAY));
      }
    });
  }

  void checkStatus() {
    Duration difference = widget.pill.timeToDrink.difference(DateTime.now());
    if (difference.inMinutes < 10) {
      setState(() {
        BlocProvider.of<PillBloc>(context, listen: false).add(UpdatePillBloc(
            pillId: widget.pill.id, status: StatusEnum.ATTENTION));
      });
    } else if (difference.inMinutes == 0) {
      setState(() {
        BlocProvider.of<PillBloc>(context, listen: false).add(UpdatePillBloc(
            pillId: widget.pill.id, status: StatusEnum.NOT_OKAY));
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: UniqueKey(),
      direction: DismissDirection.endToStart,
      confirmDismiss: (direction) async {
        final flag = await _dialogBuilder(context) ?? false;
        log(flag.toString(), name: "Delete Flage in ListItem");
        if (flag) {
          BlocProvider.of<PillBloc>(context, listen: false)
              .add(DeletePillBloc(pillId: widget.pill.id));
          return true;
        } else {
          return false;
        }
      },
      background: Container(
        width: 450,
        padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 28.0),
        decoration: BoxDecoration(
          color: const Color(0xFFE83F5B),
          borderRadius: BorderRadius.circular(20.0),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            SvgPicture.asset(
              'assets/icons/trash_icon.svg',
              width: 24.0,
              height: 24,
              color: CupertinoColors.white,
            )
          ],
        ),
      ),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        height: 80.0,
        width: 350.0,
        decoration: BoxDecoration(
          color: const Color(0xFFEEF1EF),
          borderRadius: BorderRadius.circular(20.0),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              ///width: 220,
              child: Row(
                children: [
                  Image.asset(
                    imagesPill[widget.pill.image]!,
                    width: 55.0,
                    height: 55.0,
                  ),
                  const SizedBox(
                    width: 11.0,
                  ),
                  
                       Container(
                        width:77,
                         child: Text(
                            widget.pill.name,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                            style: const TextStyle(
                                color: CupertinoColors.black, fontSize: 17.0),
                          ),
                       ),
                    
                  
                    
                ],
              ),
            ),
            Row(
              children: [
                GestureDetector(
                  child: Image.asset(
                    statusPill[widget.pill.status]!,
                    width: 31.0,
                    height: 31.0,
                  ),
                  onTap: () {
                    _onTaped();
                  },
                ),
                const SizedBox(
                  width: 11.0,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    const Text(
                      'Приём',
                      style: TextStyle(
                          fontSize: 13.0, color: CupertinoColors.black),
                    ),
                    Text(
                      '${widget.pill.timeToDrink.hour}:${widget.pill.timeToDrink.minute}',
                      style: const TextStyle(
                          fontSize: 13.0, color: CupertinoColors.black),
                    )
                  ],
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  Future<bool?> _dialogBuilder(BuildContext context) {
    return showDialog<bool?>(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
              insetPadding: EdgeInsets.all(20), child: ItemDialog(widget.pill));
        });
  }
}
