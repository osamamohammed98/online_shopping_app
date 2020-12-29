import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:online_shopping_app/util/colors.dart';
import 'package:online_shopping_app/util/strings.dart';
import 'package:online_shopping_app/util/style.dart';

class CustomFlatBtn extends StatelessWidget {
  final String btnText;
  final Function onClick;
  final bool isSolid;

  const CustomFlatBtn({
    Key key,
    this.btnText,
    this.onClick,
    this.isSolid = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    screenUtil(context);
    return Container(
      width: double.infinity,
      height: 60.h,
      decoration: BoxDecoration(
        color: isSolid ? colorBlack : colorWhite,
        border: Border.all(color: colorBlack , width: 2.w),
        borderRadius: BorderRadius.all(
          Radius.circular(12.w),
        ),
      ),
      child: FlatButton(
        splashColor: isSolid ? colorWhite : colorGrayLight,
        onPressed: onClick,
        child: Text(
          btnText ?? loginBtn,
          style:isSolid ? textBtn:textBtn.copyWith(color: colorBlack) ,
        ),
      ),
    );
  }
}