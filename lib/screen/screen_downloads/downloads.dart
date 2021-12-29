import 'dart:math';

import 'package:flutter/material.dart';
import 'package:fluttericon/entypo_icons.dart';
import 'package:netflix/api_service/dio_service.dart';
import 'package:netflix/constants/constants.dart';
import 'package:netflix/external_icons/search_icon_external.dart';
import 'package:netflix/models/model_popular_movies.dart';
import 'package:netflix/widgets/widgets.dart';

class Downloads extends StatelessWidget {
  const Downloads({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leadingWidth: 100.0,
        leading: Center(
          child: commonHeadText(
            text: "Downloads",
          ),
        ),
        actions: [
          const Icon(SearchIconExternal.search_1),
          sizedw1,
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: ExactAssetImage(
                  "assets/images/netFlix_smiley.jpg",
                ),
              ),
            ),
            height: 22,
            width: 22,
          ),
          sizedw2,
        ],
      ),
      body: ListView(
        // crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                commonHeadText(text: "\t\tSmart Downloads"),
                const Icon(Icons.edit),
              ],
            ),
          ),

          const ListTile(
            title: Text('Finch',style: TextStyle(color: Colors.white),),
            subtitle: Text('18+ | 5 Episodes | 4.8 GB',style: TextStyle(color: Colors.grey),),
            leading: Image(image: NetworkImage('https://i0.wp.com/cinemaholics.com/wp-content/uploads/2021/11/kG04DvnwU6YbVECWWxn0f61cBke.jpg?resize=1920%2C1080&ssl=1'),),
            trailing: Icon(Icons.chevron_right_outlined,color: Colors.grey,size: 35,),
          ),

          // sizedh2,
          // Row(
          //   children: [
          //     sizedw1,
          //     Container(
          //       padding: const EdgeInsets.all(10),
          //       decoration: const BoxDecoration(
          //         image: DecorationImage(
          //           image: ExactAssetImage(
          //             "assets/images/netFlix_smiley.jpg",
          //           ),
          //         ),
          //       ),
          //       height: 22,
          //       width: 22,
          //     ),
          //     sizedw1,
          //     commonHeadText(text: "Vivek"),
          //   ],
          // ),
          // sizedh2,
          // downloadedItems(),
          // sizedh2,
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Divider(
              thickness: 0.3,
              color: Colors.white70,
            ),
          ),
          sizedh1,
          commonHeadText(text: "\t\tIntroducing Downloads for you"),
          sizedh1,
          Padding(
            padding: const EdgeInsets.all(10),
            child: commonText(
                text: downloadHighlight, color: Colors.grey.shade600),
          ),
          Center(
            child: Container(
              width: 250,
              height: 250,
              decoration: const BoxDecoration(
                  color: Color(0xff303030), shape: BoxShape.circle),
              child: Stack(
                clipBehavior: Clip.none,
                children: <Widget>[
                  Positioned(
                      top: 55,
                      left: -10,
                      child: RotationTransition(
                        turns: const AlwaysStoppedAnimation(329 / 360),
                        child: SizedBox(
                          height: 165,
                          width: 140,
                          child: Image.asset(
                              "assets/downloadshighlight/beast.jpg"),
                        ),
                      )),
                  Positioned(
                      top: 65,
                      left: 120,
                      child: RotationTransition(
                        turns: const AlwaysStoppedAnimation(380 / 360),
                        child: SizedBox(
                          height: 165,
                          width: 140,
                          child:
                              Image.asset("assets/downloadshighlight/cherry.jfif"),
                        ),
                      )),
                  Positioned(
                      left: 55,
                      top: 35,
                      child: SizedBox(
                        height: 190,
                        width: 140,
                        child: Image.asset("assets/downloadshighlight/rrr.jpg"),
                      ),),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: const Color.fromRGBO(50, 84, 168,1)
              ),
              onPressed: (){},
              child: commonHeadText(text: "SET UP"),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 100,vertical: 20),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(

                  primary: Colors.grey.shade800
              ),
              onPressed: (){},
              child: commonHeadText(text: "Find more to download",size: 13.0),
            ),
          )
        ],
      ),
    );
  }

  downloadedItems() {
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
                child: const Text(
                  "Refresh",
                  style: TextStyle(color: Colors.red),
                ),
              ),
            ],
          );
        } else {
          return SizedBox(
            height: MediaQuery.of(context).size.height * 0.64,
            width: MediaQuery.of(context).size.width - 20,
            child: ListView.separated(
              shrinkWrap: true,
              primary: true,
              itemCount: 5,
              itemBuilder: (BuildContext context, index) {
                Random random = Random();
                int rMovies = random.nextInt(snapShot.data!.length);
                return ListTile(
                  isThreeLine: true,
                  leading: Image.network(
                    commonImagePath + snapShot.data![rMovies].backdropPath,
                    height: 80,
                    width: 150,
                    fit: BoxFit.fill,
                  ),
                  subtitle: Row(
                    children: [
                      commonText(
                          text: snapShot.data![rMovies].adult ? "18+ |" : "",
                          size: 11.5,
                          color: Colors.grey.shade600),
                      commonText(
                          text: "5 Episodes | ",
                          size: 11.5,
                          color: Colors.grey.shade600),
                      commonText(
                          text: "4.8 GB",
                          size: 11.2,
                          color: Colors.grey.shade600),
                    ],
                  ),
                  title: Text(
                    snapShot.data![rMovies].title,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    softWrap: false,
                    style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                        fontSize: 13.5,
                        fontFamily: 'poppins-l'),
                  ),

                  // commonHeadText(text: snapShot.data![rMovies].title,weight: FontWeight.w500,size: 13.5),

                  trailing: Transform.scale(
                    scale: 0.7,
                    child: IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.arrow_forward_ios_rounded),
                    ),
                  ),
                );
              },
              separatorBuilder: (context, index) => sizedh1,
            ),
          );
        }
      },
    );
  }
}
