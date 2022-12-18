import 'package:flutter/material.dart';
import 'package:flutter_review_app/models/comment_model.dart';
import 'package:flutter_review_app/repository/comment_repository.dart';
import 'package:provider/provider.dart';

class CommentListWidget extends StatefulWidget {
  final int movieId;

  const CommentListWidget({Key? key, required this.movieId}) : super(key: key);

  @override
  State<CommentListWidget> createState() => _CommentListWidget();
}

class _CommentListWidget extends State<CommentListWidget> {
  List<CommentModel> _list = [];

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<CommentModel>>(
        future: context.read<CommentRepository>().readComments(widget.movieId),
        builder:
            (BuildContext context, AsyncSnapshot<List<CommentModel>> snapshot) {
          if (snapshot.hasData) {
            _list = snapshot.requireData;
          }
          return GestureDetector(
              onTap: () => showModalBottomSheet(
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(16),
                        topLeft: Radius.circular(16)),
                  ),
                  context: context,
                  builder: (context) {
                    return Container(
                      padding: const EdgeInsets.all(16),
                      height: MediaQuery.of(context).size.height * 0.4,
                      child: Column(
                        children: [
                          Row(
                            children: const [
                              Text("Comentários"),
                              Icon(Icons.star)
                            ],
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          ..._list.map((e) => _SingleComment(
                              commentData: _list[_list.indexOf(e)]))
                        ],
                      ),
                    );
                  }),
              child: Container(
                margin: const EdgeInsets.all(8.0),
                padding: const EdgeInsets.all(8.0),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Icon(Icons.comment, color: Colors.yellow),
                      const Text(
                        "Comentários",
                        style: TextStyle(color: Colors.yellow),
                      ),
                      Text(
                        _list.length.toString(),
                        style: const TextStyle(color: Colors.yellow),
                      ),
                    ]),
              ));
        });
  }
}

class _SingleComment extends StatelessWidget {
  final CommentModel commentData;

  const _SingleComment({Key? key, required this.commentData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        width: double.infinity,
        margin: const EdgeInsets.symmetric(vertical: 2.0),
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                commentData.comment,
                textAlign: TextAlign.left,
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(commentData.note.toString()),
                  const Icon(Icons.star),
                ],
              )
            ],
          ),
        )
    );
  }
}
