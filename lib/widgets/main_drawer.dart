import 'package:flutter/material.dart';
import 'package:meals_app/screens/favorites_screen.dart';

class MainDrawer extends StatelessWidget {
  final String userid;
  MainDrawer({this.userid});
  Widget buildListTile(String title, IconData icon, Function tapHandler) {
    return ListTile(
      leading: Icon(
        icon,
        size: 26,
      ),
      title: Text(
        title,
        style: TextStyle(
          fontFamily: 'RobotoCondensed',
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
      onTap: tapHandler,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
          Container(
            height: 200,
            width: double.infinity,
            padding: EdgeInsets.all(15),
            alignment: Alignment.bottomLeft,
            color: Theme.of(context).primaryColor,
            child: Text(
              'Clubs And Events',
              style: TextStyle(
                //backgroundColor: Theme.of(context).primaryColor,
                fontSize: 24,
                color: Colors.white,
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          buildListTile(
            'Home',
            Icons.home,
            () {
              Navigator.of(context).pushReplacementNamed('/');
            },
          ),
          buildListTile(
            'Participated Events',
            Icons.person_add,
            () {
              Navigator.of(context)
                  .pushReplacementNamed(FavoritesScreen.routeName);
            },
          ),
          buildListTile(
            'Logout',
            Icons.settings_power,
            () {},
          ),
        ],
      ),
    );
  }
}
