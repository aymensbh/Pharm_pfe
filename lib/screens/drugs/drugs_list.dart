import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pharm_pfe/backend/sqlitedatabase_helper.dart';
import 'package:pharm_pfe/customWidgets/empty_folder.dart';
import 'package:pharm_pfe/entities/drug.dart';
import 'package:pharm_pfe/entities/user.dart';
import 'package:pharm_pfe/screens/drugs/add_edit_drug.dart';
import 'package:pharm_pfe/style/style.dart';

class DrugsList extends StatefulWidget {
  final int userid;
  final bool isSelectable;

  const DrugsList({Key key, this.userid, this.isSelectable}) : super(key: key);
  @override
  _DrugsListState createState() => _DrugsListState();
}

class _DrugsListState extends State<DrugsList> {
  List<Drug> _drugList = [];

  List<Drug> _duplicatedSearchItems = [];
  User user;

  @override
  void initState() {
    DatabaseHelper.selectSpecificUser(widget.userid).then((value) {
      setState(() {
        user = User.fromMap(value[0]);
      });
    });
    DatabaseHelper.selectDrug(widget.userid).then((value) {
      List.generate(value.length, (index) {
        setState(() {
          _drugList.add(Drug.fromMap(value[index]));

          _duplicatedSearchItems.add(Drug.fromMap(value[index]));
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
                      userid: user.id,
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
              hintText: 'Médicaments',
              hintStyle: TextStyle(color: Colors.white),
              focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.white)),
              enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.white))),
        ),
        //   title: Text("Medicaments",
        //       style: Theme.of(context)
        //           .textTheme
        //           .bodyText2
        //           .copyWith(color: Style.darkBackgroundColor)),
        backgroundColor: Style.redColor,
      ),
      body: _drugList.isEmpty
          ? EmptyFolder(icon: Icons.inbox, color: Style.redColor)
          : ListView.builder(
              physics: BouncingScrollPhysics(),
              itemCount: _drugList.length,
              itemBuilder: (context, index) => ListTile(
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
                                userid: user.id,
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
    );
  }

  filterSearchResults(String query) {
    List<Drug> dummySearchList = [];
    dummySearchList.addAll(_drugList);
    if (query.isNotEmpty) {
      List<Drug> dummyListData = [];
      dummySearchList.forEach((item) {
        if (item.name.toString().contains(query) ||
            item.cinit.toString().contains(query)) {
          dummyListData.add(item);
        }
      });
      setState(() {
        _drugList.clear();
        _drugList.addAll(dummyListData);
      });
      return;
    } else {
      setState(() {
        _drugList.clear();
        _drugList.addAll(_duplicatedSearchItems);
      });
    }
  }
}
