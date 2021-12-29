import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:netflix/api_service/dio_service.dart';
import 'package:netflix/constants/constants.dart';
import 'package:netflix/models/model_popular_movies.dart';
import 'package:netflix/screen/screen_home/screen_details.dart';
import 'package:netflix/widgets/widgets.dart';

class SearchContent extends StatefulWidget {
  const SearchContent({Key? key}) : super(key: key);

  @override
  State<SearchContent> createState() => _SearchContentState();
}

class _SearchContentState extends State<SearchContent> {
  final TextEditingController _textEditingController = TextEditingController();
  String? searchQuery;
  Timer? _debounce;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(45),
        child: AppBar(
          backgroundColor: Colors.black,
          actions: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Image.asset(
                  "assets/images/netFlix_smiley.jpg",
                  height: 20,
                  width: 30,
                  fit: BoxFit.fill,
                ),
              ),
            ),
          ],
        ),
      ),
      body: GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: SingleChildScrollView(
          physics: const ScrollPhysics(),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              sizedh1,
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5),
                child: SizedBox(
                  height: 70,
                  width: MediaQuery.of(context).size.width - 10,
                  child: TextFormField(
                    controller: _textEditingController,
                    onChanged: (textValue) {
                      if(_debounce?.isActive??false) _debounce?.cancel();
                      _debounce = Timer(const Duration(milliseconds: 500),()
                      {
                        searchQuery = _textEditingController.text;
                        setState(() {
                        });
                      });
                    },
                    keyboardType: TextInputType.name,
                    decoration: InputDecoration(
                        filled: true,
                        focusColor: Colors.grey,
                        fillColor: Colors.grey.shade900,
                        prefixIcon: const Icon(
                          Icons.search,
                          color: Colors.white,
                        ),
                        suffixIcon: const Icon(
                          Icons.mic,
                          color: Colors.white,
                        ),
                        hintText: "Search for a show, movie, genre, etc.",
                        focusedBorder: InputBorder.none,
                        enabledBorder: InputBorder.none),
                  ),
                ),
              ),
              sizedh1,
              commonText(text: "\t\t\tTop Searches"),
              sizedh2,
              FutureBuilder<List<PopularMovieResult>?>(
                future: searchQuery == null || searchQuery == "" ? DioService().fetchPopularMovies(): DioService().searchPopularMovies(searchQuery),
                builder: (context, snapShot) {
                  debugPrint("SearchQuery getting in FutureBuilder is $searchQuery");
                  if (!snapShot.hasData) {
                    return Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Center(
                          child: CircularProgressIndicator(
                            color: Colors.red,
                            strokeWidth: 3.0,
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            const SearchContent();
                          },
                          child: const Text(
                            "Refresh",
                            style: TextStyle(color: Colors.red),
                          ),
                        ),
                      ],
                    );
                  } else {
                    return Flexible(
                      child: ListView.builder(
                        primary: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: snapShot.data!.length,
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => ScreenDetails(
                                            name: snapShot.data![index].title,
                                            description:
                                                snapShot.data![index].overview,
                                            bannerUrl:
                                                snapShot.data![index].posterPath,
                                            year: snapShot
                                                .data![index].releaseDate
                                                .toString(),
                                          )));
                            },
                            child: Padding(
                              padding: const EdgeInsets.only(bottom: 8),
                              child: ListTile(
                                tileColor: Colors.grey.shade900,
                                horizontalTitleGap: 10,
                                leading: Image.network(
                                  commonImagePath +
                                      snapShot.data![index].posterPath,
                                  fit: BoxFit.fitWidth,
                                  width: 100,
                                ),
                                title: Text(snapShot.data![index].title),
                                trailing: const Icon(
                                  Icons.play_circle_filled_rounded,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    );
                  }
                },
              ),
              const SizedBox(
                height: 30,
              )
            ],
          ),
        ),
      ),
    );
  }
  // onSearchChanged(TextEditingController searchQuery){
  //
  // }
}
