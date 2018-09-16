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
            padding: EdgeInsets.all(30.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              mainAxisSize: MainAxisSize.max,
              children: [
                Container(
                  color: Colors.red,
                ),
                ConstrainedBox(
                    constraints: const BoxConstraints(minWidth: double.infinity),
                    child: RaisedButton(
                      color: Colors.deepPurple,
                      child: Text(
                        "ავტორიზაცია",
                        style: TextStyle(color: Colors.white),
                      ),
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => Login(title: 'ავტორიზაცია')));
                      },
                    )),
                SizedBox(height: 90.0)
              ],
            )));
  }
}
