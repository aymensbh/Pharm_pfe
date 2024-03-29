import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pharm_pfe/authentification/login_page.dart';
// import 'package:pharm_pfe/customWidgets/custom_grid_item.dart';
// import 'package:pharm_pfe/customWidgets/custom_grid_tool.dart';
// import 'package:pharm_pfe/entities/user.dart';
import 'package:pharm_pfe/screens/others/about.dart';
import 'package:pharm_pfe/screens/analisis/analysis_history.dart';
import 'package:pharm_pfe/screens/drugs/drugs_list.dart';
// import 'package:pharm_pfe/screens/others/report.dart';
import 'package:pharm_pfe/screens/patients/patients_list.dart';
import 'package:pharm_pfe/style/style.dart';

class HomePage extends StatefulWidget {
  final int userid;

  const HomePage({Key key, this.userid}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Style.darkBackgroundColor,
      appBar: AppBar(
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.person),
            onPressed: () {
              Navigator.of(context).push(CupertinoPageRoute(builder: (context) {
                return About(
                  userid: widget.userid,
                );
              }));
            },
          ),
          Padding(
            padding: EdgeInsets.all(8),
            child: IconButton(
              icon: Icon(
                Icons.keyboard_arrow_down,
                size: 28,
              ),
              onPressed: () {
                showModalBottomSheet(
                    context: context,
                    builder: (context) {
                      return BottomSheet(
                          elevation: 2,
                          enableDrag: false,
                          onClosing: () {},
                          builder: (context) {
                            return ListTile(
                              trailing: Icon(Icons.arrow_forward_ios,
                                  size: 18, color: Style.secondaryColor),
                              onTap: () {
                                Navigator.of(context).pop(true);
                              },
                              leading: Icon(
                                Icons.exit_to_app,
                                color: Style.redColor,
                              ),
                              title: Text(
                                "Déconextion",
                                style: Theme.of(context).textTheme.caption,
                              ),
                            );
                          });
                    }).then((value) {
                  if (value != null && value) {
                    Navigator.of(context)
                        .pushReplacement(CupertinoPageRoute(builder: (context) {
                      return LoginPage();
                    }));
                  }
                });
              },
            ),
          )
        ],
        elevation: 2,
        backgroundColor: Style.accentColor,
        title: Text(
          "Home",
          style: Theme.of(context)
              .textTheme
              .bodyText2
              .copyWith(color: Style.darkBackgroundColor),
        ),
      ),
      body: ListView(
        physics: BouncingScrollPhysics(),
        padding: EdgeInsets.all(4),
        children: <Widget>[
          ListTile(
            trailing: Icon(Icons.arrow_forward_ios,
                size: 18, color: Style.secondaryColor),
            contentPadding: EdgeInsets.all(12),
            leading: Icon(
              Icons.people,
              color: Style.purpleColor,
            ),
            onTap: () {
              Navigator.of(context).push(CupertinoPageRoute(builder: (context) {
                return PatientsList(
                  userid: widget.userid,
                  isSelectable: false,
                );
              }));
            },
            title: Text("Patients"),
          ),
          ListTile(
            trailing: Icon(Icons.arrow_forward_ios,
                size: 18, color: Style.secondaryColor),
            contentPadding: EdgeInsets.all(12),
            leading: Icon(
              Icons.inbox,
              color: Style.redColor,
            ),
            onTap: () {
              Navigator.of(context).push(CupertinoPageRoute(builder: (context) {
                return DrugsList(
                  userid: widget.userid,
                  isSelectable: false,
                );
              }));
            },
            title: Text("Médicaments"),
          ),
          ListTile(
            trailing: Icon(Icons.arrow_forward_ios,
                size: 18, color: Style.secondaryColor),
            contentPadding: EdgeInsets.all(12),
            leading: Icon(
              Icons.multiline_chart,
              color: Style.yellowColor,
            ),
            onTap: () {
              Navigator.of(context).push(CupertinoPageRoute(builder: (context) {
                return AnalysisHistoryPage(
                  userid: widget.userid,
                );
              }));
            },
            title: Text("Poches"),
          ),
          // Container(
          //     child: GridView(
          //   physics: NeverScrollableScrollPhysics(),
          //   shrinkWrap: true,
          //   gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          //       crossAxisCount: 2, mainAxisSpacing: 4, crossAxisSpacing: 4),
          //   children: <Widget>[
          //     CustomGridToolItem(
          //       icon: Icons.person_outline,
          //       onTap: () {
          //         Navigator.of(context)
          //             .push(CupertinoPageRoute(builder: (context) {
          //           return About(
          //             userid: widget.userid,
          //           );
          //         }));
          //       },
          //     ),
          //     CustomGridToolItem(
          //       icon: Icons.info_outline,
          //       onTap: () {
          //         Navigator.of(context)
          //             .push(CupertinoPageRoute(builder: (context) {
          //           return Report();
          //         }));
          //       },
          //     ),
          //   ],
          // ))
        ],
      ),
    );
  }
}
