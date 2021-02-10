import 'package:carousel_images/carousel_images.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:online_shopping_app/backend/server.dart';
import 'package:online_shopping_app/ui/widget/custom_Action_bar.dart';
import 'package:online_shopping_app/util/colors.dart';
import 'package:online_shopping_app/util/shared_method.dart';
import 'package:online_shopping_app/util/strings.dart';
import 'package:online_shopping_app/util/style.dart';

class ShoppingProductPage extends StatelessWidget {
  final String productId;

  ShoppingProductPage({Key key, this.productId}) : super(key: key);
  final globalKey = GlobalKey<ScaffoldState>();
  String selectedSize = "";

  @override
  Widget build(BuildContext context) {
    safeArea();
    screenUtil(context);
    getListImageById(productId);
    return Scaffold(
      key: globalKey,
      body: Stack(
        children: [
          ListView(
            children: [
              CarouselImages(
                scaleFactor: 0.6,
                listImages: getListImaget(),
                height: 350.h,
                borderRadius: 30.w,
                cachedNetworkImage: true,
                verticalAlignment: Alignment.topCenter,
                onTap: (index) {
                  print('Tapped on page $index');
                },
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 28.w, vertical: 12.h),
                child: !isLoading
                    ? Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${getProductObject()[docProductName]}",
                            style: textBig,
                          ),
                          SizedBox(
                            height: 13.h,
                          ),
                          Text(
                            "\$${getProductObject()[docProductPrice]}",
                            style: textMid.copyWith(color: colorRed),
                          ),
                          SizedBox(
                            height: 13.h,
                          ),
                          Text("${getProductObject()[docProductDesc]}",
                              style: textSMid.copyWith(color: colorGrayDark)),
                          SizedBox(
                            height: 23.h,
                          ),
                          Text("$selectSize", style: textMid),
                          Container(
                            height: 40.h,
                            margin: EdgeInsets.symmetric(vertical: 8.h),
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              shrinkWrap: true,
                              itemCount: getListSizes().length,
                              itemBuilder: (context, index) => CustomSizeBoxe(
                                index,
                                function: (value) => selectedSize = value,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 40.h,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SvgPicture.asset("assets/svg/book_mark.svg"),
                              RaisedButton(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 75.w, vertical: 18.h),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12.w)),
                                color: colorBlack,
                                child: Text(
                                  "$addToCarts",
                                  style: textBtn.copyWith(color: colorWhite),
                                ),
                                onPressed: () {
                                  addToCart(
                                          id: productId,
                                          selectedSize: selectedSize)
                                      .whenComplete(() => createSnackBarDone(
                                          globalKey, successProcess));
                                },
                              ),
                            ],
                          ),
                        ],
                      )
                    : Container(),
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 44.w, vertical: 56.h),
            child: CustomActionBar(
              isHaveBackBtn: true,
              isRedBox: true,
              isWithTitle: false,
              count: "${getListImaget().length}",
            ),
          ),
          Center(
            child: isLoading ? CircularProgressIndicator() : Text(""),
          ),
        ],
      ),
    );
  }
}

class CustomSizeBoxe extends StatefulWidget {
  final int index;
  final Function(String value) function;

  const CustomSizeBoxe(
    this.index, {
    Key key,
    this.function,
  }) : super(key: key);

  @override
  _CustomSizeBoxeState createState() => _CustomSizeBoxeState();
}

class _CustomSizeBoxeState extends State<CustomSizeBoxe> {
  var colorBox = colorGrayLight;
  var colorText = colorBlack;

  @override
  Widget build(BuildContext context) {
    return FlatButton(
      padding: EdgeInsets.zero,
      minWidth: 36.w,
      onPressed: () {
        widget.function("${getListSizes()[widget.index]}");
        setState(() {
          colorBox = colorRedError;
          colorText = colorWhite;
        });
      },
      child: Container(
        margin: EdgeInsets.only(right: 8.w),
        width: 36.w,
        height: 36.h,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: colorBox,
          borderRadius: BorderRadius.circular(12.w),
        ),
        child: Text(
          "${getListSizes()[widget.index]}",
          style: textMid.copyWith(color: colorText),
        ),
      ),
    );
  }
}
