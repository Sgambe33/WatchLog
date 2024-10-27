import 'package:flutter/material.dart';
import 'package:tmdb_api/tmdb_api.dart';
import 'package:watchlog/watchlist_movie_tile.dart';
import 'tmdb_service.dart';

class WatchlistPage extends StatefulWidget {
  const WatchlistPage({super.key});

  @override
  State<WatchlistPage> createState() => _WatchlistPageState();
}

class _WatchlistPageState extends State<WatchlistPage> {
  late Future<Map> _initialization;

  Future<Map> _initializeAndFetchMovies() async {
    try {
      if(!TMDBService().initialized) {
        await TMDBService().initialize();
      }
      Map result = await TMDBService().tmdb.v3.trending.getTrending(mediaType: MediaType.movie, timeWindow: TimeWindow.week);
      return result;
    } catch (e) {
      print('Error fetching trending movies: $e');
      throw Exception('Failed to fetch trending movies');
    }
  }

  @override
  void initState() {
    super.initState();
    _initialization = _initializeAndFetchMovies();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Map>(
      future: _initialization,
      builder: (BuildContext context, AsyncSnapshot<Map> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error?.toString() ?? 'Unknown error'}'));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(child: Text('No data available'));
        } else {
          return ListView.builder(
            itemCount: snapshot.data!['results'].length,
            itemBuilder: (context, index) {
              var movie = snapshot.data!['results'][index];
              return WatchlistMovieTile(movieData: movie);
            },
          );
        }
      },
    );
  }
}