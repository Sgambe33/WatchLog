import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

class TMDBHelper {
  Future<Map<String, dynamic>> getPopularThisWeek(bool fetchTv) async {
    await dotenv.load(fileName: ".env");
    var url = Uri.https(
        "api.themoviedb.org",
        "/3/trending/${fetchTv ? 'tv' : 'movie'}/week",
        {'language': 'en-US', 'api_key': dotenv.env['TMDB_API_KEY']});
    var response = await http.get(url);
    //Sort the results by popularity
    List<dynamic> results = jsonDecode(response.body)['results'];
    results.sort((a, b) => b['vote_average'].compareTo(a['vote_average']));
    return {'results': results};
  }

  Future<Map<String, dynamic>> getGenre(int genreId, bool onTVPage) async {
    await dotenv.load(fileName: ".env");
    var url = Uri.https(
        "api.themoviedb.org", "/3/discover/${onTVPage ? 'tv' : 'movie'}", {
      'with_genres': genreId.toString(),
      'language': 'en-US',
      'api_key': dotenv.env['TMDB_API_KEY']
    });
    var response = await http.get(url);
    return jsonDecode(response.body);
  }

  Future<Map<String, dynamic>> getNewThisMonth(bool onTVPage) async {
    await dotenv.load(fileName: ".env");
    var url = Uri.https(
        "api.themoviedb.org", "/3/discover/${onTVPage ? 'tv' : 'movie'}", {
      if (onTVPage)
        'first_air_date.gte': DateTime.now()
            .subtract(const Duration(days: 30))
            .toString()
            .split(' ')[0],
      'first_air_date.lte': DateTime.now().toString().split(' ')[0],
      if (!onTVPage)
        'primary_release_date.gte': DateTime.now()
            .subtract(const Duration(days: 30))
            .toString()
            .split(' ')[0],
      'primary_release_date.lte': DateTime.now().toString().split(' ')[0],
      'language': 'en-US',
      'region': 'US',
      'api_key': dotenv.env['TMDB_API_KEY']
    });
    var response = await http.get(url);
    return jsonDecode(response.body);
  }

  Future<Map<String, dynamic>> getReturningThisWeek() async {
    await dotenv.load(fileName: ".env");
    var url = Uri.https("api.themoviedb.org", "/3/discover/tv", {
      'air_date.gte': DateTime.now()
          .subtract(const Duration(days: 30))
          .toString()
          .split(' ')[0],
      'air_date.lte': DateTime.now().toString().split(' ')[0],
      'language': 'en-US',
      'region': 'US',
      'api_key': dotenv.env['TMDB_API_KEY']
    });
    var response = await http.get(url);
    return jsonDecode(response.body);
  }

  Future<Map<String, dynamic>> getMediaDetailsById(
      int mediaId, bool isTV) async {
    await dotenv.load(fileName: ".env");
    var url = Uri.https(
        "api.themoviedb.org",
        "/3/${isTV ? 'tv' : 'movie'}/$mediaId",
        {'language': 'en-US', 'api_key': dotenv.env['TMDB_API_KEY']});
    var response = await http.get(url);
    return jsonDecode(response.body);
  }
}
