abstract class MovieError implements Exception {
  late String msg;

  @override
  String toString() {
    return msg;
  }
}

class MovieRepositoryError extends MovieError {
  MovieRepositoryError(String msg) {
    this.msg = msg;
  }
}
