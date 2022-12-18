import 'dart:convert';

class MovieModelDetail {
  final int id;
  final String originalTitle;
  final double popularity;
  final String posterPath;
  final int runtime;
  final String title;
  final double voteAverage;
  // final List<MovieModel> genre;
  final String overview;
  final DateTime releaseDate;
  final String backdropPath;

  const MovieModelDetail({
    required this.id,
    required this.runtime,
    required this.popularity,
    required this.posterPath,
    required this.title,
    required this.originalTitle,
    required this.voteAverage,
    // required this.genre,
    required this.overview,
    required this.releaseDate,
    required this.backdropPath,
  });

  factory MovieModelDetail.fromJson(String str) =>
      MovieModelDetail.fromMap(json.decode(str));

  factory MovieModelDetail.fromMap(Map<String, dynamic> json) =>
      MovieModelDetail(
        // genre: List<MovieModel>.from(
        //     json["genres"].map((x) => MovieGenre.fromMap(x))),
        voteAverage: json["vote_average"],
        title: json["title"],
        originalTitle: json["original_title"],
        id: json["id"],
        overview: json["overview"],
        releaseDate: DateTime.parse(json["release_date"]),
        posterPath: json["poster_path"],
        runtime: json["runtime"],
        popularity: json["popularity"],
        backdropPath: json["backdrop_path"],
      );
}
