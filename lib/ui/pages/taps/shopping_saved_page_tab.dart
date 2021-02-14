import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:online_shopping_app/backend/server.dart';
import 'package:online_shopping_app/provider/provider_firebase.dart';
import 'package:online_shopping_app/ui/pages/taps/shopping_home_page_tap.dart';
import 'package:online_shopping_app/ui/widget/custom_Action_bar.dart';
import 'package:online_shopping_app/util/strings.dart';
import 'package:online_shopping_app/util/style.dart';
import 'package:provider/provider.dart';

class SavedPageTap extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    screenUtil(context);
    getSavedItem(context);
    return SingleChildScrollView(
      child: Column(
        children: [
          //todo this is action bar
          Selector<ProviderFirebase, List<QueryDocumentSnapshot>>(
            builder: (context, value, child) => CustomActionBar(
              title: savedPageTab,
              isHaveBackBtn: false,
              isRedBox: false,
              count: "${value.length}",
            ),
            selector: (x, y) => y.getSavedListsItem(),
          ),
          //todo this is action bar

          Selector<ProviderFirebase, List<QueryDocumentSnapshot>>(
            selector: (x, y) => y.getSavedListsItem(),
            builder: (context, value, child) => Container(
              padding: EdgeInsets.only(bottom: 12),
              child: ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                itemCount: value.length,
                itemBuilder: (context, index) {
                  return ItemList(value, index);
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
