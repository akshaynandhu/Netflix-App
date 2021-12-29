import 'package:flutter/material.dart';
import 'package:fluttericon/typicons_icons.dart';
import 'package:netflix/constants/constants.dart';
import 'package:netflix/screen/screen_home/screen_details.dart';

commonText({text, color, size, weight, family,isCentered = false}) {
  return Text(
    text,
    textAlign: isCentered?TextAlign.center:TextAlign.left,
    style: TextStyle(
      color: color ?? Colors.white,
      fontWeight: weight ?? FontWeight.w600,
      fontSize: size ?? 13.2,
      fontFamily: 'poppins-el',
    ),
  );
}

commonHeadText({text, color, size, weight}) {
  return Text(
    text,
    style: TextStyle(
      color: color ?? Colors.white,
      fontWeight: weight ?? FontWeight.w600,
      fontSize: size ?? 15,
      fontFamily: 'poppins-l',
    ),
  );
}

bannerOptions({icon, text, color}) {
  return Column(
    children: [
      Icon(
        icon,
        color: color ?? Colors.white,
      ),
      commonText(text: text, color: color ?? Colors.white),
    ],
  );
}
const List<String> categorieItems = [
  "Home",
  "My List",
  "Available for Now",
  "The World of The Witcher",
  "Holidays",
  "Hindi",
  "Tamil",
  "Punjab",
  "Telugu",
  "Malayalam",
  "Marathi",
  "Bengali",
  "English",
  "Action",
  "Anime",
  "Award Winners",
  "Biography",
  "Blockbusters",
  "Bollywood",
  "Children & Family",
  "Comedies",
  "Documenteries",
  "Dramas",
  "Fantasy",
  "Hollywood",
  "Horror",
  "International",
  "Indian",
  "Music & Musicals",
  "Reality & Talk",
  "Romance",
  "Sci-Fi",
  "Stand-Up",
  "Thrillers",
  "United States",
  "Audio Description"
];

buildCategories(context) {
  return Stack(
    children: [
      Padding(
        padding: const EdgeInsets.only(top: 100),
        child: ListView.separated(
          itemCount: categorieItems.length,
          itemBuilder: (context, index) => Center(
            child: index!=0?commonText(
                text: categorieItems[index], weight: FontWeight.w400):commonText(
                text: categorieItems[index], weight: FontWeight.w800,size: 15.0),
          ),
          separatorBuilder: (context, index) => sizedh2,
        ),
      ),
      Positioned(
        bottom: 0,
        left: (MediaQuery.of(context).size.width/2)-20,
        child: FloatingActionButton(

            backgroundColor: Colors.white,
            child: const Icon(Icons.close),
            onPressed: () {
          Navigator.pop(context);
        }),
      )
    ],
  );
}

detailsPageIcons({icon,bgColor}) {
  return Container(
    height: 35,
    width: 35,
    decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(100), color: bgColor??Colors.black),
    child: Icon(
      icon,
      color: Colors.white,
      size: 21,
    ),
  );
}

detailsPageSymbols({text, color, size, isBorder = false}) {
  return Container(
    height: 17,
    width: 28,
    decoration: BoxDecoration(
      color: color,
      border: isBorder
          ? Border.all(width: 0.8, color: Colors.white70)
          : Border.all(),
      borderRadius: BorderRadius.circular(2),
    ),
    child: Center(
        child: Text(
      text,
      style: TextStyle(fontSize: size),
    )),
  );
}

detailsPageRow({text, bgcolor, color, icon}) {
  return Container(
    height: 40,
    margin: const EdgeInsets.symmetric(horizontal: 20),
    decoration:
        BoxDecoration(color: bgcolor, borderRadius: BorderRadius.circular(5)),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          icon,
          color: color ?? Colors.black,
        ),
        sizedw1,
        Text(
          text,
          style: TextStyle(
              color: color ?? Colors.black,
              fontWeight: FontWeight.w600,
              fontSize: 18),
        )
      ],
    ),
  );
}

