import 'package:flutter/material.dart';
import 'package:news/models/news_tile_model.dart';
import 'package:news/widgets/news_screen.dart';
import 'package:news/widgets/news_tile.dart';

class Favourites extends StatefulWidget {
  final List favs;
  const Favourites({Key? key, required this.favs}) : super(key: key);

  @override
  _FavouritesState createState() => _FavouritesState();
}

class _FavouritesState extends State<Favourites> {
  News findObject(int index) {
    int i = 0;
    while (newsData['data'][i]['id'] != widget.favs[index]) {
      i++;
    }
    News newObject = News(
      id: newsData['data'][i]['id'],
      title: newsData['data'][i]['title'],
      published: newsData['data'][i]['published'],
      link: newsData['data'][i]['link'],
      isFavourite: true,
      summary: newsData['data'][i]['summary'] ?? '',
    );
    return newObject;
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: widget.favs.length,
        itemBuilder: (context, index) {
          return NewsTile(newsObject: findObject(index), favs: widget.favs);
        });
  }
}
