import 'dart:async';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:barcode_scan/barcode_scan.dart';
import 'package:share/share.dart';


class QR extends StatefulWidget {
  final bool isSend;

  QR({Key key, this.isSend}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _QRState(isSend: isSend);
  }
}

class _QRState extends State<QR> {
  TextEditingController moneyInputController;
  String base_url = 'https://api.qrserver.com/v1/create-qr-code/?size=300x300&data=';
  String url;
  String phone;
  FocusNode focusNode = new FocusNode();
  String barcode;
  bool isSend;

  _QRState({this.isSend});

  @override
  void initState() {
    _getPhone();
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
              TextFormField(
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                controller: moneyInputController,
                focusNode: focusNode,
                decoration: InputDecoration(
                  labelText: "თანხა",
                ),
              ),
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
                        url = base_url + type + moneyInputController.text + ':GE22BG0000' + phone;
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
                      child: Text('სკანერი'),
                      onPressed: () {
                        scan();
                      }),
                  MaterialButton(
                      child: Text('გაზიარება'),
                      onPressed: () {
                        Share.share(url);
                      }),
                ],
              )
            ],
          )
        ],
      ),
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
