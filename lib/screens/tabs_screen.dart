import 'package:flutter/material.dart';
import 'package:meals_app/authentication/authentication.dart';
import 'package:meals_app/screens/all_events_screen.dart';
import 'package:meals_app/screens/clubs_screen.dart';
import 'package:meals_app/widgets/main_drawer.dart';

class TabsScreen extends StatefulWidget {

final BaseAuth auth;
final VoidCallback onSignedOut;
final String userId;
final String username;

TabsScreen({Key key, this.auth, this.userId, this.onSignedOut,this.username})
      : super(key: key);


  @override
  _TabsScreenState createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {

  _signOut() async {
    try {
      await widget.auth.signOut();
      widget.onSignedOut();
    } catch (e) {
      print(e);
    }
  }

   

  final List<Map<String, Object>> _pages = [
    {'page': AllEventsScreen(), 'title': "Events",},
    {'page': ClubsScreen(), 'title': "Clubs",}
  ];
  int _selectedPageIndex = 0;
  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_pages[_selectedPageIndex]['title']),
        actions: <Widget>[
            new IconButton(
              icon: Icon(Icons.power_settings_new),
              onPressed: _signOut,
            )
          ],
      ),
      drawer: MainDrawer(userid: widget.username,),
      body: _pages[_selectedPageIndex]['page'],
      bottomNavigationBar: BottomNavigationBar(
        onTap: _selectPage,
        selectedItemColor: Colors.yellow,
        unselectedItemColor: Colors.white,
        backgroundColor: Theme.of(context).primaryColor,
        currentIndex: _selectedPageIndex,
        //type: BottomNavigationBarType.shifting,
        items: [
          BottomNavigationBarItem(
            //backgroundColor: Theme.of(context).primaryColor,
            icon: Icon(Icons.home),
            title: Text(
              'Events',
            ),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.category),
            title: Text(
              'Clubs',
            ),
          ),
        ],
      ),
    );
  }
}
