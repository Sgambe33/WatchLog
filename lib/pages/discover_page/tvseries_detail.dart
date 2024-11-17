import 'package:flutter/material.dart';
import 'package:watchlog/utils/tmdb_helper.dart';

class TVSeriesDetail extends StatefulWidget {
  const TVSeriesDetail({super.key, required this.tvSeriesId});

  final int tvSeriesId;

  @override
  State<TVSeriesDetail> createState() => _TVSeriesDetail();
}

class _TVSeriesDetail extends State<TVSeriesDetail> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: TMDBHelper().getMediaDetailsById(widget.tvSeriesId, true),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasError) {
              return const Center(child: Text("An error occurred"));
            } else {
              return Scaffold(
                body: Column(
                  children: [
                    Stack(
                      children: [
                        Container(
                          height: MediaQuery.sizeOf(context).height / 4,
                          child: Image.network(
                            'https://image.tmdb.org/t/p/w500${snapshot.data?['backdrop_path']}',
                            fit: BoxFit.cover,
                          ),
                        ),
                        Positioned(
                          bottom: 10,
                          left: 10,
                          child: Row(
                            children: [
                              Image.network(
                                'https://image.tmdb.org/t/p/w200${snapshot.data?['poster_path']}',
                                height: 100,
                              ),
                              const SizedBox(width: 10),
                              SizedBox(
                                height: 100,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      snapshot.data?['original_name'] ?? '',
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                      snapshot.data?['status'] == 'Ended'
                                          ? 'Ended'
                                          : 'Running',
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 16,
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                        Positioned(
                          bottom: 10,
                          right: 10,
                          child: AddButton(),
                        ),
                        Positioned(
                          top: 10,
                          left: 10,
                          child: IconButton(
                            icon: const Icon(Icons.arrow_back,
                                color: Colors.white),
                            onPressed: () {
                              Navigator.pop(context);
                            },
                          ),
                        ),
                      ],
                    ),
                    Text(snapshot.data?['overview'],
                        style: const TextStyle(), textAlign: TextAlign.justify),
                    Text('Rating: ${snapshot.data?['vote_average']}'),
                    Text('First aired: ${snapshot.data?['first_air_date']}'),
                  ],
                ),
              );
            }
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        });
  }
}

class AddButton extends StatefulWidget {
  @override
  _AddButtonState createState() => _AddButtonState();
}

class _AddButtonState extends State<AddButton> {
  bool added = false;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      iconSize: 30,
      icon: Icon(added ? Icons.check : Icons.add),
      color: added ? Colors.green : Colors.white,
      onPressed: () {
        setState(() {
          added = !added;
        });
      },
    );
  }
}
