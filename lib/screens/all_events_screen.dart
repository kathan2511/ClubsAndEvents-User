import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../widgets/club_item.dart';
class AllEventsScreen extends StatelessWidget {
   final String url =
      'https://cdn.pixabay.com/photo/2014/10/23/18/05/burger-500054_1280.jpg';
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: Firestore.instance.collection('Events').orderBy('date', descending: true).snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) return const Text('Loading...');
        return ListView.builder(
            padding: EdgeInsets.all(30),
            addRepaintBoundaries: true,
            itemCount: snapshot.data.documents.length,
            itemBuilder: (context, index) {
              return ClubItem(
                title: snapshot.data.documents[index]['eventName'].toString(),
                imageUrl: url,
                eventname: snapshot.data.documents[index]['title'].toString(),
                venue: snapshot.data.documents[index]['venue'].toString(),
                clubname: snapshot.data.documents[index]['clubname'],
                id: snapshot.data.documents[index].documentID,
                time: snapshot.data.documents[index]['date'],
              );
            });
      },
    );
  }
}