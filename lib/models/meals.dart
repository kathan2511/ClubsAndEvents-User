import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

enum Complexity {
  Simple,
  Challenging,
  Hard,
}

class Meal {
  final String id;
  final List<String> categories;
  final String title;
  final String imageUrl;
  final String venue;
  final List<String> volunteers;
  final String clubname;
  final bool isTechEvent;

  const Meal({
    @required this.id,
    @required this.categories,
    @required this.title,
    @required this.clubname,
    @required this.imageUrl,
    @required this.venue,
    @required this.volunteers,
    @required this.isTechEvent
  });
}
