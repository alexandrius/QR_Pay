import 'package:barcode_scan/barcode_scan.dart';
import 'package:flutter/material.dart';
import 'package:qr_pay/screens/addCard.dart';
import 'package:qr_pay/screens/manageMoney.dart';
import 'package:qr_pay/screens/qr.dart';

class CardList extends StatefulWidget {
  static String cardNumber;

  @override
  State<StatefulWidget> createState() {
    return _CardListState();
  }
}

class _CardListState extends State<CardList> {
  var result = [];
  String barcode = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('აირჩიეთ ბარათი')),
      body: Stack(
        children: [
          buildOpacity(),
          buildCenter()
        ],
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            openAddCard();
          },
          child: Icon(Icons.add)),
    );
  }

  buildOpacity() {
    if(result == null || result.length == 0){

      return Opacity(
        child: Center(
          child: Image.asset('bagger.png'),
        ),
        opacity: 0.7,
      );

    }

    return SizedBox();
  }

  buildCenter() {
    if (result == null || result.length == 0) {
      return SizedBox();
    }

    return Container(
            padding: EdgeInsets.only(left: 10.0, right: 10.0, top: 20.0),
            child: Material(
                elevation: 5.0,
                borderRadius: BorderRadius.all(Radius.circular(25.0)),
                child: Container(
                  height: 150.0,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(25.0)),
                      gradient: LinearGradient(colors: [
                        Colors.deepOrange[800],
                        Colors.deepOrange[500],
                        Colors.deepOrange[600],
                        Colors.deepOrange[500],
                        Colors.deepOrange[400],
                      ])),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      ConstrainedBox(
                          constraints: const BoxConstraints(minWidth: double.infinity),
                          child: Text(
                            "    **** **** ****" + result[0].toString().substring(14),
                            style: TextStyle(color: Colors.white, fontSize: 20.0),
                          )),
                      SizedBox(height: 10.0),
                      Text(result[1], style: TextStyle(color: Colors.white, fontSize: 12.0)),
                      SizedBox(height: 10.0),
                      Row(mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          SizedBox(width: 5.0),
                          OutlineButton(
                            child: Text('QR გენერირება', style: TextStyle(color: Colors.white)),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => ManageMoney()),
                              );
                            },
                          ),
                          SizedBox(width: 5.0),
                          OutlineButton(
                            child: Text('დასკანირება', style: TextStyle(color: Colors.white)),
                            onPressed: () {
                              scan();
                            },
                          ),
                          SizedBox(width: 5.0),
                        ],
                      )
                    ],
                  ),
                )));
  }

  scan() async {
    try {
      String barcode = await BarcodeScanner.scan();
      setState(() => this.barcode = barcode);
      print(barcode);
    } catch (e) {}
  }

  openAddCard() async {
    var result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => AddCard()),
    );
    if(result!=null){
      this.result = result;
    }

    setState(() {
    });
  }
}
