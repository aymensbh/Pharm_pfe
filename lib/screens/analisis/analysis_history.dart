import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pharm_pfe/backend/sqlitedatabase_helper.dart';
import 'package:pharm_pfe/customWidgets/empty_folder.dart';
import 'package:pharm_pfe/entities/analysis.dart';
import 'package:pharm_pfe/entities/user.dart';
import 'package:pharm_pfe/style/style.dart';

import 'add_edit_analysis.dart';

class AnalysisHistoryPage extends StatefulWidget {
  final User user;

  const AnalysisHistoryPage({Key key, this.user}) : super(key: key);
  @override
  _AnalysisHistoryPageState createState() => _AnalysisHistoryPageState();
}

class _AnalysisHistoryPageState extends State<AnalysisHistoryPage> {
  List<Analysis> analysisList = [];

  @override
  void initState() {
    DatabaseHelper.selectPoch(widget.user.id).then((value) {
      setState(() {
        List.generate(value.length, (index) {
          analysisList.add(Analysis.fromMap(value[index]));
        });
      });
    });
    super.initState();
  }

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
                    return AddEditAnalisis(
                      user: widget.user,
                    );
                  })).then((value) {
                    if (value != null) {
                      setState(() {
                        analysisList.add(value);
                      });
                    }
                  });
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
                              .push(CupertinoPageRoute(builder: (context) {
                            return AddEditAnalisis(
                              analysis: analysisList[index],
                              user: widget.user,
                            );
                          })).then((value) {
                            if (value != null) {
                              setState(() {
                                analysisList.removeAt(index);
                                analysisList.insert(0, value);
                              });
                            }
                          });
                        },
                        leading: Icon(
                          Icons.multiline_chart,
                          color: Style.yellowColor,
                        ),
                        subtitle: Text(
                          analysisList[index].creationDate,
                          style: Theme.of(context).textTheme.caption,
                        ),
                        title: Text(
                          analysisList[index].finalVolume.toString() + " ml",
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
