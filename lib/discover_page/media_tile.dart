import 'package:flutter/material.dart';

class MediaTile extends StatelessWidget {
  final String mediaTitle;
  final String mediaPoster;
  final double mediaRating;

  const MediaTile({
    super.key,
    required this.mediaTitle,
    required this.mediaPoster,
    required this.mediaRating,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Stack(
              children: [
                Container(
                  width: 185,
                  height: 278,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage("https://image.tmdb.org/t/p/w500/$mediaPoster"),
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
                Positioned(
                  top: 0,
                  right: 0,
                  child: Container(
                    padding: const EdgeInsets.all(4),
                    color: Colors.black.withOpacity(0.5),
                    child: Row(
                      children: [
                        const Icon(Icons.star, color: Colors.yellow),
                        Text(mediaRating.toStringAsFixed(1)),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Text(mediaTitle),
        ],
      ),
    );
  }
}
