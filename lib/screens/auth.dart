import 'package:flutter/material.dart';
import 'package:qr_pay/screens/cardList.dart';
import 'package:qr_pay/screens/login.dart';
import 'package:qr_pay/screens/qr.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Auth extends StatefulWidget {
  @override
  _AuthState createState() => new _AuthState();
}

class _AuthState extends State<Auth> {
  initState() {
    super.initState();
  }

  checkLoggedIn() async {
    final prefs = await SharedPreferences.getInstance();
    bool isLoggedIn = prefs.getBool('isLoggedIn');
    if (isLoggedIn) {
      Navigator.pop(context);
      Navigator.push(context, MaterialPageRoute(builder: (context) => CardList()));
    }
  }

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
                    Navigator.push(context, MaterialPageRoute(builder: (context) => Login(title: 'ავტორიზაცია')));
                  },
                ),
                OutlineButton(child: Text("რეგისტრაცია"), onPressed: () {}),
              ],
            )));
  }
}
