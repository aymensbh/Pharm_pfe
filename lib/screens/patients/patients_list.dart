import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pharm_pfe/backend/sqlitedatabase_helper.dart';
import 'package:pharm_pfe/customWidgets/empty_folder.dart';
import 'package:pharm_pfe/entities/patient.dart';
import 'package:pharm_pfe/entities/user.dart';
import 'package:pharm_pfe/screens/patients/add_edit_patient.dart';
import 'package:pharm_pfe/style/style.dart';

class PatientsList extends StatefulWidget {
  final int userid;
  final bool isSelectable;

  const PatientsList({Key key, this.userid, this.isSelectable})
      : super(key: key);
  @override
  _PatientsListState createState() => _PatientsListState();
}

class _PatientsListState extends State<PatientsList> {
  List<Patient> _patientsList = [];
  List<Patient> _duplicatedSearchItems = [];

  User user;

  @override
  void initState() {
    DatabaseHelper.selectSpecificUser(widget.userid).then((value) {
      setState(() {
        user = User.fromMap(value[0]);
      });
    });
    DatabaseHelper.selectPatient(widget.userid).then((value) {
      List.generate(value.length, (index) {
        setState(() {
          _patientsList.add(Patient.fromMap(value[index]));
          _duplicatedSearchItems.add(Patient.fromMap(value[index]));
        });
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.only(right: 4.0),
            child: IconButton(
                icon: Icon(Icons.add),
                onPressed: () {
                  Navigator.of(context)
                      .push(CupertinoPageRoute(builder: (context) {
                    return AddEditPatient(
                      userid: user.id,
                    );
                  })).then((value) {
                    if (value != null) {
                      setState(() {
                        _patientsList.insert(0, value);
                      });
                    }
                  });
                }),
          )
        ],
        backgroundColor: Style.purpleColor,
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
              hintText: 'Patients',
              hintStyle: TextStyle(color: Colors.white),
              focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.white)),
              enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.white))),
        ),
        // title: Text("Patients",
        //     style: Theme.of(context)
        //         .textTheme
        //         .bodyText2
        //         .copyWith(color: Style.darkBackgroundColor)),
      ),
      body: _patientsList.isEmpty
          ? EmptyFolder(icon: Icons.people, color: Style.purpleColor)
          : ListView.builder(
              physics: BouncingScrollPhysics(),
              itemCount: _patientsList.length,
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
                          DatabaseHelper.deletePatient(_patientsList[index].id)
                              .then((value) {
                            setState(() {
                              _patientsList.removeAt(index);
                            });
                          });
                        }
                      } catch (e) {
                        return;
                      }
                    },
                    onTap: () {
                      widget.isSelectable
                          ? Navigator.of(context).pop(_patientsList[index])
                          : Navigator.of(context)
                              .push(CupertinoPageRoute(builder: (context) {
                              return AddEditPatient(
                                  userid: user.id,
                                  patient: _patientsList[index]);
                            })).then((value) {
                              if (value != null) {
                                setState(() {
                                  _patientsList[index] = value;
                                });
                              }
                            });
                    },
                    leading: Icon(
                      Icons.person,
                      color: Style.purpleColor,
                    ),
                    trailing: Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Icon(
                        Icons.edit,
                        color: Style.secondaryColor,
                        size: 16,
                      ),
                    ),
                    title: Text(
                      _patientsList[index].fullname,
                      style: Theme.of(context).textTheme.bodyText2,
                    ),
                    subtitle: Text(_patientsList[index].birthdate,
                        style: Theme.of(context).textTheme.caption),
                  )),
    );
  }

  filterSearchResults(String query) {
    List<Patient> dummySearchList = [];
    dummySearchList.addAll(_patientsList);
    if (query.isNotEmpty) {
      List<Patient> dummyListData = [];
      dummySearchList.forEach((item) {
        if (item.fullname.contains(query)) {
          dummyListData.add(item);
        }
      });
      setState(() {
        _patientsList.clear();
        _patientsList.addAll(dummyListData);
      });
      return;
    } else {
      setState(() {
        _patientsList.clear();
        _patientsList.addAll(_duplicatedSearchItems);
      });
    }
  }
}
