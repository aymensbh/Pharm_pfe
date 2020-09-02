import 'package:flutter/material.dart';
import 'package:pharm_pfe/entities/analysis.dart';
import 'package:pharm_pfe/entities/drug.dart';
import 'package:pharm_pfe/entities/patient.dart';
import 'package:pharm_pfe/style/style.dart';

class AddEditAnalisis extends StatefulWidget {
  final Analysis analysis;

  const AddEditAnalisis({Key key, this.analysis}) : super(key: key);
  @override
  _AddEditAnalisisState createState() => _AddEditAnalisisState();
}

class _AddEditAnalisisState extends State<AddEditAnalisis> {
  String patient, drug;
  @override
  void initState() {
    // TODO: implement initState
    patient = "";
    drug = "";
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
                _validate();
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
              DateTime.now().year.toString() +
                  "-" +
                  DateTime.now().month.toString() +
                  "-" +
                  DateTime.now().day.toString(),
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
                    onTap: () {},
                    child: Container(
                        padding: EdgeInsets.symmetric(vertical: 18),
                        decoration: BoxDecoration(
                            border: Border(
                                bottom: BorderSide(
                                    color: Style.secondaryColor, width: 1))),
                        child: Text(
                          patient.isEmpty ? "+Selectioner un patient" : patient,
                          style: patient.isEmpty
                              ? Theme.of(context).textTheme.caption
                              : Theme.of(context).textTheme.bodyText2,
                        )),
                  ))),
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
                          drug.isEmpty ? "+Selectioner un Médicament" : drug,
                          style: patient.isEmpty
                              ? Theme.of(context).textTheme.caption
                              : Theme.of(context).textTheme.bodyText2,
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
                          widget.analysis == null
                              ? "0.0 ml"
                              : widget.analysis.calculatePrice(),
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
                          widget.analysis == null
                              ? "0.0 ml"
                              : widget.analysis.calculatePrice(),
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
                          widget.analysis == null
                              ? "0.0 ml"
                              : widget.analysis.calculatePrice(),
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
                          widget.analysis == null
                              ? "[0.0 ; 0.0]"
                              : widget.analysis.calculatePrice(),
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
                          color: Style.darkBackgroundColor,
                          border:
                              Border.all(color: Style.secondaryColor, width: 1),
                          borderRadius: BorderRadius.circular(4)),
                      child: Text(
                          widget.analysis == null
                              ? "100 DA"
                              : widget.analysis.calculatePrice(),
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

  _validate() {
    Analysis analysis = Analysis(
      1,
      DateTime.now().toString(),
      Patient(),
      Drug(),
    );
  }
}
