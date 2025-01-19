import 'package:flutter/material.dart';
import 'package:tentwenty_task/utils/color_palatte.dart';
import 'package:tentwenty_task/widgets/my_icons.dart';

class Cenimaseatingview extends StatefulWidget {
  Cenimaseatingview({
    required this.seatings,
    required this.selectedBorders,
    required this.allowSelection,
    required this.onSeatSelected,
    required this.onSeatUnSelected,
    super.key,
  });

  bool selectedBorders;
  List<List<int>> seatings;
  void Function(int, int) onSeatSelected;
  void Function(int, int) onSeatUnSelected;
  final bool allowSelection;

  @override
  State<Cenimaseatingview> createState() => _CenimaseatingviewState();
}

class _CenimaseatingviewState extends State<Cenimaseatingview> {
  var seatColor = [
    Colors.transparent,
    ColorPalette.grey_827D88,
    ColorPalette.yellow_CD9D0F,
    ColorPalette.blue_61C3F2,
    ColorPalette.purple_564CA3
  ];

  @override
  Widget build(BuildContext context) {
    return cenimaSeatingView("Slot"); // Update this to return the actual view
  }

  Widget cenimaSeatingView(String slot) {
    int rowCount = 1;
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: widget.selectedBorders
              ? ColorPalette.blue_61C3F2
              : Colors.transparent,
        ),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              "assets/images/screen.png",
              width: 280,
              height: 30,
            ),
            ...widget.seatings.asMap().entries.map((rowEntry) {
              int rowIndex = rowEntry.key;
              List<int> row = rowEntry.value;

              return Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                      width: 10,
                      child: Text((rowCount++).toString(), style: TextStyle(fontSize: 8),)),
                  SizedBox(width: 5,),
                  ...row.asMap().entries.map((seatEntry) {
                    int columnIndex = seatEntry.key;
                    int seat = seatEntry.value;

                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 3),
                      child: InkWell(
                        onTap: () {
                          if (seat == 1 && widget.allowSelection) {
                            widget.onSeatSelected.call(rowIndex, columnIndex);
                            setState(() {
                              widget.seatings[rowIndex][columnIndex] = 2;
                            });
                          } else if (seat == 2 && widget.allowSelection) {
                            widget.onSeatUnSelected.call(rowIndex, columnIndex);
                            setState(() {
                              widget.seatings[rowIndex][columnIndex] = 1;
                            });
                          }

                        },
                        child: SvgIcon(
                          svgIcon: SvgIcons.seat_icon,
                          height: 10,
                          width: 10,
                          color: seatColor[seat],
                        ),
                      ),
                    );
                  }).toList(),
                  SizedBox(width: 5,),
                ]
              );
            }).toList(),
          ],
        ),
      ),
    );
  }
}
