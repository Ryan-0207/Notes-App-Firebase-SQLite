import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';

class Viewnote extends StatefulWidget {
  final Map data;

  final DocumentReference ref;
  Viewnote({this.data, this.ref});

  @override
  _ViewnoteState createState() => _ViewnoteState();
}

class _ViewnoteState extends State<Viewnote> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(
                children: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Icon(
                      Icons.arrow_back_ios_sharp,
                      color: Colors.white,
                    ),
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all(Colors.grey[700]),
                      padding: MaterialStateProperty.all(EdgeInsets.all(12.0)),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      await widget.ref.delete();

                      setState(() {});
                      //delete card
                    },
                    child: Icon(Icons.delete),
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.black),
                      padding: MaterialStateProperty.all(EdgeInsets.all(12.0)),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.only(left: 15.0),
                child: Container(
                  alignment: Alignment.topLeft,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 15.0),
                      Text(
                        '${widget.data['title']}',
                        style: TextStyle(
                          fontSize: 36.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey[700],
                        ),
                      ),
                      SizedBox(height: 15.0),
                      SizedBox(height: 15.0),
                      Text(
                        '${widget.data['description']}',
                        style: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
