import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:netflix/constants/constants.dart';
import 'package:netflix/models/model_popular_movies.dart';
import 'package:netflix/models/model_top_tv_show.dart';

class DioService{

  Dio? _dio;

  DioService(){
    _dio = Dio();
  }

  Future<List<PopularMovieResult>?> fetchPopularMovies() async{
    try{
       Response response = await _dio!.get(urlPopularMovie);
       PopularMovies popularMovies = PopularMovies.fromJson(response.data);
       return popularMovies.results;
    }on DioError catch(dioError){
      debugPrint(dioError.message.toString());
    }
  }
 Future<List<PopularMovieResult>?> fetchTopRatedMovies() async{
    try{
      Response response = await _dio!.get(urlTopRatedMovie);
      PopularMovies popularMovies = PopularMovies.fromJson(response.data);
      return popularMovies.results;
    }on DioError catch(dioError){
      debugPrint(dioError.message.toString());
    }
  }

  Future<List<PopularTvShowResult>?> fetchTopTvShows() async{
    try{
      Response response = await _dio!.get(urlTv);
      PopularTvShow popularTvShow = PopularTvShow.fromJson(response.data);
      return popularTvShow.results;
    }on DioError catch(dioError){
      debugPrint(dioError.message.toString());
    }
  }


  Future<List<PopularMovieResult>?> searchPopularMovies(searchQuery) async{
    try{
      Response response = await _dio!.get("https://api.themoviedb.org/3/search/movie?api_key=d5cd849e7b0423b9843166aee15de456&language=en-US&query=$searchQuery&page=1&include_adult=false");
      PopularMovies popularMovies = PopularMovies.fromJson(response.data);
      return popularMovies.results;
    }on DioError catch(dioError){
      debugPrint(dioError.message.toString());
    }
  }


}