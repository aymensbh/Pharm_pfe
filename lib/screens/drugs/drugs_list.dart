import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pharm_pfe/customWidgets/empty_folder.dart';
import 'package:pharm_pfe/entities/drug.dart';
import 'package:pharm_pfe/screens/drugs/add_edit_drug.dart';
import 'package:pharm_pfe/style/style.dart';

class DrugsList extends StatefulWidget {
  @override
  _DrugsListState createState() => _DrugsListState();
}

class _DrugsListState extends State<DrugsList> {
  List<Drug> drugList = [
    // Drug(id: 1, dose: "1.2ml", name: "Rovamivine"),
    // Drug(id: 2, dose: "1.2ml", name: "Doliprane"),
  ];

  @override
  void initState() {
    //TODO get data from db
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
                    return AddEditDrug();
                  })).then((value) {
                    if (value != null) {
                      setState(() {
                        drugList.insert(0, value);
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
      body: drugList.isEmpty
          ? EmptyFolder(icon: Icons.inbox, color: Style.redColor)
          : ListView(
              physics: BouncingScrollPhysics(),
              children: List.generate(
                  drugList.length,
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
                              //TODO DELETE DRUG FROM DB
                              setState(() {
                                drugList.removeAt(index);
                              });
                            }
                          } catch (e) {
                            return;
                          }
                        },
                        onTap: () {
                          Navigator.of(context)
                              .push(CupertinoPageRoute(builder: (context) {
                            return AddEditDrug(drug: drugList[index]);
                          }));
                        },
                        leading: Icon(
                          Icons.inbox,
                          color: Style.redColor,
                        ),
                        title: Text(
                          drugList[index].name,
                          style: Theme.of(context).textTheme.bodyText2,
                        ),
                        subtitle: Text(
                          drugList[index].cinit.toString(),
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
