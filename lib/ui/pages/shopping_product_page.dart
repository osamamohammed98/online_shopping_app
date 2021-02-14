import 'package:carousel_images/carousel_images.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:online_shopping_app/backend/server.dart';
import 'package:online_shopping_app/provider/provider_firebase.dart';
import 'package:online_shopping_app/ui/pages/shopping_cart_page.dart';
import 'package:online_shopping_app/ui/widget/custom_Action_bar.dart';
import 'package:online_shopping_app/util/colors.dart';
import 'package:online_shopping_app/util/shared_method.dart';
import 'package:online_shopping_app/util/strings.dart';
import 'package:online_shopping_app/util/style.dart';
import 'package:provider/provider.dart';

class ShoppingProductPage extends StatelessWidget {
  final String productId;

  ShoppingProductPage({Key key, this.productId}) : super(key: key);
  final globalKey = GlobalKey<ScaffoldState>();
  String selectedSize = "0";

  @override
  Widget build(BuildContext context) {
    safeArea();
    screenUtil(context);
    getListImageById(productId, context);
    getSavedItem(context);
    return Consumer<ProviderFirebase>(
      builder: (context, value, child) => Scaffold(
        key: globalKey,
        body: Stack(
          children: [
            ListView(
              children: [
                CarouselImages(
                  scaleFactor: 0.6,
                  listImages: value.getListImaget(),
                  height: 350.h,
                  borderRadius: 30.w,
                  cachedNetworkImage: true,
                  verticalAlignment: Alignment.topCenter,
                  onTap: (index) {
                    print('Tapped on page $index');
                  },
                ),
                Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: 28.w, vertical: 12.h),
                  child:  Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${value.getProductObject()[docProductName]}",
                              style: textBig,
                            ),
                            SizedBox(
                              height: 13.h,
                            ),
                            Text(
                              "\$${value.getProductObject()[docProductPrice]}",
                              style: textMid.copyWith(color: colorRed),
                            ),
                            SizedBox(
                              height: 13.h,
                            ),
                            Text("${value.getProductObject()[docProductDesc]}",
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
                                itemCount: value.getListSizes().length,
                                itemBuilder: (context, index) => CustomSizeBoxe(
                                  index,
                                  function: (values) => selectedSize =
                                      values ?? value.getListSizes()[0],
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 40.h,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    saveCart(
                                            id: getUserId(),
                                            map: {
                                              ...Provider.of<ProviderFirebase>(
                                                      context,
                                                      listen: false)
                                                  .getProductObject(),
                                              "productId": productId
                                            },
                                            productId: productId)
                                        .then((value) {
                                      createSnackBarDone(
                                          globalKey, successProcess);
                                    });
                                  },
                                  child: SvgPicture.asset(
                                      "assets/svg/book_mark.svg"),
                                ),
                                RaisedButton(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 75.w, vertical: 18.h),
                                  shape: RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(12.w)),
                                  color: colorBlack,
                                  child: Text(
                                    "$addToCarts",
                                    style: textBtn.copyWith(color: colorWhite),
                                  ),
                                  onPressed: () {
                                    addToCart(context,
                                            id: productId,
                                            map: {
                                              ...Provider.of<ProviderFirebase>(
                                                      context,
                                                      listen: false)
                                                  .getProductObject()
                                            },
                                            selectedSize: selectedSize == 0
                                                ? Provider.of<ProviderFirebase>(
                                                        context,
                                                        listen: false)
                                                    .getListSizes()[0]
                                                : selectedSize)
                                        .whenComplete(() {
                                      createSnackBarDone(
                                          globalKey, successProcess);
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                ShoppingCartPage(),
                                          ));
                                    });
                                  },
                                ),
                              ],
                            ),
                          ],
                        )

                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 44.w, vertical: 56.h),
              child: CustomActionBar(
                isHaveBackBtn: true,
                isRedBox: true,
                isWithTitle: false,
                count:
                    "${Provider.of<ProviderFirebase>(context, listen: false).getListImaget().length}",
              ),
            ),
            Center(
              child: Provider.of<ProviderFirebase>(context, listen: false)
                      .isLoading
                  ? Container()
                  : Text(""),
            ),
          ],
        ),
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
        widget.function(
            "${Provider.of<ProviderFirebase>(context, listen: false).getListSizes()[widget.index]}");
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
          "${Provider.of<ProviderFirebase>(context, listen: false).getListSizes()[widget.index]}",
          style: textMid.copyWith(color: colorText),
        ),
      ),
    );
  }
}
