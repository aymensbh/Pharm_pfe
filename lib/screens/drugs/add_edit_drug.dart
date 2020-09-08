import 'package:flutter/material.dart';
import 'package:pharm_pfe/backend/sqlitedatabase_helper.dart';
import 'package:pharm_pfe/entities/drug.dart';
import 'package:pharm_pfe/style/style.dart';

class AddEditDrug extends StatefulWidget {
  final Drug drug;
  final int userid;

  const AddEditDrug({Key key, this.drug, this.userid}) : super(key: key);
  @override
  _AddEditDrugState createState() => _AddEditDrugState();
}

class _AddEditDrugState extends State<AddEditDrug> {
  TextEditingController drugNameController,
      cminController,
      cmaxController,
      passologieController,
      labController,
      presentationController,
      stabilityController,
      priceController,
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
      cminController = TextEditingController(text: widget.drug.cmin.toString());
      cmaxController = TextEditingController(text: widget.drug.cmax.toString());
      labController = TextEditingController(text: widget.drug.lab.toString());
      presentationController =
          TextEditingController(text: widget.drug.presentation.toString());
      stabilityController =
          TextEditingController(text: widget.drug.stability.toString());
      priceController =
          TextEditingController(text: widget.drug.price.toString());
      cinitController =
          TextEditingController(text: widget.drug.cinit.toString());
      passologieController =
          TextEditingController(text: widget.drug.passologie.toString());
    } else {
      drugNameController = TextEditingController();
      labController = TextEditingController();
      cminController = TextEditingController();
      cmaxController = TextEditingController();
      cinitController = TextEditingController();
      passologieController = TextEditingController();
      presentationController = TextEditingController();
      stabilityController = TextEditingController();
      priceController = TextEditingController();
      cinitController = TextEditingController();
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
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            children: [
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
                  decoration: _inputDecoration("Laboratoire"),
                  controller: labController,
                  validator: (input) {
                    if (input.trim().isEmpty || input.trim().length > 48) {
                      return "Veuiller saisir un laboratoir";
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
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  style: Theme.of(context).textTheme.bodyText2,
                  decoration: _inputDecoration("Stability"),
                  controller: stabilityController,
                  validator: (input) {
                    if (input.trim().isEmpty || input.trim().length > 48) {
                      return "Veuiller saisir la Stabilité";
                    }
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  style: Theme.of(context).textTheme.bodyText2,
                  decoration: _inputDecoration("Présentation"),
                  controller: presentationController,
                  validator: (input) {
                    if (input.trim().isEmpty || input.trim().length > 48) {
                      return "Veuiller saisir la Présentation";
                    }
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  style: Theme.of(context).textTheme.bodyText2,
                  decoration: _inputDecoration("Prix"),
                  controller: priceController,
                  validator: (input) {
                    if (input.trim().isEmpty || input.trim().length > 48) {
                      return "Veuiller saisir le prix";
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _validateInput() {
    if (_formKey.currentState.validate()) {
      if (widget.drug == null) {
        DatabaseHelper.insertDrug(Drug(
                id: null,
                userid: widget.userid,
                cinit: num.parse(cinitController.text.trim()),
                cmax: num.parse(cmaxController.text.trim()),
                cmin: num.parse(cminController.text.trim()),
                name: drugNameController.text.trim(),
                lab: labController.text.trim(),
                presentation: num.parse(presentationController.text.trim()),
                price: num.parse(priceController.text.trim()),
                stability: num.parse(stabilityController.text.trim()),
                passologie: num.parse(passologieController.text.trim())))
            .then((value) {
          Navigator.of(context).pop(Drug(
              id: value,
              userid: widget.userid,
              cinit: num.parse(cinitController.text.trim()),
              cmax: num.parse(cmaxController.text.trim()),
              cmin: num.parse(cminController.text.trim()),
              name: drugNameController.text.trim(),
              lab: labController.text.trim(),
              presentation: num.parse(presentationController.text.trim()),
              price: num.parse(priceController.text.trim()),
              stability: num.parse(stabilityController.text.trim()),
              passologie: num.parse(passologieController.text.trim())));
        });
      } else {
        DatabaseHelper.updateDrug(Drug(
                id: widget.drug.id,
                userid: widget.userid,
                cinit: num.parse(cinitController.text.trim()),
                cmax: num.parse(cmaxController.text.trim()),
                cmin: num.parse(cminController.text.trim()),
                name: drugNameController.text.trim(),
                lab: labController.text.trim(),
                presentation: num.parse(presentationController.text.trim()),
                price: num.parse(priceController.text.trim()),
                stability: num.parse(stabilityController.text.trim()),
                passologie: num.parse(passologieController.text.trim())))
            .then((value) {
          Navigator.of(context).pop(Drug(
              id: widget.drug.id,
              userid: widget.userid,
              cinit: num.parse(cinitController.text.trim()),
              cmax: num.parse(cmaxController.text.trim()),
              cmin: num.parse(cminController.text.trim()),
              name: drugNameController.text.trim(),
              lab: labController.text.trim(),
              presentation: num.parse(presentationController.text.trim()),
              price: num.parse(priceController.text.trim()),
              stability: num.parse(stabilityController.text.trim()),
              passologie: num.parse(passologieController.text.trim())));
        });
      }
    }
  }
}
