import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:online_shopping_app/util/colors.dart';

screenUtil(BuildContext context) {
  ScreenUtil.init(context,
      width: 392.72727272727275,
      height: 803.6363636363636,
      allowFontScaling: true);
}

safeArea() {
  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle.light.copyWith(
      systemNavigationBarColor: colorWhite,
      statusBarColor: colorTrans,
      systemNavigationBarIconBrightness: Brightness.dark,
      statusBarIconBrightness: Brightness.dark,
    ),
  );
}

var textBig = TextStyle(
    color: colorBlack,
    fontWeight: FontWeight.w600,
    fontStyle: FontStyle.normal,
    fontSize: 22.0);

var textHint = TextStyle(
    color: colorGrayDark,
    fontWeight: FontWeight.w600,
    fontStyle: FontStyle.normal,
    fontSize: 16.0);

var textBtn = TextStyle(
    color: colorWhite,
    fontWeight: FontWeight.w600,
    fontStyle: FontStyle.normal,
    fontSize: 16.0);