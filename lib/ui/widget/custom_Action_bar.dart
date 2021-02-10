import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:online_shopping_app/util/colors.dart';
import 'package:online_shopping_app/util/strings.dart';
import 'package:online_shopping_app/util/style.dart';

class CustomActionBar extends StatelessWidget {
  final String title, count;
  final bool isHaveBackBtn, isRedBox, isWithTitle;

  const CustomActionBar(
      {Key key,
      this.title,
      this.count,
      this.isHaveBackBtn = false,
      this.isRedBox = false,
      this.isWithTitle = true})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    screenUtil(context);
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [colorWhite, colorWhite.withOpacity(0)],
          begin: Alignment(0, 0),
          end: Alignment(0, 0),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          if (isHaveBackBtn)
            Container(
              alignment: Alignment.center,
              width: 36.w,
              height: 36.h,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(
                    Radius.circular(8.w),
                  ),
                  color: colorBlack),
              child: GestureDetector(
                onTap: () {
                  ExtendedNavigator.root.pop();
                },
                child: Icon(
                  Icons.arrow_back_ios,
                  color: colorWhite,
                  size: 17.w,
                ),
              ),
            ),
          if (isWithTitle)
            Text(
              title ?? homePageTab,
              style: textBig,
            ),
          Container(
            alignment: Alignment.center,
            width: 36.w,
            height: 36.h,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(
                  Radius.circular(8.w),
                ),
                color: isRedBox ? colorRed : colorBlack),
            child: Text(
              count ?? "0",
              style: textBtn,
            ),
          )
        ],
      ),
    );
  }


}
