import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';

import '../../../flutter_flow/flutter_flow_theme.dart';
import '../../../flutter_flow/flutter_flow_widgets.dart';
import '../../pages/home_page/home.dart';
import '../Customers/customer_SinglePage.dart';

class ProjectReport extends StatefulWidget {
  const ProjectReport({Key? key}) : super(key: key);

  @override
  State<ProjectReport> createState() => _ProjectReportState();
}

class _ProjectReportState extends State<ProjectReport> {
  static const _locale = 'HI';
  String _formatNumber(String s) =>
      NumberFormat.decimalPattern(_locale).format(int.parse(s));
  String get _currency =>
      NumberFormat.compactSimpleCurrency(locale: _locale, decimalDigits: 2)
          .currencySymbol;

  final scaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  late TextEditingController search;

  int firstIndex = 0;
  int lastIndex = 0;

  List listOfFilteredProjects = [];
  List<String> filterData = ['All', 'Completed', 'Active', 'Suspended'];
  late TextEditingController dropdownValue;

  // getWorkingProjects() {
  //   for (int i = 0; i < listOfActiveProjects.length; i++) {
  //     if (listOfActiveProjects[i]['status'] == 'Suspended' ||
  //         listOfActiveProjects[i]['status'] == 'Completed') {
  //       
  //     } else {
  //       listOfFilteredProjects.add(listOfActiveProjects[i]);
  //     }
  //   }
  // }

  getFirst20() {
    listOfFilteredProjects = [];
    for (int i = 0; i < listOfProjects.length; i++) {
      firstIndex = 0;
      if (listOfFilteredProjects.length < 20) {
        if (dropdownValue.text == 'All') {
          Map<String, dynamic> data = {};
          data = listOfProjects[i];
          data['index'] = i;
          listOfFilteredProjects.add(data);
        } else if (listOfProjects[i]['status'] == dropdownValue.text) {
          Map<String, dynamic> data = {};
          data = listOfProjects[i];
          data['index'] = i;
          listOfFilteredProjects.add(data);
        } else if (dropdownValue.text == 'Active') {
          if (listOfProjects[i]['status'] == 'Started' ||
              listOfProjects[i]['status'] == 'Pending') {
            Map<String, dynamic> data = {};
            data = listOfProjects[i];
            data['index'] = i;
            listOfFilteredProjects.add(data);
          }
        }

        // listOfFilteredProjects.add(listOfActiveProjects[i]);
      } else if (listOfFilteredProjects.length == 20) {
        lastIndex = i - 1;
        break;
      }
      lastIndex = i;
    }



    setState(() {});
  }

  next() {
    listOfFilteredProjects = [];
    for (int i = firstIndex; i < listOfProjects.length; i++) {
      if (listOfFilteredProjects.length < 20) {
        if (dropdownValue.text == 'All') {
          Map<String, dynamic> data = {};
          data = listOfProjects[i];
          data['index'] = i;
          listOfFilteredProjects.add(data);
        } else if (listOfProjects[i]['status'] == dropdownValue.text) {
          Map<String, dynamic> data = {};
          data = listOfProjects[i];
          data['index'] = i;
          listOfFilteredProjects.add(data);
        } else if (dropdownValue.text == 'Active') {
          if (listOfProjects[i]['status'] == 'Started' ||
              listOfProjects[i]['status'] == 'Pending') {
            Map<String, dynamic> data = {};
            data = listOfProjects[i];
            data['index'] = i;
            listOfFilteredProjects.add(data);
          }
        }

        // listOfFilteredProjects.add(listOfActiveProjects[i]);
      } else if (listOfFilteredProjects.length == 20) {
        lastIndex = i - 1;
        break;
      }
      lastIndex = i;
    }


    setState(() {});
  }

  prev() {
    listOfFilteredProjects = [];
    List prev = [];
    for (int i = lastIndex; i < listOfProjects.length; i--) {
      if (prev.length < 20) {
        if (dropdownValue.text == 'All') {
          Map<String, dynamic> data = {};
          data = listOfProjects[i];
          data['index'] = i;
          prev.add(data);
        } else if (listOfProjects[i]['status'] == dropdownValue.text) {
          Map<String, dynamic> data = {};
          data = listOfProjects[i];
          data['index'] = i;
          prev.add(data);
        } else if (dropdownValue.text == 'Active') {
          if (listOfProjects[i]['status'] == 'Started' ||
              listOfProjects[i]['status'] == 'Pending') {
            Map<String, dynamic> data = {};
            data = listOfProjects[i];
            data['index'] = i;
            prev.add(data);
          }
        }

        // listOfFilteredProjects.add(listOfActiveProjects[i]);

      } else if (prev.length == 20) {
        firstIndex = i + 1;
        break;
      }
      firstIndex = i;
    }

    listOfFilteredProjects = prev.reversed.toList();


    // listOfFilteredProjects.reversed;

    setState(() {});
  }

