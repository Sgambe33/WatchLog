import 'package:tmdb_api/tmdb_api.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class TMDBService {
  static final TMDBService _instance = TMDBService._internal();
  late final TMDB tmdb;
  bool _initialized = false;

  factory TMDBService() {
    return _instance;
  }

  TMDBService._internal();

  Future<void> initialize() async {
    if (!_initialized) {
      await dotenv.load(fileName: ".env");
      tmdb = TMDB(ApiKeys(dotenv.env['TMDB_API_KEY']!, "apiReadAccessTokenv4"));
      _initialized = true;
    }
  }

  bool get initialized => _initialized;
}