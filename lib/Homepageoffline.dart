import 'dart:math';

import 'package:flutter/material.dart';

import 'package:notes_app/Viewpageoffline.dart';

import 'package:notes_app/database.dart';

class HomePage2 extends StatefulWidget {
  @override
  _HomePage2State createState() => _HomePage2State();
}

class _HomePage2State extends State<HomePage2> {
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
          'Notes Offline',
          style: TextStyle(
              fontSize: 25.0,
              fontWeight: FontWeight.bold,
              color: Colors.white54),
        ),
        backgroundColor: Colors.black,
        centerTitle: true,
      ),
      body: FutureBuilder(
        future: getdogs(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: (context, index) {
                  Random random = new Random();
                  Color bg = mycolour[random.nextInt(3)];
                  final notes = snapshot.data[index];

                  return InkWell(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => Viewnote2(data: notes)));
                    },
                    child: Card(
                      color: bg,
                      child: Padding(
                        padding: EdgeInsets.all(15.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '${notes['title']}',
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
                                '${notes['description']}',
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
                                    await deleteDog(notes['id']);

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
                            ),
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
    );
  }
}
