import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:movieapp/detailpage.dart';

import 'home.dart';

class LoggedPage extends StatefulWidget {
  @override
  _LoggedPageState createState() => _LoggedPageState();
}

class _LoggedPageState extends State<LoggedPage>
    with SingleTickerProviderStateMixin {
  late String currentApiUrl;
  final apiKey = '0d1937a9666df99b717b73962e0c48b1';

  late TabController _tabController;
  final User = FirebaseAuth.instance.currentUser!;
  TextEditingController controller = TextEditingController();
  late List<Map<String, dynamic>> movies;

  @override
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    movies = [];
    currentApiUrl =
        'https://api.themoviedb.org/3/movie/top_rated?api_key=$apiKey';
    fetchTopRatedMovies();
  }

  Future<void> fetchTopRatedMovies() async {
    try {
      final response = await http.get(Uri.parse(currentApiUrl));

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        final List<Map<String, dynamic>> results = List.from(data['results']);
        setState(() {
          movies = results;
        });
      } else {
        throw Exception('Failed to load data');
      }
    } catch (error) {
      print('Error: $error');
      throw Exception('Failed to load data');
    }
  }

  void signout(BuildContext context) {
    print('Logged out');
    FirebaseAuth.instance.signOut();
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => homepage(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          backgroundColor: Colors.black,
          leading: Padding(
            padding: const EdgeInsets.all(8.0),
            child: IconButton(
              onPressed: () {
                signout(context);
              },
              icon: Icon(Icons.arrow_back),
            ),
          ),
          title: Padding(
            padding: const EdgeInsets.only(top: 5),
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    width: double.infinity,
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: 'Search...',
                        hintStyle: TextStyle(color: Colors.white),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.yellow),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.yellow),
                        ),
                      ),
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ),
          bottom: TabBar(
            controller: _tabController,
            indicatorColor: Colors.yellow,
            onTap: (index) {
              setState(() {
                if (index == 0) {
                  currentApiUrl =
                      'https://api.themoviedb.org/3/movie/top_rated?api_key=$apiKey';
                } else {
                  currentApiUrl =
                      'https://api.themoviedb.org/3/tv/top_rated?api_key=$apiKey';
                }
                fetchTopRatedMovies();
              });
            },
            tabs: [
              Tab(text: 'Movies'),
              Tab(text: 'Shows'),
            ],
          ),
        ),
        body: TabBarView(
          controller: _tabController,
          children: [
            buildSection('Movies'),
            buildSection('Shows'),
          ],
        ),
      ),
    );
  }

  Widget buildSection(String section) {
    String baseUrl = 'https://image.tmdb.org/t/p';
    String titleKey = (section == 'Movies') ? 'title' : 'name';
    String dateKey = (section == 'Movies') ? 'release_date' : 'first_air_date';

    return ListView.builder(
      itemCount: movies.length,
      itemBuilder: (context, index) {
        final movie = movies[index];
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MovieDetailPage(movie: movie),
                  ));
            },
            child: Container(
              height: 150,
              child: Card(
                elevation: 6,
                color: Color.fromARGB(255, 29, 29, 29),
                margin: EdgeInsets.all(8),
                child: Row(
                  children: [
                    Container(
                      width: 200,
                      height: 150,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(0),
                        color: Color.fromARGB(255, 23, 23, 23),
                      ),
                      child: Image.network(
                        '${baseUrl}${movie['poster_path']}',
                        errorBuilder: (BuildContext context, Object error,
                            StackTrace? stackTrace) {
                          // Show a placeholder or alternative content when the image fails to load
                          return Icon(
                            Icons.image_not_supported,
                            size: 50, // Adjust the size as needed
                            color: Colors.grey,
                          );
                        },
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              movie[titleKey] ?? 'Unknown Title',
                              maxLines: 1,
                              style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w900,
                                  color: Colors.white),
                            ),
                            SizedBox(height: 15),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  elevation: 0, backgroundColor: Colors.white),
                              child: Text(
                                movie[dateKey] ?? 'release date',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold),
                              ),
                              onPressed: () {},
                            ),
                            SizedBox(
                              height: 010,
                            ),
                            Text(
                              movie['overview'] ?? 'No overview available',
                              overflow: TextOverflow.ellipsis,
                              maxLines: 3,
                              style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.yellow),
                            ),
                          ],
                        ),
                      ),
                    ),
                    IconButton(
                        onPressed: () {},
                        icon: Icon(
                          Icons.more_vert_outlined,
                          color: Colors.white,
                        ))
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
