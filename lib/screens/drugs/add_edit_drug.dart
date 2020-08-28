import 'package:flutter/material.dart';
import 'package:pharm_pfe/entities/drug.dart';
import 'package:pharm_pfe/style/style.dart';

class AddEditDrug extends StatefulWidget {
  final Drug drug;

  const AddEditDrug({Key key, this.drug}) : super(key: key);
  @override
  _AddEditDrugState createState() => _AddEditDrugState();
}

class _AddEditDrugState extends State<AddEditDrug> {
  TextEditingController drugNameController,
      cminController,
      cmaxController,
      passologieController,
      cinitController;

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
    if (widget.drug != null) {
      drugNameController = TextEditingController(text: widget.drug.name);
      cminController = TextEditingController(text: widget.drug.cmin);
      cmaxController = TextEditingController(text: widget.drug.cmax);
      cinitController = TextEditingController(text: widget.drug.cinit);
      passologieController =
          TextEditingController(text: widget.drug.passologie);
    } else {
      drugNameController = TextEditingController();
      cminController = TextEditingController();
      cmaxController = TextEditingController();
      cinitController = TextEditingController();
      passologieController = TextEditingController();
    }
    super.initState();
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
        backgroundColor: Style.redColor,
        title: Text(widget.drug == null ? "Ajouter" : "Modifier",
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
                decoration: _inputDecoration("Médicament"),
                controller: drugNameController,
                validator: (input) {
                  if (input.trim().isEmpty || input.trim().length > 48) {
                    return "Veuiller saisir un médicament";
                  }
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                style: Theme.of(context).textTheme.bodyText2,
                decoration: _inputDecoration("CInit"),
                controller: cinitController,
                validator: (input) {
                  if (input.trim().isEmpty || input.trim().length > 48) {
                    return "Veuiller saisir une CInit";
                  }
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                style: Theme.of(context).textTheme.bodyText2,
                decoration: _inputDecoration("CMin"),
                controller: cminController,
                validator: (input) {
                  if (input.trim().isEmpty || input.trim().length > 48) {
                    return "Veuiller saisir une CMin";
                  }
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                style: Theme.of(context).textTheme.bodyText2,
                decoration: _inputDecoration("CMax"),
                controller: cmaxController,
                validator: (input) {
                  if (input.trim().isEmpty || input.trim().length > 48) {
                    return "Veuiller saisir une CMax";
                  }
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                style: Theme.of(context).textTheme.bodyText2,
                decoration: _inputDecoration("Passologie"),
                controller: passologieController,
                validator: (input) {
                  if (input.trim().isEmpty || input.trim().length > 48) {
                    return "Veuiller saisir une Passologie";
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  _validateInput() {
    if (_formKey.currentState.validate()) {
      //TODO: Save médicament in db
      print(cinitController.text);
      Navigator.of(context).pop(Drug(
          id: 1,
          cinit: cinitController.text.trim(),
          cmax: cmaxController.text.trim(),
          cmin: cminController.text.trim(),
          name: drugNameController.text.trim(),
          passologie: passologieController.text.trim()));
    }
  }
}
