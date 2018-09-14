import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  Login({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _LoginState createState() => new _LoginState();
}

class _LoginState extends State<Login> {
  var waitsForSMS = false;
  TextEditingController phoneController;

  @override
  void initState() {
    phoneController = TextEditingController()
      ..addListener(() {
        if (phoneController.text.length == 9) {
          setState(() {
            waitsForSMS = true;
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
            child: Center(
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
                            decoration: InputDecoration(
                              labelText: "ტელეფონი",
                            ),
                          ),
                          _renderSmsInput(),
                          SizedBox(
                            height: 20.0,
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
                    )))));
  }

  _renderSmsInput() {
    if (!waitsForSMS) {
      return SizedBox();
    }
    return TextFormField(
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        labelText: "სმს კოდი",
      ),
    );
  }
}
