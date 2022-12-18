import 'package:dio/dio.dart';

class ApiTMDB {
  static const urlBase = 'https://api.themoviedb.org/3';
  static const urlBasePhoto = 'https://image.tmdb.org/t/p/w500';
  static const urlMoviesTopRate = '/movie/top_rated';
  static const urlMoviesPopular = '/movie/popular';
  static const urlMovie = '/movie';
  static const kServerError =
      'Failed to connect to the server. Try again later.';
  static final dioOptions = BaseOptions(
    baseUrl: urlBase,
    connectTimeout: 5000,
    receiveTimeout: 3000,
    contentType: 'application/json;charset=utf-8',
  );
}
