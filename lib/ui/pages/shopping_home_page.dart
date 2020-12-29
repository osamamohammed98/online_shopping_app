import 'package:auto_route/auto_route.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:online_shopping_app/util/routes/custom_routes.gr.dart';
import 'package:online_shopping_app/util/style.dart';

class ShoppingHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    safeArea();
    screenUtil(context);
    return Scaffold(
      body: Center(
        child: FlatButton(
          child: Text("Log out"),
          onPressed: () {
            FirebaseAuth.instance.signOut();
            ExtendedNavigator.root.replace(Routes.shoppingLoginPage);
          },
        ),
      ),
    );
  }
}
