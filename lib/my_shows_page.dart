import 'package:flutter/material.dart';
import 'package:timelines_plus/timelines_plus.dart';

class MyShowsPage extends StatefulWidget {
  const MyShowsPage({super.key});

  @override
  State<MyShowsPage> createState() => _MyShowsPageState();
}

class _MyShowsPageState extends State<MyShowsPage> {
  @override
  Widget build(BuildContext context) {
    //Display upcoming tv shows / movies
    return TimelineTile(
      contents: Card(
        child: Container(
          padding: const EdgeInsets.all(8.0),
          child: const Text('contents'),
        ),
      ),
      node: TimelineNode(
        indicator: ContainerIndicator(
          child: Container(
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.blue,
            ),
            width: 60.0,
            height: 60.0,
            child: const Center(child: Text("27\ndays", textAlign: TextAlign.center,)),
          ),
        ),
        startConnector: const SolidLineConnector(),
        endConnector: const SolidLineConnector(),
      ),
    );

    //Awaiting for next season announcement
    //Ended tv shows
  }
}