detailsPageUerActions() {
  return Row(
    children: const [
      sizedw2,
      sizedw2,
      SizedBox(
        height: 60,
        width: 60,
        child: GridTile(
          child: Icon(Icons.add),
          footer: Text(
            "My list",
            textAlign: TextAlign.center,
          ),
        ),
      ),
      sizedw2,
      sizedw2,
      SizedBox(
        height: 60,
        width: 60,
        child: GridTile(
          child: Icon(Icons.thumb_up_alt_outlined),
          footer: Text(
            "Like",
            textAlign: TextAlign.center,
          ),
        ),
      ),
      sizedw2,
      sizedw2,
      SizedBox(
        height: 60,
        width: 60,
        child: GridTile(
          child: Icon(Icons.send),
          footer: Text(
            "Share",
            textAlign: TextAlign.center,
          ),
        ),
      ),
    ],
  );
}


extractGenres(List genresC){
  var genres = [
    {"id":28,"name":"Action"},{"id":12,"name":"Adventure"},{"id":16,"name":"Animation"},{"id":35,"name":"Comedy"},{"id":80,"name":"Crime"},{"id":99,"name":"Documentary"},{"id":18,"name":"Drama"},{"id":10751,"name":"Family"},{"id":14,"name":"Fantasy"},{"id":36,"name":"History"},{"id":27,"name":"Horror"},{"id":10402,"name":"Music"},{"id":9648,"name":"Mystery"},{"id":10749,"name":"Romance"},{"id":878,"name":"Science Fiction"},{"id":10770,"name":"TV Movie"},{"id":53,"name":"Thriller"},{"id":10752,"name":"War"},{"id":37,"name":"Western"}
  ];
  List<String> genreList = [];
  for(var i=0;i<genresC.length;i++) {
    var keys = genresC[i];
    for (var j = 0; j < genres.length; j++) {
      if (genres[j].containsValue(keys)) {
        genreList.add(genres[j]['name'].toString());
        break;
      }
    }
  }
  return genreList;
}



buildDescriptionSection(context, {image, title, DateTime? year, rating, desc}){
  return Container(
    height: 250,
    width: double.infinity,
    decoration: BoxDecoration(
        color: Colors.grey.shade800,
        borderRadius: const BorderRadius.only(
          topRight: Radius.circular(13),
          topLeft: Radius.circular(13),
        )
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        sizedh1,
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            sizedw1,
            ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: Image.network(commonImagePath+image,fit: BoxFit.contain,height: 130,),
            ),
            sizedw1,
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                sizedh2,
                commonHeadText(text: title),
                sizedh1,
                Row(
                  children: [
                    commonText(text: year!.year.toString(),color: Colors.grey.shade600),
                    sizedw2,
                    commonText(text: "Rating: $rating",color: Colors.grey.shade600),
                  ],
                ),
                sizedh1,
                SizedBox(
                  width: 250.0,
                  child: Text(
                    desc,
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                    softWrap: false,
                    style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w400,
                        fontSize: 11.0,
                        fontFamily: 'poppins-l'),
                  ),
                ),
              ],
            )
          ],
        ),
        sizedh1,
        Row(
          children: [
            sizedw1,
            Container(
              width: 170,
              height: 40,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(6)
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.play_arrow,color: Colors.black,),
                  commonHeadText(text: "Play",color: Colors.black)
                ],
              ),
            ),
            const SizedBox(
              width: 30,
            ),
            Column(
              children: [
                const Icon(Icons.download),
                commonHeadText(text: "Download"),
              ],
            ),
            const SizedBox(
              width: 30,
            ),
            Column(
              children: [
                const Icon(Icons.play_arrow),
                commonHeadText(text: "Preview"),
              ],
            ),
          ],
        ),
        const Divider(thickness: 1.2,),
        GestureDetector(
          onTap:(){
            Navigator.pop(context);
            Navigator.push(context, MaterialPageRoute(builder: (context) => ScreenDetails(name: title,description: desc,bannerUrl: image,year: year.toString(),)));
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  sizedw1,
                  const Icon(Icons.info),
                  sizedw1,
                  commonText(text: "Details"),
                ],
              ),
              const Icon(Typicons.right_small,),
            ],
          ),
        ),
      ],
    ),
  );
}