import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';



const String _apiKey = 'd5cd849e7b0423b9843166aee15de456';

const String urlPopularMovie ="https://api.themoviedb.org/3/movie/popular?api_key=$_apiKey&language=en-US&page=1";
const String urlTopRatedMovie ="https://api.themoviedb.org/3/movie/top_rated?api_key=$_apiKey&language=en-US&page=1";
const String urlTv ="https://api.themoviedb.org/3/tv/popular?api_key=$_apiKey&language=en-US&page=1";
const String urlTrending ="https://api.themoviedb.org/3/trending/all/day?api_key=$_apiKey>>";
const String urlSearch = "";

const String commonImagePath = "https://image.tmdb.org/t/p/w500/";

const divider = Padding(padding: EdgeInsets.only(left: 20),child:SizedBox(width: 75,child: Divider(height: 2,thickness: 2,color: Colors.red,),));
const padding = EdgeInsets.symmetric(
  horizontal: 20,
);
const sizedh1 = SizedBox(
  height: 10,
);
const sizedh2 = SizedBox(
  height: 20,
);
const sizedw1 = SizedBox(
  width: 10,
);
const sizedw2 = SizedBox(
  width: 20,
);

const downloadHighlight = "We'll download a personalized selection of movies and shows for you, so there is something to warch on your phone";

