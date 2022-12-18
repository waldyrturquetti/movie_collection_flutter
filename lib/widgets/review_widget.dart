import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_review_app/models/comment_model.dart';
import 'package:flutter_review_app/repository/comment_repository.dart';
import 'package:provider/provider.dart';

class ReviewWidget extends StatefulWidget {
  final int movieId;

  const ReviewWidget({Key? key, required this.movieId}) : super(key: key);

  @override
  State<ReviewWidget> createState() => _ReviewWidget();
}

class _ReviewWidget extends State<ReviewWidget> {
  final formKey = GlobalKey<FormState>();
  final comment = TextEditingController();
  double note = 1.0;

  @override
  void initState() {
    super.initState();
    comment.value = const TextEditingValue(text: '');
    setState (() {
      note = 1.0;
    });
    getComment();
  }

  getComment() async {
    CommentModel commentModel = await context.read<CommentRepository>().getCommentByUserAndMovie(widget.movieId);
    comment.value = TextEditingValue(text: commentModel.comment);
    setState (() {
      note = commentModel.note;
    });
  }

  saveComment() async {
    try {
      await context
          .read<CommentRepository>()
          .saveComment(widget.movieId, comment.text, note);
    } on Exception catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.toString())));
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(0),
          gradient: const LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Color.fromARGB(255, 157, 27, 27), Colors.transparent]),
        ),
        child: Padding(
            padding: const EdgeInsets.only(top: 30),
            child: Form(
                key: formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    RatingBar.builder(
                      initialRating: note,
                      minRating: 1,
                      direction: Axis.horizontal,
                      allowHalfRating: true,
                      itemCount: 5,
                      itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
                      itemBuilder: (context, _) => const Icon(
                        Icons.star,
                        color: Colors.yellow,
                      ),
                      onRatingUpdate: (rating) {
                        note = rating;
                      },
                    ),
                    Padding(
                      padding: const EdgeInsets.all(50),
                      child: Container(
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                                Color.fromARGB(255, 170, 170, 170),
                                Color.fromARGB(255, 44, 44, 48)
                              ]),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: TextFormField(
                            controller: comment,
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Comentar',
                            ),
                            keyboardType: TextInputType.text,
                            validator: (String? value) {
                              if (value != null && value.isEmpty) {
                                return 'Informe um comentário';
                              } else if (value != null && value.length < 10) {
                                return 'Informe um comentário coerente';
                              }
                              return null;
                            }),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(15),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.yellow),
                        onPressed: () {
                          if (formKey.currentState!.validate()) {
                            saveComment();
                          }
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Icon(Icons.save, color: Colors.black),
                            Padding(
                              padding: EdgeInsets.all(16),
                              child: Text(
                                "Salvar",
                                style: TextStyle(
                                    fontSize: 20, color: Colors.black),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ))),
      ),
    );
  }
}