  getSearchedProjects(String txt) {
    listOfFilteredProjects = [];
    for (int i = 0; i < listOfProjects.length; i++) {
      if (listOfProjects[i]['projectName']
              .toString()
              .toLowerCase()
              .contains(txt) ||
          customerDetailsById[listOfProjects[i]['customerID']]['name']
              .toString()
              .toLowerCase()
              .contains(txt)) {
        if (listOfFilteredProjects.length < 20) {
          if (dropdownValue.text == 'All') {
            Map<String, dynamic> data = {};
            data = listOfProjects[i];
            data['index'] = i;
            listOfFilteredProjects.add(data);
          } else if (listOfProjects[i]['status'] == dropdownValue.text) {
            Map<String, dynamic> data = {};
            data = listOfProjects[i];
            data['index'] = i;
            listOfFilteredProjects.add(data);
          } else if (dropdownValue.text == 'Active') {
            if (listOfProjects[i]['status'] == 'Started' ||
                listOfProjects[i]['status'] == 'Pending') {
              Map<String, dynamic> data = {};
              data = listOfProjects[i];
              data['index'] = i;
              listOfFilteredProjects.add(data);
            }
          }

          // listOfFilteredProjects.add(listOfActiveProjects[i]);
        } else if (listOfFilteredProjects.length == 20) {
          lastIndex = i - 1;
          break;
        }
        lastIndex = i;

        // listOfFilteredProjects.add(listOfActiveProjects[i]);
      }
    }

    setState(() {});
  }

  getNextSearchProjects(String txt) {
    listOfFilteredProjects = [];
    for (int i = firstIndex; i < listOfProjects.length; i++) {
      if (listOfProjects[i]['projectName']
              .toString()
              .toLowerCase()
              .contains(txt) ||
          customerDetailsById[listOfProjects[i]['customerID']]['name']
              .toString()
              .toLowerCase()
              .contains(txt)) {
        if (listOfFilteredProjects.length < 20) {
          if (dropdownValue.text == 'All') {
            Map<String, dynamic> data = {};
            data = listOfProjects[i];
            data['index'] = i;
            listOfFilteredProjects.add(data);
          } else if (listOfProjects[i]['status'] == dropdownValue.text) {
            Map<String, dynamic> data = {};
            data = listOfProjects[i];
            data['index'] = i;
            listOfFilteredProjects.add(data);
          } else if (dropdownValue.text == 'Active') {
            if (listOfProjects[i]['status'] == 'Started' ||
                listOfProjects[i]['status'] == 'Pending') {
              Map<String, dynamic> data = {};
              data = listOfProjects[i];
              data['index'] = i;
              listOfFilteredProjects.add(data);
            }
          }

          // listOfFilteredProjects.add(listOfActiveProjects[i]);
        } else if (listOfFilteredProjects.length == 20) {
          lastIndex = i - 1;
          break;
        }
        lastIndex = i;

        // listOfFilteredProjects.add(listOfActiveProjects[i]);
      }
    }

    setState(() {});
  }

  getPrevSearchProjects(String txt) {
    listOfFilteredProjects = [];
    List prev = [];
    for (int i = lastIndex; i < listOfProjects.length; i--) {
      if (listOfProjects[i]['projectName']
              .toString()
              .toLowerCase()
              .contains(txt) ||
          customerDetailsById[listOfProjects[i]['customerID']]['name']
              .toString()
              .toLowerCase()
              .contains(txt)) {
        if (prev.length < 20) {
          if (dropdownValue.text == 'All') {
            Map<String, dynamic> data = {};
            data = listOfProjects[i];
            data['index'] = i;
            prev.add(data);
          } else if (listOfProjects[i]['status'] == dropdownValue.text) {
            Map<String, dynamic> data = {};
            data = listOfProjects[i];
            data['index'] = i;
            prev.add(data);
          } else if (dropdownValue.text == 'Active') {
            if (listOfProjects[i]['status'] == 'Started' ||
                listOfProjects[i]['status'] == 'Pending') {
              Map<String, dynamic> data = {};
              data = listOfProjects[i];
              data['index'] = i;
              prev.add(data);
            }
          }

          // listOfFilteredProjects.add(listOfActiveProjects[i]);

        } else if (prev.length == 20) {
          firstIndex = i + 1;
          break;
        }
        firstIndex = i;
      }
    }
    listOfFilteredProjects = prev.reversed.toList();


    // listOfFilteredProjects.reversed;

    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    search = TextEditingController();
    dropdownValue = TextEditingController(text: 'All');
    getFirst20();

  }

