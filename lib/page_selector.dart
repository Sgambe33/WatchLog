import 'package:flutter/material.dart';
import 'package:watchlog/my_shows_page.dart';
import 'package:watchlog/profile_page.dart';
import 'package:watchlog/watchlist_page.dart';

import 'discover_page.dart';

class PageSelector extends StatefulWidget {
  const PageSelector({super.key, required this.title});

  final String title;

  @override
  State<PageSelector> createState() => _PageSelectorState();
}

class _PageSelectorState extends State<PageSelector> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text("MovieTrack"), actions: [IconButton(icon: const Icon(Icons.search), onPressed: () {}), IconButton(icon: const Icon(Icons.settings), onPressed: () {})]),
        body: IndexedStack(index: _selectedIndex, children: const [WatchlistPage(), MyShowsPage(), DiscoverPage(), ProfilePage()]),
        bottomNavigationBar: BottomNavigationBar(items: const [
          BottomNavigationBarItem(icon: Icon(Icons.tv), label: "Watchlist"),
          BottomNavigationBarItem(icon: Icon(Icons.movie), label: "My shows"),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: "Discover"),
          BottomNavigationBarItem(icon: Icon(Icons.supervised_user_circle), label: "Profile")
        ], currentIndex: _selectedIndex, selectedItemColor: Colors.deepPurple, unselectedItemColor: Colors.grey, backgroundColor: Colors.deepPurple, onTap: _onItemTapped));
  }
}
