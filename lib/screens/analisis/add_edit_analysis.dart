import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pharm_pfe/backend/sqlitedatabase_helper.dart';
import 'package:pharm_pfe/entities/analysis.dart';
import 'package:pharm_pfe/entities/drug.dart';
import 'package:pharm_pfe/entities/patient.dart';
import 'package:pharm_pfe/entities/user.dart';
import 'package:pharm_pfe/screens/drugs/drugs_list.dart';
import 'package:pharm_pfe/screens/patients/patients_list.dart';
import 'package:pharm_pfe/style/style.dart';

class AddEditAnalisis extends StatefulWidget {
  final Analysis analysis;
  final int userid;

  const AddEditAnalisis({Key key, this.analysis, this.userid})
      : super(key: key);
  @override
  _AddEditAnalisisState createState() => _AddEditAnalisisState();
}

class _AddEditAnalisisState extends State<AddEditAnalisis> {
  Patient patient;
  Drug drug;
  Analysis analysis;
  User user;
  String creationDate = DateTime.now().year.toString() +
      "-" +
      DateTime.now().month.toString() +
      "-" +
      DateTime.now().day.toString();

  @override
  void initState() {
    DatabaseHelper.selectSpecificUser(widget.userid).then((value) {
      setState(() {
        user = User.fromMap(value[0]);
      });
    });
    if (widget.analysis != null) {
      analysis = widget.analysis;
      _initDrugAndPatient();
    } else {
      // analysis = new Analysis();
    }
    super.initState();
  }

  _initDrugAndPatient() async {
    DatabaseHelper.selectSpecificDrug(widget.analysis.drugId).then((value) {
      setState(() {
        drug = Drug.fromMap(value[0]);
      });
    }).then((value) {
      DatabaseHelper.selectSpecificPatient(widget.analysis.patientId)
          .then((value) {
        setState(() {
          patient = Patient.fromMap(value[0]);
        });
      });
    });
  }

