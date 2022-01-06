import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:news/models/news_tile_model.dart';

import 'news_tile.dart';

List<News> news = [];
// ignore: prefer_typing_uninitialized_variables
var newsData;

Future<dynamic> getData(List favs) async {
  news = [];
  Response response =
      await get(Uri.parse("https://api.first.org/data/v1/news"));
  if (response.statusCode == 200) {
    String data = response.body;
    newsData = jsonDecode(data);
    if (newsData['status'] == 'OK') {
      newsData['data'].forEach((element) {
        News newsObject = News(
          id: element['id'],
          title: element['title'],
          link: element['link'],
          published: element['published'],
          isFavourite: favs.contains(element['id']) ? true : false,
          summary: element['summary'] ?? '',
        );
        news.add(newsObject);
      });
    }
  } else {
    // ignore: avoid_print
    print('Something went wrong');
  }
}

setFavs(List favs) {
  for (var element in news) {
    element.isFavourite = favs.contains(element.id) ? true : false;
  }
}

class NewsScreen extends StatefulWidget {
  final List favs;
  const NewsScreen({Key? key, required this.favs}) : super(key: key);

  @override
  _NewsScreenState createState() => _NewsScreenState();
}

class _NewsScreenState extends State<NewsScreen> {
  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        await getData(widget.favs);
      },
      child: ListView.builder(
          physics: const BouncingScrollPhysics(),
          itemCount: news.length,
          itemBuilder: (context, index) {
            setFavs(widget.favs);
            return NewsTile(
              newsObject: news[index],
              favs: widget.favs,
            );
          }),
    );
  }
}

class LoadingScreen extends StatefulWidget {
  final List favs;
  const LoadingScreen({Key? key, required this.favs}) : super(key: key);

  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: getData(widget.favs),
        builder: (context, snapshot) {
          return snapshot.connectionState == ConnectionState.done
              ? NewsScreen(favs: widget.favs)
              : const Center(child: CircularProgressIndicator());
        });
  }
}
