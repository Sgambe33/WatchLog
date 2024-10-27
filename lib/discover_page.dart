import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:watchlog/discover_page/media_tile.dart';
import 'package:http/http.dart' as http;

class DiscoverPage extends StatefulWidget {
  const DiscoverPage({super.key});

  @override
  State<DiscoverPage> createState() => _DiscoverPageState();
}

class _DiscoverPageState extends State<DiscoverPage> {
  bool _onTVPage = true;
  late Future<Map<String, dynamic>> _trendingFuture;
  late Future<Map<String, dynamic>> _returningFuture;

  @override
  void initState() {
    super.initState();
    _trendingFuture = _fetchTrending(_onTVPage, null, null, null, null, null, null, null);
    _returningFuture = _fetchTrending(_onTVPage, null, null, null, '2023-01-01', '2023-12-31', null, null); // Example parameters
  }

  Future<Map<String, dynamic>> _fetchTrending(bool fetchTv, String? maxDate, String? releaseDateMin, String? releaseDateMax, String? airDateMin, String? airDateMax, String? firstAirDateMin, String? firstAirDateMax) async {
    await dotenv.load(fileName: ".env");
    var url = Uri.https("api.themoviedb.org", "/3/discover/${fetchTv ? 'tv' : 'movie'}", {
      'include_adult': 'false',
      'include_video': 'false',
      'language': 'en-US',
      'page': '1',
      'sort_by': 'popularity.desc',
      'api_key': dotenv.env['TMDB_API_KEY'],
      'air_date.gte': airDateMin,
      'air_date.lte': airDateMax,
      'release_date.gte': releaseDateMin,
      'release_date.lte': releaseDateMax,
      //'first_air_date.gte': firstAirDateMin,
      //'first_air_date.lte': firstAirDateMax,
      'region': 'IT'
    });
    var response = await http.get(url);
    return jsonDecode(response.body);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const TextField(
              decoration: InputDecoration(
                icon: Icon(Icons.search),
                border: OutlineInputBorder(),
                hintText: 'Search for movies or TV shows',
              ),
            ),
            const Text("Trending", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            SizedBox(
              height: 200,
              child: FutureBuilder<Map<String, dynamic>>(
                future: _trendingFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  } else if (!snapshot.hasData || snapshot.data!['results'] == null) {
                    return const Center(child: Text('No data available'));
                  } else {
                    final movies = snapshot.data!['results'] as List<dynamic>;
                    movies.sort((a, b) => b['vote_average'].compareTo(a['vote_average']));
                    return ListView.builder(
                      itemBuilder: (context, index) {
                        final movie = movies[index];
                        return MediaTile(
                          mediaTitle: _onTVPage ? movie['name'] : movie['title'],
                          mediaPoster: movie['poster_path'],
                          mediaRating: movie['vote_average'].toDouble(),
                        );
                      },
                      itemCount: movies.length,
                      scrollDirection: Axis.horizontal,
                    );
                  }
                },
              ),
            ),
            if(_onTVPage)
              ...[
            const Text("Returning this week", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            SizedBox(
              height: 200,
              child: FutureBuilder<Map<String, dynamic>>(
                future: _returningFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  } else if (!snapshot.hasData || snapshot.data!['results'] == null) {
                    return const Center(child: Text('No data available'));
                  } else {
                    final movies = snapshot.data!['results'] as List<dynamic>;
                    movies.sort((a, b) => b['vote_average'].compareTo(a['vote_average']));
                    return ListView.builder(
                      itemBuilder: (context, index) {
                        final movie = movies[index];
                        return MediaTile(
                          mediaTitle: _onTVPage ? movie['name'] : movie['title'],
                          mediaPoster: movie['poster_path'],
                          mediaRating: movie['vote_average'].toDouble(),
                        );
                      },
                      itemCount: movies.length,
                      scrollDirection: Axis.horizontal,
                    );
                  }
                },
              ),
            )],
            const Text("New releases in October", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            SizedBox(
              height: 200,
              child: FutureBuilder<Map<String, dynamic>>(
                future: _fetchTrending(_onTVPage, null, '2024-10-01', '2024-10-31', null, null,'2024-10-01', '2024-10-31'),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  } else if (!snapshot.hasData || snapshot.data!['results'] == null) {
                    return const Center(child: Text('No data available'));
                  } else {
                    final movies = snapshot.data!['results'] as List<dynamic>;
                    movies.sort((a, b) => b['vote_average'].compareTo(a['vote_average']));
                    return ListView.builder(
                      itemBuilder: (context, index) {
                        final movie = movies[index];
                        return MediaTile(
                          mediaTitle: _onTVPage ? movie['name'] : movie['title'],
                          mediaPoster: movie['poster_path'],
                          mediaRating: movie['vote_average'].toDouble(),
                        );
                      },
                      itemCount: movies.length,
                      scrollDirection: Axis.horizontal,
                    );
                  }
                },
              ),
            ),
            const Text("All time popular", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            SizedBox(
              height: 200,
              child: FutureBuilder<Map<String, dynamic>>(
                future: _fetchTrending(_onTVPage, null, null, null, null, null, null, null),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  } else if (!snapshot.hasData || snapshot.data!['results'] == null) {
                    return const Center(child: Text('No data available'));
                  } else {
                    final movies = snapshot.data!['results'] as List<dynamic>;
                    movies.sort((a, b) => b['vote_average'].compareTo(a['vote_average']));
                    return ListView.builder(
                      itemBuilder: (context, index) {
                        final movie = movies[index];
                        return MediaTile(
                          mediaTitle: _onTVPage ? movie['name'] : movie['title'],
                          mediaPoster: movie['poster_path'],
                          mediaRating: movie['vote_average'].toDouble(),
                        );
                      },
                      itemCount: movies.length,
                      scrollDirection: Axis.horizontal,
                    );
                  }
                },
              ),
            ),
            const Text("Action", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const Text("Drama", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const Text("Horror", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const Text("Anime", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const Text("Adventure", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const Text("Comedy", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const Text("Crime", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const Text("Science Fiction", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            _onTVPage = !_onTVPage;
            _trendingFuture = _fetchTrending(_onTVPage, null, null, null, null, null,null, null);
            _returningFuture = _fetchTrending(_onTVPage, null, null, null, '2023-01-01', '2023-12-31',null, null); // Example parameters
          });
        },
        child: _onTVPage ? const Icon(Icons.movie) : const Icon(Icons.tv),
      ),
    );
  }
}