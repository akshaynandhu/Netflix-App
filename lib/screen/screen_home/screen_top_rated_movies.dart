import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:netflix/api_service/dio_service.dart';
import 'package:netflix/constants/constants.dart';
import 'package:netflix/models/model_popular_movies.dart';
import 'package:netflix/screen/screen_home/screen_details.dart';
import 'package:netflix/widgets/widgets.dart';

class TopRatedMovies extends StatelessWidget {
  const TopRatedMovies({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<PopularMovieResult>?>(
      future: DioService().fetchTopRatedMovies(),
      builder: (context, snapShot) {
        if (!snapShot.hasData) {
          return Column(
            children: [
              const Center(
                child: CircularProgressIndicator(
                  color: Colors.red,
                  strokeWidth: 3.0,
                ),
              ),
              TextButton(
                onPressed: () {
                  DioService().fetchTopTvShows();
                },
                child: const Text("Refresh",style: TextStyle(color: Colors.red),),
              ),
            ],
          );
        } else {
          return SizedBox(
            height: 150,
            width: double.infinity,
            child: Padding(
              padding: const EdgeInsets.only(left: 18),
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                primary: true,
                physics: const ScrollPhysics(),
                itemCount: snapShot.data!.length,
                itemBuilder: (BuildContext context, index) {
                  return GestureDetector(
                    onTap: (){
                     showModalBottomSheet(
                          isScrollControlled: true,
                          backgroundColor: Colors.black.withOpacity(0.6),
                          enableDrag: false,
                          context: context, builder: (context) => buildDescriptionSection(context,title: snapShot.data![index].title,desc: snapShot.data![index].overview,image: snapShot.data![index].posterPath,rating: snapShot.data![index].voteAverage,year: snapShot.data![index].releaseDate));
                      },
                    child: GridTile(
                      child: Image.network(
                        commonImagePath + snapShot.data![index].posterPath,
                      ),
                    ),
                  );
                },
                separatorBuilder: (context,index) => sizedw1,
              ),
            ),
          );
        }
      },
    );
  }
}
