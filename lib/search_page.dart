import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:watchlog/discover_page/media_tile.dart';
import 'package:http/http.dart' as http;

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  List<dynamic> _searchResults = [];
  final TextEditingController _searchController = TextEditingController();
  final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _focusNode.requestFocus();
  }

  Future<void> _searchMedia(String query) async {
    await dotenv.load(fileName: ".env");

    // Fetch movies
    var movieUrl = Uri.https("api.themoviedb.org", "/3/search/movie", {
      'query': query,
      'include_adult': 'false',
      'language': 'en-US',
      'page': '1',
      'api_key': dotenv.env['TMDB_API_KEY'],
    });
    var movieResponse = await http.get(movieUrl);
    var movieResults = jsonDecode(movieResponse.body)['results'];

    // Fetch TV series
    var tvUrl = Uri.https("api.themoviedb.org", "/3/search/tv", {
      'query': query,
      'include_adult': 'false',
      'language': 'en-US',
      'page': '1',
      'api_key': dotenv.env['TMDB_API_KEY'],
    });
    var tvResponse = await http.get(tvUrl);
    var tvResults = jsonDecode(tvResponse.body)['results'];

    // Combine results
    setState(() {
      _searchResults = [...movieResults, ...tvResults];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Search"),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _searchController,
              focusNode: _focusNode,
              decoration: const InputDecoration(
                hintText: 'Search for movies or TV shows',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.search),
              ),
              onSubmitted: (query) {
                _searchMedia(query);
              },
            ),
          ),
          Expanded(
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.7,
              ),
              itemCount: _searchResults.length,
              itemBuilder: (context, index) {
                final media = _searchResults[index];
                return MediaTile(
                  mediaTitle: media['title'] ?? media['name'],
                  mediaPoster: media['poster_path'],
                  mediaRating: media['vote_average'].toDouble(),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}