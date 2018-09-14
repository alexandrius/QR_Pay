import 'package:flutter/material.dart';
import 'package:qr_pay/screens/login.dart';

class Auth extends StatefulWidget {
  @override
  _AuthState createState() => new _AuthState();
}

class _AuthState extends State<Auth> {
  build(context) {
    return new Scaffold(
        appBar: AppBar(
          title: Text("QR Pay"),
        ),
        body: Container(
            padding: EdgeInsets.all(10.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: [
                Container(
                  color: Colors.red,
                ),
                OutlineButton(
                  child: Text("ავტორიზაცია"),
                  onPressed: () {
                    Navigator.push(
                        context,
                    MaterialPageRoute(builder: (context) => MyHomePage(title: 'ავტორიზაცია')));
                  },
                ),
                OutlineButton(child: Text("რეგისტრაცია"), onPressed: () {}),
              ],
            )));
  }
}
