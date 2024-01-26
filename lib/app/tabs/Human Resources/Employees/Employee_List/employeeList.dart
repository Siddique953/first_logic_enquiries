import 'dart:convert';
import 'dart:io';

import 'package:excel/excel.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:universal_html/html.dart' as html;

import '../../../../../flutter_flow/flutter_flow_theme.dart';
import '../../../../../flutter_flow/flutter_flow_widgets.dart';
import '../../../../pages/home_page/home.dart';

String employeeId = '';

class EmployeeList extends StatefulWidget {
  final TabController _tabController;
  const EmployeeList({
    Key? key,
    required TabController tabController,
  })  : _tabController = tabController,
        super(key: key);

  @override
  State<EmployeeList> createState() => _EmployeeListState();
}

class _EmployeeListState extends State<EmployeeList> {
  List listOfCustomers = [];

  // getCustomers() {
  //   FirebaseFirestore.instance
  //       .collection('customer')
  //       .where('status', isEqualTo: 0)
  //       .where('branchId', isEqualTo: currentBranchId)
  //       .orderBy('date', descending: true)
  //       .snapshots()
  //       .listen((event) {
  //     listOfCostomers = [];
  //     for (DocumentSnapshot customer in event.docs) {
  //       listOfCostomers.add(customer.data());
  //       // listOfFilteredCustomers.add(customer.data());
  //     }
  //     // setState(() {
  //     //   getFirst20();
  //     // });
  //
  //     if (mounted) {
  //       setState(() {
  //         getFirst20();
  //       });
  //     }
  //   });
  // }

  late TextEditingController search;
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  int firstIndex = 0;
  int lastIndex = 0;

  // listOfCustomers
  List listOfFilteredCustomers = [];

//GET FIRST 20 DATA
  getFirst20() {
    listOfFilteredCustomers = [];
    for (int i = 0; i < listOfCustomers.length; i++) {
      firstIndex = 0;
      if (listOfFilteredCustomers.length < 20) {
        Map<String, dynamic> data = {};
        data = listOfCustomers[i];
        data['index'] = i;
        listOfFilteredCustomers.add(data);
      } else if (listOfFilteredCustomers.length == 20) {
        lastIndex = i - 1;
        break;
      }
      lastIndex = i;
    }




    setState(() {});
  }

  //GET NEXT 20 DATA
  next() {
    listOfFilteredCustomers = [];
    for (int i = firstIndex; i < listOfCustomers.length; i++) {
      if (listOfFilteredCustomers.length < 20) {
        Map<String, dynamic> data = {};
        data = listOfCustomers[i];
        data['index'] = i;
        listOfFilteredCustomers.add(data);
      } else if (listOfFilteredCustomers.length == 20) {
        lastIndex = i - 1;
        break;
      }
      lastIndex = i;
    }


    setState(() {});
  }

  //GET PREVIOUS 20 DATA
  prev() {
    listOfFilteredCustomers = [];
    List prev = [];
    for (int i = lastIndex; i >= 0; i--) {
      if (prev.length < 20) {
        Map<String, dynamic> data = {};
        data = listOfCustomers[i];
        data['index'] = i;
        prev.add(data);
      } else if (prev.length == 20) {
        firstIndex = i + 1;
        break;
      }
      firstIndex = i;
    }

    listOfFilteredCustomers = prev.reversed.toList();


    // listOfFilteredProjects.reversed;

    setState(() {});
  }

  //GET FIRST 20 SEARCHED DATA
  getSearchedProjects(String txt) {
    listOfFilteredCustomers = [];
    for (int i = 0; i < listOfCustomers.length; i++) {
      if (listOfCustomers[i]['name'].toString().toLowerCase().contains(txt) ||
          listOfCustomers[i]['mobile'].toString().toLowerCase().contains(txt) ||
          listOfCustomers[i]['email'].toString().toLowerCase().contains(txt)) {
        if (listOfFilteredCustomers.length < 20) {
          Map<String, dynamic> data = {};
          data = listOfCustomers[i];
          data['index'] = i;
          listOfFilteredCustomers.add(data);
        } else if (listOfFilteredCustomers.length == 20) {
          lastIndex = i - 1;
          break;
        }
        lastIndex = i;

        // listOfFilteredProjects.add(listOfActiveProjects[i]);
      }
    }

    setState(() {});
  }

