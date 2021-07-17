import 'package:flutter/material.dart';

import 'google_auth.dart';

class Loginpage extends StatefulWidget {
  @override
  _LoginpageState createState() => _LoginpageState();
}

class _LoginpageState extends State<Loginpage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Column(
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('assets/images/cover.jpg'))),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 10.0),
            child: Text(
              'Create And Manage',
              style: TextStyle(fontSize: 36.0),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.0),
            child: ElevatedButton(
              onPressed: () async {
                signInWIthGoogle(context);
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) => Loginpage()));
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Sign In With Google',
                    style: TextStyle(fontSize: 20.0),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Image.asset(
                    'assets/images/google-logo.png',
                    height: 32.0,
                  )
                ],
              ),
              style: ElevatedButton.styleFrom(
                  primary: Colors.grey[700],
                  padding: EdgeInsets.symmetric(
                    vertical: 12.0,
                  )),
            ),
          ),
          SizedBox(
            height: 10.0,
          ),
        ],
      )),
    );
  }
}
