import 'package:flutter/material.dart';
import 'package:pharm_pfe/backend/sqlitedatabase_helper.dart';
import 'package:pharm_pfe/entities/user.dart';
import 'package:pharm_pfe/style/style.dart';

class About extends StatefulWidget {
  final User user;

  const About({Key key, this.user}) : super(key: key);
  @override
  _AboutState createState() => _AboutState();
}

class _AboutState extends State<About> {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  TextEditingController _newPasswordController = new TextEditingController();
  InputDecoration _inputDecoration(String lable) {
    return InputDecoration(
        labelText: lable,
        errorStyle:
            Theme.of(context).textTheme.caption.copyWith(color: Style.redColor),
        labelStyle: Theme.of(context).textTheme.caption,
        focusedErrorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Style.redColor),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Style.redColor),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Style.primaryColor),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Style.accentColor),
        ));
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
              //TODO update username
            },
            title: Text(
              "Nom d'utilisateur",
              style: Theme.of(context)
                  .textTheme
                  .caption
                  .copyWith(color: Style.secondaryColor.withOpacity(.6)),
            ),
            subtitle: Text(
              widget.user.username,
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
              //TODO update password
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
                          key: _formKey,
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: TextFormField(
                                  validator: (input) {
                                    if (input.trim() != widget.user.password) {
                                      return "mot de passe érroné";
                                    }
                                  },
                                  obscureText: true,
                                  decoration:
                                      _inputDecoration("Ancien mot de passe"),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: TextFormField(
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
                                    _validate();
                                  },
                                  child: Text("Confirmer",
                                      style:
                                          Theme.of(context).textTheme.caption)),
                            ],
                          ),
                        )
                      ],
                    );
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
              _obscureString(widget.user.password),
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

  _validate() {
    if (_formKey.currentState.validate()) {
      DatabaseHelper.updateUser(User(
              id: widget.user.id,
              username: widget.user.username,
              password: _newPasswordController.text.trim()))
          .then((value) {
        Navigator.of(context).pop();
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
