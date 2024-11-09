import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

class TMDBHelper {
  Future<Map<String, dynamic>> getPopularThisWeek(bool fetchTv) async {
    await dotenv.load(fileName: ".env");
    var url = Uri.https("api.themoviedb.org", "/3/trending/${fetchTv ? 'tv' : 'movie'}/week", {'language': 'en-US', 'api_key': dotenv.env['TMDB_API_KEY']});
    var response = await http.get(url);
    return jsonDecode(response.body);
  }
}
