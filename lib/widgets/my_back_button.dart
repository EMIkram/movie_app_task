import 'package:flutter/material.dart';

class MyBackButton extends StatelessWidget {
  EdgeInsets? padding;
  Color color;
  GestureTapCallback onTap;
   MyBackButton({this.padding, required this.onTap,this.color=Colors.white,Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding?? EdgeInsets.only(left: 18,top: 18, bottom: 18),      child: InkWell(
        onTap: onTap,
        child:   Container(
          color: Colors.transparent,
          child: Icon(Icons.arrow_back_ios,color: color,),
        ),
      ),
    );
  }
}
