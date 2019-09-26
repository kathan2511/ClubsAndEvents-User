import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../widgets/club_item.dart';

class CategoryMealsScreen extends StatelessWidget {
// final String categoryId;
// final String caterogyTitle;

// CategoryMealsScreen(this.categoryId,this.caterogyTitle);
  static const routeName = '/category-meals';
  @override
  Widget build(BuildContext context) {
    final String url = 'https://cdn.pixabay.com/photo/2014/10/23/18/05/burger-500054_1280.jpg';
        final routeargs =
        ModalRoute.of(context).settings.arguments as Map<String, String>;
    final categoryTitle = routeargs['title'];
    return Scaffold(
      appBar: AppBar(
        title: Text(
          categoryTitle,
        ),
      ),
      body: StreamBuilder(
        stream: Firestore.instance
            .collection('Events')
            .where('clubname', isEqualTo: categoryTitle)
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) return const Center(child: CircularProgressIndicator(),);
          return ListView.builder(
              padding: EdgeInsets.all(30),
              addRepaintBoundaries: true,
              itemCount: snapshot.data.documents.length,
              itemBuilder: (context, index) {
                return ClubItem(
                  title: snapshot.data.documents[index]['eventName'].toString(),
                  imageUrl: url,
                  eventname:
                      snapshot.data.documents[index]['title'].toString(),
                  venue: snapshot.data.documents[index]['venue'].toString(),
                  clubname: snapshot.data.documents[index]['clubname'],
                  id: snapshot.data.documents['index']['documentID'],
                  time: snapshot.data.documents[index]['date'],
                );
              });
        },
      ),
    );
  }
}
