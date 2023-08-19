import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
class TextCustom extends StatelessWidget {
  final String text;
  final Color? color;
  final FontWeight? fontWeight;
  final double? fontSize;
  final int? maxline;
  const TextCustom({required this.text,this.color,this.fontWeight,this.fontSize = 16,this.maxline=10, Key? key}): super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(text,
    style: TextStyle(
color:color,
      fontWeight: fontWeight,
      fontSize:fontSize?.sp,
    ),
      maxLines: maxline,
      overflow: TextOverflow.ellipsis,
      textAlign: TextAlign.center,

    );
  }
}
