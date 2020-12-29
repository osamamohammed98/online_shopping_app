import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:online_shopping_app/util/colors.dart';
import 'package:online_shopping_app/util/strings.dart';
import 'package:online_shopping_app/util/style.dart';

class CustomTextFormFiled extends StatelessWidget {
  final TextInputType keyboardType;
  final TextEditingController controller;
  final Function funValidate;
  final String hint;
  final bool isScure;

  CustomTextFormFiled(
      {this.keyboardType,
      this.controller,
      this.funValidate,
      this.hint,
      this.isScure = false,
      Key key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    screenUtil(context);
    return Container(
      padding: EdgeInsets.symmetric(vertical: 4.h),
      height: 60.h,
      margin: EdgeInsets.only(bottom: 22.h),
      decoration: BoxDecoration(
        color: colorGrayLight,
        borderRadius: BorderRadius.circular(12.w),
      ),
      child: TextFormField(
        obscureText: isScure,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(
            horizontal: 12.w,
          ),
          border: InputBorder.none,
          labelText: hint,
          labelStyle: textHint,
        ),
        keyboardType: keyboardType,
        controller: controller,
        validator: (value) {
          if (value.isEmpty || value == "") {
            return requiredField;
          }else if (funValidate != null){
           return funValidate(value);
          } else {
            return null;
          }
        },
        maxLines: 1,
      ),
    );
  }
}
