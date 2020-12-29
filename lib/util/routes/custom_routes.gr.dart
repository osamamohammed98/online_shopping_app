// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

// ignore_for_file: public_member_api_docs

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../../ui/pages/login_page.dart';
import '../../ui/pages/shopping_home_page.dart';
import '../../ui/pages/shopping_signup_page.dart';

class Routes {
  static const String shoppingLoginPage = '/';
  static const String shoppingHomePage = '/shopping-home-page';
  static const String shoppingSignUpPage = '/shopping-sign-up-page';
  static const all = <String>{
    shoppingLoginPage,
    shoppingHomePage,
    shoppingSignUpPage,
  };
}

class CustomRoutes extends RouterBase {
  @override
  List<RouteDef> get routes => _routes;
  final _routes = <RouteDef>[
    RouteDef(Routes.shoppingLoginPage, page: ShoppingLoginPage),
    RouteDef(Routes.shoppingHomePage, page: ShoppingHomePage),
    RouteDef(Routes.shoppingSignUpPage, page: ShoppingSignUpPage),
  ];
  @override
  Map<Type, AutoRouteFactory> get pagesMap => _pagesMap;
  final _pagesMap = <Type, AutoRouteFactory>{
    ShoppingLoginPage: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => ShoppingLoginPage(),
        settings: data,
      );
    },
    ShoppingHomePage: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => ShoppingHomePage(),
        settings: data,
      );
    },
    ShoppingSignUpPage: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => ShoppingSignUpPage(),
        settings: data,
      );
    },
  };
}
