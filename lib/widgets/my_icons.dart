import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SvgIcon extends StatelessWidget {
  double height;
  double width;
  String svgIcon;
  Color? color;

   SvgIcon({
 this.width=24,
     this.height=24,
     this.color,
     required this.svgIcon
});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: width,
      child: SvgPicture.asset(svgIcon,
      color: color,),
    );
  }
}


class SvgIcons{
  static const String dashboard_icon = "assets/svgs/dashboard_icon_grey.svg";
  static const String media_library_icon = "assets/svgs/media_library_icon_grey.svg";
  static const String more_icon = "assets/svgs/more_icon_grey.svg";
  static const String watch_icon = "assets/svgs/watch_icon.svg";
  static const String search_icon = "assets/svgs/search_icon.svg";
  static const String cross_icon = "assets/svgs/cross_icon.svg";
  static const String seat_icon = "assets/svgs/seat_icon.svg";


}