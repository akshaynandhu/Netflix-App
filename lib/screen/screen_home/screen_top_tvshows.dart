import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:netflix/api_service/dio_service.dart';
import 'package:netflix/constants/constants.dart';
import 'package:netflix/models/model_top_tv_show.dart';
import 'package:netflix/screen/screen_home/screen_details.dart';
import 'package:bordered_text/bordered_text.dart';
import 'package:netflix/widgets/widgets.dart';

class TopTvShows extends StatefulWidget {
  const TopTvShows({Key? key}) : super(key: key);

  @override
  State<TopTvShows> createState() => _TopTvShowsState();
}

class _TopTvShowsState extends State<TopTvShows> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<PopularTvShowResult>?>(
      future: DioService().fetchTopTvShows(),
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
                 setState(() {

                 });
                },
                child: const Text(
                  "Refresh",
                  style: TextStyle(color: Colors.red),
                ),
              )
            ],
          );
        } else {
          return SizedBox(
            height: 150,
            width: double.infinity,
            child: Padding(
              padding: const EdgeInsets.only(left: 10),
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                primary: true,
                physics: const ScrollPhysics(),
                itemCount: 10,
                itemBuilder: (BuildContext context, index) {
                  return GestureDetector(
                    onTap: () {
                      // Navigator.push(
                      //     context,
                      //     MaterialPageRoute(
                      //         builder: (context) => ScreenDetails(
                      //               name: snapShot.data![index].name,
                      //               description: snapShot.data![index].overview,
                      //               bannerUrl: snapShot.data![index].posterPath,
                      //               year: snapShot.data![index].firstAirDate
                      //                   .toString(),
                      //             )));

                      showModalBottomSheet(
                          isScrollControlled: true,
                          backgroundColor: Colors.black.withOpacity(0.6),
                          enableDrag: false,
                          context: context, builder: (context) => buildDescriptionSection(context,title: snapShot.data![index].originalName,desc: snapShot.data![index].overview,image: snapShot.data![index].posterPath,rating: snapShot.data![index].voteAverage,year: snapShot.data![index].firstAirDate));
                    },
                    child: Stack(
                      children: [
                        Row(
                          children: [
                            const SizedBox(
                              width: 30,
                            ),
                            SizedBox(
                              child: Image.network(
                                commonImagePath +
                                    snapShot.data![index].posterPath,fit: BoxFit.cover,
                              ),
                            ),
                            const SizedBox(
                              width: 2,
                            )
                          ],
                        ),
                        index !=0 ?
                        Positioned(
                          bottom: -18,
                          left: -7,
                          child: BorderedText(
                          strokeColor: Colors.white,
                            strokeWidth: 1.5,
                            child: Text((index+1).toString(),style:  const TextStyle(
                              fontSize: 76,
                              fontFamily: "rubik-m",
                              color: Colors.black,
                              decoration: TextDecoration.none,
                            ),),
                          )
                        )
                        :
                        Positioned(
                            bottom: -18,
                            left: 8,
                            child: BorderedText(
                              strokeColor: Colors.white,
                              strokeWidth: 1.5,
                              child: Text((index+1).toString(),style:  const TextStyle(
                                fontSize: 76,
                                fontFamily: "rubik-m",
                                color: Colors.black,
                                decoration: TextDecoration.none,
                              ),),
                            ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          );
        }
      },
    );
  }
}
