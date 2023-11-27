import 'package:flutter/material.dart';

class MovieDetailPage extends StatelessWidget {
  final Map<String, dynamic> movie;

  MovieDetailPage({required this.movie});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(movie['title'] ?? 'Movie Detail'),
        backgroundColor: Colors.black,
      ),
      body: ListView(
        padding: EdgeInsets.all(16.0),
        children: [
          // Movie Poster
          Container(
            height: 200,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(
                  'https://image.tmdb.org/t/p/original${movie['poster_path']}',
                ),
                fit: BoxFit.cover,
              ),
            ),
          ),

          // Movie Banner and Name
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Row(
              children: [
                // Small Banner
                Container(
                  width: 100,
                  height: 30,
                  color: Colors.blue, // Use your banner color
                  child: Center(
                    child: Text(
                      'Now Playing',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
                SizedBox(width: 8),

                // Movie Name
                Expanded(
                  child: Text(
                    movie['title'] ?? 'Unknown Title',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Genre, Watch Now Button, Circular Buttons
          Row(
            children: [
              // Genres
              Expanded(
                child: Text(
                  'Action, Drama', // Replace with actual genres
                  style: TextStyle(fontSize: 16),
                ),
              ),

              // Watch Now Button
              ElevatedButton(
                onPressed: () {
                  // Handle watch now button press
                },
                style: ElevatedButton.styleFrom(
                  primary: Colors.green,
                ),
                child: Text('Watch Now'),
              ),
            ],
          ),

          // Circular Buttons
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              CircularButton(
                  icon: Icons.play_arrow, borderColor: Colors.yellow),
              CircularButton(icon: Icons.favorite, borderColor: Colors.yellow),
              CircularButton(icon: Icons.share, borderColor: Colors.yellow),
            ],
          ),

          // Name
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Text(
              'Directed by: Director Name', // Replace with actual director
              style: TextStyle(fontSize: 16),
            ),
          ),

          // Rating and Language
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Rating: 4.5/5'), // Replace with actual rating
              Text('Language: English'), // Replace with actual language
            ],
          ),

          // Tab View for Related Movies and More Details
          DefaultTabController(
            length: 2,
            child: Column(
              children: [
                TabBar(
                  tabs: [
                    Tab(text: 'Related Movies'),
                    Tab(text: 'More Details'),
                  ],
                ),
                TabBarView(
                  children: [
                    // Related Movies Content
                    Center(
                      child: Text('Related Movies Content'),
                    ),

                    // More Details Content
                    Center(
                      child: Text('More Details Content'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class CircularButton extends StatelessWidget {
  final IconData icon;
  final Color borderColor;

  CircularButton({required this.icon, required this.borderColor});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: borderColor),
      ),
      child: IconButton(
        icon: Icon(icon),
        onPressed: () {
          // Handle button press
        },
      ),
    );
  }
}
