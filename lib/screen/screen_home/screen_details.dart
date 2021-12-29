import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:netflix/constants/constants.dart';
import 'package:netflix/screen/screen_home/screen_popular_movies.dart';
import 'package:netflix/widgets/widgets.dart';
import 'package:fluttericon/octicons_icons.dart';

class ScreenDetails extends StatelessWidget {
  const ScreenDetails({Key? key, this.name, this.description, this.bannerUrl,this.isAdult = false, this.year, this.cast =" ", this.creator =" "}) : super(key: key);

  final String? name, description, bannerUrl,year,cast,creator;
  final isAdult;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 280,
                width: MediaQuery.of(context).size.width,
                child: Stack(
                  children: [
                    SizedBox(
                      width: double.infinity,
                      height: 280,
                      child: Image.network(
                        commonImagePath+bannerUrl!,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        detailsPageIcons(icon: Icons.cast),
                        sizedw1,
                        detailsPageIcons(icon: Icons.close),
                      ],
                    ),
                    Positioned(
                        bottom: 17,
                        width: MediaQuery.of(context).size.width,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              commonText(text: "Preview"),
                              detailsPageIcons(icon: Octicons.mute),
                            ],
                          ),
                        )),
                  ],
                ),
              ),
              sizedh2,
              commonText(text: "\t\t\t\t\t$name"),
              sizedh1,
              Row(
                children: [
                  sizedw2,
                  commonText(text: "99% match", color: Colors.green),
                  sizedw1,
                  commonText(text: year!.split("-")[0],),
                  sizedw1,
                  detailsPageSymbols(
                      text: isAdult?"18+":'E', color: Colors.grey.shade700, size: 12.0),
                  sizedw1,
                  commonText(text: "6 Season"),
                  sizedw1,
                  detailsPageSymbols(text: "HD", isBorder: true),
                ],
              ),
              sizedh2,
              detailsPageRow(
                  text: "Play", icon: Icons.play_arrow, bgcolor: Colors.white),
              sizedh2,
              detailsPageRow(
                  text: "Download",
                  icon: Icons.download,
                  color: Colors.white,
                  bgcolor: Colors.grey.shade800),
              sizedh2,
              Padding(
                padding: padding,
                child: commonText(
                    text: description),
              ),
              sizedh2,
              Padding(
                padding: padding,
                child: Row(
                  children: [
                    commonText(text: "Cast : ", color: Colors.grey.shade600),
                    SizedBox(
                      width: 250.0,
                      child: Text(
                        cast!,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        softWrap: false,
                        style: TextStyle(
                            color: Colors.grey.shade600,
                            fontWeight: FontWeight.w400,
                            fontSize: 15.0),
                      ),
                    ),
                  ],
                ),
              ),
              sizedh1,
              Padding(
                padding: padding,
                child: Row(
                  children: [
                    commonText(text: "Creator : ", color: Colors.grey.shade600),
                    SizedBox(
                      width: 250.0,
                      child: Text(
                        creator!,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        softWrap: false,
                        style: TextStyle(
                            color: Colors.grey.shade600,
                            fontWeight: FontWeight.w400,
                            fontSize: 15.0),
                      ),
                    ),
                  ],
                ),
              ),
              detailsPageUerActions(),
              sizedh1,
              divider,
              sizedh2,
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  children: [
                    commonText(text: "Episodes"),
                    sizedw2,
                    commonText(
                        text: "More Like This", color: Colors.grey.shade600),
                  ],
                ),
              ),
              sizedh2,
              const PopularMovies(),
              const SizedBox(
                height: 30,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
