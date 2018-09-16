import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:barcode_scan/barcode_scan.dart';
import 'package:share/share.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class QR extends StatefulWidget {
  final bool isSend;

  QR({Key key, this.isSend}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _QRState(isSend: isSend);
  }
}

class _QRState extends State<QR> with TickerProviderStateMixin {
  TextEditingController moneyInputController;
  String base_url = 'https://api.qrserver.com/v1/create-qr-code/?size=300x300&data=';
  String url;
  String phone;
  FocusNode focusNode = new FocusNode();
  String barcode;
  bool isSend;
  String id;
  String amount = 'თანხა';
  bool showAnim = false;

  Animation<int> _animation;
  AnimationController _controller;

  _QRState({this.isSend});

  @override
  void initState() {
    _controller = new AnimationController(vsync: this, duration: const Duration(seconds: 5))..repeat();
    _animation = new IntTween(begin: 1, end: 61).animate(_controller);

    _getPhone();
    _initiateFireStore();
    moneyInputController = TextEditingController();

    focusNode.addListener(() {
      if (focusNode.hasFocus) {
        setState(() {
          url = null;
        });
      }
    });
    super.initState();
  }

  _getPhone() async {
    var prefs = await SharedPreferences.getInstance();
    phone = prefs.getString('phone');
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20.0),
      child: Stack(
        children: [
          Column(
            children: [
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: <Widget>[
                SizedBox(
                  width: MediaQuery.of(context).size.width - 150,
                  child: TextFormField(
                      keyboardType: TextInputType.numberWithOptions(decimal: true),
                      controller: moneyInputController,
                      focusNode: focusNode,
                      decoration: InputDecoration(
                        labelText: "თანხა",
                      )),
                ),
                Container(
                    child: Card(
                  color: Colors.green,
                  shape: CircleBorder(),
                  child: Container(
                      padding: EdgeInsets.all(20.0),
                      child: Center(
                        child: Text(
                          amount,
                          style: TextStyle(color: Colors.white),
                        ),
                      )),
                ))
              ]),
              SizedBox(
                height: 20.0,
              ),
              MaterialButton(
                  child: Text('QR გენერირება'),
                  onPressed: () {
                    setState(() {
                      if (moneyInputController.text.length > 0) {
                        focusNode.unfocus();
                        final type = isSend ? 'send:' : 'receive:';
                        url = base_url + type + moneyInputController.text + ':GE22BG0000' + phone + ':' + id;
                      }
                    });
                  }),
              SizedBox(
                height: 20.0,
              ),
              _drawQr()
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  MaterialButton(
                      child: Text('გაზიარება'),
                      onPressed: () {
                        Share.share(url);
                      }),
                ],
              )
            ],
          ),
          _showAnimation()
        ],
      ),
    );
  }

  bool skipOnce = true;

  _initiateFireStore() async {
    CollectionReference collection = Firestore.instance.collection('payments');
    final DocumentReference document = collection.document();
    await document.setData(<String, double>{'total': 0.0, 'added': 0.0});
    id = document.documentID;

    document.snapshots().listen((data) {
      var amount = data['total'];
      if(skipOnce){
        skipOnce = false;
      }else{
        showAnim = true;
        Timer(const Duration(milliseconds: 4000), () {
          setState(() {
            showAnim = false;
          });
        });
      }

      setState(() {
        this.amount = amount.toString() + '‎ ₾';
      });
    });


  }

  _showAnimation() {

    print(showAnim);
    if (!showAnim) return new SizedBox();

    return new AnimatedBuilder(
      animation: _animation,
      builder: (BuildContext context, Widget child) {
        return new Image.asset(
          'assets/anim/out000${_animation.value}.png',
          gaplessPlayback: true,
        );
      },
    );
  }

  Future scan() async {
    try {
      String barcode = await BarcodeScanner.scan();
      setState(() => this.barcode = barcode);
      print(barcode);
    } catch (e) {}
  }

  _drawQr() {
    if (url == null) return SizedBox();

    return SizedBox(
      height: 150.0,
      width: 150.0,
      child: Image.network(url),
    );
  }
}
