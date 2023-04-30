// To parse this JSON data, do
//
//     final searchMovieResponse = searchMovieResponseFromJson(jsonString);

import 'dart:convert';

import 'package:movies_app/models/models.dart';

class SearchMovieResponse {
    int page;
    List<Movie> results;
    int totalPages;
    int totalMovies;

    SearchMovieResponse({
        required this.page,
        required this.results,
        required this.totalPages,
        required this.totalMovies,
    });

    factory SearchMovieResponse.fromRawJson(String str) => SearchMovieResponse.fromJson(json.decode(str));

    factory SearchMovieResponse.fromJson(Map<String, dynamic> json) => SearchMovieResponse(
        page: json["page"],
        results: List<Movie>.from(json["results"].map((x) => Movie.fromJson(x))),
        totalPages: json["total_pages"],
        totalMovies: json["total_results"],
    );
}