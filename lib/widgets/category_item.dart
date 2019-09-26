import 'package:flutter/material.dart';
import 'package:meals_app/screens/clubs_event_screen.dart';

class CategoryItem extends StatelessWidget {
  final String id;
  final String title;
  final String departmemt;

  CategoryItem({this.id, this.title, this.departmemt});

  void selectCategory(BuildContext context) {
    Navigator.of(context).pushNamed(
      CategoryMealsScreen.routeName,
      arguments: {
        'id': id,
        'title': title,
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => selectCategory(context),
      splashColor: Theme.of(context).primaryColor,
      child: Container(
        child: Card(
          color: Colors.blue,
          child: ListTile(
            subtitle: Text(
              departmemt,
              style: TextStyle(color: Colors.black),
            ),
            title: Text(
              title,
              style: Theme.of(context).textTheme.title,
            ),
          ),
        ),
      ),
    );
  }
}
