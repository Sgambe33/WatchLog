import 'package:flutter/material.dart';
import 'package:watchlog/utils/constants.dart';
import 'package:watchlog/pages/discover_page/media_tile.dart';
import 'package:watchlog/utils/tmdb_helper.dart';

import 'discover_page/tvseries_detail.dart';

class DiscoverPage extends StatefulWidget {
  const DiscoverPage({super.key});

  @override
  State<DiscoverPage> createState() => _DiscoverPageState();
}

class _DiscoverPageState extends State<DiscoverPage> {
  bool _onTVPage = true;
  final TMDBHelper _tmdbHelper = TMDBHelper();
  final String _currentMonth = months[DateTime.now().month - 1];

  @override
  void initState() {
    super.initState();
  }

  Widget _buildGenreSection(String title, int genreId) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: const TextStyle(fontSize: 24)),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: FutureBuilder(
            future: _tmdbHelper.getGenre(genreId, _onTVPage),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                var mediaList = snapshot.data?['results'];
                return Row(
                  children: List<InkWell>.generate(mediaList.length, (index) {
                    return InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => TVSeriesDetail(
                                tvSeriesId: mediaList[index]['id']),
                          ),
                        );
                      },
                      child: MediaTile(
                        mediaTitle: mediaList[index]['title'] ??
                            mediaList[index]['name'],
                        mediaPoster: mediaList[index]['poster_path'],
                        mediaRating: mediaList[index]['vote_average'],
                      ),
                    );
                  }),
                );
              } else {
                return const SizedBox(
                  height: 200, // Adjust the height as needed
                  child: Center(child: CircularProgressIndicator()),
                );
              }
            },
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final genres = _onTVPage
        ? {
            'Action & Adventure': SerieGenres.ActionAdventure.id,
            'Drama': SerieGenres.Drama.id,
            'Mystery': SerieGenres.Mystery.id,
            'Animation': SerieGenres.Animation.id,
            'Comedy': SerieGenres.Comedy.id,
            'Crime': SerieGenres.Crime.id,
            'Science Fiction': SerieGenres.SciFiFantasy.id,
          }
        : {
            'Action': MovieGenres.Action.id,
            'Drama': MovieGenres.Drama.id,
            'Horror': MovieGenres.Horror.id,
            'Adventure': MovieGenres.Adventure.id,
            'Comedy': MovieGenres.Comedy.id,
            'Crime': MovieGenres.Crime.id,
            'Science Fiction': MovieGenres.ScienceFiction.id,
          };

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(_onTVPage ? '🔥 Popular TV Shows' : '🔥 Popular Movies',
                style: const TextStyle(fontSize: 24)),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: FutureBuilder(
                future: _tmdbHelper.getPopularThisWeek(_onTVPage),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    var mediaList = snapshot.data?['results'];
                    return Row(
                      children:
                          List<MediaTile>.generate(mediaList.length, (index) {
                        return MediaTile(
                          mediaTitle: mediaList[index]['title'] ??
                              mediaList[index]['name'],
                          mediaPoster: mediaList[index]['poster_path'],
                          mediaRating: mediaList[index]['vote_average'],
                        );
                      }),
                    );
                  } else {
                    return const SizedBox(
                      height: 200, // Adjust the height as needed
                      child: Center(child: CircularProgressIndicator()),
                    );
                  }
                },
              ),
            ),
            if (_onTVPage) ...[
              const Text('Returning this week', style: TextStyle(fontSize: 24)),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: FutureBuilder(
                  future: _tmdbHelper.getReturningThisWeek(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.done) {
                      var mediaList = snapshot.data?['results'];
                      return Row(
                        children:
                            List<MediaTile>.generate(mediaList.length, (index) {
                          return MediaTile(
                            mediaTitle: mediaList[index]['title'] ??
                                mediaList[index]['name'],
                            mediaPoster: mediaList[index]['poster_path'],
                            mediaRating: mediaList[index]['vote_average'],
                          );
                        }),
                      );
                    } else {
                      return const SizedBox(
                        height: 200, // Adjust the height as needed
                        child: Center(child: CircularProgressIndicator()),
                      );
                    }
                  },
                ),
              ),
            ],
            Text('New shows in $_currentMonth',
                style: const TextStyle(fontSize: 24)),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: FutureBuilder(
                future: _tmdbHelper.getNewThisMonth(_onTVPage),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    var mediaList = snapshot.data?['results'];
                    return Row(
                      children:
                          List<MediaTile>.generate(mediaList.length, (index) {
                        return MediaTile(
                          mediaTitle: mediaList[index]['title'] ??
                              mediaList[index]['name'],
                          mediaPoster: mediaList[index]['poster_path'],
                          mediaRating: mediaList[index]['vote_average'],
                        );
                      }),
                    );
                  } else {
                    return const SizedBox(
                      height: 200, // Adjust the height as needed
                      child: Center(child: CircularProgressIndicator()),
                    );
                  }
                },
              ),
            ),
            ...genres.entries
                .map((entry) => _buildGenreSection(entry.key, entry.value)),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            _onTVPage = !_onTVPage;
          });
        },
        child: _onTVPage ? const Icon(Icons.movie) : const Icon(Icons.tv),
      ),
    );
  }
}
