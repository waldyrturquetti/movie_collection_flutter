import 'package:dartz/dartz.dart';
import '../errors/movie_errors.dart';
import '../models/movie_detail_model.dart';
import '../repository/movie_repository.dart';

class MovieDetailController {
  final _repository = MovieRepository();

  MovieModelDetail? movieDetail;
  MovieError? movieError;

  bool loading = true;

  Future<Either<MovieError, MovieModelDetail>> fetchById(int id) async {
    movieError = null;
    final result = await _repository.fetchById(id);
    result.fold(
      (error) => movieError = error,
      (detail) => movieDetail = detail,
    );
    return result;
  }
}
