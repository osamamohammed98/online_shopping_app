import 'package:auto_route/auto_route_annotations.dart';
import 'package:online_shopping_app/ui/pages/login_page.dart';
import 'package:online_shopping_app/ui/pages/shopping_home_page.dart';
import 'package:online_shopping_app/ui/pages/shopping_signup_page.dart';

@MaterialAutoRouter(
  routes: <AutoRoute>[
    // initial route is named "/"
    MaterialRoute(page: ShoppingLoginPage, initial: true),
    MaterialRoute(page: ShoppingHomePage, ),
    MaterialRoute(page: ShoppingSignUpPage, ),
  ],
)
class $CustomRoutes{}