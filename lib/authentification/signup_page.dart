import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pharm_pfe/authentification/home_page.dart';
import 'package:pharm_pfe/authentification/login_page.dart';
import 'package:pharm_pfe/backend/sqlitedatabase_helper.dart';
import 'package:pharm_pfe/entities/user.dart';
import 'package:pharm_pfe/style/style.dart';

class SignupPage extends StatefulWidget {
  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController usernameController,
      passwordController,
      passwordConfirmationController;

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
  void initState() {
    usernameController = TextEditingController();
    passwordController = TextEditingController();
    passwordConfirmationController = TextEditingController();
    super.initState();
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
          "Phahrme signup",
          style: Theme.of(context)
              .textTheme
              .bodyText2
              .copyWith(color: Style.darkBackgroundColor),
        ),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          physics: BouncingScrollPhysics(),
          children: <Widget>[
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                  controller: usernameController,
                  validator: (input) {
                    if (input.trim().length < 4 || input.trim().length > 20) {
                      return "Veuiller saisire un nom d'utilisateur";
                    }
                  },
                  cursorColor: Style.accentColor,
                  decoration: _inputDecoration("Username", Icons.person)),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                  controller: passwordController,
                  validator: (input) {
                    if (input.trim().length < 4 || input.trim().length > 20) {
                      return "Veuiller saisire un mot de passe";
                    }
                  },
                  obscureText: true,
                  cursorColor: Style.accentColor,
                  decoration: _inputDecoration("Password", Icons.vpn_key)),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                  controller: passwordConfirmationController,
                  validator: (input) {
                    if (input.trim().length < 4 ||
                        input.trim().length > 20 ||
                        passwordController.text.trim() != input.trim()) {
                      return "Veuiller confirmer un mot de passe";
                    }
                  },
                  obscureText: true,
                  cursorColor: Style.accentColor,
                  decoration:
                      _inputDecoration("Confirm Password", Icons.replay)),
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
                    _validate();
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
      ),
    );
  }

  _validate() {
    if (_formKey.currentState.validate()) {
      DatabaseHelper.insertUser(new User(
              id: null,
              password: passwordController.text.trim(),
              username: usernameController.text.trim()))
          .then((value) {
        Navigator.of(context)
            .pushReplacement(CupertinoPageRoute(builder: (contex) {
          return HomePage(userid: value);
        }));
      }).catchError((onError) {
        showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                elevation: 2,
                title: Text("Nom d'utilisateur déjat existé!",
                    style: Theme.of(context)
                        .textTheme
                        .caption
                        .copyWith(color: Style.redColor)),
                actions: [
                  FlatButton(
                    splashColor: Style.lightBackgroundColor,
                    child: Text(
                      "Ok",
                      style: Theme.of(context).textTheme.caption,
                    ),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  )
                ],
              );
            });
      });
    }
  }
}
