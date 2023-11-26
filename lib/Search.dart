import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:make_my_show/Video.dart';

class Search extends StatefulWidget {
  @override
  State<Search> createState() => _Movies();
}

class _Movies extends State<Search> {
  List<dynamic> items = [];
  List<dynamic> filteredItems = [];

  Future<void> fetchData() async {
    final url = Uri.parse('https://priyadarsan.000webhostapp.com/API.php');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      setState(() {
        items = json.decode(response.body);
        filteredItems = List.from(items);
      });
    } else {
      print('Failed to load data');
    }
  }

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  void _filterMovies(String query) {
    setState(() {
      filteredItems = items
          .where((movie) =>
              movie['NAME'].toLowerCase().contains(query.toLowerCase()) ||
              movie['TITLE'].toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Shows'),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () async {
              final query = await showSearch<String>(
                context: context,
                delegate: MovieSearchDelegate(items),
              );
              if (query != null && query.isNotEmpty) {
                _filterMovies(query);
              }
            },
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              'Movie List',
              style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
            ),
          ),
          Expanded( 
            child: ListView.builder(
              itemCount: filteredItems.length,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  title: Text('${filteredItems[index]['NAME']}'),
                  subtitle: Text(
                    'Title: ${filteredItems[index]['TITLE']}',
                    maxLines: 3,
                  ),
                  leading: Image.network('${filteredItems[index]['IMAGE']}'),
                  onTap: () {
                    if (filteredItems[index]['TRAILER'] != null) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Video(
                            name:"${filteredItems[index]['NAME']}",
                            title:"${filteredItems[index]['TITLE']}",
                            trailer: "${filteredItems[index]['TRAILER']}",
                          ),
                        ),
                      );
                    } else {
                      // Handle the case where 'TRAILER' is null or not present
                      print('Trailer information not available');
                    }
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class MovieSearchDelegate extends SearchDelegate<String> {
  final List<dynamic> movies;

  MovieSearchDelegate(this.movies);

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        close(context, '');
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return _buildSearchResults();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return _buildSearchResults();
  }

  Widget _buildSearchResults() {
    final List<dynamic> searchResults = query.isEmpty
        ? List.from(movies)
        : movies
            .where((movie) =>
                movie['NAME'].toLowerCase().contains(query.toLowerCase()) ||
                movie['TITLE'].toLowerCase().contains(query.toLowerCase()))
            .toList();

    return ListView.builder(
      itemCount: searchResults.length,
      itemBuilder: (BuildContext context, int index) {
        return ListTile(
          title: Text('${searchResults[index]['NAME']}'),
          subtitle: Text(
            'Title: ${searchResults[index]['TITLE']}',
            maxLines: 4,
          ),
          leading: Image.network('${searchResults[index]['IMAGE']}'),
        );
      },
    );
  }
}
