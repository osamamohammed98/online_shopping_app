import 'package:auto_route/auto_route.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:online_shopping_app/util/colors.dart';
import 'package:online_shopping_app/util/routes/custom_routes.gr.dart';
import 'package:online_shopping_app/util/style.dart';

class CustomBottomNavBar extends StatefulWidget {
  int selectedIndex;
  final TabController tabController;

  CustomBottomNavBar({Key key, this.selectedIndex, this.tabController})
      : super(key: key);

  @override
  _CustomBottomNavBarState createState() => _CustomBottomNavBarState();
}

class _CustomBottomNavBarState extends State<CustomBottomNavBar> {
  @override
  Widget build(BuildContext context) {
    screenUtil(context);
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          shadow,
        ],
      ),
      child: BottomNavigationBar(
        type: BottomNavigationBarType.shifting,
        selectedItemColor: colorRed,
        currentIndex: widget.selectedIndex,
        onTap: (value) {
          setState(() {
            widget.selectedIndex = value;
            if (widget.selectedIndex != 3)
              widget.tabController.animateTo(widget.selectedIndex);
          });

          if (widget.selectedIndex == 3) {
            FirebaseAuth.instance.signOut();
            ExtendedNavigator.root.replace(Routes.shoppingLoginPage);
          }
        },
        showUnselectedLabels: false,
        showSelectedLabels: false,
        items: [
          BottomNavigationBarItem(
              icon: Container(
                padding: EdgeInsets.all(5.h),
                decoration: BoxDecoration(
                  border: Border(
                    top: BorderSide(
                        color:
                            widget.selectedIndex == 0 ? colorRed : colorTrans,
                        width: 2.w),
                  ),
                ),
                child: SvgPicture.asset(
                  "assets/svg/tab_home.svg",
                  color: widget.selectedIndex == 0 ? colorRed : colorBlack,
                ),
              ),
              label: ""),
          BottomNavigationBarItem(
              icon: Container(
                padding: EdgeInsets.all(5.h),
                decoration: BoxDecoration(
                  border: Border(
                    top: BorderSide(
                        color:
                            widget.selectedIndex == 1 ? colorRed : colorTrans,
                        width: 2.w),
                  ),
                ),
                child: SvgPicture.asset(
                  "assets/svg/tab_search.svg",
                  color: widget.selectedIndex == 1 ? colorRed : colorBlack,
                ),
              ),
              label: ""),
          BottomNavigationBarItem(
              icon: Container(
                padding: EdgeInsets.all(5.h),
                decoration: BoxDecoration(
                  border: Border(
                    top: BorderSide(
                        color:
                            widget.selectedIndex == 2 ? colorRed : colorTrans,
                        width: 2.w),
                  ),
                ),
                child: SvgPicture.asset(
                  "assets/svg/tab_saved.svg",
                  color: widget.selectedIndex == 2 ? colorRed : colorBlack,
                ),
              ),
              label: ""),
          BottomNavigationBarItem(
              icon: Container(
                padding: EdgeInsets.all(5.h),
                decoration: BoxDecoration(
                  border: Border(
                    top: BorderSide(
                        color:
                            widget.selectedIndex == 3 ? colorRed : colorTrans,
                        width: 2.w),
                  ),
                ),
                child: SvgPicture.asset(
                  "assets/svg/tab_logout.svg",
                  color: widget.selectedIndex == 3 ? colorRed : colorBlack,
                ),
              ),
              label: ""),
        ],
      ),
    );
  }
}
