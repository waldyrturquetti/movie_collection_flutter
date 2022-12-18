import 'package:flutter/material.dart';
import 'package:flutter_review_app/controllers/movie_controller.dart';
import 'package:flutter_review_app/pages/detail_page.dart';
import 'package:flutter_review_app/widgets/movie_card.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class MovieListGrid extends StatelessWidget {
  final MovieController controller;
  final ScrollController scrollController;

  const MovieListGrid({
    Key? key,
    required this.controller,
    required this.scrollController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (controller.loading) {
      return Container(
        decoration: const BoxDecoration(
          color: Colors.black,
        ),
        child: Center(
          child: LoadingAnimationWidget.staggeredDotsWave(
              color: const Color.fromARGB(255, 255, 77, 77), size: 200),
        ),
      );
    }

    if (controller.movieError?.msg != null) {
      return Container(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.max,
          children: [
            Text(
              controller.movieError!.msg,
              textAlign: TextAlign.center,
              style: const TextStyle(color: Colors.black),
            )
          ],
        ),
      );
    }

    return GridView.builder(
        controller: scrollController,
        padding: const EdgeInsets.symmetric(),
        itemCount: controller.moviesCount,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 25,
          crossAxisSpacing: 25,
          childAspectRatio: 0.65,
        ),
        itemBuilder: _buildMovieCard);
  }

  Widget _buildMovieCard(context, index) {
    final movie = controller.movies[index];
    return MovieCard(
      posterPath: movie.posterPath,
      onTap: () => _openDetailPage(movie.id, context),
    );
  }

  _openDetailPage(movieId, context) {
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => MovieDetailPage(movieId)));
  }
}
