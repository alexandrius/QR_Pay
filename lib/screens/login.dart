import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:qr_pay/screens/cardList.dart';
import 'package:qr_pay/screens/manageMoney.dart';
import 'package:qr_pay/screens/qr.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Login extends StatefulWidget {
  Login({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _LoginState createState() => new _LoginState();
}

class _LoginState extends State<Login> {
  var waitsForSMS = false;
  var _animatedHeight = 0.0;
  var loading = false;
  TextEditingController phoneController;
  TextEditingController smsController;
  bool phoneControllerExecutedCommand;
  bool smsControllerExecutedCommand;

  @override
  void initState() {
    phoneControllerExecutedCommand = false;
    smsControllerExecutedCommand = false;

    phoneController = TextEditingController()
      ..addListener(() {
        if (phoneController.text.length == 9 && !phoneControllerExecutedCommand) {
          phoneControllerExecutedCommand = true;
          setState(() {
            waitsForSMS = true;
            _animatedHeight = 80.0;
          });

          Timer(const Duration(milliseconds: 500), () {
            setState(() {
              var rng = new Random();
              smsController.text = rng.nextInt(9999).toString();
            });
          });
        } else {
          setState(() {
            waitsForSMS = false;
            _animatedHeight = 0.0;
          });
        }
      });

    smsController = TextEditingController()
      ..addListener(() {
        if (smsController.text.length == 4 && !smsControllerExecutedCommand) {
          smsControllerExecutedCommand = true;
          setState(() {
            loading = true;
            Timer(const Duration(milliseconds: 1000), () {
              setLoggedIn();
            });
          });
        }
      });
    super.initState();
  }

  setLoggedIn() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isLoggedIn', true);
    await prefs.setString('phone', phoneController.text);
    Navigator.pop(context);
    Navigator.push(context, MaterialPageRoute(builder: (context) => CardList()));
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: Container(
            padding: EdgeInsets.all(10.0),
            child: Stack(children: [
              Center(
                  child: Card(
                      elevation: 5.0,
                      child: Container(
                        padding: EdgeInsets.all(10.0),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            TextFormField(
                              keyboardType: TextInputType.number,
                              controller: phoneController,
                              maxLength: 9,
                              decoration: InputDecoration(
                                labelText: "ტელეფონი",
                              ),
                            ),
                            _renderSmsInput(),
                            SizedBox(
                              height: 10.0,
                            ),
                            ConstrainedBox(
                              constraints: const BoxConstraints(minWidth: double.infinity),
                              child: RaisedButton(
                                child: Text('შემდეგი'),
                                onPressed: () {

                                },
                              ),
                            )
                          ],
                        ),
                      ))),
              _showProgress()
            ])));
  }

  _showProgress() {
    if (loading) {
      return Center(child: CircularProgressIndicator(backgroundColor: Colors.red));
    }
    return SizedBox();
  }

  _renderSmsInput() {
    return AnimatedContainer(
        height: _animatedHeight,
        duration: Duration(milliseconds: 500),
        child: TextFormField(
          maxLength: 4,
          controller: smsController,
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
            labelText: "სმს კოდი",
          ),
        ));
  }
}
