import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:fluttertoast/fluttertoast.dart';
void PushToNextScreen(context, wight) => Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => wight),
    );

void showToast(msg) {
  Fluttertoast.showToast(
      msg: msg,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 5,
      backgroundColor: Colors.red,
      textColor: Colors.white,
      fontSize: 16.0);
}void showToastSuccess(msg) {
  Fluttertoast.showToast(
      msg: msg,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 5,
      backgroundColor: Colors.green,
      textColor: Colors.white,
      fontSize: 16.0);
}

void navigatorAndFinish(context, Widget widget) => Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => widget),
      (Route<dynamic> route) => false,
    );

Widget bottom({
  required double width,
  required double height,
  required Color color,
  required VoidCallback? onPressed,
  required String text,
  required Color Colortext,
  required Color borderColor,
}) =>
    Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        border: Border.all(
          color: borderColor,
        ),
        color: color,
        borderRadius: BorderRadius.circular(5.0),
      ),
      child: MaterialButton(
        onPressed: onPressed,
        child: Text(
          text,
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 21.0,
            color: Colortext,
          ),
        ),
      ),
    );
Widget customBottom({
  required double width,
  required double height,
  required Color color,
  required VoidCallback? onPressed,
  required Widget widget,
  required Color borderColor,
}) =>
    Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        border: Border.all(
          color: borderColor,
        ),
        color: color,
        borderRadius: BorderRadius.circular(5.0),
      ),
      child: MaterialButton(
        onPressed: onPressed,
        padding: EdgeInsets.zero,
        child: widget
      ),
    );

Widget defulteditTextx({
  required TextEditingController Controlar,
  required TextInputType keyboardType,
  Function? onfiled,
  // Function? onchanged ,
  FormFieldValidator<String>? validator,
  required String Lable,
  required String hint,
  IconData? prefix,
  IconData? sufix,
  suffixPressed,
  bool? obscureText = false,
  Function(String)? onSubmit,
}) =>
    TextFormField(
      onFieldSubmitted: onSubmit,
      obscureText: obscureText!,
      controller: Controlar,
      keyboardType: keyboardType,
      // onChanged:(s)
      // {
      //   onchanged!(s);
      // } ,
      validator: validator,
      decoration: InputDecoration(
        floatingLabelBehavior: FloatingLabelBehavior.always,
        labelStyle: TextStyle(fontWeight: FontWeight.w500,fontSize: 22, color: HexColor('#F15A22'),),
        labelText: Lable,
        icon: Icon(prefix,color: HexColor('#050640'),),

        hintText: hint,
        hintStyle: TextStyle(fontSize: 11.5),
        // border: InputBorder.none,
        suffixIcon: sufix != null
            ? IconButton(onPressed: suffixPressed, icon: Icon(sufix))
            : null,
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.grey),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.grey),
        ),
        //filled: false,
        //fillColor: Colors.grey[200],
      ),
    );

Widget separator(double wide, double high) {
  return SizedBox(
    width: wide,
    height: high,
  );
}

Widget BulidProfileItem(IconData iconData, String title,
    {GestureTapCallback? ontab}) {
  return Column(
    children: [
      ListTile(
        onTap: ontab,
        leading: Icon(
          iconData,
          size: 32,
          color: Colors.green,
        ),
        title: Text(
          title,
          style: const TextStyle(
              color: Colors.black87,
              fontSize: 17.0,
              fontWeight: FontWeight.bold),
        ),
        trailing: const Icon(
          Icons.arrow_forward_ios,
          color: Colors.black,
        ),
      ),
      const Divider(
        height: 1,
        color: Colors.grey,
      ),
    ],
  );
}

Widget defaultFormField({
  required context,
  TextEditingController? controller,
  dynamic label,
  IconData? prefix,
  String? initialValue,
  TextInputType? keyboardType,
  Function(String)? onSubmit,
  onChange,
  onTap,
  required String? Function(String?) validate,
  bool isPassword = false,
  bool enabled = true,
  IconData? suffix,
  suffixPressed,
}) =>
    TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      obscureText: isPassword,
      textAlign: TextAlign.start,
      onFieldSubmitted: onSubmit,
      enabled: enabled,
      onChanged: onChange,
      onTap: onTap,
      validator: validate,
      textCapitalization: TextCapitalization.words,
      textAlignVertical: TextAlignVertical.center,
      style: Theme.of(context).textTheme.bodyText1,
      initialValue: initialValue,
      //textCapitalization: TextCapitalization.words,

      decoration: InputDecoration(
        hintText: label,
        border: UnderlineInputBorder(),
        prefixIcon: Icon(
          prefix,
        ),
        suffixIcon: suffix != null
            ? IconButton(onPressed: suffixPressed, icon: Icon(suffix))
            : null,
      ),
    );
