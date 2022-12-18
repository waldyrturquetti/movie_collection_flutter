import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_review_app/databases/dbfirestore.dart';
import 'package:flutter_review_app/models/comment_model.dart';
import 'package:flutter_review_app/services/auth_service.dart';
import 'package:flutter/material.dart';

class CommentRepository extends ChangeNotifier {
  List<CommentModel> _list = [];
  List<CommentModel> _listNotes = [];
  CommentModel commentModel = CommentModel('', 1, DateTime.now());
  late FirebaseFirestore db;
  late AuthService auth;

  CommentRepository({required this.auth}) {
    _startRepository();
  }

  _startRepository() async {
    await _startFirestore();
  }

  _startFirestore() {
    db = DBFirestore.get();
  }

  saveComment(int movieId, String comment, double note) {
    db
        .collection('comments')
        .doc(movieId.toString())
        .collection('users')
        .doc(auth.user!.uid.toString())
        .set({
      'comment': comment,
      'note': note,
      'date': DateTime.now(),
    });
  }

  Future<List<CommentModel>> readComments(int movieId) async {
    _list.clear();
    if (auth.user != null) {
      await db
          .collection('comments')
          .doc(movieId.toString())
          .collection('users')
          .get()
          .then(
            (res) => {
              res.docs.forEach((element) {
                _list.add(CommentModel(element.data()["comment"],
                    element.data()["note"], element.data()["date"].toDate()));
              })
            },
            onError: (e) => print(e),
          );
    }
    return _list;
  }

  Future<CommentModel> getCommentByUserAndMovie(int movieId) async {
    if (auth.user != null) {
      await db
          .collection('comments')
          .doc(movieId.toString())
          .collection('users')
          .doc(auth.user!.uid)
          .get()
          .then(
            (value) => {
              if (value.data() != null)
                {
                  commentModel = CommentModel(value.data()!["comment"],
                      value.data()!["note"], value.data()!["date"].toDate())
                }
              else
                {commentModel = CommentModel('', 1, DateTime.now())}
            },
            onError: (e) => print(e),
          );
    }

    return commentModel;
  }

  Future<double> readNotas(int movieId) async {
    _listNotes.clear();

    if (auth.user != null) {
      await db
          .collection('comments')
          .doc(movieId.toString())
          .collection('users')
          .get()
          .then(
            (res) => {
              res.docs.forEach((element) {
                _listNotes.add(CommentModel(element.data()["comment"],
                    element.data()["note"], element.data()["date"].toDate()));
              })
            },
            onError: (e) => print(e),
          );
    }

    return _listNotes
            .map((e) => e.note)
            .reduce((value, element) => value + element) /
        _listNotes.length;
  }
}
