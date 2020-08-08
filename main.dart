import 'package:flutter/material.dart';

import 'package:firebase_database/firebase_database.dart';

void main() {
  runApp(MaterialApp(
    home: Home(),
  ));
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<String> pendingworks = ['Cook Food', 'Buy Groceries', 'Work Hard'];
  final _controller = TextEditingController();
  final db = FirebaseDatabase.instance.reference();

  Widget worklist(work) {
    return Card(
      margin: EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 0.0),
      child: Padding(
        padding: EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            SizedBox(
              height: 1.0,
            ),
            Row(
              children: <Widget>[
                Text(
                  work,
                  style: TextStyle(fontSize: 14.0, color: Colors.grey[600]),
                ),
                FlatButton(
                  child: Icon(Icons.delete),
                  onPressed: () => {
                    setState(() {
                      pendingworks.remove(work);
                    })
                  },
                ),
              ],
            ),
            SizedBox(
              height: 1.0,
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomPadding: false,
        backgroundColor: Colors.grey[200],
        appBar: AppBar(
          backgroundColor: Colors.black,
          title: Text('Tasks',
              style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.0,
                  fontFamily: 'IndieFlower')),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Column(
                children: pendingworks.map((work) => worklist(work)).toList(),
              ),
              Column(
                children: <Widget>[
                  Card(
                      margin: EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 0.0),
                      child: TextField(
                        cursorColor: Colors.black,
                        controller: _controller,
                        decoration: InputDecoration(
                            prefixIcon: Icon(
                              Icons.message,
                              color: Colors.black,
                            ),
                            hintText: 'Add Note'),
                      )),
                ],
              ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          elevation: 0,
          backgroundColor: Colors.black,
          child: Icon(Icons.add),
          onPressed: () {
            setState(() {
              pendingworks.add(_controller.text);
            });
            _controller.clear();
          },
        ));
  }
}
