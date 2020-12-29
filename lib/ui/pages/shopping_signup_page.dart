import 'package:auto_route/auto_route.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:online_shopping_app/ui/widget/custom_flat_button.dart';
import 'package:online_shopping_app/ui/widget/custom_text_form_filed.dart';
import 'package:online_shopping_app/util/shared_method.dart';
import 'package:online_shopping_app/util/strings.dart';
import 'package:online_shopping_app/util/style.dart';

class ShoppingSignUpPage extends StatefulWidget {
  @override
  _ShoppingSignUpPageState createState() => _ShoppingSignUpPageState();
}

class _ShoppingSignUpPageState extends State<ShoppingSignUpPage> {
  final GlobalKey<FormState> keyForm = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> keyScaffold = GlobalKey<ScaffoldState>();
  TextEditingController _controllerEmail, _controllerPassword;
  bool inAsyncCall = false;

  @override
  void initState() {
    super.initState();
    _controllerEmail = TextEditingController();
    _controllerPassword = TextEditingController();
  }

  Future<bool> createUser() async {
    try {
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
              email: _controllerEmail.text.toString(),
              password: _controllerPassword.text.toString())
          .whenComplete(() {
                createSnackBarDone(keyScaffold, doneRegister);
                print(doneRegister);
        return true;
      }).catchError((onError) {
                print(onError.toString());
                createSnackBarError(keyScaffold, onError.toString());
        return false;
      });
    } on FirebaseAuthException catch (e) {
      createSnackBarError(keyScaffold, e.toString());
      print(e.toString());
      return false;
    } catch (e) {
      createSnackBarError(keyScaffold, e.toString());
      print(e.toString());
      return false;
    }
  }

  void _submitBtn() async {
    setState(() {
      inAsyncCall = true;
    });
    validateBtn(keyForm: keyForm);
    if (keyForm.currentState.validate()) {
      await createUser().then((value) {
        setState(() {
          if (value == true || value == false) {
            inAsyncCall = false;
          } else if (value) {
            ExtendedNavigator.root.pop();
          }
        });
      });
    } else {
      setState(() {
        inAsyncCall = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    screenUtil(context);
    safeArea();
    return Scaffold(
      key: keyScaffold,
      body: ModalProgressHUD(
        inAsyncCall: inAsyncCall,
        child: Center(
          child: Container(
            alignment: Alignment.center,
            width: double.infinity,
            margin: EdgeInsets.symmetric(horizontal: 34.w, vertical: 35.h),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: EdgeInsets.only(top: 34.h),
                  child: Text(createNewAccount,
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
                        btnText: createNewAccountBtn,
                        isSolid: true,
                        onClick: () => _submitBtn(),
                      ),
                    ],
                  ),
                ),
                CustomFlatBtn(
                  btnText: backBtn,
                  isSolid: false,
                  onClick: () {
                    ExtendedNavigator.root.pop();
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
