import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:online_shopping_app/backend/server.dart';
import 'package:online_shopping_app/provider/provider_firebase.dart';
import 'package:online_shopping_app/ui/widget/custom_Action_bar.dart';
import 'package:online_shopping_app/util/colors.dart';
import 'package:online_shopping_app/util/strings.dart';
import 'package:online_shopping_app/util/style.dart';
import 'package:provider/provider.dart';

class ShoppingCartPage extends StatefulWidget {
  @override
  _ShoppingCartPageState createState() => _ShoppingCartPageState();
}

class _ShoppingCartPageState extends State<ShoppingCartPage> {

  String price = "0";

  List<int> cart_items = [];

  @override
  Widget build(BuildContext context) {
    screenUtil(context);
    safeArea();
    getListItemFromCart(context);
    //print("d ${listOfCartItem}");

    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Container(
        padding: EdgeInsets.only(left: 14.w, right: 14.w, top: 50.h),
        child: Column(
          children: [
            Expanded(
              flex: 1,
              child: Selector<ProviderFirebase, String>(
                selector: (x, y) => y.getCountInCart(),
                builder: (context, value, child) =>
                    CustomActionBar(
                      count: "${Provider.of<ProviderFirebase>(context,listen: false).cartLists.length}" ?? "0",
                      isWithTitle: true,
                      title: cartTitle,
                      isRedBox: true,
                      isHaveBackBtn: true,
                    ),
              ),
            ),
            Expanded(
              flex: 10,
              child: Selector<ProviderFirebase, List<QueryDocumentSnapshot>>(
                selector: (x, y) => y.getItemsCart(),
                builder: (context, values, child) =>
                    Container(
                      child: ListView.separated(
                        itemCount: values.length,
                        shrinkWrap: true,
                        scrollDirection: Axis.vertical,
                        itemBuilder: (context, index) {
                          return CartItem(
                            title: values[index]["name"],
                            size: values[index]["size"],
                            imageUrl: values[index]["imagesUrl"][0],
                            price: values[index]["price"],);
                        },
                        separatorBuilder: (context, index) => Divider(),
                      ),
                    ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Container(
                padding: EdgeInsets.all(14.w),
                color: colorWhite,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      cartTotal,
                      style: textMid.copyWith(fontSize: 20),
                    ),
                    Text(
                      "\$${Provider.of<ProviderFirebase>(context, listen:false)
                          .getCartPrice()}",
                      style:
                      textMid.copyWith(fontSize: 20, color: colorRedError),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CartItem extends StatelessWidget {
  final String imageUrl, title, price, size;

  const CartItem({
    Key key,
    this.imageUrl,
    this.title,
    this.price,
    this.size,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FlatButton(
      splashColor: colorGrayLight,
      padding: EdgeInsets.all(4.w),
      onPressed: () {},
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            flex: 1,
            child: Container(
              width: 85.w,
              height: 85.h,
              decoration: BoxDecoration(
                color: colorGrayLight,
                borderRadius: BorderRadius.circular(12.w),
                image: DecorationImage(
                  image: NetworkImage("$imageUrl"),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          SizedBox(
            width: 22.w,
          ),
          Expanded(
            flex: 3,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title ?? "Product Name & Title",
                  style: textMid,
                ),
                Text(
                  "\$" + price ?? "\$130",
                  style: textSMid.copyWith(color: colorRedError, fontSize: 18),
                ),
                Text("$cartSize" + size, style: textMid),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
