import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:todo_app_api/view/components/widgets/text_costume.dart';

class ElevatedButtonCustom extends StatelessWidget{

  final void Function()? onPressed;
  final String text;
  final double width;
  final double? radius;
  final Color? backgroundColor;
  const ElevatedButtonCustom({required this.onPressed, required this.text,this.width = 300,this.radius = 12,this.backgroundColor=Colors.grey, Key? key}) : super(key: key);


@override
Widget build(BuildContext context){
  return SizedBox(

    width: width.w  ,
    child: ElevatedButton(

    onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(radius!.r),
        ),
        backgroundColor: backgroundColor,
      ),

    child: TextCustom(text: text,),

    ),
  );

}

}