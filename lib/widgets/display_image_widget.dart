import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_review_app/constants/globals.dart';

class DisplayImage extends StatelessWidget {
  final String imagePath;

  const DisplayImage({
    Key? key,
    required this.imagePath,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Stack(children: [
      buildImage(const Color.fromARGB(255, 255, 57, 57)),
      Positioned(
        right: 4,
        top: 10,
        child: buildEditIcon(Colors.white),
      )
    ]));
  }

  Widget buildImage(Color color) {

    final String path = imagePath.isNotEmpty ? imagePath : Globals.defaultImage;

    final image = path.contains('https://')
        ? NetworkImage(path)
        : FileImage(File(path));

    return CircleAvatar(
      radius: 75,
      backgroundColor: color,
      child: CircleAvatar(
        backgroundImage: image as ImageProvider,
        radius: 70,
      ),
    );
  }

  Widget buildEditIcon(Color color) => buildCircle(
      all: 8,
      child: Icon(
        Icons.edit,
        color: color,
        size: 20,
      ));

  Widget buildCircle({
    required Widget child,
    required double all,
  }) =>
      ClipOval(
          child: Container(
        padding: EdgeInsets.all(all),
        color: Colors.black,
        child: child,
      ));
}
