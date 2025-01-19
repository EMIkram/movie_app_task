import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tentwenty_task/bloc/movie/movies_bloc.dart';
import 'package:tentwenty_task/bloc/movie_detail/movie_detail_bloc.dart';
import 'package:tentwenty_task/bloc/ticket/ticket_bloc.dart';
import 'package:tentwenty_task/environment.dart';
import 'views/home_view.dart';

void main() async {
  await Environment.initialize();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<MoviesBloc>(
          create: (context) => MoviesBloc(),
          lazy: false,
        ),
        BlocProvider<MovieDetailBloc>(
          create: (context) => MovieDetailBloc(),
          lazy: false,
        ),
        BlocProvider<TicketBloc>(
          create: (context) => TicketBloc(),
          lazy: false,
        ),
      ],
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Ten Twenty Task',
          theme: ThemeData(),
          home: HomeScreen()),
    );
  }
}
