import 'package:flutter/material.dart';
import 'package:pharm_pfe/style/style.dart';

class Report extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Style.lightBackgroundColor,
      appBar: AppBar(
        backgroundColor: Style.darkBackgroundColor,
        leading: IconButton(
            tooltip: "Back",
            icon: Icon(Icons.arrow_back, color: Style.primaryColor),
            onPressed: () {
              Navigator.of(context).pop();
            }),
        title: Text(
          "Report bug!",
          style: Theme.of(context)
              .textTheme
              .bodyText2
              .copyWith(color: Style.primaryColor),
        ),
      ),
      body: Container(
          alignment: Alignment.center,
          color: Style.lightBackgroundColor,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleAvatar(
                backgroundColor: Style.darkBackgroundColor,
                maxRadius: 80,
                child: Icon(
                  Icons.info_outline,
                  color: Style.primaryColor,
                  size: 120,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              RaisedButton(
                color: Style.darkBackgroundColor,
                onPressed: () {},
                child: Text("Reporter un error!"),
              ),
              SizedBox(
                height: 100,
              )
            ],
          )),
    );
  }
}
