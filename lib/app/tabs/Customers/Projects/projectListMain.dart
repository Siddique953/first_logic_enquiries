import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fl_erp/app/pages/home_page/home.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../../../../flutter_flow/flutter_flow_theme.dart';
import '../../../../flutter_flow/flutter_flow_widgets.dart';
import '../../../app_widget.dart';
import '../customer_SinglePage.dart';

class ProjectList extends StatefulWidget {
  const ProjectList({Key? key}) : super(key: key);

  @override
  State<ProjectList> createState() => _ProjectListState();
}

class _ProjectListState extends State<ProjectList> {
  List listOfProjects = [];

  getCustomers() {
    FirebaseFirestore.instance
        .collection('projects')
        // .where('status', isEqualTo: 0)
        .where('branchId', isEqualTo: currentBranchId)
        .orderBy('date', descending: true)
        .snapshots()
        .listen((event) {
      listOfProjects = [];
      for (DocumentSnapshot customer in event.docs) {
        listOfProjects.add(customer.data());
        // listOfFilteredCustomers.add(customer.data());
      }
      // setState(() {
      //   getFirst20();
      // });

      if (mounted) {
        setState(() {
          getFirst20();
        });
      }
    });
  }

  TextEditingController search=TextEditingController();
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  int firstIndex = 0;
  int lastIndex = 0;
  bool showNButton = false;
  bool showPButton = false;

