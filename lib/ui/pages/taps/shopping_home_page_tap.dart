import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:online_shopping_app/backend/server.dart';
import 'package:online_shopping_app/provider/provider_firebase.dart';
import 'package:online_shopping_app/ui/pages/shopping_product_page.dart';
import 'package:online_shopping_app/ui/widget/custom_Action_bar.dart';
import 'package:online_shopping_app/util/colors.dart';
import 'package:online_shopping_app/util/strings.dart';
import 'package:online_shopping_app/util/style.dart';
import 'package:provider/provider.dart';

class HomePageTap extends StatefulWidget {
  @override
  _HomePageTapState createState() => _HomePageTapState();
}

class _HomePageTapState extends State<HomePageTap> {
  final CollectionReference _collectionReference =
      FirebaseFirestore.instance.collection(colProductCollectionName);

  FirebaseAuth auth = FirebaseAuth.instance;
  String cartItemCount = "0";

  @override
  initState() {
    super.initState();
    getCountInCartStream(context).then((value) => cartItemCount = value ?? "0");
    getListItemFromCart(context);
  }

  @override
  Widget build(BuildContext context) {
    screenUtil(context);

    return SingleChildScrollView(
      child: Column(
        children: [
          //todo this is action bar
          CustomActionBar(
              isHaveBackBtn: false,
              isRedBox: false,
              count:
                  "${Provider.of<ProviderFirebase>(context, listen: false).cartLists.length}" ??
                      "0"),
          //todo this is action bar

          Container(
            width: double.infinity,
            child: FutureBuilder<QuerySnapshot>(
              future: _collectionReference.get(),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  //todo make error page
                  return Center(
                    child: Text("${snapshot.error}"),
                  );
                }

                if (snapshot.connectionState == ConnectionState.done) {
                  List<QueryDocumentSnapshot> docs = snapshot.data.docs;
                  return Container(
                    width: double.infinity,
                    child: ListView.builder(
                      itemCount: docs.length,
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      // ignore: missing_return
                      itemBuilder: (context, index) {
                        return ItemList(docs, index);
                      },
                    ),
                  );
                }
                return Center(
                  child: CircularProgressIndicator(),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class ItemList extends StatelessWidget {
  final List<QueryDocumentSnapshot> docs;
  final int index;

  ItemList(this.docs, this.index);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      width: double.infinity,
      height: 320.h,
      margin: EdgeInsets.symmetric(horizontal: 6.w, vertical: 12.h),
      decoration: BoxDecoration(
        shape: BoxShape.rectangle,
      ),
      child: FlatButton(
        padding: EdgeInsets.all(0),
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ShoppingProductPage(
                  productId: docs[index].id,
                ),
              ));
        },
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Expanded(
              child: Stack(
                children: [
                  Container(
                    height: 320.h,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12.w),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(12.w),
                      child: CachedNetworkImage(
                        imageUrl: "${docs[index]["imagesUrl"][0]}",
                        errorWidget: (context, url, error) => Icon(Icons.error),
                        fit: BoxFit.cover,
                        width: double.infinity,
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: Padding(
                      padding: EdgeInsets.all(16.w),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "${docs[index]['name']}",
                            style: textMid,
                          ),
                          Text(
                            "\$${docs[index]['price']}",
                            style: textSMid.copyWith(color: colorRedError),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
    ;
  }
}
