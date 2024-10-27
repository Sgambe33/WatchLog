import 'package:flutter/material.dart';

class WatchlistMovieTile extends StatelessWidget {
  final Map<String, dynamic> movieData;

  const WatchlistMovieTile({super.key, required this.movieData});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Row(
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(4.0),
              bottomLeft: Radius.circular(4.0),
            ),
            child: Image.network(
              "https://image.tmdb.org/t/p/w500${movieData["poster_path"]}",
              height: 120,
              fit: BoxFit.cover,
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    movieData["title"], style: const TextStyle(overflow: TextOverflow.ellipsis),
                  ),
                  Text(movieData["release_date"].split("-")[0]),
                  const SizedBox(height: 8.0),
                  TextButton(
                    onPressed: () {},
                    style: TextButton.styleFrom(
                      backgroundColor: Colors.grey[850],
                      shape: RoundedRectangleBorder(
                        borderRadius:
                        BorderRadius.circular(4.0), // Rectangle shape
                      ),
                    ),
                    child: const Text("Movie info"),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
