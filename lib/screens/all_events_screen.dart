import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../widgets/club_item.dart';
class AllEventsScreen extends StatelessWidget {
  //  final String url =
      // 'https://firebasestorage.googleapis.com/v0/b/clubsandevents-686b9.appspot.com/o/Unknown.png?alt=media&token=11499eb1-def9-41e0-b468-7c6ac7faa2a1';
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: Firestore.instance.collection('Events').orderBy('date', descending: true).snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) return Center(child: CircularProgressIndicator(),);
        return ListView.builder(
            padding: EdgeInsets.all(30),
            addRepaintBoundaries: true,
            itemCount: snapshot.data.documents.length,
            itemBuilder: (context, index) {
              return ClubItem(
                title: snapshot.data.documents[index]['eventName'].toString(),
                imageUrl: snapshot.data.documents[index]['imageUrl'].toString(),
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