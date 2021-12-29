import 'package:flutter/material.dart';
import 'package:netflix/constants/constants.dart';
import 'package:netflix/external_icons/search_icon_external.dart';
import 'package:netflix/screen/screen_home/screen_popular_movies.dart';
import 'package:netflix/screen/screen_home/screen_search.dart';
import 'package:netflix/screen/screen_home/screen_top_rated_movies.dart';
import 'package:netflix/screen/screen_home/screen_top_tvshows.dart';
import 'package:netflix/widgets/widgets.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  CustomScrollView(
          slivers: [
            SliverAppBar(
              backgroundColor: Colors.transparent,
              floating: true,
              expandedHeight: 450,
              toolbarHeight: 80,
              flexibleSpace: FlexibleSpaceBar(
                background: Image.network(
                  "https://www.keralatv.in/media/2021/09/Malayalam-OTT-Releases.jpg",
                  fit: BoxFit.cover,
                  width: double.infinity,
                ),
              ),
              title: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Image.asset(
                        "assets/images/netFlixLogo.png",
                        height: 30,
                        width: 30,
                        fit: BoxFit.cover,
                      ),
                      Row(
                        children: [
                          IconButton(
                            onPressed: () {
                              Navigator.push(context, MaterialPageRoute(builder: (context) => const SearchContent()));
                            },
                            icon:  const Icon(
                              SearchIconExternal.search_1,
                              size: 28,
                            ),
                          ),
                          ClipRRect(
                              borderRadius: BorderRadius.circular(5),
                              child: Image.asset(
                                "assets/images/netFlix_smiley.jpg",
                                height: 30,
                                width: 30,
                                fit: BoxFit.cover,
                              )),
                        ],
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      commonHeadText(
                          text: "TV Shows",),
                      commonHeadText(
                          text: "Movies"),
                      Row(
                        children: [
                          commonHeadText(
                              text: "Categories"),
                          IconButton(onPressed: (){
                            showModalBottomSheet(
                                isScrollControlled: true,
                                backgroundColor: Colors.black.withOpacity(0.6),
                                isDismissible: false,
                                enableDrag: false,
                                context: context, builder: (context) => buildCategories(context));
                          },
                              icon: const Icon(Icons.arrow_drop_down)),
                        ],
                      ),
                    ],
                  )
                ],
              ),
            ),
            SliverToBoxAdapter(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  sizedh2,
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 18.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        sizedw1,
                        commonText(text: "\tAction\t",family: 'poppins-el'),
                        commonText(
                          text: "•",
                          color: Colors.white38,
                        ),
                        commonText(text: "\tAdventure\t"),
                      ],
                    ),
                  ),
                  sizedh2,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      bannerOptions(icon: Icons.add, text: "My List"),
                      Container(
                        width: 80,
                        height: 40,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(3)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            const Icon(Icons.play_arrow, color: Colors.black),
                            commonHeadText(text: "Play", color: Colors.black,weight: FontWeight.w800),
                          ],
                        ),
                      ),
                      // bannerOptions(icon: Icons.play_arrow,text: "Play",),),
                      bannerOptions(icon: Icons.info_outline, text: "Info"),
                    ],
                  ),

                  sizedh2,
                  commonHeadText(text: "\t\t\t\tTop 10 Rated in India"),
                  sizedh2,
                  const TopTvShows(),
                  sizedh2,
                  commonHeadText(text: "\t\t\t\tTop on Netflix",),
                  sizedh2,
                  const PopularMovies(),
                  sizedh2,
                  commonHeadText(text: "\t\t\t\tTrending Movies"),
                  sizedh2,
                  const TopRatedMovies(),
                  const SizedBox(
                    height: 40,
                  ),

                ],
              ),
            ),
          ],
    );
  }
}
