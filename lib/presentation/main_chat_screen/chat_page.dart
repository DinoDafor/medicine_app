import '../main_chat_screen/widgets/chat_item_widget.dart';
import 'package:flutter/material.dart';
import 'package:medicine_app/core/app_export.dart';

class ThirtyfivePage extends StatefulWidget {
  const ThirtyfivePage({Key? key})
      : super(
    key: key,
  );

  @override
  ThirtyfivePageState createState() => ThirtyfivePageState();
}

class ThirtyfivePageState extends State<ThirtyfivePage>
    with AutomaticKeepAliveClientMixin<ThirtyfivePage> {
  @override
  bool get wantKeepAlive => true;
  @override
  Widget build(BuildContext context) {
    mediaQueryData = MediaQuery.of(context);

    return SafeArea(
      child: Scaffold(
        body: Container(
          width: double.maxFinite,
          decoration: AppDecoration.fillWhiteA,
          child: Column(
            children: [
              SizedBox(height: 24.v),
              _buildThirtyFive(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildThirtyFive(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.h),
        child: ListView.separated(
          physics: BouncingScrollPhysics(),
          shrinkWrap: true,
          separatorBuilder: (
              context,
              index,
              ) {
            return SizedBox(
              height: 24.v,
            );
          },
          itemCount: 1,
          itemBuilder: (context, index) {
            return ThirtyfiveItemWidget();
          },
        ),
      ),
    );
  }
}