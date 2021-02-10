import 'package:auto_route/auto_route.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:online_shopping_app/ui/widget/custom_flat_button.dart';
import 'package:online_shopping_app/ui/widget/custom_text_form_filed.dart';
import 'package:online_shopping_app/util/routes/custom_routes.gr.dart';
import 'package:online_shopping_app/util/shared_method.dart';
import 'package:online_shopping_app/util/strings.dart';
import 'package:online_shopping_app/util/style.dart';

class ShoppingLoginPage extends StatefulWidget {
  @override
  _ShoppingLoginPageState createState() => _ShoppingLoginPageState();
}

class _ShoppingLoginPageState extends State<ShoppingLoginPage> {
  final GlobalKey<FormState> keyForm = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> keyScaffold = GlobalKey<ScaffoldState>();
  TextEditingController _controllerEmail, _controllerPassword;
  bool isAsyncCall = false;
  FirebaseAuth auth;

  @override
  void initState() {
    super.initState();
    _controllerEmail = TextEditingController();
    _controllerPassword = TextEditingController();
    auth = FirebaseAuth.instance;
    auth.authStateChanges().listen((user) {
      if (user != null) {
        ExtendedNavigator.root.push(Routes.shoppingHomePage);
      }
    });
  }

  Future<bool> signInUser() async {
    try {
      UserCredential credential = await auth.signInWithEmailAndPassword(
          email: _controllerEmail.text.toString(),
          password: _controllerPassword.text.toString());

      if (credential.user.uid.isNotEmpty) {
        createSnackBarDone(keyScaffold, doneSignIn);
        return true;
      } else {
        print("onError".toString());
        createSnackBarError(keyScaffold, "onError".toString());
        return false;
      }
    } catch (e) {
      print(e.toString());
      createSnackBarError(keyScaffold, e.toString());
      return false;
    }


  }

  _onSubmitBtn() async {
    bool sigin = await signInUser();
    validateBtn(keyForm: keyForm);
    if (keyForm.currentState.validate()) {
      if (sigin) {
        setState(() {
          isAsyncCall = true;
        });
        ExtendedNavigator.root.replace(
          Routes.shoppingHomePage,
        );
      } else {
        setState(() {
          isAsyncCall = true;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    screenUtil(context);
    safeArea();
    return Scaffold(
      key: keyScaffold,
      body: ModalProgressHUD(
        inAsyncCall: isAsyncCall ?? false,
        child: Center(
          child: Container(
            alignment: Alignment.center,
            width: double.infinity,
            margin: EdgeInsets.symmetric(horizontal: 34.w, vertical: 35.h),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: EdgeInsets.only(top: 30.h),
                  child: Text(loginTitlePage,
                      style: textBig, textAlign: TextAlign.center),
                ),
                Form(
                  key: keyForm,
                  child: Column(
                    children: [
                      CustomTextFormFiled(
                        hint: emailHint,
                        keyboardType: TextInputType.emailAddress,
                        controller: _controllerEmail,
                        funValidate: emailValidation,
                      ),
                      CustomTextFormFiled(
                        hint: passwordHint,
                        keyboardType: TextInputType.visiblePassword,
                        isScure: true,
                        controller: _controllerPassword,
                        funValidate: passwordValidation,
                      ),
                      CustomFlatBtn(
                        btnText: loginBtn,
                        isSolid: true,
                        onClick: () {
                          _onSubmitBtn();
                        },
                      ),
                    ],
                  ),
                ),
                CustomFlatBtn(
                  btnText: createAccountBtn,
                  isSolid: false,
                  onClick: () {
                    ExtendedNavigator.root.push(Routes.shoppingSignUpPage);
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
