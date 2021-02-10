import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:online_shopping_app/util/colors.dart';
import 'package:online_shopping_app/util/strings.dart';
import 'package:online_shopping_app/util/style.dart';
import 'package:string_validator/string_validator.dart';

validateBtn({@required GlobalKey<FormState> keyForm}) {
  bool isValid = keyForm.currentState.validate();
  if (isValid) {
    keyForm.currentState.save();
  } else {
    return;
  }
}

passwordValidation(String value){
  if(value.length <6){
    return passwordValid;
  }else{
    return;
  }
}

emailValidation(String value){
  if(!isEmail(value)){
    return emailValid;
  }else{
    return;
  }
}

void createSnackBarDone(GlobalKey<ScaffoldState> keyScaffold,
    String message) {
  keyScaffold.currentState..removeCurrentSnackBar()..showSnackBar(SnackBar(
    backgroundColor: colorGreenDone,
    content: Text(
      message,
      style: textBtn.copyWith(fontSize: 14, fontWeight: FontWeight.normal),
    ),
  ));
}


Widget createSnackBarError(GlobalKey<ScaffoldState> keyScaffold, String message) {
  keyScaffold.currentState..removeCurrentSnackBar()..showSnackBar(SnackBar(
    backgroundColor: colorRedError,
    content: Text(
      message,
      style: textBtn.copyWith(fontSize: 14, fontWeight: FontWeight.normal),
    ),
  ));
}