import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

// Create a Form widget.
class MyCustomForm extends StatefulWidget {
  @override
  MyCustomFormState createState() {
    return MyCustomFormState();
  }
}

// Create a corresponding State class.
// This class holds data related to the form.
class MyCustomFormState extends State<MyCustomForm> {
  // Create a global key that uniquely identifies the Form widget
  // and allows validation of the form.
  //
  // Note: This is a GlobalKey<FormState>,
  // not a GlobalKey<MyCustomFormState>.
  final _formKey = GlobalKey<FormState>();

  String eventName = "";
  String desc = "";
  String experName = "";

  @override
  Widget build(BuildContext context) {
    
    // Build a Form widget using the _formKey created above.
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          TextField(
            onChanged: (text){
              eventName = text;
            },
            decoration: InputDecoration(
              labelText: "Name",
              icon:Icon(Icons.event),
            ),
          ),
          TextField(
            onChanged: (text){
              desc = text; 
            },
            decoration: InputDecoration(
              labelText: "Descriptiom",
              icon:Icon(Icons.event_note),
            ),
          ),
          TextField(
            onChanged: (text){
              experName = text; 
            },
            decoration: InputDecoration(
              labelText: "Expert name",
              icon:Icon(Icons.person),
            ),
          ),

          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: Center(
              child: RaisedButton(
              onPressed: () {
                  Firestore.instance.runTransaction(
                    (Transaction transaction) async{
                      CollectionReference reference = Firestore.instance.collection('Events');
                      await reference.add({"eventName": eventName});
                    }
                  );
                },
                child: Text('Submit'),
              ),
            ),
            
          ),
        ],
      ),
    );
  }
}