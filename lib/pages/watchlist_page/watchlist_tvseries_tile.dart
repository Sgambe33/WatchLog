import 'package:flutter/material.dart';

class WatchlistTVSeriesTile extends StatelessWidget {
  final Map<String, dynamic> tvSeriesData;

  const WatchlistTVSeriesTile({super.key, required this.tvSeriesData});

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
              "https://image.tmdb.org/t/p/w500${tvSeriesData["poster_path"]}",
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
                    tvSeriesData["original_name"],
                    style: const TextStyle(overflow: TextOverflow.ellipsis),
                  ),
                  const Text("S01E10 - Hello there"),
                  const Row(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.symmetric(vertical: 8.0),
                          child: LinearProgressIndicator(
                            value: 0.7,
                            borderRadius: BorderRadius.all(Radius.circular(5.0)),
                          ),
                        ),
                      ),
                      Padding(padding: EdgeInsets.only(left: 8.0), child: Text("20/30")),
                    ],
                  ),
                  Row(
                    children: [
                      TextButton(
                        onPressed: () {},
                        style: TextButton.styleFrom(
                          backgroundColor: Colors.grey[850],
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(4.0), // Rectangle shape
                          ),
                        ),
                        child: const Text("Episode info"),
                      ),
                      const SizedBox(width: 8.0),
                      const Text("10 left"),
                    ],
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
