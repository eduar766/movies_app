import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:movies_app/models/models.dart';
import 'package:movies_app/models/search_movie_response.dart';

class MoviesProvider extends ChangeNotifier{
  final String _apiKey = '73e9d3da8f2da01f1f08152ca5b70fbf';
  final String _baseUrl = 'api.themoviedb.org';
  final String _lenguage = 'es-ES';

  List<Movie> onDisplayMovies = [];
  List<Movie> popularMovies = [];
  int _popularpage = 0;

  Map<int, List<Cast>> moviesCast = {};

  MoviesProvider() {
    print('MoviesProvider inicializado');
    getOnDisplayMovies();
    getPopularMovies();
  }

  Future<String> _getJsonData(String endpoint, [int page = 1]) async {
    final url = Uri.https(_baseUrl, endpoint, {
      'api_key': _apiKey,
      'lenguage': _lenguage,
      'page': '$page'
    });

    final response = await http.get(url);
    return response.body;
  }

  getOnDisplayMovies() async {
    final jsonData = await _getJsonData('3/movie/now_playing');
    final nowPlayingResponse = NowPlayingResponse.fromRawJson(jsonData);
    onDisplayMovies = nowPlayingResponse.results;
    notifyListeners();
  }

  getPopularMovies() async {
    _popularpage++;
    final popular = await _getJsonData('3/movie/popular', _popularpage);
    final popularResponse = PopularResponse.fromRawJson(popular);
    popularMovies = [...popularMovies, ...popularResponse.results];
    notifyListeners();
  }

  Future<List<Cast>> getMovieCast(int movieId) async {
    if (moviesCast.containsKey(movieId)) return moviesCast[movieId]!;
    
    final jsonData = await _getJsonData('3/movie/$movieId/credits'); 
    final creditsResponse = CreditsResponse.fromRawJson(jsonData);

    moviesCast[movieId] = creditsResponse.cast;
    return creditsResponse.cast;
  }

  Future<List<Movie>> searchMovies(String query) async {
    final url = Uri.https(_baseUrl, '3/search/movie', {
      'api_key': _apiKey,
      'lenguage': _lenguage,
      'query': query
    });

    final response = await http.get(url);
    final searchResponse = SearchMovieResponse.fromRawJson(response.body);

    return searchResponse.results;
  }

}