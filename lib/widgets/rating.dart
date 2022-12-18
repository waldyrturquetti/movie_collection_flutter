import 'package:flutter/material.dart';

class Rate extends StatelessWidget {
  final double value;

  // ignore: use_key_in_widget_constructors
  const Rate(this.value);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Image.asset('assets/images/tmdb.png'),
        const SizedBox(width: 8.0),
        Text(
          value.toStringAsFixed(1),
          style: const TextStyle(fontSize: 20, color: Colors.white),
        ),
      ],
    );
  }
}
