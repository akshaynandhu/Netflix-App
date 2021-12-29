import 'package:flutter/material.dart';
import 'package:fluttericon/elusive_icons.dart';
import 'package:netflix/api_service/dio_service.dart';
import 'package:netflix/constants/constants.dart';
import 'package:netflix/models/model_popular_movies.dart';
import 'package:netflix/widgets/widgets.dart';

class FastLaugh extends StatelessWidget {
  const FastLaugh({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return FutureBuilder<List<PopularMovieResult>?>(
      future: DioService().fetchPopularMovies(),
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
                onPressed: () {},
                child: const Text(
                  "Refresh",
                  style: TextStyle(color: Colors.red),
                ),
              )
            ],
          );
        } else {
          return ListView.separated(
            primary: true,
            physics: const ScrollPhysics(),
            itemCount: snapShot.data!.length,
            itemBuilder: (BuildContext context, index) {
              return Stack(
                children: [
                  SizedBox(
                    width: width,
                    height: height * 0.883,
                    child: Image.network(
                      commonImagePath + snapShot.data![index].posterPath,
                      fit: BoxFit.cover,
                      filterQuality: FilterQuality.high,
                    ),
                  ),
                  Positioned(
                    top: 15,
                    right: 20,
                    child: Container(
                      width: 30,
                      height: 25,
                      color: Colors.black,
                      child: Center(
                        child: commonHeadText(text: '16+',),
                      ),
                    )
                  ),

                  Positioned(
                    top: 15,
                    left: 20,
                    child: commonHeadText(text: snapShot.data![index].title),
                  ),

                  Positioned(
                    right: 20,
                    bottom: 0,
                    child: Column(
                      children: [
                        // Container(
                        //   height: 35,
                        //   width: 30,
                        //   decoration: const BoxDecoration(
                        //     shape: BoxShape.circle,
                        //     image: DecorationImage(
                        //       image: ExactAssetImage(
                        //           "assets/images/netFlix_smiley.jpg"),
                        //     ),
                        //   ),
                        // ),
                        fastLaughItems(
                            icon: Icons.insert_emoticon, text: "${snapShot.data![index].voteAverage} k"),
                        sizedh2,
                        fastLaughItems(
                            icon: Icons.add, text: "My List"),
                        sizedh2,
                        fastLaughItems(
                            icon: Icons.send, text: "Share"),
                        sizedh2,
                        fastLaughItems(
                            icon: Icons.play_arrow, text: "Play"),
                      ],
                    ),
                  ),
                ],
              );
            },
            separatorBuilder: (context, index) => sizedw1,
          );
        }
      },
    );
  }

  fastLaughItems({icon, text}) {
    return Column(
      children: [
        Icon(
          icon,
        ),
        commonText(text: text),
      ],
    );
  }
}
