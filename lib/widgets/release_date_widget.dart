import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/constantes_model.dart';

class ChipDate extends StatelessWidget {
  final DateTime? date;
  final Color color;
  final String dateFormat;

  const ChipDate(
      {Key? key,
      @required this.date,
      this.color = Colors.transparent,
      this.dateFormat = newDateFormat})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Chip(
      backgroundColor: color.withOpacity(0.9),
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      avatar: const CircleAvatar(
        backgroundColor: Colors.transparent,
        child: Icon(
          Icons.calendar_today,
          size: 18,
          color: Colors.white,
        ),
      ),
      label: Text(
        DateFormat(dateFormat).format(date!),
        textAlign: TextAlign.end,
        style: const TextStyle(
          fontSize: 18,
          color: Colors.white,
        ),
      ),
    );
  }
}
