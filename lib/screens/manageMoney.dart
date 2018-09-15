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
    return new DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            bottom: new TabBar(
              labelColor: Colors.white,
              tabs: [
                new Tab(text: "მიღება"),
                new Tab(text: "გადარიცხვა")
              ],
            ),
          ),
          body: TabBarView(children: [QR(isSend: true), QR(isSend: false)]),
        ));
  }
}
