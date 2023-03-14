import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../../../../../flutter_flow/flutter_flow_theme.dart';
import '../../../../../flutter_flow/flutter_flow_util.dart';
import '../../../../../flutter_flow/flutter_flow_widgets.dart';
import '../../../../models/Employee/EmployeeModel.dart';
import '../../../../pages/home_page/home.dart';

String employeeId = '';

class EmployeeList extends StatefulWidget {
  final TabController _tabController;
  const EmployeeList({
    Key key,
    @required TabController tabController,
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

  TextEditingController search;
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  int firstIndex = 0;
  int lastIndex = 0;

  // listOfCustomers
  List listOfFilteredCustomers = [];

//GET FIRST 20 DATA
  getFirst20() {
    listOfFilteredCustomers = [];
    print('===============================================');
    print(listOfCustomers.length);
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

    print('=====================FIRST INDEX==========================');
    print(firstIndex);

    print('==========================LAST INDEX=====================');
    print(lastIndex);

    print('==========================LIST CURRENT LENGTH=====================');
    print(listOfFilteredCustomers.length);

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

    print(firstIndex);
    print(lastIndex);

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

    print(firstIndex);
    print(lastIndex);

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
    print(firstIndex);
    print(lastIndex);
    setState(() {});
  }

  //GET PREVIOUS 20 SEARCHED DATA
  getPrevSearchProjects(String txt) {
    listOfFilteredCustomers = [];
    List prev = [];
    print('[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[');
    print(lastIndex);
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

    print(firstIndex);
    print(lastIndex);

    // listOfFilteredProjects.reversed;

    setState(() {});
  }

  @override
  void initState() {
    super.initState();

    print(employeeList.length);

    listOfCustomers.addAll(employeeList);

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
                                                  '']
                                          .name;

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
                                                //               id: listOfFilteredCustomers[
                                                //               index]
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
                    lastIndex + 1 < listOfCustomers.length
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
}
