//SOON TM

//const Text("Trending", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
//SizedBox(
//  height: 200,
//  child: FutureBuilder<Map<String, dynamic>>(
//    future: _trendingFuture,
//    builder: (context, snapshot) {
//      if (snapshot.connectionState == ConnectionState.waiting) {
//        return const Center(child: CircularProgressIndicator());
//      } else if (snapshot.hasError) {
//        return Center(child: Text('Error: ${snapshot.error}'));
//      } else if (!snapshot.hasData || snapshot.data!['results'] == null) {
//        return const Center(child: Text('No data available'));
//      } else {
//        final movies = snapshot.data!['results'] as List<dynamic>;
//        movies.sort((a, b) => b['vote_average'].compareTo(a['vote_average']));
//        return ListView.builder(
//          itemBuilder: (context, index) {
//            final movie = movies[index];
//            return MediaTile(
//              mediaTitle: _onTVPage ? movie['name'] : movie['title'],
//              mediaPoster: movie['poster_path'],
//              mediaRating: movie['vote_average'].toDouble(),
//            );
//          },
//          itemCount: movies.length,
//          scrollDirection: Axis.horizontal,
//        );
//      }
//    },
//  ),
//),
//if(_onTVPage)
//  ...[
//const Text("Returning this week", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
//SizedBox(
//  height: 200,
//  child: FutureBuilder<Map<String, dynamic>>(
//    future: _returningFuture,
//    builder: (context, snapshot) {
//      if (snapshot.connectionState == ConnectionState.waiting) {
//        return const Center(child: CircularProgressIndicator());
//      } else if (snapshot.hasError) {
//        return Center(child: Text('Error: ${snapshot.error}'));
//      } else if (!snapshot.hasData || snapshot.data!['results'] == null) {
//        return const Center(child: Text('No data available'));
//      } else {
//        final movies = snapshot.data!['results'] as List<dynamic>;
//        movies.sort((a, b) => b['vote_average'].compareTo(a['vote_average']));
//        return ListView.builder(
//          itemBuilder: (context, index) {
//            final movie = movies[index];
//            return MediaTile(
//              mediaTitle: _onTVPage ? movie['name'] : movie['title'],
//              mediaPoster: movie['poster_path'],
//              mediaRating: movie['vote_average'].toDouble(),
//            );
//          },
//          itemCount: movies.length,
//          scrollDirection: Axis.horizontal,
//        );
//      }
//    },
//  ),
//)],
//const Text("New releases in October", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
//SizedBox(
//  height: 200,
//  child: FutureBuilder<Map<String, dynamic>>(
//    future: _fetchTrending(_onTVPage, null, '2024-10-01', '2024-10-31', null, null,'2024-10-01', '2024-10-31'),
//    builder: (context, snapshot) {
//      if (snapshot.connectionState == ConnectionState.waiting) {
//        return const Center(child: CircularProgressIndicator());
//      } else if (snapshot.hasError) {
//        return Center(child: Text('Error: ${snapshot.error}'));
//      } else if (!snapshot.hasData || snapshot.data!['results'] == null) {
//        return const Center(child: Text('No data available'));
//      } else {
//        final movies = snapshot.data!['results'] as List<dynamic>;
//        movies.sort((a, b) => b['vote_average'].compareTo(a['vote_average']));
//        return ListView.builder(
//          itemBuilder: (context, index) {
//            final movie = movies[index];
//            return MediaTile(
//              mediaTitle: _onTVPage ? movie['name'] : movie['title'],
//              mediaPoster: movie['poster_path'],
//              mediaRating: movie['vote_average'].toDouble(),
//            );
//          },
//          itemCount: movies.length,
//          scrollDirection: Axis.horizontal,
//        );
//      }
//    },
//  ),
//),
//const Text("All time popular", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
//SizedBox(
//  height: 200,
//  child: FutureBuilder<Map<String, dynamic>>(
//    future: _fetchTrending(_onTVPage, null, null, null, null, null, null, null),
//    builder: (context, snapshot) {
//      if (snapshot.connectionState == ConnectionState.waiting) {
//        return const Center(child: CircularProgressIndicator());
//      } else if (snapshot.hasError) {
//        return Center(child: Text('Error: ${snapshot.error}'));
//      } else if (!snapshot.hasData || snapshot.data!['results'] == null) {
//        return const Center(child: Text('No data available'));
//      } else {
//        final movies = snapshot.data!['results'] as List<dynamic>;
//        movies.sort((a, b) => b['vote_average'].compareTo(a['vote_average']));
//        return ListView.builder(
//          itemBuilder: (context, index) {
//            final movie = movies[index];
//            return MediaTile(
//              mediaTitle: _onTVPage ? movie['name'] : movie['title'],
//              mediaPoster: movie['poster_path'],
//              mediaRating: movie['vote_average'].toDouble(),
//            );
//          },
//          itemCount: movies.length,
//          scrollDirection: Axis.horizontal,
//        );
//      }
//    },
//  ),
//),
//const Text("Action", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
//const Text("Drama", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
//const Text("Horror", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
//const Text("Anime", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
//const Text("Adventure", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
//const Text("Comedy", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
//const Text("Crime", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
//const Text("Science Fiction", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),