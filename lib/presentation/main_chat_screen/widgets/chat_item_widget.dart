import 'package:flutter/material.dart';
import 'package:medicine_app/core/app_export.dart';

class ThirtyfiveItemWidget extends StatelessWidget {
  const ThirtyfiveItemWidget({Key? key})
      : super(
    key: key,
  );

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CustomImageView(
          imagePath: ImageConstant.imgEllipse,
          height: 60.adaptSize,
          width: 60.adaptSize,
          radius: BorderRadius.circular(
            30.h,
          ),
        ),
        Padding(
          padding: EdgeInsets.only(
            left: 20.h,
            top: 8.v,
            bottom: 8.v,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Виктор Комаров",
                style: theme.textTheme.titleMedium,
              ),
              SizedBox(height: 5.v),
              Text(
                "Всего наилучшего...",
                style: theme.textTheme.titleSmall,
              ),
            ],
          ),
        ),
        Spacer(),
        Container(
          width: 60.h,
          margin: EdgeInsets.only(
            top: 15.v,
            bottom: 3.v,
          ),
          child: Text(
            "Сегодня,\n15:30",
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.right,
            style: theme.textTheme.titleSmall!.copyWith(
              height: 1.40,
            ),
          ),
        ),
      ],
    );
  }
}