  _save() {
    if (widget.analysis == null) {
      DatabaseHelper.insertPoch(analysis).then((value) {
        Navigator.of(context).pop(Analysis(
            id: value,
            userid: user.id,
            drugId: drug.id,
            patientId: patient.id,
            adminDose: _calculateAdminDose(),
            creationDate: creationDate,
            finalVolume: _calculateFinalVolume(_calculateAdminDose()),
            maxIntervale: _calculateMaxIntervale(250.0),
            minIntervale: _calculateMinIntervale(250.0),
            price: _calculatePrice(),
            reliquat: _calculateReliquat(
                _calculateFinalVolume(_calculateAdminDose()))));
      });
    } else {
      DatabaseHelper.updatePoch(Analysis(
              id: widget.analysis.id,
              userid: user.id,
              drugId: drug.id,
              patientId: patient.id,
              adminDose: _calculateAdminDose(),
              creationDate: creationDate,
              finalVolume: _calculateFinalVolume(_calculateAdminDose()),
              maxIntervale: _calculateMaxIntervale(250.0),
              minIntervale: _calculateMinIntervale(250.0),
              price: _calculatePrice(),
              reliquat: _calculateReliquat(
                  _calculateFinalVolume(_calculateAdminDose()))))
          .then((value) {
        Navigator.of(context).pop(Analysis(
            id: widget.analysis.id,
            userid: user.id,
            drugId: drug.id,
            patientId: patient.id,
            adminDose: _calculateAdminDose(),
            creationDate: creationDate,
            finalVolume: _calculateFinalVolume(_calculateAdminDose()),
            maxIntervale: _calculateMaxIntervale(250.0),
            minIntervale: _calculateMinIntervale(250.0),
            price: _calculatePrice(),
            reliquat: _calculateReliquat(
                _calculateFinalVolume(_calculateAdminDose()))));
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Style.darkBackgroundColor,
      appBar: AppBar(
        elevation: 2,
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.check),
              onPressed: () {
                _save();
              })
        ],
        backgroundColor: Style.yellowColor,
        title: Text(widget.analysis == null ? "Ajouter" : "Modifier",
            style: Theme.of(context)
                .textTheme
                .bodyText2
                .copyWith(color: Style.darkBackgroundColor)),
      ),
      body: ListView(
        physics: BouncingScrollPhysics(),
        children: [
          SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              creationDate,
              style: Theme.of(context)
                  .textTheme
                  .caption
                  .copyWith(color: Style.secondaryColor),
            ),
          ),
          Padding(
              padding: const EdgeInsets.all(8.0),
              child: Material(
                  color: Style.darkBackgroundColor,
                  child: InkWell(
                    onTap: () {
                      Navigator.of(context)
                          .push(CupertinoPageRoute(builder: (context) {
                        return PatientsList(
                          userid: user.id,
                          isSelectable: true,
                        );
                      })).then((value) {
                        if (value != null)
                          setState(() {
                            patient = value;
                            if (drug != null) {
                              _calculatePoch();
                            }
                          });
                      });
                    },
                    child: Container(
                        padding: EdgeInsets.symmetric(vertical: 18),
                        decoration: BoxDecoration(
                            border: Border(
                                bottom: BorderSide(
                                    color: Style.secondaryColor, width: 1))),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              patient == null
                                  ? "Selectioner un patient"
                                  : patient.fullname,
                              style: patient == null
                                  ? Theme.of(context).textTheme.caption
                                  : Theme.of(context).textTheme.bodyText2,
                            ),
                            patient != null
                                ? Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: CircleAvatar(
                                      radius: 16,
                                      backgroundColor: Style.accentColor,
                                      child: Icon(
                                        Icons.check,
                                        color: Style.darkBackgroundColor,
                                        size: 20,
                                      ),
                                    ),
                                  )
                                : Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: CircleAvatar(
                                      radius: 16,
                                      backgroundColor: Style.redColor,
                                      child: Icon(
                                        Icons.remove,
                                        color: Style.darkBackgroundColor,
                                        size: 20,
                                      ),
                                    ),
                                  )
                          ],
                        )),
                  ))),
          Padding(
              padding: const EdgeInsets.all(8.0),
              child: Material(
                  color: Style.darkBackgroundColor,
                  child: InkWell(
                    onTap: () {
                      Navigator.of(context)
                          .push(CupertinoPageRoute(builder: (context) {
                        return DrugsList(
                          userid: user.id,
                          isSelectable: true,
                        );
                      })).then((value) {
                        if (value != null)
                          setState(() {
                            drug = value;
                            if (patient != null) {
                              _calculatePoch();
                            }
                          });
                      });
                    },
                    child: Container(
                        padding: EdgeInsets.symmetric(vertical: 18),
                        decoration: BoxDecoration(
                            border: Border(
                                bottom: BorderSide(
                                    color: Style.secondaryColor, width: 1))),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              drug == null
                                  ? "Selectioner un Médicament"
                                  : drug.name,
                              style: drug == null
                                  ? Theme.of(context).textTheme.caption
                                  : Theme.of(context).textTheme.bodyText2,
                            ),
                            drug != null
                                ? Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: CircleAvatar(
                                      radius: 16,
                                      backgroundColor: Style.accentColor,
                                      child: Icon(
                                        Icons.check,
                                        color: Style.darkBackgroundColor,
                                        size: 20,
                                      ),
                                    ),
                                  )
                                : Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: CircleAvatar(
                                      radius: 16,
                                      backgroundColor: Style.redColor,
                                      child: Icon(
                                        Icons.remove,
                                        color: Style.darkBackgroundColor,
                                        size: 20,
                                      ),
                                    ),
                                  )
                          ],
                        )),
                  ))),
          SizedBox(
            height: 20,
          ),
          Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Dose administré",
                    style: Theme.of(context).textTheme.caption,
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Container(
                      alignment: Alignment.centerLeft,
                      padding:
                          EdgeInsets.symmetric(vertical: 18, horizontal: 12),
                      decoration: BoxDecoration(
                          color: Style.darkBackgroundColor,
                          border:
                              Border.all(color: Style.secondaryColor, width: 1),
                          borderRadius: BorderRadius.circular(4)),
                      child: Text(
                          analysis != null
                              ? analysis.adminDose.toString()
                              : "0.0",
                          style: Theme.of(context)
                              .textTheme
                              .bodyText2
                              .copyWith(fontFamily: 'elc'))),
                ],
              )),
          Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Volum finale",
                    style: Theme.of(context).textTheme.caption,
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Container(
                      alignment: Alignment.centerLeft,
                      padding:
                          EdgeInsets.symmetric(vertical: 18, horizontal: 12),
                      decoration: BoxDecoration(
                          color: Style.darkBackgroundColor,
                          border:
                              Border.all(color: Style.secondaryColor, width: 1),
                          borderRadius: BorderRadius.circular(4)),
                      child: Text(
                          analysis != null
                              ? analysis.finalVolume.toString()
                              : "0.0",
                          style: Theme.of(context)
                              .textTheme
                              .bodyText2
                              .copyWith(fontFamily: 'elc'))),
                ],
              )),
          Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Reliquat",
                    style: Theme.of(context).textTheme.caption,
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Container(
                      alignment: Alignment.centerLeft,
                      padding:
                          EdgeInsets.symmetric(vertical: 18, horizontal: 12),
                      decoration: BoxDecoration(
                          color: Style.darkBackgroundColor,
                          border:
                              Border.all(color: Style.secondaryColor, width: 1),
                          borderRadius: BorderRadius.circular(4)),
                      child: Text(
                          analysis != null
                              ? analysis.reliquat.toString()
                              : "0.0",
                          style: Theme.of(context)
                              .textTheme
                              .bodyText2
                              .copyWith(fontFamily: 'elc'))),
                ],
              )),
          Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Intervale",
                    style: Theme.of(context).textTheme.caption,
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Container(
                      alignment: Alignment.centerLeft,
                      padding:
                          EdgeInsets.symmetric(vertical: 18, horizontal: 12),
                      decoration: BoxDecoration(
                          color: Style.darkBackgroundColor,
                          border:
                              Border.all(color: Style.secondaryColor, width: 1),
                          borderRadius: BorderRadius.circular(4)),
                      child: Text(
                          analysis != null
                              ? "[${analysis.maxIntervale} ; ${analysis.minIntervale}]"
                              : "[0.0 ; 0.0]",
                          style: Theme.of(context)
                              .textTheme
                              .bodyText2
                              .copyWith(fontFamily: 'elc'))),
                ],
              )),
          Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Prix",
                    style: Theme.of(context).textTheme.caption,
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Container(
                      alignment: Alignment.centerLeft,
                      padding:
                          EdgeInsets.symmetric(vertical: 18, horizontal: 12),
                      decoration: BoxDecoration(
                          color: Style.yellowColor,
                          boxShadow: [
                            BoxShadow(
                                blurRadius: 5,
                                color: Style.secondaryColor.withOpacity(.5),
                                offset: Offset(1, 1))
                          ],
                          borderRadius: BorderRadius.circular(4)),
                      child: Text(
                          analysis != null ? analysis.price.toString() : "0.0",
                          style: Theme.of(context)
                              .textTheme
                              .bodyText2
                              .copyWith(fontFamily: 'elc'))),
                ],
              )),
        ],
      ),
    );
  }

  num _calculateAdminDose() {
    return patient.sc * drug.passologie;
  }

  num _calculateFinalVolume(num adminDose) {
    return adminDose / drug.cinit;
  }

  num _calculateReliquat(num finalVolume) {
    //TODO presentation ceil
    return ((finalVolume / drug.presentation).ceil()) * drug.presentation -
        finalVolume;
  }

  num _calculateMaxIntervale(num volum) {
    return drug.cmin * volum;
  }

  num _calculateMinIntervale(num volum) {
    return drug.cmin * volum;
  }

  num _calculatePrice() {
    return 0.0;
  }

  _calculatePoch() {
    analysis = Analysis(
        id: null,
        userid: user.id,
        drugId: drug.id,
        patientId: patient.id,
        adminDose: _calculateAdminDose(),
        creationDate: creationDate,
        finalVolume: _calculateFinalVolume(_calculateAdminDose()),
        maxIntervale: _calculateMaxIntervale(250.0),
        minIntervale: _calculateMinIntervale(250.0),
        price: _calculatePrice(),
        reliquat:
            _calculateReliquat(_calculateFinalVolume(_calculateAdminDose())));
  }
}
