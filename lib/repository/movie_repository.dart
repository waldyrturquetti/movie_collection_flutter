import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_review_app/core/api_tmdb.dart';
import 'package:flutter_review_app/errors/movie_errors.dart';
import 'package:flutter_review_app/models/movie_detail_model.dart';
import 'package:flutter_review_app/models/movie_response_model.dart';

class MovieRepository {
  final Dio _dio = Dio(ApiTMDB.dioOptions);
  final apiKey = dotenv.env['API_KEY'];
  final urlMoviesPopular = ApiTMDB.urlMoviesPopular;
  final urlMovie = ApiTMDB.urlMovie;

  Future<Either<MovieError, MovieResponseModel>> fetchAllMovies(
      int page) async {
    try {
      final response =
          await _dio.get('$urlMoviesPopular?api_key=$apiKey&page=$page');
      final model = MovieResponseModel.fromMap(response.data);
      return Right(model);
    } on DioError catch (error) {
      if (error.response != null) {
        return Left(MovieRepositoryError(error.response!.data['status_msg']));
      }
      return Left(MovieRepositoryError(ApiTMDB.kServerError));
    } on Exception catch (error) {
      return Left(MovieRepositoryError(error.toString()));
    }
  }

  Future<Either<MovieError, MovieModelDetail>> fetchById(int id) async {
    try {
      final response =
          await _dio.get('$urlMovie/$id?api_key=$apiKey&language=pt-BR');
      final model = MovieModelDetail.fromMap(response.data);
      return Right(model);
    } on DioError catch (error) {
      if (error.response != null) {
        return Left(MovieRepositoryError(error.response!.data['status msg']));
      } else {
        return Left(MovieRepositoryError(ApiTMDB.kServerError));
      }
    } on Exception catch (error) {
      return Left(MovieRepositoryError(error.toString()));
    }
  }
}
