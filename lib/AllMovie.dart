import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:carousel_slider/carousel_slider.dart';
import 'package:make_my_show/Type_of_Movie.dart';

class AllMovie extends StatefulWidget {
  const AllMovie({Key? key}) : super(key: key);

  @override
  State<AllMovie> createState() => _Movies();
}

class _Movies extends State<AllMovie> {
  List<dynamic> items = [];
  final List<String> imageList = [
    'assets/Tiger3.jpeg',
    'assets/IRONMAN.jpg',
    'assets/Extraction.jpeg',
    'assets/transformer.jpg',
    'assets/SAHOO.png',
  ];

  Future<void> fetchData() async {
    final url = Uri.parse('https://priyadarsan.000webhostapp.com/API.php');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      setState(() {
        items = json.decode(response.body);
      });
    } else {
      print('Failed to load data');
    }
  }

  List<dynamic> getALLMovies() {
    // Assuming the movies are ordered by their release date
    return items.take(10).toList();
  }

  List<dynamic> getActionMovies() {
    return items.where((movie) => movie['TYPE'] == 'Action').toList();
  }

  List<dynamic> getTrendingMovies() {
    return items.where((movie) => movie['TYPE'] == 'Most Watched').toList();
  }

  List<dynamic> getFavoriteMovies() {
    return items.where((movie) => movie['TYPE'] == 'Trending').toList();
  }

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  @override
  Widget build(BuildContext context) {
    List<dynamic> ALLMovies = getALLMovies();
    List<dynamic> actionMovies = getActionMovies();
    List<dynamic> trendingMovies = getTrendingMovies();
    List<dynamic> FavoriteMovies = getFavoriteMovies();
    return Scaffold(
      appBar: AppBar(
        title: Text('My Show'),
      ),
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Carousel Slider
            Container(
              margin: EdgeInsets.only(top: 20, bottom: 15),
              height: 160,
              width: MediaQuery.of(context).size.width,
              child: CarouselSlider(
                options: CarouselOptions(
                  height: 200,
                  autoPlay: true,
                  enlargeCenterPage: true,
                  aspectRatio: 40 / 100,
                ),
                items: imageList.map((String imagePath) {
                  return Builder(
                    builder: (BuildContext context) {
                      return Container(
                        width: MediaQuery.of(context).size.width,
                        margin: EdgeInsets.symmetric(horizontal: 5.0),
                        decoration: BoxDecoration(
                          color: Colors.white,
                        ),
                        child: Image.asset(
                          imagePath,
                          fit: BoxFit.cover,
                        ),
                      );
                    },
                  );
                }).toList(),
              ),
            ),

            // Latest Movies Section
            Row(
              mainAxisAlignment: MainAxisAlignment
                  .spaceBetween, // Aligns children on both sides
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 7.0),
                  child: Text(
                    "Latest Movies",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 21,
                        color: Colors.white),
                  ),
                ),
                // Add more widgets on the other side
                IconButton(
                  color: Colors.white,
                  icon: Icon(Icons.arrow_circle_right),
                  onPressed: () {
                   Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => MovieType(Type: "ALL")),
                    );
                  },
                ),
                // Add more widgets as needed
              ],
            ),
            Container(
              height: 220.0,
              margin: EdgeInsets.only(bottom: 10.0),
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: ALLMovies.length,
                itemBuilder: (BuildContext context, int index) {
                  return Padding(
                    padding: EdgeInsets.only(top: 10, left: 5, right: 5),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8.0),
                      child: Image.network(
                        '${ALLMovies[index]['IMAGE']}',
                        width: 120.0,
                        fit: BoxFit.cover,
                      ),
                    ),
                  );
                },
              ),
            ),

            // Action Movies Section
            Row(
              mainAxisAlignment: MainAxisAlignment
                  .spaceBetween, // Aligns children on both sides
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 7.0),
                  child: Text(
                    "Action Movies",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 21,
                        color: Colors.white),
                  ),
                ),
                // Add more widgets on the other side
                IconButton(
                  color: Colors.white,
                  icon: Icon(Icons.arrow_circle_right),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => MovieType(Type: "Action")),
                    );
                  },
                ),
                // Add more widgets as needed
              ],
            ),
            Container(
              height: 220.0,
              margin: EdgeInsets.only(bottom: 10.0),
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: actionMovies.length,
                itemBuilder: (BuildContext context, int index) {
                  return Padding(
                    padding: EdgeInsets.only(top: 10, left: 5, right: 5),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8.0),
                      child: Image.network(
                        '${actionMovies[index]['IMAGE']}',
                        width: 120.0,
                        fit: BoxFit.cover,
                      ),
                    ),
                  );
                },
              ),
            ),

            // Trending Movies Section
            Row(
              mainAxisAlignment: MainAxisAlignment
                  .spaceBetween, // Aligns children on both sides
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 7.0),
                  child: Text(
                    "Trending Movies",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 21,
                        color: Colors.white),
                  ),
                ),
                // Add more widgets on the other side
                IconButton(
                  color: Colors.white,
                  icon: Icon(Icons.arrow_circle_right),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => MovieType(Type: "Most Watched")),
                    );
                  },
                ),
                // Add more widgets as needed
              ],
            ),
            Container(
              height: 220.0,
              margin: EdgeInsets.only(bottom: 10.0),
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: trendingMovies.length,
                itemBuilder: (BuildContext context, int index) {
                  return Padding(
                    padding: EdgeInsets.only(top: 10, left: 5, right: 5),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8.0),
                      child: Image.network(
                        '${trendingMovies[index]['IMAGE']}',
                        width: 120.0,
                        fit: BoxFit.cover,
                      ),
                    ),
                  );
                },
              ),
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment
                  .spaceBetween, // Aligns children on both sides
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 7.0),
                  child: Text(
                    "Favorite Movies",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 21,
                        color: Colors.white),
                  ),
                ),
                // Add more widgets on the other side
                IconButton(
                  color: Colors.white,
                  icon: Icon(Icons.arrow_circle_right),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => MovieType(Type: "Trending")),
                    );
                  },
                ),
                // Add more widgets as needed
              ],
            ),
            Container(
              height: 220.0,
              margin: EdgeInsets.only(bottom: 10.0),
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: FavoriteMovies.length,
                itemBuilder: (BuildContext context, int index) {
                  return Padding(
                    padding: EdgeInsets.only(top: 10, left: 5, right: 5),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8.0),
                      child: Image.network(
                        '${FavoriteMovies[index]['IMAGE']}',
                        width: 120.0,
                        fit: BoxFit.cover,
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
