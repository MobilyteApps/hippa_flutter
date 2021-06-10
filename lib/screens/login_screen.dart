import 'package:app/providers/login_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class LoginPage extends StatefulWidget {

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  double height;
  double width;

  LoginProvider loginProvider;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final loginProvider = Provider.of<LoginProvider>(context);

    if (this.loginProvider != loginProvider) {
      this.loginProvider = loginProvider;
    }
  }


  @override
  Widget build(BuildContext context) {
    height = MediaQuery
        .of(context)
        .size
        .height;
    width = MediaQuery
        .of(context)
        .size
        .width;
    return Scaffold(

        body: Container(

            height: height,
            width: width,
            child: Center(child:

            MaterialButton(
              padding: EdgeInsets.only(top: 20, bottom: 20),
              color: Colors.black,
              child: Container(width: width * 0.5,
                child: Text('Login', textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.white),),),

              onPressed: () {},
            )))

    );
  }
}
