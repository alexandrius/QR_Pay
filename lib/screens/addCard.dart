import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';

class AddCard extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _AddCardState();
  }
}

class _AddCardState extends State<AddCard> {
  var cardController = new MaskedTextController(mask: '0000 0000 0000 0000');
  var dateController = new MaskedTextController(mask: '00 / 00');
  var cvvController = new TextEditingController();

  var _iconSize = 0.0;
  var _inputWidthDif = 40.0;
  var masterCardIcon = Image.asset('icon_mc.png');
  var visaIcon = Image.asset('icon_visa.png');
  var padding = 0.0;
  Image currentIcon;
  var showProgress = false;

  @override
  void initState() {
    cvvController.addListener(() {
      if (cvvController.text.length > 3) {
        cvvController.text = cvvController.text.substring(0, 3);
      }
    });

    cardController.addListener(() {
      if (cardController.text.length > 0) {
        if (cardController.text.startsWith('5')) {
          currentIcon = masterCardIcon;
        } else {
          currentIcon = visaIcon;
        }
        setState(() {
          _iconSize = 30.0;
          _inputWidthDif = 90.0;
          padding = 20.0;
        });
      } else {
        setState(() {
          currentIcon = null;
          _iconSize = 0.0;
          _inputWidthDif = 40.0;
          padding = 0.0;
        });
      }
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('ბარათის დამატება')), body: Stack(children: [buildContainer(context), _progress()]));
  }

  _progress() {
    if (!showProgress) {
      return SizedBox();
    }

    return Center(child: CircularProgressIndicator());
  }

  Container buildContainer(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20.0),
      child: Column(children: <Widget>[
        Row(children: <Widget>[
          AnimatedContainer(
            duration: Duration(milliseconds: 200),
            width: _iconSize,
            height: 30.0,
            child: currentIcon,
          ),
          AnimatedContainer(
            duration: Duration(milliseconds: 200),
            width: padding,
          ),
          AnimatedContainer(
              duration: Duration(milliseconds: 200),
              width: (MediaQuery.of(context).size.width) - _inputWidthDif,
              child: TextFormField(
                  keyboardType: TextInputType.number,
                  controller: cardController,
                  decoration: InputDecoration(
                    labelText: "ბარათის ნომერი",
                  )))
        ]),
        Row(
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width / 2 - 30,
              child: TextFormField(
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                controller: dateController,
                decoration: InputDecoration(
                  labelText: "ვადა",
                ),
              ),
            ),
            SizedBox(width: 20.0),
            SizedBox(
              width: MediaQuery.of(context).size.width / 2 - 30,
              child: TextFormField(
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                controller: cvvController,
                decoration: InputDecoration(
                  labelText: "CVV",
                ),
              ),
            )
          ],
        ),
        SizedBox(height: 20.0),
        RaisedButton(
          child: Text('დამატება'),
          onPressed: () {
            if (cardController.text.length > 0 && dateController.text.length > 0 && cvvController.text.length == 3) {
              setState(() {
                showProgress = true;
              });
              Timer(const Duration(milliseconds: 500), () {
                Navigator.pop(context, [cardController.text, dateController.text]);
              });
            }
          },
        )
      ]),
    );
  }
}
