import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
// import 'package:example/content.dart';
import 'package:swipe_cards/draggable_card.dart';
import 'package:swipe_cards/swipe_cards.dart';
import 'dart:math';
class Content {
  final String text;
  // final Color color;
  final Image img;
  Content({
    required this.text,
    //  required this.color,
      required this.img});
}

class HomePage extends StatefulWidget {
  const   HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<SwipeItem> _swipeItems = <SwipeItem>[];
  MatchEngine? _matchEngine;
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
  List<String> _names = [
    "Red",
    "Blue",
    "Green",
    "Yellow",
    "Orange",
    "Grey",
    "Purple",
    "Pink"
  ];
  List<Image> _imgname = [
    //  Image(image: AssetImage('assets/videos/book1.mp4',)),
    // Image(image: AssetImage('assets/img/ai.jpg')),
    Image(image: AssetImage('assets/img/tom.jpg')),
    Image(image: AssetImage('assets/img/tom.jpg')),
    Image(image: AssetImage('assets/img/hamlet.jpg')),
    Image(image: AssetImage('assets/img/prideprejudes.jpg')),
    Image(image: AssetImage('assets/img/crimepunishment.jpg')),
    Image(image: AssetImage('assets/img/warpeace.jpg')),
  ];

  List<Color> _colors = [
    Colors.red,
    Colors.blue,
    Colors.green,
    Colors.yellow,
    Colors.orange,
    Colors.grey,
    Colors.purple,
    Colors.pink
  ];
  

 

void initState() {
  int minLength = min(_names.length, _imgname.length); // Get the smaller length
  for (int i = 0; i < minLength; i++) {
    _swipeItems.add(SwipeItem(
      content: Content(
        text: _names[i],
        img: _imgname[i], // Use the corresponding image
      ),
      likeAction: () {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text("Liked ${_names[i]}"),
          duration: Duration(milliseconds: 500),
        ));
      },
      nopeAction: () {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text("Nope ${_names[i]}"),
          duration: Duration(milliseconds: 500),
        ));
      },
      superlikeAction: () {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text("Superliked ${_names[i]}"),
          duration: Duration(milliseconds: 500),
        ));
      },
      onSlideUpdate: (SlideRegion? region) async {
        print("Region $region");
      },
    ));
  }

  _matchEngine = MatchEngine(swipeItems: _swipeItems);
  super.initState();
}

 
  @override
  Widget build(BuildContext context) {
    return Scaffold(

    key: _scaffoldKey,
        body: Container(
            child: Stack(children: [
          Container(
            height: MediaQuery.of(context).size.height - kToolbarHeight,
            child: SwipeCards(
              matchEngine: _matchEngine!,
              itemBuilder: (BuildContext context, int index) {
  return Container(
    alignment: Alignment.center,
    child: _swipeItems[index].content.img,  // Display the image here
  );
},

              onStackFinished: () {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text("Stack Finished"),
                  duration: Duration(milliseconds: 500),
                ));
              },
              itemChanged: (SwipeItem item, int index) {
                print("item: ${item.content.text}, index: $index");
              },
              leftSwipeAllowed: true,
              rightSwipeAllowed: true,
              upSwipeAllowed: true,
              fillSpace: true,
              likeTag: Container(
                margin: const EdgeInsets.all(15.0),
                padding: const EdgeInsets.all(3.0),
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.green)
                ),
                child: Text('Like'),
              ),
              nopeTag: Container(
                margin: const EdgeInsets.all(15.0),
                padding: const EdgeInsets.all(3.0),
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.red)
                ),
                child: Text('Nope'),
              ),
              superLikeTag: Container(
                margin: const EdgeInsets.all(15.0),
                padding: const EdgeInsets.all(3.0),
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.orange)
                ),
                child: Text('Super Like'),
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                    onPressed: () {
                      _matchEngine!.currentItem?.nope();
                    },
                    child: Text("Nope")),
                ElevatedButton(
                    onPressed: () {
                      _matchEngine!.currentItem?.superLike();
                    },
                    child: Text("Superlike")),
                ElevatedButton(
                    onPressed: () {
                      _matchEngine!.currentItem?.like();
                    },
                    child: Text("Like"))
              ],
            ),
          )
        ]))
    );
  }
}