  // listOfCustomers
  List listOfFilteredProjects = [];

//GET FIRST 20 DATA
  getFirst20() {
    listOfFilteredProjects = [];

    print(listOfProjects.length);
    for (int i = 0; i < listOfProjects.length; i++) {
      firstIndex = 0;
      if (listOfFilteredProjects.length < 20) {
        Map<String, dynamic> data = {};
        data = listOfProjects[i];
        data['index'] = i;
        listOfFilteredProjects.add(data);
      } else if (listOfFilteredProjects.length == 20) {
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
    print(listOfFilteredProjects.length);

    setState(() {});
  }

  //GET NEXT 20 DATA
  next() {
    listOfFilteredProjects = [];
    for (int i = firstIndex; i < listOfProjects.length; i++) {
      if (listOfFilteredProjects.length < 20) {
        Map<String, dynamic> data = {};
        data = listOfProjects[i];
        data['index'] = i;
        listOfFilteredProjects.add(data);
      } else if (listOfFilteredProjects.length == 20) {
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
    listOfFilteredProjects = [];
    List prev = [];
    for (int i = lastIndex; i >= 0; i--) {
      if (prev.length < 20) {
        Map<String, dynamic> data = {};
        data = listOfProjects[i];
        data['index'] = i;
        prev.add(data);
      } else if (prev.length == 20) {
        firstIndex = i + 1;
        break;
      }
      firstIndex = i;
    }

    listOfFilteredProjects = prev.reversed.toList();

    print(firstIndex);
    print(lastIndex);

    // listOfFilteredProjects.reversed;

    setState(() {});
  }

  //GET FIRST 20 SEARCHED DATA
  getSearchedProjects(String txt) {
    showNButton = false;
    listOfFilteredProjects = [];
    for (int i = 0; i < listOfProjects.length; i++) {
      if (listOfProjects[i]['projectName']
              .toString()
              .toLowerCase()
              .contains(txt) ||
          listOfProjects[i]['customerName']
              .toString()
              .toLowerCase()
              .contains(txt) ||
          listOfProjects[i]['mobile'].toString().toLowerCase().contains(txt) ||
          listOfProjects[i]['email'].toString().toLowerCase().contains(txt)) {
        print(i);

        if (listOfFilteredProjects.length < 20) {
          showNButton = false;
          Map<String, dynamic> data = {};
          data = listOfProjects[i];
          data['index'] = listOfFilteredProjects.length;
          listOfFilteredProjects.add(data);
        } else if (listOfFilteredProjects.length == 20) {
          showNButton = true;
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
    showPButton = true;
    showNButton = false;
    listOfFilteredProjects = [];
    for (int i = firstIndex; i < listOfProjects.length; i++) {
      if (listOfProjects[i]['projectName']
              .toString()
              .toLowerCase()
              .contains(txt) ||
          listOfProjects[i]['customerName']
              .toString()
              .toLowerCase()
              .contains(txt) ||
          listOfProjects[i]['mobile'].toString().toLowerCase().contains(txt) ||
          listOfProjects[i]['email'].toString().toLowerCase().contains(txt)) {
        if (i > 20) {
          showNButton = true;
          setState(() {});
        } else if (i <= 20) {
          showNButton = false;
          setState(() {});
        }

        if (listOfFilteredProjects.length < 20) {
          Map<String, dynamic> data = {};
          data = listOfProjects[i];
          data['index'] = i;
          listOfFilteredProjects.add(data);
        } else if (listOfFilteredProjects.length == 20) {
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
    showPButton = false;
    listOfFilteredProjects = [];
    List prev = [];
    print('[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[');
    print(lastIndex);
    for (int i = lastIndex; i >= 0; i--) {
      if (listOfProjects[i]['projectName']
              .toString()
              .toLowerCase()
              .contains(txt) ||
          listOfProjects[i]['customerName']
              .toString()
              .toLowerCase()
              .contains(txt) ||
          listOfProjects[i]['mobile'].toString().toLowerCase().contains(txt) ||
          listOfProjects[i]['email'].toString().toLowerCase().contains(txt)) {
        if (i > 20) {
          showPButton = true;
          setState(() {});
        } else if (i <= 20) {
          showPButton = false;
          setState(() {});
        }

        if (prev.length < 20) {
          Map<String, dynamic> data = {};
          data = listOfProjects[i];
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
    listOfFilteredProjects = prev.reversed.toList();

    print(firstIndex);
    print(lastIndex);

    // listOfFilteredProjects.reversed;

    setState(() {});
  }

  @override
  void initState() {
    super.initState();

    listOfFilteredProjects = [];
    getCustomers();
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
                    Expanded(
                      child: Text(
                        'Project List',
                        style: FlutterFlowTheme.bodyText1.override(
                            fontFamily: 'Poppins',
                            fontSize: 25,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                    // Padding(
                    //   padding: EdgeInsetsDirectional.fromSTEB(0, 0, 8, 0),
                    //   child: FFButtonWidget(
                    //     onPressed: () {
                    //       showDialog(
                    //           context: context,
                    //           builder: (buildContext) {
                    //             return CreateNewPopup(
                    //               form: formKey,
                    //             );
                    //           });
                    //     },
                    //     text: 'Create',
                    //     options: FFButtonOptions(
                    //       width: 100,
                    //       height: 45,
                    //       color: Color(0xff0054FF),
                    //       textStyle: FlutterFlowTheme.subtitle2.override(
                    //         fontFamily: 'Poppins',
                    //         color: Colors.white,
                    //         fontSize: 15,
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
              listOfFilteredProjects.length == 0
                  ? LottieBuilder.network(
                      'https://assets9.lottiefiles.com/packages/lf20_HpFqiS.json',
                      height: 500,
                    )
                  : SizedBox(
                      width: double.infinity,
                      child: DataTable(
                        horizontalMargin: 10,
                        columns: [
                          DataColumn(
                            label: Text("S.Id",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize:
                                        MediaQuery.of(context).size.width *
                                            0.008)),
                          ),
                          // DataColumn(
                          //   label: Text("Date",
                          //       style: TextStyle(
                          //           fontWeight: FontWeight.bold,
                          //           fontSize:
                          //               MediaQuery.of(context).size.width *
                          //                   0.008)),
                          // ),
                          DataColumn(
                            label: Text("Project Name",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize:
                                        MediaQuery.of(context).size.width *
                                            0.008)),
                          ),
                          DataColumn(
                            label: Text("Customer Name",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize:
                                        MediaQuery.of(context).size.width *
                                            0.008)),
                          ),
                          DataColumn(
                            label: Text("Mobile",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize:
                                        MediaQuery.of(context).size.width *
                                            0.008)),
                          ),
                          DataColumn(
                            label: Text("Email",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize:
                                        MediaQuery.of(context).size.width *
                                            0.008)),
                          ),
                          DataColumn(
                            label: Text("Action",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize:
                                        MediaQuery.of(context).size.width *
                                            0.008)),
                          ),
                        ],
                        rows: List.generate(
                          listOfFilteredProjects.length,
                          (index) {
                            // getCount(data[index].id);

                            String projectName =
                                listOfFilteredProjects[index]['projectName'];
                            String customerName = customerDetailsById[
                                    listOfFilteredProjects[index]['customerID']]
                                ['name'];

                            String mobile = customerDetailsById[
                                    listOfFilteredProjects[index]
                                        ['customerID']]['phoneCode'] +
                                customerDetailsById[
                                    listOfFilteredProjects[index]
                                        ['customerID']]['mobile'];
                            String email = customerDetailsById[
                                    listOfFilteredProjects[index]['customerID']]
                                ['email'];

                            int count = listOfFilteredProjects[index]['index'];

                            return DataRow(
                              color: index.isOdd
                                  ? MaterialStateProperty.all(
                                      Colors.blueGrey.shade50.withOpacity(0.7))
                                  : MaterialStateProperty.all(
                                      Colors.blueGrey.shade50),
                              cells: [
                                DataCell(
                                  SelectableText(
                                    '${count + 1}',
                                    style: FlutterFlowTheme.bodyText2.override(
                                      fontFamily: 'Lexend Deca',
                                      color: Colors.black,
                                      fontSize:
                                          MediaQuery.of(context).size.width *
                                              0.008,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),

                                DataCell(
                                  SelectableText(
                                    projectName,
                                    style: FlutterFlowTheme.bodyText2.override(
                                      fontFamily: 'Lexend Deca',
                                      color: Colors.black,
                                      fontSize:
                                          MediaQuery.of(context).size.width *
                                              0.008,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                DataCell(
                                  SelectableText(
                                    customerName,
                                    style: FlutterFlowTheme.bodyText2.override(
                                      fontFamily: 'Lexend Deca',
                                      color: Colors.black,
                                      fontSize:
                                          MediaQuery.of(context).size.width *
                                              0.008,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                DataCell(
                                  SelectableText(
                                    mobile,
                                    style: FlutterFlowTheme.bodyText2.override(
                                      fontFamily: 'Lexend Deca',
                                      color: Colors.black,
                                      fontSize:
                                          MediaQuery.of(context).size.width *
                                              0.008,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                DataCell(
                                  SelectableText(
                                    email,
                                    style: FlutterFlowTheme.bodyText2.override(
                                      fontFamily: 'Lexend Deca',
                                      color: Colors.black,
                                      fontSize:
                                          MediaQuery.of(context).size.width *
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
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      CustomerSinglePage(
                                                        id: listOfFilteredProjects[
                                                                index]
                                                            ['customerID'],
                                                        selectedIndex: 1,
                                                        tab: true,
                                                        project:
                                                            listOfFilteredProjects[
                                                                index],
                                                      )));
                                        },
                                        text: 'View',
                                        options: FFButtonOptions(
                                          width: 80,
                                          height: 30,
                                          color: Color(0xff0054FF),
                                          textStyle: FlutterFlowTheme.subtitle2
                                              .override(
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
              SizedBox(
                height: 50,
              ),

              ///

              Padding(
                padding: const EdgeInsets.only(bottom: 20, left: 15, right: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    search.text == ''
                        ? firstIndex > 0
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
                                  textStyle: FlutterFlowTheme.subtitle2
                                      .override(
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
                            : SizedBox()
                        : showPButton
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
                                  textStyle: FlutterFlowTheme.subtitle2
                                      .override(
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

                    search.text == ''
                        ? lastIndex + 1 < listOfProjects.length
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
                                  textStyle: FlutterFlowTheme.subtitle2
                                      .override(
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
                            : SizedBox()
                        : showNButton
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
                                  textStyle: FlutterFlowTheme.subtitle2
                                      .override(
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
