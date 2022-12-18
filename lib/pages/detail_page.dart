import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_review_app/core/api_tmdb.dart';
import 'package:flutter_review_app/widgets/comment_list_widget.dart';
import 'package:flutter_review_app/widgets/rating_user_widget.dart';
import 'package:flutter_review_app/widgets/review_widget.dart';
import '../controllers/movie_detail_controller.dart';
import '../widgets/centered_msg_widget.dart';
import '../widgets/rating.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import '../widgets/release_date_widget.dart';

class MovieDetailPage extends StatefulWidget {
  final int movieId;

  // ignore: use_key_in_widget_constructors
  const MovieDetailPage(
    this.movieId,
  );

  @override
  // ignore: library_private_types_in_public_api
  _MovieDetailPageState createState() => _MovieDetailPageState();
}

class _MovieDetailPageState extends State<MovieDetailPage> {
  final _controller = MovieDetailController();

  @override
  void initState() {
    super.initState();
    _initialize();
  }

  _initialize() async {
    setState(() {
      _controller.loading = true;
    });

    await _controller.fetchById(widget.movieId);

    setState(() {
      _controller.loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: _buildMovieDetail(),
    );
  }

  _buildAppBar() {
    return AppBar(
      title: Text(_controller.movieDetail?.title ?? ''),
    );
  }

  _buildMovieDetail() {
    if (_controller.loading) {
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

    if (_controller.movieError != null) {
      return CenteredMessage(message: _controller.movieError?.msg);
    }

    return Scaffold(
      backgroundColor: Colors.black,
      body: Container(
        decoration: BoxDecoration(
          borderRadius:
              const BorderRadius.only(bottomLeft: Radius.circular(50)),
          color: Colors.black,
          gradient: const LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color.fromARGB(255, 248, 248, 248),
                Color.fromARGB(0, 255, 255, 255)
              ]),
          image: DecorationImage(
            colorFilter: ColorFilter.mode(
                Colors.red.withOpacity(0.3), BlendMode.dstATop),
            image: NetworkImage(_buildCover()),
            fit: BoxFit.cover,
          ),
        ),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
          child: ListView(
            children: [
              _buildPoster(),
              _buildStatus(),
              _buildOverview(),
              ReviewWidget(movieId: widget.movieId),
              CommentListWidget(movieId: widget.movieId),
            ],
          ),
        ),
      ),
    );
  }

  _buildOverview() {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: const BoxDecoration(color: Color.fromARGB(255, 157, 27, 27)),
      child: Text(
        _controller.movieDetail?.overview ?? 'Essa seria a snipose',
        textAlign: TextAlign.justify,
        style: const TextStyle(
          color: Color.fromARGB(255, 255, 255, 255),
          height: 1.5,
          fontSize: 16,
        ),
      ),
    );
  }

  _buildStatus() {
    Size size = MediaQuery.of(context).size;
    return Container(
      width: size.width * 0.5,
      height: 80,
      padding: const EdgeInsets.only(left: 20),
      decoration: const BoxDecoration(
          color: Color.fromARGB(255, 157, 27, 27),
          boxShadow: [
            BoxShadow(
                offset: Offset(0, -10),
                blurRadius: 2,
                color: Color.fromARGB(255, 157, 27, 27))
          ]),
      child: Padding(
        padding: const EdgeInsets.only(left: 30, bottom: 20, top: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Rate(_controller.movieDetail?.voteAverage ?? 5),
            RatingUser(movieId: widget.movieId),
            ChipDate(date: _controller.movieDetail!.releaseDate),
          ],
        ),
      ),
    );
  }

  _buildCover() {
    const urlBasePhoto = ApiTMDB.urlBasePhoto;
    final urlPhoto = _controller.movieDetail?.posterPath ??
        '/5GA3vV1aWWHTSDO5eno8V5zDo8r.jpg';

    return '$urlBasePhoto$urlPhoto';
  }

  _buildPoster() {
    const urlBasePhoto = ApiTMDB.urlBasePhoto;
    final urlPhoto = _controller.movieDetail?.backdropPath ??
        '/5GA3vV1aWWHTSDO5eno8V5zDo8r.jpg';
    Size size = MediaQuery.of(context).size;
    return Column(
      children: <Widget>[
        Container(
          height: size.height * 0.3,
          child: Stack(
            children: <Widget>[
              Container(
                height: size.height * 0.6 - 50,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        fit: BoxFit.cover,
                        image: NetworkImage('$urlBasePhoto$urlPhoto'))),
              )
            ],
          ),
        )
      ],
    );
  }
}
