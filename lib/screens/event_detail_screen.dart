import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meals_app/models/screen_arguments.dart';
import 'add_event_screen.dart';
import 'package:intl/intl.dart';

class EventDetailScreen extends StatelessWidget {
  static final routeName = '/meal_detail';

  @override
  Widget build(BuildContext context) {
    final ScreenArguments screenArguments =
        ModalRoute.of(context).settings.arguments;
    // Card _list(DocumentSnapshot document, String date) {
    //   return Card(
    //     elevation: 3,
    //     child: Row(
    //       crossAxisAlignment: CrossAxisAlignment.start,
    //       children: <Widget>[
    //         Container(
    //           padding: const EdgeInsets.all(8),
    //           child: Image.asset(
    //             'lib/images/lake.jpg',
    //             width: 65,
    //             height: 65,
    //             fit: BoxFit.cover,
    //           ),
    //         ),
    //         Expanded(
    //           child: Column(children: <Widget>[
    //             Container(
    //               alignment: Alignment.centerLeft,
    //               padding: const EdgeInsets.only(top: 25, left: 10),
    //               child: Text(
    //                 document['eventName'],
    //                 style: TextStyle(
    //                   fontSize: 20,
    //                 ),
    //               ),
    //             ),
    //             Container(
    //               alignment: Alignment.center,
    //               padding: const EdgeInsets.only(left: 10, top: 5),
    //               child: Text(date),
    //             ),
    //           ]),
    //         ),
    //       ],
    //     ),
    //   );
    // }

    // final List<String> entries = <String>["web", "app", "flutter","dark_web","react"];
    // final List<String> date = <String>[
    //   "21 May, 2019",
    //   "21 May, 2019",
    //   "21 May, 2019",
    //   "21 May, 2019",
    //   "21 May, 2019",
    //   "21 May, 2019",
    // ];
    // Widget list = StreamBuilder(
    //     stream: Firestore.instance.collection('Events').snapshots(),
    //     builder: (context, snapshot) {
    //       if (!snapshot.hasData) return const Text("Loading....");
    //       return ListView.builder(
    //         itemCount: snapshot.data.documents.length,
    //         itemBuilder: (BuildContext context, int index) {
    //           return _list(snapshot.data.documents[index], date[index]);
    //         },
    //       );
    //     }

    //     // ListView.builder(
    //   itemCount: entries.length,
    //   itemBuilder: (BuildContext context, int index){
    //     return _list(entries[index],date[index]);
    //   },
    // )
    // );

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
            /*3*/
            Icon(
              Icons.star,
              color: Colors.red[500],
            ),
            Text('11'),
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
          style: TextStyle(fontWeight: FontWeight.bold),
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
            child: Image.asset(
              'lib/images/lake.jpg',
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
                    _titleSection(documentSnapshot['eventName'],
                        documentSnapshot['desc']),
                    _textSection(documentSnapshot['title']),
                    _detailText("Venue : " + documentSnapshot['venue']),
                    _detailText("Club : " + documentSnapshot['clubname']),
                    _detailText("Date : " +
                        DateFormat("dd-MMMM-yyyy")
                            .format(documentSnapshot['date'].toDate())),
                    _detailText("Time : " +
                        DateFormat("HH:mm")
                            .format(documentSnapshot['date'].toDate())),
                  ],
                ),
              ),
            ),
          ),
        ],
      );
    }

    Container _stream() {
      return Container(
        child: StreamBuilder(
            stream: Firestore.instance
                .collection('Events')
                .document(screenArguments.id)
                .snapshots(),
            builder: (context, snapshot) {
              if (!snapshot.hasData)
                return const Center(child: CircularProgressIndicator());
              return _bodyField(snapshot.data);
            }),
      );
    }

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          bottom: TabBar(
            tabs: [
              Tab(icon: Icon(Icons.home)),
              Tab(icon: Icon(Icons.add)),
            ],
          ),
          title: Text(screenArguments.eventName),
        ),
        floatingActionButton: FloatingActionButton(
          child: Text('Register'),
          backgroundColor: Colors.blue,
          onPressed: () {},
        ),
        body: TabBarView(
          children: [
            _stream(),
            MyCustomForm(),
          ],
        ),
      ),
    );
  }
}
