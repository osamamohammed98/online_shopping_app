import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:online_shopping_app/ui/pages/taps/shopping_home_page_tap.dart';
import 'package:online_shopping_app/ui/pages/taps/shopping_saved_page_tab.dart';
import 'package:online_shopping_app/ui/pages/taps/shopping_search_page_tab.dart';
import 'package:online_shopping_app/ui/widget/custom_bottom_nav_bar.dart';
import 'package:online_shopping_app/util/style.dart';

class ShoppingHomePage extends StatefulWidget {
  @override
  _ShoppingHomePageState createState() => _ShoppingHomePageState();
}

class _ShoppingHomePageState extends State<ShoppingHomePage>
    with SingleTickerProviderStateMixin {
  TabController _tabController;
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    safeArea();
    screenUtil(context);

    return Scaffold(
      body: Container(
        margin: EdgeInsets.only(top: 64.h, right: 30.w, left: 30.w),
        child: TabBarView(
          controller: _tabController,
          children: [
            HomePageTap(),
            SearchPageTap(),
            SavedPageTap(),
            Center(),
          ],
        ),
      ),
      bottomNavigationBar: CustomBottomNavBar(
        tabController: _tabController,
        selectedIndex: _selectedIndex,
      ),
    );
  }
  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }
}
