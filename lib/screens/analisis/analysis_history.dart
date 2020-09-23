import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pharm_pfe/backend/sqlitedatabase_helper.dart';
import 'package:pharm_pfe/customWidgets/empty_folder.dart';
import 'package:pharm_pfe/entities/analysis.dart';
import 'package:pharm_pfe/entities/user.dart';
import 'package:pharm_pfe/style/style.dart';

import 'add_edit_analysis.dart';

class AnalysisHistoryPage extends StatefulWidget {
  final int userid;

  const AnalysisHistoryPage({Key key, this.userid}) : super(key: key);
  @override
  _AnalysisHistoryPageState createState() => _AnalysisHistoryPageState();
}

class _AnalysisHistoryPageState extends State<AnalysisHistoryPage> {
  List<Analysis> analysisList = [];
  List<Analysis> _duplicatedSearchItems = [];
  User user;

  @override
  void initState() {
    DatabaseHelper.selectSpecificUser(widget.userid).then((value) {
      setState(() {
        user = User.fromMap(value[0]);
      });
    });
    DatabaseHelper.selectPoch(widget.userid).then((value) {
      setState(() {
        List.generate(value.length, (index) {
          analysisList.add(Analysis.fromMap(value[index]));
          _duplicatedSearchItems.add(Analysis.fromMap(value[index]));
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
                      userid: user.id,
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

        title: TextField(
          onChanged: (input) {
            filterSearchResults(input);
          },
          cursorColor: Colors.white,
          style: TextStyle(color: Colors.white),
          decoration: InputDecoration(
              suffixIcon: Icon(
                Icons.search,
                color: Colors.white,
              ),
              hintText: 'Poches',
              hintStyle: TextStyle(color: Colors.white),
              focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.white)),
              enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.white))),
        ),
        // title: Text("Poches",
        //     style: Theme.of(context)
        //         .textTheme
        //         .bodyText2
        //         .copyWith(color: Style.darkBackgroundColor)),
        backgroundColor: Style.yellowColor,
      ),
      body: analysisList.isEmpty
          ? EmptyFolder(icon: Icons.multiline_chart, color: Style.yellowColor)
          : ListView.builder(
              itemCount: analysisList.length,
              physics: BouncingScrollPhysics(),
              itemBuilder: (contex, index) => ListTile(
                    onLongPress: () async {
                      try {
                        if (await showDialog(
                            barrierDismissible: false,
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                elevation: 2,
                                title: Text("Supprimer!",
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyText2
                                        .copyWith(color: Style.primaryColor)),
                                actions: [
                                  FlatButton(
                                      splashColor: Style.lightBackgroundColor,
                                      onPressed: () {
                                        Navigator.of(context).pop(false);
                                      },
                                      child: Text("Annuler",
                                          style: Theme.of(context)
                                              .textTheme
                                              .caption
                                              .copyWith(
                                                  color:
                                                      Style.secondaryColor))),
                                  FlatButton(
                                      splashColor: Style.lightBackgroundColor,
                                      onPressed: () {
                                        Navigator.of(context).pop(true);
                                      },
                                      child: Text("Supprimer",
                                          style: Theme.of(context)
                                              .textTheme
                                              .caption
                                              .copyWith(
                                                  color: Style.redColor))),
                                ],
                              );
                            })) {
                          DatabaseHelper.deletePoch(analysisList[index].id)
                              .then((value) {
                            setState(() {
                              analysisList.removeAt(index);
                            });
                          });
                        }
                      } catch (e) {
                        return;
                      }
                    },
                    onTap: () {
                      Navigator.of(context)
                          .push(CupertinoPageRoute(builder: (context) {
                        return AddEditAnalisis(
                          analysis: analysisList[index],
                          userid: user.id,
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
    );
  }

  filterSearchResults(String query) {
    List<Analysis> dummySearchList = [];
    dummySearchList.addAll(analysisList);
    if (query.isNotEmpty) {
      List<Analysis> dummyListData = [];
      dummySearchList.forEach((item) {
        if (item.finalVolume.toString().contains(query) ||
            item.creationDate.toString().contains(query)) {
          dummyListData.add(item);
        }
      });
      setState(() {
        analysisList.clear();
        analysisList.addAll(dummyListData);
      });
      return;
    } else {
      setState(() {
        analysisList.clear();
        analysisList.addAll(_duplicatedSearchItems);
      });
    }
  }
}
