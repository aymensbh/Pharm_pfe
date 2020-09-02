import 'package:flutter/material.dart';
import 'package:pharm_pfe/style/style.dart';

class About extends StatefulWidget {
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
          "About",
          style: Theme.of(context)
              .textTheme
              .bodyText2
              .copyWith(color: Style.darkBackgroundColor),
        ),
      ),
    );
  }
}
