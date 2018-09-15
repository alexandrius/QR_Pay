import 'package:flutter/material.dart';

class QR extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new _QRState();
  }
}

class _QRState extends State<QR> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('QR კოდი'),
      ),
      body: Container(),
    );
  }
}
