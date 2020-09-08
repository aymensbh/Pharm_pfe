import 'package:flutter/material.dart';
import 'package:pharm_pfe/entities/user.dart';
import 'package:pharm_pfe/style/style.dart';

class About extends StatefulWidget {
  final User user;

  const About({Key key, this.user}) : super(key: key);
  @override
  _AboutState createState() => _AboutState();
}

class _AboutState extends State<About> {
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

  String _obscureString(String string) {
    String obsString = "";
    for (int i = 0; i < string.length; i++) {
      obsString += "*";
    }
    return obsString;
  }
}
