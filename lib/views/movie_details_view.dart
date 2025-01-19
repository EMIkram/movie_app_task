import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:tentwenty_task/bloc/movie_detail/movie_detail_bloc.dart';
import 'package:tentwenty_task/modals/movie_modal.dart';
import 'package:tentwenty_task/utils/color_palatte.dart';
import 'package:tentwenty_task/utils/constants.dart';
import 'package:tentwenty_task/views/select_ticket_view.dart';
import 'package:tentwenty_task/widgets/my_back_button.dart';
import 'package:tentwenty_task/widgets/my_button.dart';
import 'package:tentwenty_task/widgets/my_text.dart';

import '../modals/movie_genres.dart';
import '../modals/movie_video.dart';
import 'youtube_video_player_view.dart';

class MovieDetailScreen extends StatefulWidget {
  MovieModal movie;
  bool fromSearch;

  MovieDetailScreen({required this.movie, required this.fromSearch, Key? key});

  @override
  State<MovieDetailScreen> createState() => _MovieDetailScreenState();
}

class _MovieDetailScreenState extends State<MovieDetailScreen> {
  var getColor = {
    "0": ColorPalette.blue_61C3F2,
    "1": ColorPalette.pink_E26CA5,
    "2": ColorPalette.purple_564CA3,
    "3": ColorPalette.yellow_CD9D0F
  };
  int colorNumber = 0;

  List<MovieGenres> movieGenres = <MovieGenres>[];
  List<MovieVideo> movieVideos = <MovieVideo>[];

  late MovieDetailBloc movieDetailBloc;

  @override
  void initState() {
    movieDetailBloc = context.read<MovieDetailBloc>();
    super.initState();
    movieDetailBloc
        .add(GetGenresByMovieIdEvent(movieID: widget.movie.id.toString()));
    movieDetailBloc.add(GetVideosByMovieIdEvent(movieID: widget.movie.id.toString()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: [
        Stack(
          children: [
            Container(
              height: MediaQuery.of(context).size.height * 0.60,
              width: double.maxFinite,
              child: Hero(
                tag: widget.movie.id.toString(),
                child: Image.network(
                  imageURL + widget.movie.posterPath.toString(),
                  fit: BoxFit.fitWidth,
                ),
              ),
            ),
            Container(
              height: MediaQuery.of(context).size.height * 0.60,
              width: double.maxFinite,
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.center,
                      end: Alignment.bottomCenter,
                      colors: [
                    Colors.black.withOpacity(0.0),
                    Colors.black.withOpacity(0.1),
                    Colors.black.withOpacity(0.3),
                    Colors.black.withOpacity(0.5),
                    Colors.black.withOpacity(0.7),
                  ])),
              child: Column(
                children: [
                  SizedBox(
                    height: 35,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      MyBackButton(onTap: () {
                        print('on pop');
                        Navigator.pop(context);
                      }),
                      MyText(
                        widget.fromSearch ? "Watch" : "",
                        fontSize: 16,
                        color: ColorPalette.white_F6F6FA,
                      )
                    ],
                  ),
                  Spacer(),
                  MyText(
                    'In Theaters ' +
                        DateFormat('MMMM dd,yyyy').format(DateTime.parse(
                            widget.movie.releaseDate.toString())),
                    fontSize: 22,
                    fontWeight: FontWeight.w500,
                    color: ColorPalette.white_F6F6FA,
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                  MyButton(
                      width: 280,
                      height: 60,
                      color: ColorPalette.blue_61C3F2,
                      child: Center(
                        child: MyText(
                          "Get Tickets",
                          color: ColorPalette.white_F6F6FA,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => SelectTicketScreen(
                                    movie: widget.movie,
                                    dates: getNextSevenDays(
                                        widget.movie.releaseDate.toString()),
                                  )),
                        );
                      }),
                  const SizedBox(
                    height: 12,
                  ),
                  MyButton(
                      width: 280,
                      height: 60,
                      outlined: true,
                      color: ColorPalette.blue_61C3F2,
                      child: Center(
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.play_arrow,
                              color: ColorPalette.white_F6F6FA,
                            ),
                            MyText(
                              " Watch Trailer",
                              color: ColorPalette.white_F6F6FA,
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ],
                        ),
                      ),
                      onPressed: () {
                        int index = movieVideos.indexWhere((element) =>
                            element.type!.toUpperCase() ==
                            "Trailer".toUpperCase());
                        print(index);
                        if (index != -1) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => YoutubePlayerScreen(
                                    movieVideos[index].key!)),
                          );
                        } else {
                          ///show error or something
                          // FlutterToast("Not Found", "No Trailer has been found.");
                        }
                      }),
                  const SizedBox(
                    height: 35,
                  ),
                ],
              ),
            )
          ],
        ),
        Padding(
          padding: const EdgeInsets.all(35.0),
          child: SizedBox(
            height: MediaQuery.of(context).size.height * 0.40 - 70,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  width: double.maxFinite,
                ),
                MyText(
                  "Genres",
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  color: ColorPalette.textColor,
                ),
                const SizedBox(
                  height: 20,
                ),
                SizedBox(
                  height: 35,
                  child: BlocBuilder<MovieDetailBloc, MovieDetailState>(
                    builder: (context, state) {
                      if (state is MovieGenresFetchedSuccessState) {
                        movieGenres = state.movieGenres;
                      } else if (state is MovieVideosFetchedSuccessState){
                        movieVideos = state.movieVideos;
                      }
                      return ListView(
                        scrollDirection: Axis.horizontal,
                        children: movieGenres.map((genre) {
                          Color? color = getColor[(colorNumber % 4).toString()];
                          colorNumber++;
                          return Padding(
                            padding: const EdgeInsets.only(right: 8.0),
                            child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(25),
                                  color: color),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 12.0, vertical: 8),
                                child: MyText(
                                  genre.name!,
                                  color: ColorPalette.white_F6F6FA,
                                ),
                              ),
                            ),
                          );
                        }).toList(),
                      );
                    },
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                MyText(
                  "Overview",
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  color: ColorPalette.textColor,
                ),
                const SizedBox(
                  height: 20,
                ),
                Expanded(
                  child: SizedBox(
                      child: SingleChildScrollView(
                          child: MyText(
                    widget.movie.overview!,
                    color: ColorPalette.grey_827D88,
                  ))),
                )
              ],
            ),
          ),
        ),
      ],
    ));
  }

  List<String> getNextSevenDays(String releaseDate) {
    List<String> dates = [];
    DateTime startDate =
        DateTime.parse(releaseDate); // Convert string to DateTime
    DateFormat formatter = DateFormat('d MMM'); // Format like "8 Mar"

    for (int i = 0; i < 7; i++) {
      DateTime date = startDate.add(Duration(days: i)); // Get next 7 days
      dates.add(formatter.format(date));
    }

    return dates;
  }
}
