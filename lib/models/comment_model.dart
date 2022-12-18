class CommentModel {
  final String comment;
  final double note;
  final DateTime date;

  CommentModel(this.comment, this.note, this.date);

  @override
  String toString() {
    return 'CommentModel{comment: $comment, note: $note,}';
  }
}
