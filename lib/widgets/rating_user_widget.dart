import 'package:flutter/material.dart';
import 'package:flutter_review_app/repository/comment_repository.dart';
import 'package:provider/provider.dart';

class RatingUser extends StatefulWidget {
  final int movieId;

  const RatingUser({Key? key, required this.movieId}) : super(key: key);

  @override
  State<RatingUser> createState() => _RatingUsers();
}

class _RatingUsers extends State<RatingUser> {
  var notes = 0.0;

  @override
  void initState() {
    super.initState();
    getNotes();
  }

  getNotes() async {
    notes = (await context.read<CommentRepository>().readNotas(widget.movieId));

    setState(() {
      notes;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      Image.asset('assets/images/star.png'),
      const SizedBox(width: 1),
      Text(
        '$notes',
        style: const TextStyle(fontSize: 20, color: Colors.white),
      ),
    ]);
  }
}
