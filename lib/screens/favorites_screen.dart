import 'package:flutter/material.dart';
import 'package:meals_app/widgets/main_drawer.dart';

class FavoritesScreen extends StatelessWidget {
  static const routeName = '/favorites';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Participated Events'),
      ),
      drawer: MainDrawer(),
      body: Center(
        child: Text('Favorites'),
      ),
    );
  }
}
