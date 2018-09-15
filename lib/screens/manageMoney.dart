import 'package:flutter/material.dart';
import 'package:qr_pay/screens/qr.dart';

class ManageMoney extends StatefulWidget {
  createState() {
    return new _ManageMoneyState();
  }
}

class _ManageMoneyState extends State<ManageMoney> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ConstrainedBox(
            constraints: BoxConstraints(minWidth: double.infinity),
            child: RaisedButton(child: Text('გადარიცხვა'), onPressed: () {
//              Navigator.push(context, MaterialPageRoute(builder: (context) => QR()));
            }),
          ),
          ConstrainedBox(
            constraints: BoxConstraints(minWidth: double.infinity),
            child: RaisedButton(child: Text('მიღება'), onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => QR()));
            }),
          )
        ],
      ),
    );
  }
}
