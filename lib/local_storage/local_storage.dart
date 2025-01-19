// import 'package:cached_map/cached_map.dart';
// import 'package:tentwenty_task/modals/movie_modal.dart';
//
// class LocalStorage extends Mapped{
//
//   void storeMoviesList(List<MovieModal> movies){
//     super.saveFile(file: {
//       "movies_list" : [movies.map((element)=> element.toJson())]
//     }, cachedFileName: "movies_list");
//   }
//
//   fetchMoviesList() async{
//     dynamic json = await super.loadFile(cachedFileName: "movies_list");
//     List rawList = json["movies_list"];
//     return rawList.map((json)=> MovieModal.fromJson(json)).toList();
//   }
// }