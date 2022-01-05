import 'package:flutter/material.dart';
import 'package:news/models/news_tile_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NewsTile extends StatefulWidget {
  final News newsObject;
  final List favs;
  const NewsTile({Key? key, required this.newsObject, required this.favs})
      : super(key: key);

  @override
  State<NewsTile> createState() => _NewsTileState();
}

class _NewsTileState extends State<NewsTile> {
  @override
  Widget build(BuildContext context) {
    void onTapped() async {
      SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      if (widget.newsObject.isFavourite!) {
        setState(() {
          widget.newsObject.isFavourite = false;
        });
        widget.favs.remove(widget.newsObject.id!);
      } else {
        setState(() {
          widget.newsObject.isFavourite = true;
        });
        widget.favs.add(widget.newsObject.id!);
      }
      List<String> toBeStored = widget.favs.map((e) => e.toString()).toList();
      sharedPreferences.setStringList('favs', toBeStored);
    }

    return Card(
      margin: const EdgeInsets.fromLTRB(15, 10, 15, 5),
      elevation: 6,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20))),
      child: ListTile(
        title: Padding(
          padding: const EdgeInsets.only(bottom: 8.0),
          child: Text(
            widget.newsObject.title!,
            style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 15),
          ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.newsObject.summary!,
              overflow: TextOverflow.ellipsis,
              maxLines: 3,
              style: const TextStyle(fontSize: 15, color: Colors.black),
            ),
            const SizedBox(
              height: 8,
            ),
            Text(
              widget.newsObject.published!,
              textAlign: TextAlign.start,
            ),
          ],
        ),
        contentPadding: const EdgeInsets.fromLTRB(10, 10, 10, 5),
        leading: IconButton(
          icon: Icon(widget.newsObject.isFavourite!
              ? Icons.favorite
              : Icons.favorite_border),
          color: widget.newsObject.isFavourite! ? Colors.red : null,
          iconSize: 40,
          onPressed: onTapped,
          alignment: Alignment.center,
        ),
      ),
    );
  }
}