  @override
  void dispose() {
    super.dispose();
    dropdownValue.dispose();
    search.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(20, 15, 20, 0),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Expanded(
                      child: Text(
                        'Project Report',
                        style: FlutterFlowTheme.bodyText1.override(
                            fontFamily: 'Poppins',
                            fontSize: 25,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        width: 200,
                        height: 60,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                            color: Color(0xFFE6E6E6),
                          ),
                        ),
                        child: Center(
                          child: CustomDropdown.search(
                            hintText: 'Select particulars',
                            hintStyle: TextStyle(color: Colors.black),
                            items: filterData,

                            // excludeSelected: false,

                            controller: dropdownValue,
                            onChanged: (val) {
                              setState(() {
                                getFirst20();
                              });
                            },
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(0, 20, 0, 20),
                    child: Container(
                      width: 600,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            blurRadius: 3,
                            color: Color(0x39000000),
                            offset: Offset(0, 1),
                          )
                        ],
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(4, 4, 0, 4),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Expanded(
                              child: Padding(
                                padding:
                                    EdgeInsetsDirectional.fromSTEB(4, 0, 4, 0),
                                child: TextFormField(
                                  controller: search,
                                  obscureText: false,
                                  onChanged: (text) {
                                    setState(() {
                                      listOfFilteredProjects.clear();
                                      if (search.text == '') {
                                        // listOfFilteredProjects
                                        //     .addAll(listOfActiveProjects);
                                        getFirst20();
                                      } else {
                                        getSearchedProjects(text.toLowerCase());
                                      }
                                    });
                                  },
                                  decoration: InputDecoration(
                                    labelText: 'Search ',
                                    hintText: 'Please Search With Name',
                                    labelStyle:
                                        FlutterFlowTheme.bodyText2.override(
                                      fontFamily: 'Poppins',
                                      color: Color(0xFF7C8791),
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Color(0x00000000),
                                        width: 2,
                                      ),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Color(0x00000000),
                                        width: 2,
                                      ),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    filled: true,
                                    fillColor: Colors.white,
                                  ),
                                  style: FlutterFlowTheme.bodyText1.override(
                                    fontFamily: 'Poppins',
                                    color: Color(0xFF090F13),
                                    fontSize: 14,
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(0, 0, 8, 0),
                              child: FFButtonWidget(
                                onPressed: () {
                                  search.clear();
                                  setState(() {
                                    // listOfFilteredProjects
                                    //     .addAll(listOfActiveProjects);
                                    getFirst20();
                                  });
                                },
                                text: 'Clear',
                                options: FFButtonOptions(
                                  width: 100,
                                  height: 40,
                                  color: Color(0xff231F20),
                                  textStyle:
                                      FlutterFlowTheme.subtitle2.override(
                                    fontFamily: 'Poppins',
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.normal,
                                  ),
                                  elevation: 2,
                                  borderSide: BorderSide(
                                    color: Colors.transparent,
                                    width: 1,
                                  ),
                                  borderRadius: 50,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              listOfFilteredProjects.length == 0
                  ? LottieBuilder.network(
                      'https://assets9.lottiefiles.com/packages/lf20_HpFqiS.json',
                      height: 500,
                    )
                  : Row(
                      children: [
                        Expanded(
                          child: FittedBox(
                            child: DataTable(
                              horizontalMargin: 10,
                              columns: [
                                DataColumn(
                                  label: Text(
                                    "Sl.No",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize:
                                            MediaQuery.of(context).size.width *
                                                0.008),
                                  ),
                                ),
                                DataColumn(
                                  label: Text(
                                    "Name",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize:
                                            MediaQuery.of(context).size.width *
                                                0.008),
                                  ),
                                ),
                                DataColumn(
                                  label: Text("Project",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.008)),
                                ),
                                DataColumn(
                                  label: Text("Status",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.008)),
                                ),
                                DataColumn(
                                  label: Flexible(
                                    child: Container(
                                      child: Text("Project Cost",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.008)),
                                    ),
                                  ),
                                ),
                                DataColumn(
                                  label: Flexible(
                                    child: Container(
                                      child: Text("Total Paid",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.008)),
                                    ),
                                  ),
                                ),
                                DataColumn(
                                  label: Flexible(
                                    child: Container(
                                      child: Text("Due Balance",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.008)),
                                    ),
                                  ),
                                ),
                                DataColumn(
                                  label: Flexible(
                                    child: Container(
                                      child: Text("Action",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.008)),
                                    ),
                                  ),
                                ),
                              ],
                              // dividerThickness: 0.0,
                              // showBottomBorder: false,
                              rows: List.generate(
                                listOfFilteredProjects.length + 4,
                                (index) {
                                  // getCount(data[index].id);

                                  String customerName = '';
                                  String status = '';
                                  String projectName = '';
                                  double totalAmt = 0;
                                  double totalPaid = 0;
                                  double balanceDue = 0;
                                  int count = 0;

                                  if (index < listOfFilteredProjects.length) {
                                    customerName = customerDetailsById[
                                        listOfFilteredProjects[index]
                                            ['customerID']]['name'];
                                    status =
                                        listOfFilteredProjects[index]['status'];
                                    projectName = listOfFilteredProjects[index]
                                        ['projectName'];
                                    totalAmt = listOfFilteredProjects[index]
                                            ['projectCost']
                                        .toDouble();
                                    totalPaid = listOfFilteredProjects[index]
                                            ['totalPaid']
                                        .toDouble();
                                    balanceDue = listOfFilteredProjects[index]
                                                ['projectCost']
                                            .toDouble() -
                                        listOfFilteredProjects[index]
                                                ['totalPaid']
                                            .toDouble();

                                    count =
                                        listOfFilteredProjects[index]['index'];
                                  }

                                  return index == listOfFilteredProjects.length
                                      ? DataRow(
                                          color: MaterialStateProperty.all(
                                              Colors.transparent),
                                          cells: [
                                            DataCell(SelectableText(
                                              '',
                                              style: FlutterFlowTheme.bodyText2
                                                  .override(
                                                fontFamily: 'Lexend Deca',
                                                color: Colors.black,
                                                fontSize: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.008,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            )),
                                            DataCell(
                                              SelectableText(
                                                '',
                                                style: FlutterFlowTheme
                                                    .bodyText2
                                                    .override(
                                                  fontFamily: 'Lexend Deca',
                                                  color: Colors.black,
                                                  fontSize:
                                                      MediaQuery.of(context)
                                                              .size
                                                              .width *
                                                          0.008,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ),
                                            DataCell(SelectableText(
                                              '',
                                              style: FlutterFlowTheme.bodyText2
                                                  .override(
                                                fontFamily: 'Lexend Deca',
                                                color: Colors.black,
                                                fontSize: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.008,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            )),
                                            DataCell(SelectableText(
                                              '',
                                              style: FlutterFlowTheme.bodyText2
                                                  .override(
                                                fontFamily: 'Lexend Deca',
                                                color: status == 'Completed'
                                                    ? Colors.teal
                                                    : status == 'Suspended'
                                                        ? Colors.red
                                                        : Color(0xff0054FF),
                                                fontSize: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.008,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            )),
                                            DataCell(SelectableText(
                                              '',
                                              style: FlutterFlowTheme.bodyText2
                                                  .override(
                                                fontFamily: 'Lexend Deca',
                                                color: totalAmt == 0
                                                    ? Colors.red
                                                    : Colors.black,
                                                fontSize: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.008,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            )),
                                            DataCell(SelectableText(
                                              '',
                                              style: FlutterFlowTheme.bodyText2
                                                  .override(
                                                fontFamily: 'Lexend Deca',
                                                color: Colors.black,
                                                fontSize: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.008,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            )),
                                            DataCell(SelectableText('',
                                                style: FlutterFlowTheme
                                                    .bodyText2
                                                    .override(
                                                  fontFamily: 'Lexend Deca',
                                                  color: Colors.black,
                                                  fontSize:
                                                      MediaQuery.of(context)
                                                              .size
                                                              .width *
                                                          0.008,
                                                  fontWeight: FontWeight.bold,
                                                ))),
                                            DataCell(SelectableText('',
                                                style: FlutterFlowTheme
                                                    .bodyText2
                                                    .override(
                                                  fontFamily: 'Lexend Deca',
                                                  color: Colors.black,
                                                  fontSize:
                                                      MediaQuery.of(context)
                                                              .size
                                                              .width *
                                                          0.008,
                                                  fontWeight: FontWeight.bold,
                                                ))),
                                          ],
                                        )
                                      : index ==
                                              listOfFilteredProjects.length + 1
                                          ? DataRow(
                                              color: MaterialStateProperty.all(
                                                  Colors.transparent),
                                              cells: [
                                                DataCell(
                                                  SelectableText(
                                                    '',
                                                    style: FlutterFlowTheme
                                                        .bodyText2
                                                        .override(
                                                      fontFamily: 'Lexend Deca',
                                                      color: Colors.black,
                                                      fontSize:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width *
                                                              0.008,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                ),
                                                DataCell(
                                                  SelectableText(
                                                    '',
                                                    style: FlutterFlowTheme
                                                        .bodyText2
                                                        .override(
                                                      fontFamily: 'Lexend Deca',
                                                      color: Colors.black,
                                                      fontSize:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width *
                                                              0.008,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                ),
                                                DataCell(
                                                  firstIndex > 0
                                                      ? FFButtonWidget(
                                                          onPressed: () {
                                                            setState(() {
                                                              if (search.text ==
                                                                  '') {
                                                                lastIndex =
                                                                    firstIndex -
                                                                        1;
                                                                prev();
                                                              } else {
                                                                lastIndex =
                                                                    firstIndex -
                                                                        1;
                                                                getPrevSearchProjects(
                                                                    search
                                                                        .text);
                                                              }
                                                            });
                                                          },
                                                          text: 'Prev',
                                                          options:
                                                              FFButtonOptions(
                                                            width: 80,
                                                            height: 30,
                                                            color: Color(
                                                                0xff0054FF),
                                                            textStyle: FlutterFlowTheme
                                                                .subtitle2
                                                                .override(
                                                                    fontFamily:
                                                                        'Poppins',
                                                                    color: Colors
                                                                        .white,
                                                                    fontSize:
                                                                        12,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold),
                                                            borderSide:
                                                                BorderSide(
                                                              color: Colors
                                                                  .transparent,
                                                              width: 1,
                                                            ),
                                                            borderRadius: 8,
                                                          ),
                                                        )
                                                      : SizedBox(),
                                                ),
                                                DataCell(
                                                  SelectableText(
                                                    '',
                                                    style: FlutterFlowTheme
                                                        .bodyText2
                                                        .override(
                                                      fontFamily: 'Lexend Deca',
                                                      color: status ==
                                                              'Completed'
                                                          ? Colors.teal
                                                          : status ==
                                                                  'Suspended'
                                                              ? Colors.red
                                                              : Color(
                                                                  0xff0054FF),
                                                      fontSize:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width *
                                                              0.008,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                ),
                                                DataCell(
                                                  lastIndex + 1 <
                                                          listOfProjects.length
                                                      ? FFButtonWidget(
                                                          onPressed: () {
                                                            setState(() {
                                                              if (search.text ==
                                                                  '') {
                                                                firstIndex =
                                                                    lastIndex +
                                                                        1;
                                                                next();
                                                              } else {
                                                                firstIndex =
                                                                    lastIndex +
                                                                        1;
                                                                getNextSearchProjects(
                                                                    search
                                                                        .text);
                                                              }
                                                            });
                                                          },
                                                          text: 'Next',
                                                          options:
                                                              FFButtonOptions(
                                                            width: 80,
                                                            height: 30,
                                                            color: Color(
                                                                0xff0054FF),
                                                            textStyle: FlutterFlowTheme
                                                                .subtitle2
                                                                .override(
                                                                    fontFamily:
                                                                        'Poppins',
                                                                    color: Colors
                                                                        .white,
                                                                    fontSize:
                                                                        12,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold),
                                                            borderSide:
                                                                BorderSide(
                                                              color: Colors
                                                                  .transparent,
                                                              width: 1,
                                                            ),
                                                            borderRadius: 8,
                                                          ),
                                                        )
                                                      : SizedBox(),
                                                ),
                                                DataCell(
                                                  SelectableText(
                                                    '',
                                                    style: FlutterFlowTheme
                                                        .bodyText2
                                                        .override(
                                                      fontFamily: 'Lexend Deca',
                                                      color: Colors.black,
                                                      fontSize:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width *
                                                              0.008,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                ),
                                                DataCell(
                                                  SelectableText('',
                                                      style: FlutterFlowTheme
                                                          .bodyText2
                                                          .override(
                                                        fontFamily:
                                                            'Lexend Deca',
                                                        color: balanceDue > 0
                                                            ? Colors.red
                                                            : balanceDue == 0 &&
                                                                    totalAmt !=
                                                                        0
                                                                ? Colors.teal
                                                                : Colors.black,
                                                        fontSize: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .width *
                                                            0.008,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      )),
                                                ),
                                                DataCell(
                                                  SelectableText('',
                                                      style: FlutterFlowTheme
                                                          .bodyText2
                                                          .override(
                                                        fontFamily:
                                                            'Lexend Deca',
                                                        color: balanceDue > 0
                                                            ? Colors.red
                                                            : balanceDue == 0 &&
                                                                    totalAmt !=
                                                                        0
                                                                ? Colors.teal
                                                                : Colors.black,
                                                        fontSize: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .width *
                                                            0.008,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      )),
                                                ),
                                              ],
                                            )
                                          : index ==
                                                  listOfFilteredProjects
                                                          .length +
                                                      2
                                              ? DataRow(
                                                  color:
                                                      MaterialStateProperty.all(
                                                          Colors.transparent),
                                                  cells: [
                                                    DataCell(SelectableText(
                                                      '',
                                                      style: FlutterFlowTheme
                                                          .bodyText2
                                                          .override(
                                                        fontFamily:
                                                            'Lexend Deca',
                                                        color: Colors.black,
                                                        fontSize: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .width *
                                                            0.008,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                    )),
                                                    DataCell(
                                                      SelectableText(
                                                        '',
                                                        style: FlutterFlowTheme
                                                            .bodyText2
                                                            .override(
                                                          fontFamily:
                                                              'Lexend Deca',
                                                          color: Colors.black,
                                                          fontSize: MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .width *
                                                              0.008,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                        ),
                                                      ),
                                                    ),
                                                    DataCell(SelectableText(
                                                      '',
                                                      style: FlutterFlowTheme
                                                          .bodyText2
                                                          .override(
                                                        fontFamily:
                                                            'Lexend Deca',
                                                        color: Colors.black,
                                                        fontSize: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .width *
                                                            0.008,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                    )),
                                                    DataCell(SelectableText(
                                                      '',
                                                      style: FlutterFlowTheme
                                                          .bodyText2
                                                          .override(
                                                        fontFamily:
                                                            'Lexend Deca',
                                                        color: status ==
                                                                'Completed'
                                                            ? Colors.teal
                                                            : status ==
                                                                    'Suspended'
                                                                ? Colors.red
                                                                : Color(
                                                                    0xff0054FF),
                                                        fontSize: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .width *
                                                            0.008,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                    )),
                                                    DataCell(SelectableText(
                                                      '',
                                                      style: FlutterFlowTheme
                                                          .bodyText2
                                                          .override(
                                                        fontFamily:
                                                            'Lexend Deca',
                                                        color: totalAmt == 0
                                                            ? Colors.red
                                                            : Colors.black,
                                                        fontSize: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .width *
                                                            0.008,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                    )),
                                                    DataCell(SelectableText(
                                                      '',
                                                      style: FlutterFlowTheme
                                                          .bodyText2
                                                          .override(
                                                        fontFamily:
                                                            'Lexend Deca',
                                                        color: Colors.black,
                                                        fontSize: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .width *
                                                            0.008,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                    )),
                                                    DataCell(SelectableText('',
                                                        style: FlutterFlowTheme
                                                            .bodyText2
                                                            .override(
                                                          fontFamily:
                                                              'Lexend Deca',
                                                          color: balanceDue > 0
                                                              ? Colors.red
                                                              : balanceDue ==
                                                                          0 &&
                                                                      totalAmt !=
                                                                          0
                                                                  ? Colors.teal
                                                                  : Colors
                                                                      .black,
                                                          fontSize: MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .width *
                                                              0.008,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                        ))),
                                                    DataCell(SelectableText('',
                                                        style: FlutterFlowTheme
                                                            .bodyText2
                                                            .override(
                                                          fontFamily:
                                                              'Lexend Deca',
                                                          color: balanceDue > 0
                                                              ? Colors.red
                                                              : balanceDue ==
                                                                          0 &&
                                                                      totalAmt !=
                                                                          0
                                                                  ? Colors.teal
                                                                  : Colors
                                                                      .black,
                                                          fontSize: MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .width *
                                                              0.008,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                        ))),
                                                  ],
                                                )
                                              : index ==
                                                      listOfFilteredProjects
                                                              .length +
                                                          3
                                                  ? DataRow(
                                                      color:
                                                          MaterialStateProperty
                                                              .all(Colors
                                                                  .transparent),
                                                      cells: [
                                                        DataCell(
                                                          SelectableText(
                                                            '',
                                                            style:
                                                                FlutterFlowTheme
                                                                    .bodyText2
                                                                    .override(
                                                              fontFamily:
                                                                  'Lexend Deca',
                                                              color:
                                                                  Colors.black,
                                                              fontSize: MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .width *
                                                                  0.008,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                            ),
                                                          ),
                                                        ),
                                                        DataCell(
                                                          SelectableText(
                                                            '',
                                                            style:
                                                                FlutterFlowTheme
                                                                    .bodyText2
                                                                    .override(
                                                              fontFamily:
                                                                  'Lexend Deca',
                                                              color:
                                                                  Colors.black,
                                                              fontSize: MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .width *
                                                                  0.008,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                            ),
                                                          ),
                                                        ),
                                                        DataCell(
                                                          SelectableText(
                                                            '',
                                                            style:
                                                                FlutterFlowTheme
                                                                    .bodyText2
                                                                    .override(
                                                              fontFamily:
                                                                  'Lexend Deca',
                                                              color:
                                                                  Colors.black,
                                                              fontSize: MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .width *
                                                                  0.008,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                            ),
                                                          ),
                                                        ),
                                                        DataCell(
                                                          SelectableText(
                                                            '',
                                                            style:
                                                                FlutterFlowTheme
                                                                    .bodyText2
                                                                    .override(
                                                              fontFamily:
                                                                  'Lexend Deca',
                                                              color: status ==
                                                                      'Completed'
                                                                  ? Colors.teal
                                                                  : status ==
                                                                          'Suspended'
                                                                      ? Colors
                                                                          .red
                                                                      : Color(
                                                                          0xff0054FF),
                                                              fontSize: MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .width *
                                                                  0.008,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                            ),
                                                          ),
                                                        ),
                                                        DataCell(
                                                          SelectableText(
                                                            _formatNumber(
                                                                totalProjectCost
                                                                    .round()
                                                                    .toString()
                                                                    // .split('.')[0]
                                                                    .replaceAll(
                                                                        ',', '')
                                                                    .replaceAll(
                                                                        '.',
                                                                        '')),
                                                            style:
                                                                FlutterFlowTheme
                                                                    .bodyText2
                                                                    .override(
                                                              fontFamily:
                                                                  'Lexend Deca',
                                                              color:
                                                                  Colors.black,
                                                              fontSize: MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .width *
                                                                  0.008,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                            ),
                                                          ),
                                                        ),
                                                        DataCell(
                                                          SelectableText(
                                                            _formatNumber(
                                                                totalProjectPaid
                                                                    .round()
                                                                    .toString()
                                                                    .replaceAll(
                                                                        ',', '')
                                                                    .replaceAll(
                                                                        '.',
                                                                        '')),
                                                            style:
                                                                FlutterFlowTheme
                                                                    .bodyText2
                                                                    .override(
                                                              fontFamily:
                                                                  'Lexend Deca',
                                                              color:
                                                                  Colors.black,
                                                              fontSize: MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .width *
                                                                  0.008,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                            ),
                                                          ),
                                                        ),
                                                        DataCell(
                                                          SelectableText(
                                                              _formatNumber(
                                                                  totalProjectDue
                                                                      .round()
                                                                      .toString()
                                                                      .replaceAll(
                                                                          ',',
                                                                          '')
                                                                      .replaceAll(
                                                                          '.',
                                                                          '')),
                                                              style:
                                                                  FlutterFlowTheme
                                                                      .bodyText2
                                                                      .override(
                                                                fontFamily:
                                                                    'Lexend Deca',
                                                                color:
                                                                    totalProjectDue ==
                                                                            0
                                                                        ? Colors
                                                                            .teal
                                                                        : Colors
                                                                            .red,
                                                                fontSize: MediaQuery.of(
                                                                            context)
                                                                        .size
                                                                        .width *
                                                                    0.008,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                              )),
                                                        ),
                                                        DataCell(
                                                          SelectableText('',
                                                              style:
                                                                  FlutterFlowTheme
                                                                      .bodyText2
                                                                      .override(
                                                                fontFamily:
                                                                    'Lexend Deca',
                                                                color: balanceDue >
                                                                        0
                                                                    ? Colors.red
                                                                    : balanceDue ==
                                                                                0 &&
                                                                            totalAmt !=
                                                                                0
                                                                        ? Colors
                                                                            .teal
                                                                        : Colors
                                                                            .black,
                                                                fontSize: MediaQuery.of(
                                                                            context)
                                                                        .size
                                                                        .width *
                                                                    0.008,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                              )),
                                                        ),
                                                      ],
                                                    )
                                                  : DataRow(
                                                      color: index.isOdd
                                                          ? MaterialStateProperty
                                                              .all(Colors
                                                                  .blueGrey
                                                                  .shade50
                                                                  .withOpacity(
                                                                      0.7))
                                                          : MaterialStateProperty
                                                              .all(Colors
                                                                  .blueGrey
                                                                  .shade50),
                                                      cells: [
                                                        DataCell(SelectableText(
                                                          '${count + 1}',
                                                          style:
                                                              FlutterFlowTheme
                                                                  .bodyText2
                                                                  .override(
                                                            fontFamily:
                                                                'Lexend Deca',
                                                            color: Colors.black,
                                                            fontSize: MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .width *
                                                                0.008,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                          ),
                                                        )),
                                                        DataCell(
                                                          SelectableText(
                                                            customerName,
                                                            style:
                                                                FlutterFlowTheme
                                                                    .bodyText2
                                                                    .override(
                                                              fontFamily:
                                                                  'Lexend Deca',
                                                              color:
                                                                  Colors.black,
                                                              fontSize: MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .width *
                                                                  0.008,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                            ),
                                                          ),
                                                        ),
                                                        DataCell(SelectableText(
                                                          projectName,
                                                          style:
                                                              FlutterFlowTheme
                                                                  .bodyText2
                                                                  .override(
                                                            fontFamily:
                                                                'Lexend Deca',
                                                            color: Colors.black,
                                                            fontSize: MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .width *
                                                                0.008,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                          ),
                                                        )),
                                                        DataCell(SelectableText(
                                                          status,
                                                          style:
                                                              FlutterFlowTheme
                                                                  .bodyText2
                                                                  .override(
                                                            fontFamily:
                                                                'Lexend Deca',
                                                            color: status ==
                                                                    'Completed'
                                                                ? Colors.teal
                                                                : status ==
                                                                        'Suspended'
                                                                    ? Colors.red
                                                                    : Color(
                                                                        0xff0054FF),
                                                            fontSize: MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .width *
                                                                0.008,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                          ),
                                                        )),
                                                        DataCell(SelectableText(
                                                          _formatNumber(totalAmt
                                                              .truncate()
                                                              .toString()
                                                              // .split('.')[0]
                                                              .replaceAll(
                                                                  ',', '')
                                                              .replaceAll(
                                                                  '.', '')),
                                                          style:
                                                              FlutterFlowTheme
                                                                  .bodyText2
                                                                  .override(
                                                            fontFamily:
                                                                'Lexend Deca',
                                                            color: totalAmt == 0
                                                                ? Colors.red
                                                                : Colors.black,
                                                            fontSize: MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .width *
                                                                0.008,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                          ),
                                                        )),
                                                        DataCell(SelectableText(
                                                          _formatNumber(
                                                              totalPaid
                                                                  .truncate()
                                                                  .toString()
                                                                  // .split('.')[0]
                                                                  .replaceAll(
                                                                      ',', '')
                                                                  .replaceAll(
                                                                      '.', '')),
                                                          style:
                                                              FlutterFlowTheme
                                                                  .bodyText2
                                                                  .override(
                                                            fontFamily:
                                                                'Lexend Deca',
                                                            color: Colors.black,
                                                            fontSize: MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .width *
                                                                0.008,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                          ),
                                                        )),
                                                        DataCell(SelectableText(
                                                            _formatNumber(
                                                                balanceDue
                                                                    .truncate()
                                                                    .toString()
                                                                    // .split('.')[0]
                                                                    .replaceAll(
                                                                        ',', '')
                                                                    .replaceAll(
                                                                        '.',
                                                                        '')),
                                                            style:
                                                                FlutterFlowTheme
                                                                    .bodyText2
                                                                    .override(
                                                              fontFamily:
                                                                  'Lexend Deca',
                                                              color: balanceDue >
                                                                      0
                                                                  ? Colors.red
                                                                  : balanceDue ==
                                                                              0 &&
                                                                          totalAmt !=
                                                                              0
                                                                      ? Colors
                                                                          .teal
                                                                      : Colors
                                                                          .black,
                                                              fontSize: MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .width *
                                                                  0.008,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                            ))),
                                                        DataCell(
                                                          Row(
                                                            children: [
                                                              FFButtonWidget(
                                                                onPressed: () {
                                                                  Navigator.push(
                                                                      context,
                                                                      MaterialPageRoute(
                                                                          builder: (context) => CustomerSinglePage(
                                                                                id: listOfFilteredProjects[index]['customerID'],
                                                                                selectedIndex: 1,
                                                                                tab: true,
                                                                                project: listOfFilteredProjects[index],
                                                                              )));
                                                                },
                                                                text: 'View',
                                                                options:
                                                                    FFButtonOptions(
                                                                  width: 80,
                                                                  height: 30,
                                                                  color: Color(
                                                                      0xff0054FF),
                                                                  textStyle: FlutterFlowTheme.subtitle2.override(
                                                                      fontFamily:
                                                                          'Poppins',
                                                                      color: Colors
                                                                          .white,
                                                                      fontSize:
                                                                          12,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold),
                                                                  borderSide:
                                                                      BorderSide(
                                                                    color: Colors
                                                                        .transparent,
                                                                    width: 1,
                                                                  ),
                                                                  borderRadius:
                                                                      8,
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ],
                                                    );
                                },
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
              SizedBox(
                height: 50,
              ),
              // Padding(
              //   padding: const EdgeInsets.only(bottom: 20, left: 15, right: 15),
              //   child: Row(
              //     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              //     children: [
              //       firstIndex > 0
              //           ? FFButtonWidget(
              //               onPressed: () {
              //                 setState(() {
              //                   if (search.text == '') {
              //                     lastIndex = firstIndex - 1;
              //                     prev();
              //                   } else {
              //                     lastIndex = firstIndex - 1;
              //                     getPrevSearchProjects(search.text);
              //                   }
              //                 });
              //               },
              //               text: 'Prev',
              //               options: FFButtonOptions(
              //                 width: 80,
              //                 height: 30,
              //                 color: Color(0xff0054FF),
              //                 textStyle: FlutterFlowTheme.subtitle2.override(
              //                     fontFamily: 'Poppins',
              //                     color: Colors.white,
              //                     fontSize: 12,
              //                     fontWeight: FontWeight.bold),
              //                 borderSide: BorderSide(
              //                   color: Colors.transparent,
              //                   width: 1,
              //                 ),
              //                 borderRadius: 8,
              //               ),
              //             )
              //           : SizedBox(),
              //       // SizedBox(width:50,),
              //       lastIndex + 1 < listOfProjects.length
              //           ? FFButtonWidget(
              //               onPressed: () {
              //                 setState(() {
              //                   if (search.text == '') {
              //                     firstIndex = lastIndex + 1;
              //                     next();
              //                   } else {
              //                     firstIndex = lastIndex + 1;
              //                     getNextSearchProjects(search.text);
              //                   }
              //                 });
              //               },
              //               text: 'Next',
              //               options: FFButtonOptions(
              //                 width: 80,
              //                 height: 30,
              //                 color: Color(0xff0054FF),
              //                 textStyle: FlutterFlowTheme.subtitle2.override(
              //                     fontFamily: 'Poppins',
              //                     color: Colors.white,
              //                     fontSize: 12,
              //                     fontWeight: FontWeight.bold),
              //                 borderSide: BorderSide(
              //                   color: Colors.transparent,
              //                   width: 1,
              //                 ),
              //                 borderRadius: 8,
              //               ),
              //             )
              //           : SizedBox(),
              //     ],
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
