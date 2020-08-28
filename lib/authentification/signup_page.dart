import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pharm_pfe/authentification/home_page.dart';
import 'package:pharm_pfe/authentification/login_page.dart';
import 'package:pharm_pfe/style/style.dart';

class SignupPage extends StatefulWidget {
  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  InputDecoration _inputDecoration(String lable, IconData icon) {
    return InputDecoration(
        labelText: lable,
        prefixIcon: Icon(
          icon,
          color: Style.secondaryColor,
          size: 20,
        ),
        labelStyle: Theme.of(context).textTheme.caption,
        focusedErrorBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Style.primaryColor),
        ),
        errorBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.redAccent),
        ),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Style.primaryColor),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Style.accentColor),
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Style.darkBackgroundColor,
      resizeToAvoidBottomInset: false,
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        backgroundColor: Style.accentColor,
        title: Text(
          "Phahrme",
          style: Theme.of(context)
              .textTheme
              .bodyText2
              .copyWith(color: Style.darkBackgroundColor),
        ),
      ),
      body: ListView(
        physics: BouncingScrollPhysics(),
        children: <Widget>[
          SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
                cursorColor: Style.accentColor,
                decoration: _inputDecoration("Username", Icons.person)),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
                obscureText: true,
                cursorColor: Style.accentColor,
                decoration: _inputDecoration("Password", Icons.vpn_key)),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
                obscureText: true,
                cursorColor: Style.accentColor,
                decoration: _inputDecoration("Confirm Password", Icons.replay)),
          ),
          SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ButtonTheme(
              minWidth: MediaQuery.of(context).size.width,
              child: FlatButton(
                color: Style.accentColor,
                onPressed: () {
                  Navigator.of(context)
                      .pushReplacement(CupertinoPageRoute(builder: (contex) {
                    return HomePage();
                  }));
                },
                child: Text("S'inscrire",
                    style: Theme.of(context)
                        .textTheme
                        .bodyText2
                        .copyWith(color: Style.darkBackgroundColor)),
              ),
            ),
          ),
          Center(
            child: FlatButton(
                onPressed: () {
                  Navigator.of(context)
                      .pushReplacement(CupertinoPageRoute(builder: (contex) {
                    return LoginPage();
                  }));
                },
                child: Text("Already have account? Login!",
                    style: Theme.of(context).textTheme.caption)),
          ),
        ],
      ),
    );
  }
}
