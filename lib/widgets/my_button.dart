import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tentwenty_task/utils/color_palatte.dart';

class MyButton extends StatelessWidget {
  String label;
  Widget? child;
  GestureTapCallback onPressed;
  double height;
  double width;
  double? fontSize;
  Color color;
  bool enabled;
  bool outlined;

  MyButton(
      { this.label="",
        this.child,
        required this.width,
        this.outlined=false,
        this.fontSize,
        this.enabled=true,
        required this.height,
        required this.color,
        required this.onPressed,
        Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: enabled?onPressed:null,
      child: Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
          color: outlined
            ?Colors.transparent
              :enabled
              ?color
              :ColorPalette.grey_827D88,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: enabled
              ?color
              :ColorPalette.grey_827D88,
          width: 1.5),
        ),
        child:child?? Center(child: Text(
          label,
          style: TextStyle(
          color: ColorPalette.white_F6F6FA,
          fontWeight: FontWeight.bold,
          fontSize: fontSize??14
        ),
        ),
        ),
      ),
    );
  }
}
