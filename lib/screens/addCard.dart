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

  @override
  void initState() {
    cvvController.addListener((){
      if(cvvController.text.length > 3){
        cvvController.text = cvvController.text.substring(0, 3);
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('ბარათის დამატება')),
        body: Container(
            padding: EdgeInsets.all(20.0),
            child: Column(children: <Widget>[
              TextFormField(
                keyboardType: TextInputType.number,
                controller: cardController,
                decoration: InputDecoration(
                  labelText: "ბარათის ნომერი",
                ),
              ),
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
              )
            ])));
  }
}