  //GET NEXT 20 SEARCHED DATA
  getNextSearchProjects(String txt) {
    listOfFilteredCustomers = [];
    for (int i = firstIndex; i < listOfCustomers.length; i++) {
      if (listOfCustomers[i]['name'].toString().toLowerCase().contains(txt) ||
          listOfCustomers[i]['mobile'].toString().toLowerCase().contains(txt) ||
          listOfCustomers[i]['email'].toString().toLowerCase().contains(txt)) {
        if (listOfFilteredCustomers.length < 20) {
          Map<String, dynamic> data = {};
          data = listOfCustomers[i];
          data['index'] = i;
          listOfFilteredCustomers.add(data);
        } else if (listOfFilteredCustomers.length == 20) {
          lastIndex = i - 1;
          break;
        }
        lastIndex = i;

        // listOfFilteredProjects.add(listOfActiveProjects[i]);
      }
    }
    setState(() {});
  }

  //GET PREVIOUS 20 SEARCHED DATA
  getPrevSearchProjects(String txt) {
    listOfFilteredCustomers = [];
    List prev = [];
    for (int i = lastIndex; i >= 0; i--) {
      if (listOfCustomers[i]['name'].toString().toLowerCase().contains(txt) ||
          listOfCustomers[i]['mobile'].toString().toLowerCase().contains(txt) ||
          listOfCustomers[i]['email'].toString().toLowerCase().contains(txt)) {
        if (prev.length < 20) {
          Map<String, dynamic> data = {};
          data = listOfCustomers[i];
          data['index'] = i;
          prev.add(data);
          // prev.add(listOfCustomers[i]);
        } else if (prev.length == 20) {
          firstIndex = i + 1;
          break;
        }
        firstIndex = i;
      }
    }
    listOfFilteredCustomers = prev.reversed.toList();


    // listOfFilteredProjects.reversed;

    setState(() {});
  }

