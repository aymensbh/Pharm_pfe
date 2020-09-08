import 'package:flutter/material.dart';
import 'package:flutter_holo_date_picker/flutter_holo_date_picker.dart';
import 'package:pharm_pfe/backend/sqlitedatabase_helper.dart';
import 'package:pharm_pfe/entities/patient.dart';
import 'package:pharm_pfe/style/style.dart';

class AddEditPatient extends StatefulWidget {
  final Patient patient;

  final int userid;

  const AddEditPatient({Key key, this.patient, this.userid}) : super(key: key);
  @override
  _AddEditPatientState createState() => _AddEditPatientState();
}

class _AddEditPatientState extends State<AddEditPatient> {
  TextEditingController fullnameController,
      scController,
      phoneController,
      doctorController,
      addressController;
  String birthDate;
  GlobalKey<FormState> _formKey;

  InputDecoration _inputDecoration(String lable) {
    return InputDecoration(
        labelText: lable,
        errorStyle:
            Theme.of(context).textTheme.caption.copyWith(color: Style.redColor),
        labelStyle: Theme.of(context).textTheme.caption,
        focusedErrorBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Style.redColor),
        ),
        errorBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Style.redColor),
        ),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Style.primaryColor),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Style.accentColor),
        ));
  }

  @override
  void initState() {
    _formKey = GlobalKey();
    if (widget.patient != null) {
      fullnameController = TextEditingController(text: widget.patient.fullname);
      phoneController = TextEditingController(text: widget.patient.phone);
      doctorController = TextEditingController(text: widget.patient.doctor);
      addressController = TextEditingController(text: widget.patient.address);
      scController = TextEditingController(text: widget.patient.sc.toString());
      birthDate = widget.patient.birthdate;
    } else {
      fullnameController = TextEditingController();
      phoneController = TextEditingController();
      doctorController = TextEditingController();
      addressController = TextEditingController();
      scController = TextEditingController();
      birthDate = "";
    }
    super.initState();
  }

  _validateInput() {
    if (_formKey.currentState.validate()) {
      //TODO: save Patient
      if (widget.patient == null) {
        print("added");
        DatabaseHelper.insertPatient(Patient(
                id: null,
                userid: widget.userid,
                address: addressController.text.trim(),
                doctor: doctorController.text.trim(),
                birthdate: birthDate.isEmpty ? "2000-1-1" : birthDate,
                sc: num.parse(scController.text),
                fullname: fullnameController.text.trim(),
                phone: phoneController.text.trim()))
            .then((value) {
          Navigator.of(context).pop(Patient(
              id: value,
              userid: widget.userid,
              address: addressController.text.trim(),
              doctor: doctorController.text.trim(),
              birthdate: birthDate.isEmpty ? "2000-1-1" : birthDate,
              sc: num.parse(scController.text),
              fullname: fullnameController.text.trim(),
              phone: phoneController.text.trim()));
        }).catchError((onError) {
          return;
        });
      } else {
        print("updated");
        DatabaseHelper.updatePatient(Patient(
                id: widget.patient.id,
                userid: widget.patient.userid,
                address: addressController.text.trim(),
                doctor: doctorController.text.trim(),
                birthdate: birthDate.isEmpty ? "2000-1-1" : birthDate,
                sc: num.parse(scController.text),
                fullname: fullnameController.text.trim(),
                phone: phoneController.text.trim()))
            .then((value) {
          Navigator.of(context).pop(Patient(
              id: widget.patient.id,
              userid: widget.userid,
              address: addressController.text.trim(),
              doctor: doctorController.text.trim(),
              birthdate: birthDate.isEmpty ? "2000-1-1" : birthDate,
              sc: num.parse(scController.text),
              fullname: fullnameController.text.trim(),
              phone: phoneController.text.trim()));
        }).catchError((onError) {
          return;
        });
      }
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
                _validateInput();
              })
        ],
        backgroundColor: Style.purpleColor,
        title: Text(widget.patient == null ? "Ajouter" : "Modifier",
            style: Theme.of(context)
                .textTheme
                .bodyText2
                .copyWith(color: Style.darkBackgroundColor)),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          physics: BouncingScrollPhysics(),
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                style: Theme.of(context).textTheme.bodyText2,
                decoration: _inputDecoration("Nom complet de patient"),
                controller: fullnameController,
                validator: (input) {
                  if (input.trim().isEmpty || input.trim().length > 48) {
                    return "Veuiller saisir un nom complet";
                  }
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                style: Theme.of(context).textTheme.bodyText2,
                decoration: _inputDecoration("Docteur"),
                controller: doctorController,
                validator: (input) {
                  if (input.trim().isEmpty || input.trim().length > 48) {
                    return "Veuiller saisir un nom complet";
                  }
                },
              ),
            ),
            Padding(
                padding: const EdgeInsets.all(8.0),
                child: Material(
                    color: Style.darkBackgroundColor,
                    child: InkWell(
                      onTap: () {
                        DatePicker.showSimpleDatePicker(
                          context,
                          cancelText: "Annuler",
                          titleText: "Date de naissance",
                          textColor: Style.primaryColor,
                          initialDate: DateTime(1994),
                          firstDate: DateTime(1960),
                          lastDate: DateTime(2012),
                          dateFormat: "dd-MMMM-yyyy",
                          locale: DateTimePickerLocale.fr,
                          looping: true,
                        ).then((value) {
                          if (value != null) {
                            setState(() {
                              birthDate = value.year.toString() +
                                  "-" +
                                  value.month.toString() +
                                  "-" +
                                  value.day.toString();
                            });
                          }
                        });
                      },
                      child: Container(
                          padding: EdgeInsets.symmetric(vertical: 18),
                          decoration: BoxDecoration(
                              border: Border(
                                  bottom: BorderSide(
                                      color: Style.secondaryColor, width: 1))),
                          child: Text(
                            birthDate.isEmpty ? "Date de naissance" : birthDate,
                            style: birthDate.isEmpty
                                ? Theme.of(context).textTheme.caption
                                : Theme.of(context).textTheme.bodyText2,
                          )),
                    ))),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                style: Theme.of(context).textTheme.bodyText2,
                decoration: _inputDecoration("Surface corporelle"),
                controller: scController,
                keyboardType: TextInputType.number,
                validator: (input) {
                  if (input.trim().isEmpty || input.trim().length > 48) {
                    return "Veuiller saisir une sc";
                  }
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                style: Theme.of(context).textTheme.bodyText2,
                decoration: _inputDecoration("Adresse"),
                controller: addressController,
                validator: (input) {
                  if (input.trim().isEmpty || input.trim().length > 48) {
                    return "Veuiller saisir une adress";
                  }
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                style: Theme.of(context).textTheme.bodyText2,
                decoration: _inputDecoration("Contact"),
                controller: phoneController,
                validator: (input) {
                  if (input.trim().isEmpty || input.trim().length > 48) {
                    return "Veuiller saisir un contact";
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
