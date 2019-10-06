import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../widgets/category_item.dart';

class ClubsScreen extends StatefulWidget {
  @override
  _ClubsScreenState createState() => _ClubsScreenState();
}

class _ClubsScreenState extends State<ClubsScreen> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: Firestore.instance.collection('Clubs').snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) return Center(child: CircularProgressIndicator(),);
        return ListView.builder(
          padding: EdgeInsets.all(30),
          addRepaintBoundaries: true,
          itemCount: snapshot.data.documents.length,
          itemExtent: 80.0,
          itemBuilder: (context, index) => CategoryItem(
            id: snapshot.data.documents[index].documentID,
            title: snapshot.data.documents[index]['title'],
            departmemt: snapshot.data.documents[index]['department'],
          ),
        );
      },
    );
  }
}