  @override
  void initState() {
    super.initState();


    listOfCustomers= employeeList.where((element) => element['delete']==false).toList();
        // .addAll(employeeList);

    listOfFilteredCustomers = [];
    // getCustomers();
    search = TextEditingController();

    getFirst20();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    search.text = '';
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
                    IconButton(
                      icon: Icon(
                        Icons.arrow_back_ios_new,
                        size: 20,
                        color: Colors.black,
                      ),
                      onPressed: () {
                        // setState(() {
                        widget._tabController.animateTo(5);
                        // });
                      },
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: Text(
                        'Employee Lists',
                        style: FlutterFlowTheme.bodyText1.override(
                            fontFamily: 'Poppins',
                            fontSize: 25,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(0, 0, 8, 0),
                      child: FFButtonWidget(
                        onPressed: () {
                          setState(() {
                            widget._tabController.animateTo(7);
                          });
                        },
                        text: '+ ADD',
                        options: FFButtonOptions(
                          width: 100,
                          height: 45,
                          color: Color(0xff0054FF),
                          textStyle: FlutterFlowTheme.subtitle2.override(
                            fontFamily: 'Poppins',
                            color: Colors.white,
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
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
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(20, 0, 30, 0),
                    child: InkWell(
                      onTap: (){

                        // sortList();
                        importData();
                        /// EXCEL DOWNLOAD
                      },
                      child: Container(
                        width: 100,
                        height: 30,
                        decoration: BoxDecoration(
                            color: Colors.blueGrey,
                            borderRadius: BorderRadius.all(Radius.circular(20))
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Icon(Icons.download,color: Colors.white,),
                            Text('Excel',
                              style: FlutterFlowTheme.subtitle2.override(
                                fontFamily: 'Poppins',
                                color: Colors.white,
                                fontSize: 13,
                                fontWeight: FontWeight.bold,
                              ),),

                          ],
                        ),
                      ),
                    ),
                  ),
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
                                      listOfFilteredCustomers.clear();
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
                                    hintText:
                                        'Please Enter Number, Phone or E-Mail',
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
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(20, 0, 30, 0),
                    child: InkWell(
                      onTap: (){

                        widget._tabController.animateTo(33);
                        // Navigator.push(context, MaterialPageRoute(builder: (context)=>DeletedEmployees(
                        //   tabController: widget._tabController,
                        // )));
                      },
                      child: Container(
                        width: 150,
                        height: 45,
                        decoration: BoxDecoration(
                          color: Colors.red,
                            borderRadius: BorderRadius.all(Radius.circular(20))
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Icon(Icons.delete,color: Colors.white,),
                            Text('Deleted Staffs',
                              style: FlutterFlowTheme.subtitle2.override(
                              fontFamily: 'Poppins',
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),),

                          ],
                        ),
                      ),
                    ),
                  ),
                  // Padding(
                  //   padding: EdgeInsetsDirectional.fromSTEB(20, 0, 30, 0),
                  //   child: FFButtonWidget(
                  //     onPressed: () {
                  //       setState(() {
                  //         widget._tabController.animateTo(7);
                  //       });
                  //     },
                  //     text: 'Deleted Staffs',
                  //     options: FFButtonOptions(
                  //       width: 150,
                  //       height: 45,
                  //       color: Colors.red,
                  //       textStyle: FlutterFlowTheme.subtitle2.override(
                  //         fontFamily: 'Poppins',
                  //         color: Colors.white,
                  //         fontSize: 12,
                  //         fontWeight: FontWeight.bold,
                  //       ),
                  //       elevation: 2,
                  //       borderSide: BorderSide(
                  //         color: Colors.transparent,
                  //         width: 1,
                  //       ),
                  //       borderRadius: 50,
                  //     ),
                  //   ),
                  // ),
                ],
              ),
              listOfFilteredCustomers.length == 0
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
                                  label: Text("Sl.No",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.008)),
                                ),
                                DataColumn(
                                  label: Text("Emp ID",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.008)),
                                ),
                                DataColumn(
                                  label: Text("Emp Name",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.008)),
                                ),
                                DataColumn(
                                  label: Text("Department",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.008)),
                                ),
                                DataColumn(
                                  label: Text("Designation",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.008)),
                                ),
                                DataColumn(
                                  label: Text("Manager",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.008)),
                                ),
                                DataColumn(
                                  label: Text("Email",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.008)),
                                ),
                                // DataColumn(
                                //   label: Text("Place",
                                //       style: TextStyle(
                                //           fontWeight: FontWeight.bold,
                                //           fontSize: 11)),
                                // ),
                                DataColumn(
                                  label: Flexible(
                                    child: Text("Phone",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.008)),
                                  ),
                                ),
                                DataColumn(
                                  label: Text("Action",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.008)),
                                ),
                              ],
                              rows: List.generate(
                                listOfFilteredCustomers.length,
                                (index) {
                                  // getCount(data[index].id);

                                  String empId =
                                      listOfFilteredCustomers[index]['empId'];

                                  String name =
                                      listOfFilteredCustomers[index]['name'];

                                  String dept =
                                      listOfFilteredCustomers[index]['dept'];

                                  String designation =
                                      listOfFilteredCustomers[index]
                                          ['designation'];

                                  String manager = empDataById[
                                              listOfFilteredCustomers[index]
                                                      ['reportingManager'] ??
                                                  ''] ==
                                          null
                                      ? ''
                                      : empDataById[
                                              listOfFilteredCustomers[index]
                                                      ['reportingManager'] ??
                                                  '']!
                                          .name??'';

                                  String email =
                                      listOfFilteredCustomers[index]['email'];
                                  String mobile =
                                      listOfFilteredCustomers[index]['phone'];

                                  int count =
                                      listOfFilteredCustomers[index]['index'];

                                  return DataRow(
                                    color: index.isOdd
                                        ? MaterialStateProperty.all(Colors
                                            .blueGrey.shade50
                                            .withOpacity(0.7))
                                        : MaterialStateProperty.all(
                                            Colors.blueGrey.shade50),
                                    cells: [
                                      DataCell(
                                        SelectableText(
                                          '${count + 1}',
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
                                        ),
                                      ),
                                      DataCell(
                                        SelectableText(
                                          empId,
                                          style: FlutterFlowTheme.bodyText2
                                              .override(
                                            fontFamily: 'Lexend Deca',
                                            color: Colors.black,
                                            fontSize: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.007,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                      DataCell(
                                        SelectableText(
                                          name,
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
                                        ),
                                      ),
                                      DataCell(
                                        SelectableText(
                                          dept,
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
                                        ),
                                      ),
                                      DataCell(
                                        SelectableText(
                                          designation ?? '',
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
                                        ),
                                      ),
                                      DataCell(
                                        SelectableText(
                                          manager ?? '',
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
                                        ),
                                      ),
                                      DataCell(
                                        SelectableText(
                                          email,
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
                                        ),
                                      ),
                                      DataCell(
                                        SelectableText(
                                          mobile,
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
                                        ),
                                      ),

                                      DataCell(
                                        Row(
                                          children: [
                                            FFButtonWidget(
                                              onPressed: () {
                                                employeeId = empId;

                                                widget._tabController
                                                    .animateTo(8);
                                                // Navigator.push(
                                                //     context,
                                                //     MaterialPageRoute(
                                                //         builder: (context) =>
                                                //             CustomerSinglePage(
                                                //               id: listOfFilteredCustomers[index]
                                                //               ['customerID'],
                                                //               selectedIndex: 0,
                                                //               tab: false,
                                                //               project: {},
                                                //             )));
                                              },
                                              text: 'View',
                                              options: FFButtonOptions(
                                                width: 80,
                                                height: 30,
                                                color: Color(0xff0054FF),
                                                textStyle: FlutterFlowTheme
                                                    .subtitle2
                                                    .override(
                                                        fontFamily: 'Poppins',
                                                        color: Colors.white,
                                                        fontSize: 12,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                borderSide: BorderSide(
                                                  color: Colors.transparent,
                                                  width: 1,
                                                ),
                                                borderRadius: 8,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      // DataCell(Text(fileInfo.size)),
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
              Padding(
                padding: const EdgeInsets.only(bottom: 20, left: 15, right: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    firstIndex > 0
                        ? FFButtonWidget(
                            onPressed: () {
                              setState(() {
                                if (search.text == '') {
                                  lastIndex = firstIndex - 1;
                                  prev();
                                } else {
                                  lastIndex = firstIndex - 1;
                                  getPrevSearchProjects(search.text);
                                }
                              });
                            },
                            text: 'Prev',
                            options: FFButtonOptions(
                              width: 80,
                              height: 30,
                              color: Color(0xff0054FF),
                              textStyle: FlutterFlowTheme.subtitle2.override(
                                  fontFamily: 'Poppins',
                                  color: Colors.white,
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold),
                              borderSide: BorderSide(
                                color: Colors.transparent,
                                width: 1,
                              ),
                              borderRadius: 8,
                            ),
                          )
                        : SizedBox(),
                    // SizedBox(width:50,),
                    (lastIndex + 1 < listOfCustomers.length && listOfFilteredCustomers.length==20)
                        ? FFButtonWidget(
                            onPressed: () {
                              setState(() {
                                if (search.text == '') {
                                  firstIndex = lastIndex + 1;
                                  next();
                                } else {
                                  firstIndex = lastIndex + 1;
                                  getNextSearchProjects(search.text);
                                }
                              });
                            },
                            text: 'Next',
                            options: FFButtonOptions(
                              width: 80,
                              height: 30,
                              color: Color(0xff0054FF),
                              textStyle: FlutterFlowTheme.subtitle2.override(
                                  fontFamily: 'Poppins',
                                  color: Colors.white,
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold),
                              borderSide: BorderSide(
                                color: Colors.transparent,
                                width: 1,
                              ),
                              borderRadius: 8,
                            ),
                          )
                        : SizedBox(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// ORIGINAL

  Future<void> importData() async {
    var excel = Excel.createExcel();



    Sheet sheetObject = excel['Employee'];
    CellStyle cellStyle = CellStyle(
        verticalAlign: VerticalAlign.Center,
        horizontalAlign: HorizontalAlign.Center,

        // backgroundColorHex: "#1AFF1A",
        fontFamily: getFontFamily(FontFamily.Calibri));
    CellStyle totalStyle = CellStyle(
        fontFamily: getFontFamily(FontFamily.Calibri),
        fontSize: 16,
        bold: true);

    //HEADINGS

    if (listOfCustomers.length > 0) {
      var cell1 = sheetObject.cell(CellIndex.indexByString("A2"));
      cell1.value = 'SL NO';
      cell1.cellStyle = cellStyle;

      var cell2 = sheetObject.cell(CellIndex.indexByString("B2"));
      cell2.value = 'Emp ID'; // dynamic values support provided;
      cell2.cellStyle = cellStyle;

      var cell3 = sheetObject.cell(CellIndex.indexByString("C2"));
      cell3.value = 'Name'; // dynamic values support provided;
      cell3.cellStyle = cellStyle;

      var cell4 = sheetObject.cell(CellIndex.indexByString("D2"));
      cell4.value = 'E-Mail'; // dynamic values support provided;
      cell4.cellStyle = cellStyle;

      var cell5 = sheetObject.cell(CellIndex.indexByString("E2"));
      cell5.value = 'Phone Number'; // dynamic values support provided;
      cell5.cellStyle = cellStyle;

      var cell6 = sheetObject.cell(CellIndex.indexByString("F2"));
      cell6.value = 'DoB'; // dynamic values support provided;
      cell6.cellStyle = cellStyle;

      ///
      var cell7 = sheetObject.cell(CellIndex.indexByString("G2"));
      cell7.value = 'Gender'; // dynamic values support provided;
      cell7.cellStyle = cellStyle;

      var cell8 = sheetObject.cell(CellIndex.indexByString("H2"));
      cell8.value = 'PAN Number'; // dynamic values support provided;
      cell8.cellStyle = cellStyle;

      var cell9 = sheetObject.cell(CellIndex.indexByString("I2"));
      cell9.value = 'Department'; // dynamic values support provided;
      cell9.cellStyle = cellStyle;

      var cell10 = sheetObject.cell(CellIndex.indexByString("J2"));
      cell10.value = 'Sub Department'; // dynamic values support provided;
      cell10.cellStyle = cellStyle;

      var cell11 = sheetObject.cell(CellIndex.indexByString("K2"));
      cell11.value = 'Designation'; // dynamic values support provided;
      cell11.cellStyle = cellStyle;

      var cell12 = sheetObject.cell(CellIndex.indexByString("L2"));
      cell12.value = 'Reporting Manager'; // dynamic values support provided;
      cell12.cellStyle = cellStyle;
      var cell13 = sheetObject.cell(CellIndex.indexByString("M2"));
      cell13.value = 'Team Leader'; // dynamic values support provided;
      cell13.cellStyle = cellStyle;
      var cell14 = sheetObject.cell(CellIndex.indexByString("N2"));
      cell14.value = 'Work Type'; // dynamic values support provided;
      cell14.cellStyle = cellStyle;
      var cell15 = sheetObject.cell(CellIndex.indexByString("O2"));
      cell15.value = 'Probation Period'; // dynamic values support provided;
      cell15.cellStyle = cellStyle;
      var cell16 = sheetObject.cell(CellIndex.indexByString("P2"));
      cell16.value = 'Date of Joining'; // dynamic values support provided;
      cell16.cellStyle = cellStyle;
      var cell17 = sheetObject.cell(CellIndex.indexByString("Q2"));
      cell17.value = 'CTC'; // dynamic values support provided;
      cell17.cellStyle = cellStyle;
      var cell18 = sheetObject.cell(CellIndex.indexByString("R2"));
      cell18.value = 'Account Holder Name'; // dynamic values support provided;
      cell18.cellStyle = cellStyle;
      var cell19 = sheetObject.cell(CellIndex.indexByString("S2"));
      cell19.value = 'Bank Name'; // dynamic values support provided;
      cell19.cellStyle = cellStyle;
      var cell20 = sheetObject.cell(CellIndex.indexByString("T2"));
      cell20.value = 'City'; // dynamic values support provided;
      cell20.cellStyle = cellStyle;
      var cell21 = sheetObject.cell(CellIndex.indexByString("U2"));
      cell21.value = 'IFSC'; // dynamic values support provided;
      cell21.cellStyle = cellStyle;
      var cell22 = sheetObject.cell(CellIndex.indexByString("V2"));
      cell22.value = 'Branch Name'; // dynamic values support provided;
      cell22.cellStyle = cellStyle;
      var cell23 = sheetObject.cell(CellIndex.indexByString("W2"));
      cell23.value = 'Account Number'; // dynamic values support provided;
      cell23.cellStyle = cellStyle;
    }

    //CELL VALUES

    for (int i = 0; i < listOfCustomers.length; i++) {

      String pan='';
      String teamLead='';
      String reportingMan='';
      try {
       pan= listOfCustomers[i]['pan'] ?? '';

       if(listOfCustomers[i]['reportingManager']!=''){
         reportingMan=empDataById[listOfCustomers[i]['reportingManager']]!.name??'';
       }
       if(listOfCustomers[i]['teamLead']!=''){
         teamLead=empDataById[listOfCustomers[i]['teamLead']]!.name??'';
       }


      } catch (e) {
        pan='';
      }

      var cell1 = sheetObject.cell(CellIndex.indexByString("A${i+4}"));
      cell1.value = i+1;
      cell1.cellStyle = cellStyle;

      var cell2 = sheetObject.cell(CellIndex.indexByString("B${i+4}"));
      cell2.value = listOfCustomers[i]['empId']; // dynamic values support provided;
      cell2.cellStyle = cellStyle;

      var cell3 = sheetObject.cell(CellIndex.indexByString("C${i+4}"));
      cell3.value = listOfCustomers[i]['name']; // dynamic values support provided;
      cell3.cellStyle = cellStyle;

      var cell4 = sheetObject.cell(CellIndex.indexByString("D${i+4}"));
      cell4.value = listOfCustomers[i]['email']; // dynamic values support provided;
      cell4.cellStyle = cellStyle;

      var cell5 = sheetObject.cell(CellIndex.indexByString("E${i+4}"));
      cell5.value = listOfCustomers[i]['phone']; // dynamic values support provided;
      cell5.cellStyle = cellStyle;

      var cell6 = sheetObject.cell(CellIndex.indexByString("F${i+4}"));
      cell6.value = DateFormat('dd - MMM - yyyy').format(listOfCustomers[i]['dob'].toDate()); // dynamic values support provided;
      cell6.cellStyle = cellStyle;

      ///
      var cell7 = sheetObject.cell(CellIndex.indexByString("G${i+4}"));
      cell7.value = listOfCustomers[i]['gender']; // dynamic values support provided;
      cell7.cellStyle = cellStyle;

      var cell8 = sheetObject.cell(CellIndex.indexByString("H${i+4}"));
      cell8.value = pan; // dynamic values support provided;
      cell8.cellStyle = cellStyle;

      var cell9 = sheetObject.cell(CellIndex.indexByString("I${i+4}"));
      cell9.value = listOfCustomers[i]['dept']; // dynamic values support provided;
      cell9.cellStyle = cellStyle;

      var cell10 = sheetObject.cell(CellIndex.indexByString("J${i+4}"));
      cell10.value = listOfCustomers[i]['subDept']; // dynamic values support provided;
      cell10.cellStyle = cellStyle;

      var cell11 = sheetObject.cell(CellIndex.indexByString("K${i+4}"));
      cell11.value = listOfCustomers[i]['designation']; // dynamic values support provided;
      cell11.cellStyle = cellStyle;

      var cell12 = sheetObject.cell(CellIndex.indexByString("L${i+4}"));
      cell12.value = reportingMan; // dynamic values support provided;
      cell12.cellStyle = cellStyle;
      var cell13 = sheetObject.cell(CellIndex.indexByString("M${i+4}"));
      cell13.value = teamLead; // dynamic values support provided;
      cell13.cellStyle = cellStyle;
      var cell14 = sheetObject.cell(CellIndex.indexByString("N${i+4}"));
      cell14.value = listOfCustomers[i]['empType']; // dynamic values support provided;
      cell14.cellStyle = cellStyle;
      var cell15 = sheetObject.cell(CellIndex.indexByString("O${i+4}"));
      cell15.value = listOfCustomers[i]['probation']; // dynamic values support provided;
      cell15.cellStyle = cellStyle;
      var cell16 = sheetObject.cell(CellIndex.indexByString("P${i+4}"));
      cell16.value = DateFormat('dd - MMM - yyyy',).format(listOfCustomers[i]['joinedDate'].toDate()); // dynamic values support provided;
      cell16.cellStyle = cellStyle;
      var cell17 = sheetObject.cell(CellIndex.indexByString("Q${i+4}"));
      cell17.value = listOfCustomers[i]['ctc']; // dynamic values support provided;
      cell17.cellStyle = cellStyle;
      var cell18 = sheetObject.cell(CellIndex.indexByString("R${i+4}"));
      cell18.value = listOfCustomers[i]['accountHolderName']; // dynamic values support provided;
      cell18.cellStyle = cellStyle;
      var cell19 = sheetObject.cell(CellIndex.indexByString("S${i+4}"));
      cell19.value = listOfCustomers[i]['bankName']; // dynamic values support provided;
      cell19.cellStyle = cellStyle;
      var cell20 = sheetObject.cell(CellIndex.indexByString("T${i+4}"));
      cell20.value = listOfCustomers[i]['city']; // dynamic values support provided;
      cell20.cellStyle = cellStyle;
      var cell21 = sheetObject.cell(CellIndex.indexByString("U${i+4}"));
      cell21.value = listOfCustomers[i]['ifsc']; // dynamic values support provided;
      cell21.cellStyle = cellStyle;
      var cell22 = sheetObject.cell(CellIndex.indexByString("V${i+4}"));
      cell22.value = listOfCustomers[i]['branchName']; // dynamic values support provided;
      cell22.cellStyle = cellStyle;
      var cell23 = sheetObject.cell(CellIndex.indexByString("W${i+4}"));
      cell23.value = listOfCustomers[i]['accountNumber']; // dynamic values support provided;
      cell23.cellStyle = cellStyle;

    }

    excel.setDefaultSheet('Employee');
    var fileBytes = excel.encode();
    File file;

    final content = base64Encode(fileBytes!);
    final anchor = html.AnchorElement(
        href: "data:application/octet-stream;charset=utf-16le;base64,$content")
      ..setAttribute(
          "download", "${DateTime.now().toString().substring(0, 10)}.xlsx")
      ..click();
  }

  ///
  // sortList() {
  //   List months = <String>[ 'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec', ];
  //   List dynamicList = listOfCustomers;
  //
  //   int lengthOfArray = dynamicList.length;
  //   for (int i = 0; i < lengthOfArray - 1; i++) {
  //     for (int j = 0; j < lengthOfArray - i - 1; j++) {
  //
  //       final k=months.indexOf(DateFormat('MMM').format(dynamicList[j]['dob'].toDate()));
  //       final z=months.indexOf(DateFormat('MMM').format(dynamicList[j+1]['dob'].toDate()));
  //
  //       // if (listOfCustomers[j] > listOfCustomers[j + 1]) {
  //       if (k > z) {
  //         // Swapping using temporary variable
  //         var temp = dynamicList[j];
  //         dynamicList[j] = dynamicList[j + 1];
  //         dynamicList[j + 1] = temp;
  //       }
  //     }
  //   }
  //
  //   importData(dynamicList);
  // }
  ///

  // Future<void> importData(List listOfCustomers) async {
  //   var excel = Excel.createExcel();
  //
  //
  //
  //   Sheet sheetObject = excel['Employee'];
  //   CellStyle cellStyle = CellStyle(
  //       verticalAlign: VerticalAlign.Center,
  //       horizontalAlign: HorizontalAlign.Center,
  //
  //       // backgroundColorHex: "#1AFF1A",
  //       fontFamily: getFontFamily(FontFamily.Calibri));
  //   CellStyle totalStyle = CellStyle(
  //       fontFamily: getFontFamily(FontFamily.Calibri),
  //       fontSize: 16,
  //       bold: true);
  //
  //   //HEADINGS
  //
  //   if (listOfCustomers.length > 0) {
  //     var cell1 = sheetObject.cell(CellIndex.indexByString("A2"));
  //     cell1.value = 'SL NO';
  //     cell1.cellStyle = cellStyle;
  //
  //
  //
  //     var cell3 = sheetObject.cell(CellIndex.indexByString("B2"));
  //     cell3.value = 'Name'; // dynamic values support provided;
  //     cell3.cellStyle = cellStyle;
  //
  //
  //
  //     var cell5 = sheetObject.cell(CellIndex.indexByString("C2"));
  //     cell5.value = 'Phone Number'; // dynamic values support provided;
  //     cell5.cellStyle = cellStyle;
  //
  //     var cell6 = sheetObject.cell(CellIndex.indexByString("D2"));
  //     cell6.value = 'DoB'; // dynamic values support provided;
  //     cell6.cellStyle = cellStyle;
  //
  //     ///
  //     var cell7 = sheetObject.cell(CellIndex.indexByString("E2"));
  //     cell7.value = 'Gender'; // dynamic values support provided;
  //     cell7.cellStyle = cellStyle;
  //
  //
  //   }
  //
  //   //CELL VALUES
  //
  //   for (int i = 0; i < listOfCustomers.length; i++) {
  //
  //
  //
  //     var cell1 = sheetObject.cell(CellIndex.indexByString("A${i+4}"));
  //     cell1.value = i+1;
  //     cell1.cellStyle = cellStyle;
  //
  //     var cell2 = sheetObject.cell(CellIndex.indexByString("B${i+4}"));
  //     cell2.value = listOfCustomers[i]['empId']; // dynamic values support provided;
  //     cell2.cellStyle = cellStyle;
  //
  //     var cell3 = sheetObject.cell(CellIndex.indexByString("C${i+4}"));
  //     cell3.value = listOfCustomers[i]['name']; // dynamic values support provided;
  //     cell3.cellStyle = cellStyle;
  //
  //
  //
  //     var cell5 = sheetObject.cell(CellIndex.indexByString("D${i+4}"));
  //     cell5.value = listOfCustomers[i]['phone']; // dynamic values support provided;
  //     cell5.cellStyle = cellStyle;
  //
  //     var cell6 = sheetObject.cell(CellIndex.indexByString("E${i+4}"));
  //     cell6.value = DateFormat('dd - MMM - yyyy').format(listOfCustomers[i]['dob'].toDate()); // dynamic values support provided;
  //     cell6.cellStyle = cellStyle;
  //
  //
  //
  //   }
  //
  //   excel.setDefaultSheet('Employee');
  //   var fileBytes = excel.encode();
  //   File file;
  //
  //   final content = base64Encode(fileBytes!);
  //   final anchor = html.AnchorElement(
  //       href: "data:application/octet-stream;charset=utf-16le;base64,$content")
  //     ..setAttribute(
  //         "download", "${DateTime.now().toString().substring(0, 10)}.xlsx")
  //     ..click();
  // }

  ///

}


