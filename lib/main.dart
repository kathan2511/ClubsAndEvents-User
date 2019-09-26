import 'package:flutter/material.dart';
import 'package:meals_app/screens/clubs_event_screen.dart';
import 'package:meals_app/screens/favorites_screen.dart';
import './screens/event_detail_screen.dart';
import './authentication/root_page.dart';
import './authentication/authentication.dart';
void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ClubsAndEvents',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        accentColor: Colors.lightBlueAccent,
        textTheme: ThemeData.light().textTheme.copyWith(
              body1: TextStyle(color: Colors.indigo),
              body2: TextStyle(color: Colors.indigoAccent),
              title: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
            ),
      ),
      home: RootPage(auth: new Auth()),
      debugShowCheckedModeBanner: false,
      routes: {
        // '/' : (ctx) => TabsScreen(),
        CategoryMealsScreen.routeName: (ctx) => CategoryMealsScreen(),
        EventDetailScreen.routeName: (ctx) => EventDetailScreen(),
        FavoritesScreen.routeName: (ctx) => FavoritesScreen(),
      },
    );
  }
}
