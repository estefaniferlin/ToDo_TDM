import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class TmdbService {
  final String apiKey = 'ab4b3e0426d4631b16550348b4781ce5'; //API do The Movie Database
  final String baseUrl = 'https://api.themoviedb.org/3';
  final String baseImageUrl = 'https://image.tmdb.org/t/p/w500';

  Future<List> fetchPopularMovies() async {
    final response = await http.get(Uri.parse('$baseUrl/movie/popular?api_key=$apiKey'));

    if (response.statusCode == 200) {
      Map data = json.decode(response.body);
      List movies = data['results'];
      return movies;
    } else {
      throw Exception('Failed to load movies');
    }
  }
}

class MoviesScreen extends StatefulWidget {
  @override
  _MoviesScreenState createState() => _MoviesScreenState();
}

class _MoviesScreenState extends State<MoviesScreen> {
  final TmdbService _tmdbService = TmdbService();

  @override
  Widget build(BuildContext context) {
    // Determina a cor do Card com base no tema atual
    Color cardColor = Theme.of(context).brightness == Brightness.dark
        ? Colors.grey[850]! // cinza quando for tema escuro
        : Colors.green[400]!; // verde quando for tema claro

    return Scaffold(
      appBar: AppBar(
        title: Text("Filmes Populares"),
      ),
      body: FutureBuilder<List>(
        future: _tmdbService.fetchPopularMovies(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data?.length,
              itemBuilder: (context, index) {
                var movie = snapshot.data![index];
                return Card(
                  margin: EdgeInsets.all(8.0),
                  child: Column(
                    children: <Widget>[
                      ListTile(
                        contentPadding: EdgeInsets.all(10.0),
                        title: Text(movie['title'], style: TextStyle(fontWeight: FontWeight.bold)),
                        subtitle: Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: Text(movie['overview']),
                        ),
                      ),
                      ClipRRect(
                        // ClipRRect é usado para dar uma borda arredondada à imagem
                        borderRadius: BorderRadius.only(bottomLeft: Radius.circular(5.0), bottomRight: Radius.circular(5.0)),
                        child: Image.network(
                          '${_tmdbService.baseImageUrl}${movie['poster_path']}',
                          width: double.infinity,
                          fit: BoxFit.cover,
                          height: 200.0, // Defina uma altura fixa para todas as imagens
                        ),
                      ),
                    ],
                  ),
                );
              },
            );
          } else if (snapshot.hasError) {
            return Center(child: Text("Erro ao carregar dados: ${snapshot.error}"));
          }
          return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
