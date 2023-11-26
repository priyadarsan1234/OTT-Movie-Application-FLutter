import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class MovieType extends StatefulWidget {
  const MovieType({Key? key, required this.Type}) : super(key: key);

  final String Type;

  @override
  State<MovieType> createState() => _Movies();
}

class _Movies extends State<MovieType> {
  List<dynamic> items = [];

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

  List<dynamic> getFilteredMovies() {
    if (widget.Type == "ALL") {
      return items.take(10).toList();
    } else {
      return items.where((movie) => movie['TYPE'] == widget.Type).toList();
    }
  }

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  @override
  Widget build(BuildContext context) {
    List<dynamic> filteredMovies = getFilteredMovies();

    return Material(
      child: Scaffold(
        appBar: AppBar(
          title: Text('My Show - ${widget.Type} Movies'),
        ),
        backgroundColor: Colors.black,
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 7.0, vertical: 5),
                
              ),
              GridView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 10.0,
                  mainAxisSpacing: 10.0,
                  childAspectRatio: 0.5, // Aspect ratio: height = 2 * width
                ),
                itemCount: filteredMovies.length,
                itemBuilder: (BuildContext context, int index) {
                  return Padding(
                    padding: const EdgeInsets.only(top: 5),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8.0),
                      child: Image.network(
                        '${filteredMovies[index]['IMAGE']}',
                        fit: BoxFit.cover,
                      ),
                    ),
                    
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
