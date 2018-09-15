import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';


class QR extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new _QRState();
  }
}

class _QRState extends State<QR> {
  TextEditingController moneyInputController;
  String base_url = 'https://api.qrserver.com/v1/create-qr-code/?size=300x300&data=';
  String url;
  String phone;
  FocusNode focusNode = new FocusNode();

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
    return Scaffold(
        appBar: AppBar(
          title: Text('QR კოდი'),
        ),
        body: Container(
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
                            url = base_url + 'acct' + moneyInputController.text + ':GE22BG0000' + phone;
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
                  MaterialButton(
                    child: Text('სკანერი'),
                    onPressed: () {

                    },
                  )
                ],
              )
            ],
          ),
        ));
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
