import 'package:flutter/material.dart';
import 'package:pharm_pfe/style/style.dart';

class EmptyFolder extends StatelessWidget {
  final IconData icon;
  final Color color;

  const EmptyFolder({Key key, this.icon, this.color}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          CircleAvatar(
            radius: 50,
            backgroundColor: color,
            child: Icon(icon, size: 60, color: Style.darkBackgroundColor),
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            "Dossier vide!",
            style: Theme.of(context).textTheme.caption,
          ),
        ],
      ),
    );
  }
}
