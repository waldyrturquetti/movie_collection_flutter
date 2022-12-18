import 'package:flutter/material.dart';

class MovieCard extends StatelessWidget {
  final String posterPath;
  final VoidCallback onTap;

  const MovieCard({
    Key? key,
    required this.onTap,
    required this.posterPath,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          gradient: const LinearGradient(
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter,
              colors: [Colors.black, Colors.transparent]),
          boxShadow: const [
            BoxShadow(
              color: Colors.red,
              blurRadius: 1,
              offset: Offset(0, 4),
            )
          ],
          image: DecorationImage(
            image: NetworkImage(
              'https://image.tmdb.org/t/p/w220_and_h330_face/$posterPath',
            ),
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
