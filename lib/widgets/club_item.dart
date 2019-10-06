import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:meals_app/models/screen_arguments.dart';
import '../screens/event_detail_screen.dart';
import 'package:intl/intl.dart';

class ClubItem extends StatelessWidget {
  final String title;
  final String imageUrl;
  final String eventname;
  final String clubname;
  final String venue;
  final String id;
  final Timestamp time;
  final bool participated;

  ClubItem({
    @required this.title,
    @required this.imageUrl,
    @required this.eventname,
    @required this.clubname,
    @required this.venue,
    @required this.id,
    @required this.time,
    this.participated = false,
  });

  void selectEvent(BuildContext context) {
    Navigator.of(context).pushNamed(EventDetailScreen.routeName, arguments: ScreenArguments(eventName: title,id: id));
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => selectEvent(context),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        elevation: 4,
        margin: EdgeInsets.all(10),
        child: Column(
          children: <Widget>[
            Stack(
              children: <Widget>[
                ClipRRect(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(15),
                    topRight: Radius.circular(15),
                  ),
                  child: Image.network(
                    imageUrl.toString(),
                    height: 200,
                    width: double.infinity,
                    fit: BoxFit.fitWidth,
                  ),
                ),
                Positioned(
                  bottom: 20,
                  right: 10,
                  child: Container(
                    width: 300,
                    color: Colors.black54,
                    padding: EdgeInsets.symmetric(
                      vertical: 5,
                      horizontal: 20,
                    ),
                    child: Text(
                      title,
                      style: TextStyle(
                        fontSize: 26,
                        color: Colors.white,
                      ),
                      softWrap: true,
                      overflow: TextOverflow.fade,
                    ),
                  ),
                )
              ],
            ),
            Padding(
              padding: EdgeInsets.all(20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Icon(
                        Icons.calendar_today,
                      ),
                      SizedBox(
                        width: 6,
                      ),
                      Text(DateFormat.yMMMd().format(time.toDate())),
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      Icon(
                        Icons.category,
                      ),
                      SizedBox(
                        width: 6,
                      ),
                      Text('$clubname'),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
