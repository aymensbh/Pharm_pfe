import 'package:flutter/material.dart';
import 'package:pharm_pfe/backend/sqlitedatabase_helper.dart';
import 'package:pharm_pfe/entities/user.dart';
import 'package:pharm_pfe/style/style.dart';

class About extends StatefulWidget {
  final int userid;

  const About({Key key, this.userid}) : super(key: key);
  @override
  _AboutState createState() => _AboutState();
}

class _AboutState extends State<About> {
  GlobalKey<FormState> _passwordFormKey;
  GlobalKey<FormState> _usernameFormKey;

  TextEditingController _newPasswordController;
  TextEditingController _newUsernameController;

  InputDecoration _inputDecoration(String lable) {
    return InputDecoration(
        labelText: lable,
        errorStyle:
            Theme.of(context).textTheme.caption.copyWith(color: Style.redColor),
        labelStyle: Theme.of(context).textTheme.caption,
        focusedErrorBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Style.redColor),
        ),
        errorBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Style.redColor),
        ),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Style.primaryColor),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Style.accentColor),
        ));
  }

  User user;

  @override
  void initState() {
    _newPasswordController = TextEditingController();
    _newUsernameController = TextEditingController();
    _passwordFormKey = GlobalKey<FormState>();
    _usernameFormKey = GlobalKey<FormState>();
    DatabaseHelper.selectSpecificUser(widget.userid).then((value) {
      setState(() {
        user = User.fromMap(value[0]);
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Style.darkBackgroundColor,
      appBar: AppBar(
        backgroundColor: Style.secondaryColor,
        title: Text(
          "Profile",
          style: Theme.of(context)
              .textTheme
              .bodyText2
              .copyWith(color: Style.darkBackgroundColor),
        ),
      ),
      body: ListView(
        physics: BouncingScrollPhysics(),
        children: [
          ListTile(
            title: Text(
              "Informations confidentielles",
              style: Theme.of(context)
                  .textTheme
                  .caption
                  .copyWith(color: Style.secondaryColor),
            ),
          ),
          ListTile(
            onTap: () {
              _newUsernameController.text = user.username;
              showDialog(
                  context: context,
                  builder: (context) {
                    return SimpleDialog(
                      elevation: 2,
                      title: Text(
                        "Nom d'utilisateur Modification",
                        style: Theme.of(context).textTheme.bodyText2,
                      ),
                      children: [
                        Form(
                          key: _usernameFormKey,
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 8.0, vertical: 2.0),
                                child: TextFormField(
                                  style: Theme.of(context).textTheme.caption,
                                  cursorColor: Style.primaryColor,
                                  controller: _newUsernameController,
                                  validator: (input) {
                                    if (input.trim().length > 20 ||
                                        input.trim().length < 4) {
                                      return "nom d'utilisateur";
                                    }
                                  },
                                  decoration: _inputDecoration(
                                      "Nouveau nom d'utilisateur"),
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 8.0),
                                child: TextFormField(
                                  style: Theme.of(context).textTheme.caption,
                                  cursorColor: Style.primaryColor,
                                  validator: (input) {
                                    if (input.trim() != user.password) {
                                      return "nom d'utilisateur";
                                    }
                                  },
                                  obscureText: true,
                                  decoration: _inputDecoration("Mot de passe"),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          alignment: Alignment.centerRight,
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              FlatButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: Text(
                                    "Anuller",
                                    style: Theme.of(context)
                                        .textTheme
                                        .caption
                                        .copyWith(color: Style.secondaryColor),
                                  )),
                              FlatButton(
                                  onPressed: () {
                                    _validateUsername();
                                  },
                                  child: Text("Confirmer",
                                      style:
                                          Theme.of(context).textTheme.caption)),
                            ],
                          ),
                        )
                      ],
                    );
                  }).then((value) {
                if (value != null) {
                  setState(() {
                    user.username = value;
                  });
                }
              });
            },
            title: Text(
              "Nom d'utilisateur",
              style: Theme.of(context)
                  .textTheme
                  .caption
                  .copyWith(color: Style.secondaryColor.withOpacity(.6)),
            ),
            subtitle: Text(
              user.username,
              style: Theme.of(context)
                  .textTheme
                  .bodyText2
                  .copyWith(color: Style.primaryColor),
            ),
            trailing: Padding(
              padding: const EdgeInsets.all(4.0),
              child: Icon(
                Icons.edit,
                color: Style.secondaryColor,
                size: 16,
              ),
            ),
            leading: CircleAvatar(
              backgroundColor: Style.secondaryColor,
              child:
                  Icon(Icons.person_outline, color: Style.darkBackgroundColor),
            ),
          ),
          ListTile(
            onTap: () {
              _newPasswordController.clear();
              showDialog(
                  context: context,
                  builder: (context) {
                    return SimpleDialog(
                      elevation: 2,
                      title: Text(
                        "Mot de passe Modification",
                        style: Theme.of(context).textTheme.bodyText2,
                      ),
                      children: [
                        Form(
                          key: _passwordFormKey,
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 8.0, vertical: 2.0),
                                child: TextFormField(
                                  style: Theme.of(context).textTheme.caption,
                                  cursorColor: Style.primaryColor,
                                  validator: (input) {
                                    if (input.trim() != user.password) {
                                      return "mot de passe érroné";
                                    }
                                  },
                                  obscureText: true,
                                  decoration:
                                      _inputDecoration("Ancien mot de passe"),
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 8.0),
                                child: TextFormField(
                                  style: Theme.of(context).textTheme.caption,
                                  cursorColor: Style.primaryColor,
                                  controller: _newPasswordController,
                                  validator: (input) {
                                    if (input.trim().length > 20 ||
                                        input.trim().length < 4) {
                                      return "mot de passe érroné";
                                    }
                                  },
                                  obscureText: true,
                                  decoration:
                                      _inputDecoration("Nouveau mot de passe"),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          alignment: Alignment.centerRight,
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              FlatButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: Text(
                                    "Anuller",
                                    style: Theme.of(context)
                                        .textTheme
                                        .caption
                                        .copyWith(color: Style.secondaryColor),
                                  )),
                              FlatButton(
                                  onPressed: () {
                                    _validatePassword();
                                  },
                                  child: Text("Confirmer",
                                      style:
                                          Theme.of(context).textTheme.caption)),
                            ],
                          ),
                        )
                      ],
                    );
                  }).then((value) {
                if (value != null) {
                  setState(() {
                    user.password = value;
                  });
                }
              });
            },
            title: Text(
              "Mot de passe",
              style: Theme.of(context)
                  .textTheme
                  .caption
                  .copyWith(color: Style.secondaryColor.withOpacity(.6)),
            ),
            subtitle: Text(
              _obscureString(user.password),
              style: Theme.of(context)
                  .textTheme
                  .bodyText2
                  .copyWith(color: Style.primaryColor),
            ),
            trailing: Padding(
              padding: const EdgeInsets.all(4.0),
              child: Icon(
                Icons.edit,
                color: Style.secondaryColor,
                size: 16,
              ),
            ),
            leading: CircleAvatar(
              backgroundColor: Style.redColor,
              child: Icon(Icons.vpn_key, color: Style.darkBackgroundColor),
            ),
          ),
        ],
      ),
    );
  }

  _validateUsername() {
    if (_usernameFormKey.currentState.validate()) {
      DatabaseHelper.updateUser(User(
        id: user.id,
        username: _newUsernameController.text.trim(),
        password: user.password,
      )).then((value) {
        Navigator.of(context).pop(_newUsernameController.text.trim());
      });
    }
  }

  _validatePassword() {
    if (_passwordFormKey.currentState.validate()) {
      DatabaseHelper.updateUser(User(
              id: user.id,
              username: user.username,
              password: _newPasswordController.text.trim()))
          .then((value) {
        Navigator.of(context).pop(_newPasswordController.text.trim());
      });
    }
  }

  String _obscureString(String string) {
    String obsString = "";
    for (int i = 0; i < string.length; i++) {
      obsString += "*";
    }
    return obsString;
  }
}
