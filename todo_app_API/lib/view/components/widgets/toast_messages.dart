import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '';


Future<bool?>showToast({required String message, Color color = Colors.red}){
return Fluttertoast.showToast(msg: message,
  toastLength: Toast.LENGTH_SHORT,
  gravity: ToastGravity.BOTTOM,
  timeInSecForIosWeb: 1,
  backgroundColor: color,
  textColor: Colors.black,
  fontSize: 16.sp,



);
}