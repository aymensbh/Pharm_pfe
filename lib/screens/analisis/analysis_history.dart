import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pharm_pfe/customWidgets/empty_folder.dart';
import 'package:pharm_pfe/entities/analysis.dart';
import 'package:pharm_pfe/style/style.dart';

import 'add_analysis.dart';

class AnalysisHistoryPage extends StatefulWidget {
  @override
  _AnalysisHistoryPageState createState() => _AnalysisHistoryPageState();
}

class _AnalysisHistoryPageState extends State<AnalysisHistoryPage> {
  List<Analysis> analysisList = [
    // Analysis(id: 1, result: "1.2ml", creationDate: "2020-10-12"),
    // Analysis(id: 2, result: "1.2ml", creationDate: "2020-10-12"),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Style.darkBackgroundColor,
      appBar: AppBar(
        elevation: 2,
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.only(right: 4.0),
            child: IconButton(
                icon: Icon(Icons.add),
                onPressed: () {
                  Navigator.of(context)
                      .push(CupertinoPageRoute(builder: (context) {
                    return AddPoch();
                  }));
                }),
          )
        ],
        title: Text("Poches",
            style: Theme.of(context)
                .textTheme
                .bodyText2
                .copyWith(color: Style.darkBackgroundColor)),
        backgroundColor: Style.yellowColor,
      ),
      body: analysisList.isEmpty
          ? EmptyFolder(icon: Icons.multiline_chart, color: Style.yellowColor)
          : ListView(
              physics: BouncingScrollPhysics(),
              children: List.generate(
                  analysisList.length,
                  (index) => ListTile(
                        onTap: () {
                          Navigator.of(context)
                              .push(CupertinoPageRoute(builder: (context) {}));
                        },
                        leading: Icon(
                          Icons.multiline_chart,
                          color: Style.yellowColor,
                        ),
                        subtitle: Text(
                          analysisList[index].result,
                          style: Theme.of(context).textTheme.caption,
                        ),
                        title: Text(
                          analysisList[index].creationDate,
                          style: Theme.of(context).textTheme.bodyText2,
                        ),
                        trailing: Icon(
                          Icons.edit,
                          color: Style.secondaryColor,
                          size: 16,
                        ),
                      )),
            ),
    );
  }
}
