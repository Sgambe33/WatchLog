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
    return SizedBox(
        width: 100.0, // Set the width to match the image width
        height: 200.0, // Set a fixed height for the card
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Stack(
                children: [
                  ClipRRect(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(10.0),
                      topRight: Radius.circular(10.0),
                    ),
                    child: Image.network(
                      'https://image.tmdb.org/t/p/w500$mediaPoster.jpg',
                      width: 100.0,
                      height: 135.0,
                      fit: BoxFit.cover,
                      loadingBuilder: (context, child, loadingProgress) {
                        if (loadingProgress == null) {
                          return child;
                        } else {
                          return const Center(child: CircularProgressIndicator());
                        }
                      },
                    ),
                  ),
                  Positioned(
                    top: 0,
                    right: 0,
                    child: Transform.scale(
                      scale: 0.6, // Adjust scale as needed
                      child: Chip(
                        label: Text(
                          mediaRating.toStringAsFixed(1),
                          style: const TextStyle(
                            color: Colors.white,
                          ),
                        ),
                        backgroundColor: Colors.black.withOpacity(0.7),
                        padding: EdgeInsets.zero, // Remove any padding
                        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap, // Shrink the tap target size
                      ),
                    ),
                  ),
                ],
              ),
              const Spacer(), // Add a spacer to push the text to the center vertically
              Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(5.0, 0.0, 5.0, 0.0),
                child: Center(
                  child: Text(
                    mediaTitle,
                    textAlign: TextAlign.center,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 12.0, // Adjust font size to fit within the fixed height
                    ),
                  ),
                ),
              ),
              const Spacer(), // Add another spacer to balance the vertical alignment
            ],
          ),
        ));
  }
}
