import 'package:flutter/material.dart';
import 'package:pharm_pfe/style/style.dart';

class CustomGridToolItem extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;

  const CustomGridToolItem({Key key, this.icon, this.onTap})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: BorderRadius.circular(0),
      color: Style.darkBackgroundColor,
      child: InkWell(
        borderRadius: BorderRadius.circular(0),
        onTap: onTap,
        child: Container(
          alignment: Alignment.center,
          child: CircleAvatar(
              backgroundColor: Style.lightBackgroundColor,
              child: Icon(icon, size: 22, color: Style.primaryColor,)), 
        ),
      ),
    );
  }
}
