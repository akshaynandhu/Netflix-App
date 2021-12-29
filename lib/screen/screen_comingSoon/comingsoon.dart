import 'package:flutter/material.dart';
import 'package:fluttericon/octicons_icons.dart';
import 'package:netflix/api_service/dio_service.dart';
import 'package:netflix/constants/constants.dart';
import 'package:netflix/models/model_popular_movies.dart';
import 'package:netflix/widgets/widgets.dart';
import 'package:intl/intl.dart';

class ComingSoon extends StatelessWidget {
  const ComingSoon({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        body: Stack(
          children: [
            const ComingSoonItem(),
            Positioned(
              top: 10,
              child: SizedBox(
                height: 30,
                width: 60,
                child: Image.asset(
                  "assets/images/netFlixLogo.png",
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ComingSoonItem extends StatelessWidget {
  const ComingSoonItem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
                var releaseData = parseMonth(snapShot.data![index].releaseDate);
                return SizedBox(
                  height: MediaQuery.of(context).size.height * 0.8,
                  width: double.infinity,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        child: Stack(
                          children: [
                            Image.network(
                              commonImagePath +
                                  snapShot.data![index].posterPath,
                              height: MediaQuery.of(context).size.height * 0.4,
                              width: double.infinity,
                              fit: BoxFit.cover,
                            ),
                            Positioned(
                              top: 115,
                              left: 180,
                              child: Container(
                                height: 40,
                                width: 40,
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    border: Border.all(color: Colors.white)),
                                child: const Icon(Icons.play_arrow),
                              ),
                            ),
                            Positioned(
                              right: 10,
                              bottom: 15,
                              child: detailsPageIcons(
                                  icon: Octicons.mute,
                                  bgColor: Colors.black.withOpacity(0.3)),
                            )
                          ],
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          SizedBox(
                            height: 60,
                            width: 90,
                            child: GridTile(
                              child: const Icon(
                                Icons.notifications_outlined,
                                size: 20,
                              ),
                              footer: commonText(
                                  text: "Remind Me",
                                  isCentered: true,
                                  size: 11.0),
                            ),
                          ),
                          SizedBox(
                            height: 60,
                            width: 90,
                            child: GridTile(
                              child: const Icon(
                                Icons.info_outline,
                                size: 20,
                              ),
                              footer: commonText(
                                  text: "Info", isCentered: true, size: 11.0),
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10),
                        child: commonText(
                            text:
                                "Coming on ${releaseData[1]} ${releaseData[0]}"),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 10, bottom: 4),
                        child: commonHeadText(
                          text: snapShot.data![index].title,
                          size: 16.0,
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(left: 10, bottom: 4),
                          child: commonText(
                              text: snapShot.data![index].overview,
                              size: 12.0,
                              weight: FontWeight.w400),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 10, bottom: 10,top: 10),
                        child: parseGenre(
                            extractGenres(snapShot.data![index].genreIds),
                            context),
                      ),
                    ],
                  ),
                );
              },
              separatorBuilder: (context, index) => sizedh2);
        }
      },
    );
  }

  parseMonth(DateTime mix) {
    var fSplite = mix.month;
    var monDate = [
      DateFormat('MMMM').format(DateTime(0, fSplite)).toString(),
      fSplite.toString()
    ];
    return monDate;
  }

  parseGenre(List list, context) {
    return SizedBox(
      height: 30,
      child: ListView.separated(
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            return commonText(
              text: list[index],
            );
          },
          separatorBuilder: (context, index) =>
              commonText(text: "\t•\t", color: Colors.green),
          itemCount: list.length),
    );
  }
}
