import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:tentwenty_task/bloc/ticket/ticket_bloc.dart';
import 'package:tentwenty_task/modals/movie_modal.dart';
import 'package:tentwenty_task/utils/color_palatte.dart';
import 'package:tentwenty_task/views/booked_seat_view.dart';
import 'package:tentwenty_task/widgets/my_back_button.dart';
import 'package:tentwenty_task/widgets/my_button.dart';
import 'package:tentwenty_task/widgets/my_icons.dart';
import 'package:tentwenty_task/widgets/my_text.dart';

class SelectTicketScreen extends StatefulWidget {
  MovieModal movie;
  List<String> dates = [];
  SelectTicketScreen({required this.movie, required this.dates, Key? key})
      : super(key: key);

  @override
  State<SelectTicketScreen> createState() => _SelectTicketScreenState();
}

class _SelectTicketScreenState extends State<SelectTicketScreen> {
  var seatColor = [
    Colors.transparent,
    ColorPalette.grey_827D88,
    ColorPalette.yellow_CD9D0F,
    ColorPalette.blue_61C3F2,
    ColorPalette.purple_564CA3
  ];

  TicketBloc ticketBloc = TicketBloc();

  String selectedDate = '';

  String selectedSlot= '';

  @override
  void initState() {
    // ticketBloc.add(SelectDateEvent(date: widget.dates.firstOrNull ?? ''));
    // ticketBloc.add(SelectSlotEvent(slot: '1'));
    selectedDate = widget.dates.first;
    selectedSlot='1';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(
              height: 20,
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
                        child: MyText(
                          widget.movie.title!,
                          fontSize: 22,
                          fontWeight: FontWeight.w500,
                          color: ColorPalette.black_2E2739,
                        ),
                      ),
                      MyText(
                        'In Theaters ' +
                            DateFormat('MMMM dd,yyyy').format(DateTime.parse(
                                widget.movie.releaseDate.toString())),
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                        color: ColorPalette.blue_61C3F2,
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
            Expanded(
                child: Container(
              width: double.maxFinite,
              color: ColorPalette.light_grey_DBDBDF,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Spacer(),
                    MyText(
                      "Date",
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      height: 35,
                      child: BlocBuilder<TicketBloc, TicketState>(
                        builder: (context, state) {
                          if (state is DateSelectedState) {
                            selectedDate = state.selectedDate;
                          }
                          return ListView(
                            scrollDirection: Axis.horizontal,
                            children: widget.dates
                                .map((date) => Padding(
                                      padding:
                                          const EdgeInsets.only(right: 12.0),
                                      child: Container(
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(8),
                                            color: date == selectedDate
                                                ? ColorPalette.blue_61C3F2
                                                : ColorPalette.grey_827D88
                                                    .withOpacity(0.1)),
                                        child: GestureDetector(
                                          onTap: () {
                                            ticketBloc.add(
                                                SelectDateEvent(date: date));
                                          },
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 12.0, vertical: 8),
                                            child: MyText(
                                              date,
                                              color: date == selectedDate
                                                  ? ColorPalette.white_F6F6FA
                                                  : ColorPalette.black_2E2739,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ))
                                .toList(),
                          );
                        },
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Container(
                      height: 300,
                      child: BlocBuilder<TicketBloc, TicketState>(
                        builder: (context, state) {
                          if(state is SlotSelectedState){
                            selectedSlot = state.selectedSlot;
                          }
                          return ListView(
                            scrollDirection: Axis.horizontal,
                            children: [
                              ///'1' and '2' are dummy slots for UI //TODO change it to dynamic slots
                              ...['1', '2']
                                  .map((slot) => Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              children: [
                                                MyText(
                                                  "12:30 ",
                                                  fontSize: 16,
                                                ),
                                                MyText(
                                                  " Cinetech hall $slot",
                                                  color:
                                                      ColorPalette.grey_827D88,
                                                  fontSize: 16,
                                                )
                                              ],
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                cenimaSeatingView(selectedSlot == slot)
                                              ],
                                            ),
                                            Row(
                                              children: [
                                                MyText(
                                                  "From ",
                                                  color:
                                                      ColorPalette.grey_827D88,
                                                  fontSize: 16,
                                                ),
                                                MyText(
                                                  "50\$ ",
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                                MyText(
                                                  "or ",
                                                  color:
                                                      ColorPalette.grey_827D88,
                                                  fontSize: 16,
                                                ),
                                                MyText(
                                                  "2500 Bonus",
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 16,
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ))
                                  .toList()
                            ],
                          );
                        },
                      ),
                    ),
                    Spacer(),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: MyButton(
                          child: Center(
                            child: MyText(
                              "Select Seats",
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                              color: ColorPalette.white_F6F6FA,
                            ),
                          ),
                          width: double.maxFinite,
                          height: 60,
                          color: ColorPalette.blue_61C3F2,
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => BookedSeatView(seatings: ticketBloc.seatings, movie: widget.movie,)),
                            );
                          }),
                    )
                  ],
                ),
              ),
            ))
          ],
        ),
      ),
    );
  }

  Widget cenimaSeatingView(bool selected){

    return Container(
      decoration: BoxDecoration(
          border: Border.all(color:selected ? ColorPalette.blue_61C3F2: Colors.transparent),
          borderRadius: BorderRadius.circular(12)
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30.0,vertical: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset("assets/images/screen.png",
              width: 280,
              height: 30,
            ),
            ...ticketBloc.seatings.map((row) => Row(
              children: row.map((seat) =>
                  Padding(
                    padding: const EdgeInsets.all(1.0),
                    child: SvgIcon(svgIcon: SvgIcons.seat_icon,
                      height: 10,
                      width: 10,
                      color: seatColor[seat],
                    ),
                  )
              ).toList(),
            )).toList()
          ],
        ),
      ),
    );

  }

}
