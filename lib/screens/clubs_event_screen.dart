import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../widgets/club_item.dart';

class CategoryMealsScreen extends StatelessWidget {
  static const routeName = '/category-meals';
  Container _titleSection(String title, String title2) {
      return Container(
        padding:
            const EdgeInsets.only(left: 32, right: 32, top: 32, bottom: 20),
        child: Row(
          children: [
            Expanded(
              /*1*/
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /*2*/
                  Container(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: Text(
                      title,
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
                    ),
                  ),
                  Text(
                    title2,
                    style: TextStyle(
                      color: Colors.grey[500],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    }

    Container _detailText(String label) {
      return Container(
        alignment: Alignment.centerLeft,
        padding: const EdgeInsets.only(left: 32, right: 32, top: 5, bottom: 5),
        child: Text(
          label,
          style: TextStyle(fontWeight: FontWeight.bold,color: Colors.blueAccent),
        ),
      );
    }

    Container _textSection(String description) {
      return Container(
        padding:
            const EdgeInsets.only(left: 32, right: 32, top: 10, bottom: 20),
        child: Text(
          description,
          softWrap: true,
        ),
      );
    }

    Stack _bodyField(DocumentSnapshot documentSnapshot) {
      return Stack(
        children: <Widget>[
          Container(
            child: Image.network(
              documentSnapshot['imageUrl'],
              width: 640,
              height: 255,
              fit: BoxFit.cover,
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 218),
            child: Card(
              margin: EdgeInsets.all(0),
              elevation: 2.0,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                topRight: Radius.circular(50.0),
              )),
              child: Align(
                child: Column(
                  children: <Widget>[
                    _titleSection(documentSnapshot['fullTitle'],
                        documentSnapshot['desc']),
                        _detailText("Department : " + documentSnapshot['department']),
                    _detailText("Email : " + documentSnapshot['headEmail']),
                    _detailText("Phone : " + documentSnapshot['headPhone'].toString()),
                    _detailText("Club Head : " + documentSnapshot['headName']),
                    _detailText("Founded At : " +
                        DateFormat("dd-MMMM-yyyy")
                            .format(documentSnapshot['founded'].toDate())),
                  ],
                ),
              ),
            ),
          ),
        ],
      );
    }
    Container _stream(categoryId) {
      return Container(
        child: StreamBuilder(
            stream: Firestore.instance
                .collection('Clubs')
                .document(categoryId)
                .snapshots(),
            builder: (context, snapshot) {
              if (!snapshot.hasData)
                return const Center(child: CircularProgressIndicator());
              return _bodyField(snapshot.data);
            }),
      );
    }
  StreamBuilder clubEvents(categoryTitle) { return StreamBuilder(
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
                  imageUrl: snapshot.data.documents[index]['imageUrl'].toString(),
                  eventname:
                      snapshot.data.documents[index]['title'].toString(),
                  venue: snapshot.data.documents[index]['venue'].toString(),
                  clubname: snapshot.data.documents[index]['clubname'],
                  id: snapshot.data.documents[index].documentID,
                  time: snapshot.data.documents[index]['date'],
                );
              });
        },
      );}
  @override
  Widget build(BuildContext context) {
    // final String url = 'https://cdn.pixabay.com/photo/2014/10/23/18/05/burger-500054_1280.jpg';
        final routeargs =
        ModalRoute.of(context).settings.arguments as Map<String, String>;
    final categoryTitle = routeargs['title'];
     final categoryId = routeargs['id'];
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          bottom: TabBar(
            tabs: [
              Tab(icon: Icon(Icons.calendar_today)),
              Tab(icon: Icon(Icons.person)),
            ],
          ),
          title: Text(categoryTitle),
        ),
        body: TabBarView(
          children: [
           clubEvents(categoryTitle),
            _stream(categoryId),
          ],
        ),
      ),
    );
  }
}
