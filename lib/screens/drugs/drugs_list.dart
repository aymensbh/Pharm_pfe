import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pharm_pfe/backend/sqlitedatabase_helper.dart';
import 'package:pharm_pfe/customWidgets/empty_folder.dart';
import 'package:pharm_pfe/entities/drug.dart';
import 'package:pharm_pfe/entities/user.dart';
import 'package:pharm_pfe/screens/drugs/add_edit_drug.dart';
import 'package:pharm_pfe/style/style.dart';

class DrugsList extends StatefulWidget {
  final User user;
  final bool isSelectable;

  const DrugsList({Key key, this.user, this.isSelectable}) : super(key: key);
  @override
  _DrugsListState createState() => _DrugsListState();
}

class _DrugsListState extends State<DrugsList> {
  List<Drug> _drugList = [];

  @override
  void initState() {
    DatabaseHelper.selectDrug(widget.user.id).then((value) {
      List.generate(value.length, (index) {
        setState(() {
          _drugList.add(Drug.fromMap(value[index]));
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
                    return AddEditDrug(
                      drug: null,
                      userid: widget.user.id,
                    );
                  })).then((value) {
                    if (value != null) {
                      setState(() {
                        _drugList.insert(0, value);
                      });
                    }
                  });
                }),
          )
        ],
        title: Text("Medicaments",
            style: Theme.of(context)
                .textTheme
                .bodyText2
                .copyWith(color: Style.darkBackgroundColor)),
        backgroundColor: Style.redColor,
      ),
      body: _drugList.isEmpty
          ? EmptyFolder(icon: Icons.inbox, color: Style.redColor)
          : ListView(
              physics: BouncingScrollPhysics(),
              children: List.generate(
                  _drugList.length,
                  (index) => ListTile(
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
                                            .copyWith(
                                                color: Style.primaryColor)),
                                    actions: [
                                      FlatButton(
                                          splashColor:
                                              Style.lightBackgroundColor,
                                          onPressed: () {
                                            Navigator.of(context).pop(false);
                                          },
                                          child: Text("Annuler",
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .caption
                                                  .copyWith(
                                                      color: Style
                                                          .secondaryColor))),
                                      FlatButton(
                                          splashColor:
                                              Style.lightBackgroundColor,
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
                              DatabaseHelper.deleteDrug(_drugList[index].id)
                                  .then((value) {
                                setState(() {
                                  _drugList.removeAt(index);
                                });
                              });
                            }
                          } catch (e) {
                            return;
                          }
                        },
                        onTap: () {
                          widget.isSelectable
                              ? Navigator.of(context).pop(_drugList[index])
                              : Navigator.of(context)
                                  .push(CupertinoPageRoute(builder: (context) {
                                  return AddEditDrug(
                                    drug: _drugList[index],
                                    userid: widget.user.id,
                                  );
                                })).then((value) {
                                  if (value != null) {
                                    setState(() {
                                      _drugList[index] = value;
                                    });
                                  }
                                });
                        },
                        leading: Icon(
                          Icons.inbox,
                          color: Style.redColor,
                        ),
                        title: Text(
                          _drugList[index].name,
                          style: Theme.of(context).textTheme.bodyText2,
                        ),
                        subtitle: Text(
                          _drugList[index].cinit.toString(),
                          style: Theme.of(context).textTheme.caption,
                        ),
                        trailing: Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Icon(
                            Icons.edit,
                            color: Style.secondaryColor,
                            size: 16,
                          ),
                        ),
                      )),
            ),
    );
  }
}
