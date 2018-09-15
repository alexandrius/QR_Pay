import 'dart:async';

import 'package:flutter/material.dart';

class Passcode extends StatefulWidget {
  Passcode({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _PasscodeState createState() => new _PasscodeState();
}

class _PasscodeState extends State<Passcode> {
  var waitsForSMS = false;
  var _animatedHeight = 0.0;
  var loading = false;
  TextEditingController phoneController;
  TextEditingController smsController;

  @override
  void initState() {

    phoneController = TextEditingController()
      ..addListener(() {
        if (phoneController.text.length == 9) {
          setState(() {
            waitsForSMS = true;
            _animatedHeight = 80.0;
          });

          Timer(const Duration(milliseconds: 500), () {
            setState(() {
              smsController.text = "8350";
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
        if (smsController.text.length == 4) {
          setState(() {
            loading = true;
          });
        }
      });
    super.initState();
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
                                onPressed: () {},
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
