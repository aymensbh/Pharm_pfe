import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pharm_pfe/authentification/home_page.dart';
import 'package:pharm_pfe/authentification/signup_page.dart';
import 'package:pharm_pfe/backend/sqlitedatabase_helper.dart';
import 'package:pharm_pfe/entities/user.dart';
import 'package:pharm_pfe/style/style.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  List<User> users = [];
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController usernameController, passwordController;

  InputDecoration _inputDecoration(String lable, IconData icon) {
    return InputDecoration(
        prefixIcon: Icon(
          icon,
          color: Style.secondaryColor,
          size: 20,
        ),
        labelText: lable,
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
    DatabaseHelper.init();
    usernameController = TextEditingController();
    passwordController = TextEditingController();
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
          "Phahrme login",
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
                  cursorColor: Style.accentColor,
                  validator: (input) {
                    if (input.trim().length < 4 || input.trim().length > 20) {
                      return "Veuiller saisire un nom d'utilisateur";
                    }
                  },
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
                  child: Text("S'identifier",
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
                      return SignupPage();
                    }));
                  },
                  child: Text("No account? Signup!",
                      style: Theme.of(context).textTheme.caption)),
            ),
          ],
        ),
      ),
    );
  }

  _validate() {
    if (_formKey.currentState.validate()) {
      DatabaseHelper.loginWithUsernameAndPassword(
              username: usernameController.text.trim(),
              password: passwordController.text.trim())
          .then((value) {
        if (value.isEmpty) {
          showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  elevation: 2,
                  title: Text("Nom d'utilisateur ou mot de passe incorrect!",
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
        } else {
          Navigator.of(context)
              .pushReplacement(CupertinoPageRoute(builder: (contex) {
            return HomePage(
              user: User.fromMap(value[0]),
            );
          }));
        }
      });
    }
  }
}
