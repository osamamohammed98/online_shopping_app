import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:online_shopping_app/backend/server.dart';
import 'package:online_shopping_app/ui/pages/taps/shopping_home_page_tap.dart';
import 'package:online_shopping_app/ui/widget/custom_text_form_filed.dart';
import 'package:online_shopping_app/util/strings.dart';
import 'package:online_shopping_app/util/style.dart';

class SearchPageTap extends StatefulWidget {
  @override
  _SearchPageTapState createState() => _SearchPageTapState();
}

class _SearchPageTapState extends State<SearchPageTap> {
  TextEditingController _controllerName = TextEditingController();

  @override
  Widget build(BuildContext context) {
    screenUtil(context);
    return SingleChildScrollView(
      child: Column(
        children: [
          //todo this is action bar
          CustomTextFormFiled(
            keyboardType: TextInputType.text,
            hint: hintSearch,
            isScure: false,
            controller: _controllerName,
          ),

          SizedBox(
            height: ScreenUtil().setHeight(10),
          ),

          Text(
            "$searchResults",
            style: textMid,
          ),

          Container(
            width: double.infinity,
            child: FutureBuilder<QuerySnapshot>(
              future: collectionReference.orderBy("name").startAt(["${_controllerName.text}"]).endAt(["${_controllerName.text}\uf8ff"]) .get(),
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

          //todo this is action bar
        ],
      ),
    );
  }
}
