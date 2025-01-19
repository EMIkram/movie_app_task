import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tentwenty_task/widgets/cenimaSeatingview.dart';

import '../modals/movie_modal.dart';
import '../utils/color_palatte.dart';
import '../widgets/my_back_button.dart';
import '../widgets/my_button.dart';
import '../widgets/my_icons.dart';
import '../widgets/my_text.dart';

class BookedSeatView extends StatelessWidget {
   BookedSeatView({required this.seatings,required this.movie,super.key});
  MovieModal movie;
   List<List<int>> seatings;

  var seatColor = [
    Colors.transparent,
    ColorPalette.grey_827D88,
    ColorPalette.yellow_CD9D0F,
    ColorPalette.blue_61C3F2,
    ColorPalette.purple_564CA3
  ];
  String selectedDate = '';
  String selectedSlot= '';


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorPalette.white_F6F6FA,
      body: Column(
        children: [
          SizedBox(
            height: 70,
            width: double.maxFinite,
          ),
          Container(
            color: ColorPalette.white_F6F6FA,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                MyBackButton(
                  color: Colors.black,
                  onTap: () => Navigator.pop(context),
                ),
                Spacer(),
                Column(
                  children: [
                    SizedBox(
                      width: MediaQuery.sizeOf(context).width-80,
                      child: Center(
                        child: MyText(
                          movie.title!,
                          textAlign: TextAlign.center,
                          fontSize: 22,
                          fontWeight: FontWeight.w500,
                          color: ColorPalette.black_2E2739,
                        ),
                      ),
                    ),
                    Center(
                      child: MyText(
                        'In Theaters ' +
                            DateFormat('MMMM dd,yyyy').format(DateTime.parse(
                                movie.releaseDate.toString())),
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                        color: ColorPalette.blue_61C3F2,
                      ),
                    ),
                  ],
                ),
                Spacer(),
                SizedBox(
                  width: 25,
                )
              ],
            ),
          ),
          SizedBox(height: 80,),
          Cenimaseatingview(seatings: seatings, selectedBorders: false, allowSelection: true, onSeatSelected: (rowIndex, columnIndex){}),
          SizedBox(height: 150,),
          Row( mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  width: 30.0,  // Adjust the width and height to make it circular
                  height: 30.0, // Make it a perfect circle
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,  // Ensures the container is circular
                    color: Colors.white,      // Background color
                  ),
                  child: Icon(
                    Icons.add,              // Icon you want inside the circle
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  width: 30.0,  // Adjust the width and height to make it circular
                  height: 30.0, // Make it a perfect circle
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,  // Ensures the container is circular
                    color: Colors.white,      // Background color
                  ),
                  child: Icon(
                    Icons.remove,              // Icon you want inside the circle
                  ),
                ),
              ),
              SizedBox(width: 10,)
            ],
          ),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Container(
              height: 5,
              width: double.maxFinite,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4),
                color: ColorPalette.light_grey_DBDBDF
              ),
            ),
          ),
          Expanded(child: Container(
            color: Colors.white,
            child: Column(
              children: [
                SizedBox(height: 10,),
                Row(
                  children: [
                    seatWithNameWidget('Selected', 2),
                    seatWithNameWidget('Not Available', 1),
                  ],
                ),
               Row(
                 children: [
                   seatWithNameWidget('VIP (150\$)', 4),
                   seatWithNameWidget('Regular', 3),
                 ],
               ),
                Spacer(),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        width: 100,
                        height: 60,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: ColorPalette.light_grey_DBDBDF.withOpacity(0.3)
                        ),
                      ),
                      SizedBox(width: 20,),
                      Expanded(
                        child: MyButton(
                            child: Center(
                              child: MyText(
                                "Proceed to pay",
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                                color: ColorPalette.white_F6F6FA,
                              ),
                            ),
                            width: double.maxFinite,
                            height: 60,
                            color: ColorPalette.blue_61C3F2,
                            onPressed: () {
                            }),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 10,)

              ],
            ),
          ))
        ],
      ),
    );
  }

  Widget seatWithNameWidget(String title, int colorIndex){
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Row(children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: SvgIcon(
            svgIcon: SvgIcons.seat_icon,
            height: 20,
            width: 20,
            color: seatColor[colorIndex],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(title, style: TextStyle(color: ColorPalette.grey_827D88),),
        )
      ],),
    );
  }
}

