import 'package:flutter/material.dart';

class Category {
  final String id;
  final String title; // Italian, vegetarian...
  final Color color; //background color

  const Category({
    @required this.id,
    @required this.title,
    this.color = Colors.orange,
  });
}
