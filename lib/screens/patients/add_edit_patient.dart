import 'package:flutter/material.dart';
import 'package:pharm_pfe/entities/patient.dart';
import 'package:pharm_pfe/style/style.dart';

class AddEditPatient extends StatefulWidget {
  final Patient patient;

  const AddEditPatient({Key key, this.patient}) : super(key: key);
  @override
  _AddEditPatientState createState() => _AddEditPatientState();
}

class _AddEditPatientState extends State<AddEditPatient> {
  TextEditingController fullnameController, phoneController, addressController;
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
      addressController = TextEditingController(text: widget.patient.addess);
      birthDate = widget.patient.birthdate;
    } else {
      fullnameController = TextEditingController();
      phoneController = TextEditingController();
      addressController = TextEditingController();
      birthDate = "";
    }
    super.initState();
  }

  _validateInput() {
    if (_formKey.currentState.validate()) {
      //TODO: save Patient
      Navigator.of(context).pop(Patient(
          id: 1,
          addess: addressController.text.trim(),
          birthdate: "2020/12/12",
          fullname: fullnameController.text.trim(),
          phone: phoneController.text.trim()));
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
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                style: Theme.of(context).textTheme.bodyText2,
                decoration: _inputDecoration("Nom complet"),
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
                child: Material(
                    color: Style.darkBackgroundColor,
                    child: InkWell(
                      onTap: () {},
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
