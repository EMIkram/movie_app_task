import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tentwenty_task/bloc/movie/movies_bloc.dart';
import 'package:tentwenty_task/modals/genre_modal.dart';
import 'package:tentwenty_task/modals/movie_modal.dart';
import 'package:tentwenty_task/utils/color_palatte.dart';
import 'package:tentwenty_task/utils/constants.dart';
import 'package:tentwenty_task/views/movie_details_view.dart';
import 'package:tentwenty_task/widgets/my_back_button.dart';
import 'package:tentwenty_task/widgets/my_icons.dart';
import 'package:tentwenty_task/widgets/my_text.dart';
import 'package:tentwenty_task/widgets/text_field.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController searchController = TextEditingController();
  FocusNode searchFocus = FocusNode();
  Timer? _debouncer;
  String lastSearchString = "";
  late MoviesBloc moviesBloc;

  @override
  void initState() {
    super.initState();
    moviesBloc = context.read<MoviesBloc>();
    searchListener();

  }

  searchListener() {
    searchController.addListener(() {
      if (_debouncer != null) {
        _debouncer!.cancel();
      }
      _debouncer = Timer(
        Duration(milliseconds: 500),
            () {
              if(searchController.text.trim().isNotEmpty && lastSearchString != searchController.text.trim()){
            moviesBloc.add(SearchByQueryEvent(query: searchController.text.trim(),stillSearching: searchFocus.hasFocus));
          } else if(searchController.text.trim().isEmpty){
                moviesBloc.add(SearchFieldClearEvent());
              }
        },
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorPalette.white_F6F6FA,
      body: WillPopScope(
        onWillPop: () {
          moviesBloc.searchList.clear();
          moviesBloc.searchedGenre = "";
          moviesBloc.searchFieldEnabled = false;
          return Future.value(false);
        },
        child: SafeArea(
          child: BlocBuilder<MoviesBloc, MoviesState>(
            builder: (context, state) {
              return Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 12.0, vertical: 18),
                    child: state is SearchEnabledState
                    ? searchViewHeader(state)
                        :Row(
                      children: [
                        MyText(
                          "Watch",
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                        ),
                        const Spacer(),
                        GestureDetector(
                            onTap: () {
                             moviesBloc.add(EnableSearchEvent(
                               stillSearching: true
                             ));
                            },
                            child: SvgIcon(
                                svgIcon: SvgIcons.search_icon))
                      ],
                    ),
                  ),
                  Expanded(
                    child: state is SearchEnabledState && searchController.text.isEmpty && state.searchList.isEmpty
                        ? searchByGenresUI()
                        : state is SearchEnabledState
                        ? searchResultsUI(state)
                        : upcomingMoviesList(),
                  ),

                  ///footer
                  Container(
                    height: 70,
                    width: double.maxFinite,
                    decoration: BoxDecoration(
                        color: ColorPalette.black_2E2739,
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(35),
                          topRight: Radius.circular(35),
                        )),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SvgIcon(
                              svgIcon: SvgIcons.dashboard_icon,
                              height: 18,
                              width: 18,
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            MyText(
                              "Dashboard",
                              color: ColorPalette.grey_827D88,
                              fontSize: 12,
                            )
                          ],
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SvgIcon(
                              svgIcon: SvgIcons.watch_icon,
                              height: 18,
                              width: 18,
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            MyText(
                              "Watch",
                              color: ColorPalette.white_F6F6FA,
                              fontSize: 12,
                            )
                          ],
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SvgIcon(
                              svgIcon: SvgIcons.media_library_icon,
                              height: 18,
                              width: 18,
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            MyText(
                              "Media Library",
                              color: ColorPalette.grey_827D88,
                              fontSize: 12,
                            )
                          ],
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SvgIcon(
                              svgIcon: SvgIcons.more_icon,
                              height: 18,
                              width: 18,
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            MyText(
                              "More",
                              color: ColorPalette.grey_827D88,
                              fontSize: 12,
                            )
                          ],
                        ),
                      ],
                    ),
                  )
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  Widget upcomingMoviesList() {
    return ListView.builder(
        itemCount: moviesBloc.upcomingMoviesList.length,
        itemBuilder: (context, index) {
          MovieModal movie = moviesBloc.upcomingMoviesList[index];
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) =>
                MovieDetailScreen(movie: movie, fromSearch: false)),
              );
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Stack(
                children: [
                  Container(
                    height: 250,
                    width: double.maxFinite,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: ColorPalette.grey_827D88),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(15),
                      child: Hero(
                        tag: movie.id.toString(),
                        child: Image.network(
                          imageURL + movie.posterPath.toString(),
                          fit: BoxFit.fitWidth,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    height: 250,
                    width: double.maxFinite,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        gradient: LinearGradient(
                            begin: Alignment.center,
                            end: Alignment.bottomCenter,
                            colors: [
                              Colors.black.withOpacity(0.0),
                              Colors.black.withOpacity(0.1),
                              Colors.black.withOpacity(0.2),
                              Colors.black.withOpacity(0.5),
                              Colors.black.withOpacity(0.6),
                              Colors.black.withOpacity(0.7),
                              Colors.black.withOpacity(0.9)
                            ])),
                    alignment: Alignment.bottomLeft,
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: MyText(
                        movie.title ?? "",
                        color: ColorPalette.white_F6F6FA,
                        fontSize: 23,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }

  Widget searchViewHeader(SearchEnabledState state) {
    return !state.stillSearching ? Row(
      children: [
        MyBackButton(
          onTap: () {
            lastSearchString = "";
            searchController.clear();
            searchFocus.unfocus();
            moviesBloc.add(DisableSearchEvent());
          },
          color: ColorPalette.black_2E2739,
        ),
        MyText(
          "${state.searchList.length} Result(s) Found",
          fontSize: 17,
          fontWeight: FontWeight.w500,
          color: ColorPalette.black_2E2739,
        ),
      ],
    )
        :Padding(
      padding: const EdgeInsets.all(8.0),
      child: MyTextField(
        width: double.maxFinite,
        leading: GestureDetector(
            onTap: () {
              ///on search icon tap
            },
            child: SvgIcon(
              svgIcon: SvgIcons.search_icon,
            )),
        leadingHeight: 22,
        leadingWidth: 22,
        trailing: GestureDetector(
          onTap: () {
            lastSearchString = "";
            searchController.clear();
            searchFocus.unfocus();
            moviesBloc.add(DisableSearchEvent());
          },
          child: SvgIcon(
            svgIcon: SvgIcons.cross_icon,
            height: 26,
            width: 26,
          ),
        ),
        trailingHeight: 28,
        trailingWidth: 28,
        hintText: "TV shows, movies and more",
        onEditingComplete: () async {
         Future.delayed(Duration(milliseconds: 600)).then((v){
           moviesBloc.add(EnableSearchEvent(stillSearching: false));
         });
        },
        hintStyle: TextStyle(
            color: ColorPalette.grey_827D88
                .withOpacity(0.5)),
        controller: searchController,
        focusNode: searchFocus,
        color: ColorPalette.light_grey_DBDBDF,
      ),
    );
  }

  Widget searchByGenresUI() {
    List<DummyGenres> dummyGenres = DummyGenres.getDummyGeres();
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              childAspectRatio: 1.5, crossAxisCount: 2),
          shrinkWrap: true,
          itemCount: dummyGenres.length,
          itemBuilder: (context, index) {
            DummyGenres genre = dummyGenres[index];
            return GestureDetector(
              onTap: () async {
                moviesBloc.add(SearchByGenreEvent(genreID: genre.id.toString() ,
                    stillSearching: true, genreName: genre.name ?? ""));
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Stack(
                  children: [
                    Container(
                      height: 120,
                      width: double.maxFinite,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: ColorPalette.grey_827D88),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(15),
                        child: Image.asset(
                          genre.imageUrl!,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Container(
                      height: 120,
                      width: double.maxFinite,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: Colors.black12),
                      alignment: Alignment.bottomLeft,
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: MyText(
                          genre.name ?? "",
                          color: ColorPalette.white_F6F6FA,
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          }),
    );
  }

  Widget searchResultsUI(SearchEnabledState state) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: ListView(
        children: [
          SizedBox(
            height: state.stillSearching ? 15 : 0,
          ),
          Visibility(
            visible: state.stillSearching,
            child: MyText(
              "Top Results",
              color: ColorPalette.black_2E2739,
              fontSize: 16,
            ),
          ),
          SizedBox(
            height: state.stillSearching ? 15 : 0,
          ),
          Visibility(
              visible: state.stillSearching, child: const Divider()),
          const SizedBox(
            height: 15,
          ),
          ...state.searchList.map((movie) =>
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => MovieDetailScreen(movie: movie, fromSearch: true,)),
                        );
                      },
                      child: Container(
                        height: 115,
                        width: 170,
                        child: ClipRRect(
                          child: Hero(
                            tag: movie.id!,
                            child: Image.network(
                              movie.posterPath == null
                                  ? "https://picsum.photos/200/350" ///dummy image
                                  : imageURL + (movie.posterPath!),
                              fit: BoxFit.fitWidth,
                            ),
                          ),
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 12,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: 150,
                          child: MyText(
                            movie.title!,
                            color: ColorPalette.black_2E2739,
                            fontSize: 18,
                          ),
                        ),
                        MyText(
                          state.searchedGenre ?? '',
                          color: ColorPalette.grey_827D88,
                        )
                      ],
                    ),
                    const Spacer(),
                    MyText(
                      "...",
                      fontSize: 35,
                      color: ColorPalette.blue_61C3F2,
                    ),
                    const SizedBox(
                      width: 8,
                    )
                  ],
                ),
              ))
        ],
      ),
    );
  }
}
