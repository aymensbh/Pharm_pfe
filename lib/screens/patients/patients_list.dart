import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pharm_pfe/customWidgets/empty_folder.dart';
import 'package:pharm_pfe/entities/patient.dart';
import 'package:pharm_pfe/screens/patients/add_edit_patient.dart';
import 'package:pharm_pfe/style/style.dart';

class PatientsList extends StatefulWidget {
  @override
  _PatientsListState createState() => _PatientsListState();
}

class _PatientsListState extends State<PatientsList> {
  List<Patient> _patientsList = [];
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
                      return AddEditPatient();
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
          title: Text("Patients",
              style: Theme.of(context)
                  .textTheme
                  .bodyText2
                  .copyWith(color: Style.darkBackgroundColor)),
        ),
        body: _patientsList.isEmpty
            ? EmptyFolder(icon: Icons.people, color: Style.purpleColor)
            : ListView(
                children: List.generate(
                    _patientsList.length,
                    (index) => ListTile(
                          onTap: () {
                            Navigator.of(context)
                                .push(CupertinoPageRoute(builder: (context) {
                              return AddEditPatient(
                                  patient: _patientsList[index]);
                            }));
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
              ));
  }
}
