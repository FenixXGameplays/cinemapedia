

import 'dart:convert';

import 'movie_from_moviedb.dart';

MovieDbResponse movieDbResponseFromJson(String str) => MovieDbResponse.fromJson(json.decode(str));


class MovieDbResponse {
    final Dates? dates;
    final int page;
    final List<MovieFromMovieDB> results;
    final int totalPages;
    final int totalResults;

    MovieDbResponse({
        required this.dates,
        required this.page,
        required this.results,
        required this.totalPages,
        required this.totalResults,
    });

    factory MovieDbResponse.fromJson(Map<String, dynamic> json) => MovieDbResponse(
        dates: json["dates"] != null ? Dates.fromJson(json["dates"]): null,
        page: json["page"],
        results: List<MovieFromMovieDB>.from(json["results"].map((x) => MovieFromMovieDB.fromJson(x))),
        totalPages: json["total_pages"],
        totalResults: json["total_results"],
    );


}

class Dates {
    final DateTime maximum;
    final DateTime minimum;

    Dates({
        required this.maximum,
        required this.minimum,
    });

    factory Dates.fromJson(Map<String, dynamic> json) => Dates(
        maximum: DateTime.parse(json["maximum"]),
        minimum: DateTime.parse(json["minimum"]),
    );

   
}

