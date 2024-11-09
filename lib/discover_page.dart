import 'dart:convert';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:watchlog/discover_page/media_tile.dart';
import 'package:http/http.dart' as http;
import 'package:watchlog/tmdb_helper.dart';

class DiscoverPage extends StatefulWidget {
  const DiscoverPage({super.key});

  @override
  State<DiscoverPage> createState() => _DiscoverPageState();
}

class _DiscoverPageState extends State<DiscoverPage> {
  bool _onTVPage = true;
  final TMDBHelper _tmdbHelper = TMDBHelper();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: FutureBuilder(future: _tmdbHelper.getPopularThisWeek(_onTVPage), builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  var mediaList = snapshot.data?['results'];
                  return Row(
                      children: List<MediaTile>.generate(mediaList.length, (index) {
                    return MediaTile(mediaTitle: mediaList[index]['title'] ?? mediaList[index]['name'], mediaPoster: mediaList[index]['poster_path'], mediaRating: mediaList[index]['vote_average']);
                  }));
                } else {
                  return const CircularProgressIndicator();
                }
              })),
        ])),
        floatingActionButton: FloatingActionButton(
            onPressed: () {
              setState(() {
                _onTVPage = !_onTVPage;
              });
            },
            child: _onTVPage ? const Icon(Icons.movie) : const Icon(Icons.tv)));
  }
}
