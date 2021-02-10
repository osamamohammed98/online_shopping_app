import 'package:flutter/material.dart';
import 'package:online_shopping_app/ui/widget/custom_Action_bar.dart';
import 'package:online_shopping_app/util/style.dart';

class SearchPageTap extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    screenUtil(context);
    return Column(
      children: [
        //todo this is action bar
        CustomActionBar(isHaveBackBtn: false,isRedBox: false,),
        //todo this is action bar
      ],
    );
  }
}
