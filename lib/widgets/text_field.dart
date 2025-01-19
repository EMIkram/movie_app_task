import 'package:flutter/material.dart';
import 'package:tentwenty_task/utils/color_palatte.dart';

class MyTextField extends StatefulWidget {
  Widget? leading;
  double? leadingWidth;
  double? leadingHeight;
  Widget? trailing;
  double? trailingWidth;
  double? trailingHeight;
  String? hintText;
  bool isPassword;
  bool validation;
  Color? color;
  double? height;
  double? width;
  TextStyle? hintStyle;
  TextEditingController controller;
  FocusNode? focusNode;
  VoidCallback? onEditingComplete;
  TextInputAction? textInputAction;

  MyTextField(
      {this.hintText,
        required this.controller,
        this.focusNode,
        this.onEditingComplete,
        this.textInputAction,
        this.leading,
        this.trailing,
        this.isPassword=false,
        this.validation=true,
        this.height,
        this.width,
        this.color,
        this.leadingHeight,
        this.leadingWidth,
        this.trailingHeight,
        this.trailingWidth,
        this.hintStyle,

        Key? key}) : super(key: key);

  @override
  _MyTextFieldState createState() => _MyTextFieldState();
}

class _MyTextFieldState extends State<MyTextField> {
  bool obsecureText = true;
  @override
  Widget build(BuildContext context) {
    return  Container(
      height: widget.height??60,
      width: widget.width??290,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding:  EdgeInsets.only(top: 10,bottom: 10,left: 10),
            child: Container(
                height: widget.leadingHeight?? 24,
                width: widget.leadingWidth??24,
                child: widget.leading
            ),
          ),
          Expanded(
            child: Padding(
              padding:  EdgeInsets.only(left: 13),
              child: TextField(
                onEditingComplete: widget.onEditingComplete,
                textInputAction: widget.textInputAction,
                focusNode: widget.focusNode,
                controller: widget.controller,
                obscureText: widget.isPassword?obsecureText:false,
                style:  TextStyle(fontSize: 12, color: ColorPalette.black_2E2739),
                decoration: InputDecoration(
                  border: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  hintText: widget.hintText??"",
                  hintStyle: widget.hintStyle??TextStyle(fontSize: 12,fontWeight: FontWeight.bold,color: ColorPalette.white_F6F6FA),
                ),
              ),
            ),
          ),
          Padding(
            padding: widget.isPassword? EdgeInsets.only(top: 15,bottom: 15,right: 15)
                : EdgeInsets.only(top: 0,bottom: 0,right: 15),
            child: widget.isPassword?
            Container(
              height: 24,
              width: 24,
              child: GestureDetector(
                onTap: (){
                  setState(() {
                    obsecureText = !obsecureText;
                  });
                },
                child: Icon(obsecureText?
                Icons.visibility_off:
                Icons.visibility,
                  color: ColorPalette.grey_827D88,),
              ),
            ):
            widget.trailing!=null?
            Container(
                height: widget.trailingHeight?? 24,
                width: widget.trailingWidth??24,
                child: widget.trailing
            )
                : const SizedBox(
              height: 24,
              width: 24,
            ),
          ),
        ],
      ),decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        color: widget.color??ColorPalette.white_F6F6FA
    ),
    );
  }
}
