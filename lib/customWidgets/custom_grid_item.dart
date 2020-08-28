import 'package:flutter/material.dart';
import 'package:pharm_pfe/style/style.dart';

class CustomGridItem extends StatelessWidget {
  final IconData icon;
  final Color color;
  final String title;
  final VoidCallback onTap;

  const CustomGridItem({
    Key key,
    this.icon,
    this.color,
    this.title,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Style.darkBackgroundColor,
      borderRadius: BorderRadius.circular(0),
      child: InkWell(
        borderRadius: BorderRadius.circular(0),
        onTap: onTap,
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(title, style: Theme.of(context).textTheme.caption),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Icon(icon, size: 50, color: color),
              )
            ],
          ),
        ),
      ),
    );
  }
}
