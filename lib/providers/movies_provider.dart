import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:movies_app/models/models.dart';

class MoviesProvider extends ChangeNotifier{
  final String _apiKey = '73e9d3da8f2da01f1f08152ca5b70fbf';
  final String _baseUrl = 'api.themoviedb.org';
  final String _lenguage = 'es-Es';

  List<Movie> onDisplayMovies = [];
  List<Movie> popularMovies = [];
  int _popularpage = 0;

  MoviesProvider() {
    print('MoviesProvider inicializado');
    getOnDisplayMovies();
    getPopularMovies();
  }

  Future<String> _getJsonData(String endpoint, [int page = 1]) async {
    var url = Uri.https(_baseUrl, endpoint, {
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
}