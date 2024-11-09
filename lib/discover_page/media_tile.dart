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
      width: 200.0, // Set the width to match the image width
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
                  borderRadius: const BorderRadius.only(topLeft: Radius.circular(10.0), topRight: Radius.circular(10.0)),
                  child: Image.network(
                    'https://image.tmdb.org/t/p/w500/7dFZJ2ZJJdcmkp05B9NWlqTJ5tq.jpg',
                    width: 200.0,
                    height: 270.0,
                    fit: BoxFit.cover,
                  ),
                ),
                Align(
                  alignment: const AlignmentDirectional(1.0, -1.0),
                  child: Padding(
                      padding: const EdgeInsetsDirectional.fromSTEB(0.0, 5.0, 5.0, 5.0),
                      child: Theme(
                        data: Theme.of(context).copyWith(canvasColor: Colors.transparent),
                        child: Chip(
                          label: Text("7.4"),
                          backgroundColor: Colors.transparent, // or any other color
                        ),
                      )),
                ),
              ],
            ),
            const Padding(
              padding: EdgeInsetsDirectional.fromSTEB(5.0, 5.0, 5.0, 5.0),
              child: Text(
                'Chronicles of the Sun: Part cinq et sis et qatrevingt',
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
