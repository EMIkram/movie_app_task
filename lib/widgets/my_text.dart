import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MyText extends StatelessWidget {
  String text;
  double? fontSize;
  Color? color;
  FontWeight? fontWeight;
  double? letterSpacing;
  TextStyle? style;
  TextAlign? textAlign;
  TextDecoration? textDecoration;
   MyText(this.text,{
     this.fontSize,
     this.style,
     this.color,
     this.fontWeight,
     this.letterSpacing,
     this.textDecoration,
     this.textAlign
  });

  @override
  Widget build(BuildContext context) {
    return Text(text,
      textAlign: textAlign,
      overflow: TextOverflow.ellipsis,
      style:  style??GoogleFonts.poppins(
        // letterSpacing: letterSpacing,
        fontSize: fontSize??14,
        color: color??Colors.black,
        fontWeight: fontWeight??FontWeight.normal,
        decoration: textDecoration
      ),

    );
  }
}
