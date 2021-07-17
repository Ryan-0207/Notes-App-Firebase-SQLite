import 'dart:math';

import 'package:flutter/material.dart';
//import 'package:intl/intl.dart';
import 'package:notes_app/Viewnote.dart';
import 'package:notes_app/addnote.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:notes_app/database.dart';
import 'package:notes_app/google_auth.dart';
import 'package:notes_app/login.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  CollectionReference ref = FirebaseFirestore.instance
      .collection('users')
      .doc(FirebaseAuth.instance.currentUser.uid)
      .collection('notes');

  List<Color> mycolour = [
    Colors.red,
    Colors.yellow[200],
    Colors.deepPurple[200]
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Notes',
          style: TextStyle(
              fontSize: 25.0,
              fontWeight: FontWeight.bold,
              color: Colors.white54),
        ),
        backgroundColor: Colors.black,
        actions: [
          ElevatedButton(
            onPressed: () async {
              await deleteAll();
              signout();

              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (context) => Loginpage(),
                ),
              );
            },
            child: Text(
              'Signout',
              style: TextStyle(
                  fontSize: 25.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.white54),
            ),
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(Colors.black),
              padding: MaterialStateProperty.all(EdgeInsets.all(12.0)),
            ),
          )
        ],
      ),
      body: FutureBuilder<QuerySnapshot>(
        future: ref.get(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
                itemCount: snapshot.data.docs.length,
                itemBuilder: (context, index) {
                  Random random = new Random();
                  Color bg = mycolour[random.nextInt(3)];
                  Map data = snapshot.data.docs[index].data();

                  DocumentReference ref1 = snapshot.data.docs[index].reference;

                  return InkWell(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) =>
                              Viewnote(data: data, ref: ref1)));
                    },
                    child: Card(
                      color: bg,
                      child: Padding(
                        padding: EdgeInsets.all(15.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '${data['title']}',
                              style: TextStyle(
                                fontSize: 24.0,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 12.0),
                              child: Text(
                                '${data['description']}',
                                style: TextStyle(
                                  fontSize: 15.0,
                                  color: Colors.black,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                ElevatedButton(
                                  onPressed: () async {
                                    await ref1.delete();

                                    setState(() {});
                                    //delete card
                                  },
                                  child: Icon(
                                    Icons.delete,
                                  ),
                                  style: ButtonStyle(
                                    backgroundColor:
                                        MaterialStateProperty.all(Colors.black),
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  );
                });
          } else {
            return Center(
              child: Text('Loading....'),
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => Addnote(),
            ),
          ).then((value) {
            setState(() {});
          });
        },
        child: Icon(
          Icons.article_rounded,
          color: Colors.grey[700],
        ),
      ),
    );
  }
}
