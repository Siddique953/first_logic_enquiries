import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../../../../flutter_flow/flutter_flow_theme.dart';
import '../../../../flutter_flow/flutter_flow_util.dart';
import '../../../../flutter_flow/flutter_flow_widgets.dart';
import '../../../../flutter_flow/upload_media.dart';
import '../../../app_widget.dart';

class AgentList extends StatefulWidget {
  const AgentList({Key? key}) : super(key: key);

  @override
  State<AgentList> createState() => _AgentListState();
}

class _AgentListState extends State<AgentList> {
  List listOfAgents = [];

  getAgents() {
    print(currentBranchId);
    FirebaseFirestore.instance
        .collection('agents')
        // .where('verified', isEqualTo: true)
        .where('branchId', isEqualTo: currentBranchId)
        .orderBy('uid', descending: false)
        .snapshots()
        .listen((event) {
      listOfAgents = [];
      for (DocumentSnapshot customer in event.docs) {
        listOfAgents.add(customer.data());
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

  TextEditingController search = TextEditingController();
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  int firstIndex = 0;
  int lastIndex = 0;

  // listOfCustomers
  List listOfFilteredAgents = [];

  //GET FIRST 20 DATA
  getFirst20() {
    listOfFilteredAgents = [];

    print(listOfAgents.length);
    for (int i = 0; i < listOfAgents.length; i++) {
      firstIndex = 0;
      if (listOfFilteredAgents.length < 20) {
        Map<String, dynamic> data = {};
        data = listOfAgents[i];
        data['index'] = i;
        listOfFilteredAgents.add(data);
      } else if (listOfFilteredAgents.length == 20) {
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
    print(listOfFilteredAgents.length);

    setState(() {});
  }

  //GET NEXT 20 DATA
  next() {
    listOfFilteredAgents = [];
    for (int i = firstIndex; i < listOfAgents.length; i++) {
      if (listOfFilteredAgents.length < 20) {
        Map<String, dynamic> data = {};
        data = listOfAgents[i];
        data['index'] = i;
        listOfFilteredAgents.add(data);
      } else if (listOfFilteredAgents.length == 20) {
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
    listOfFilteredAgents = [];
    List prev = [];
    for (int i = lastIndex; i >= 0; i--) {
      if (prev.length < 20) {
        Map<String, dynamic> data = {};
        data = listOfAgents[i];
        data['index'] = i;
        prev.add(data);
      } else if (prev.length == 20) {
        firstIndex = i + 1;
        break;
      }
      firstIndex = i;
    }

    listOfFilteredAgents = prev.reversed.toList();

    print(firstIndex);
    print(lastIndex);

    // listOfFilteredProjects.reversed;

    setState(() {});
  }

  //GET FIRST 20 SEARCHED DATA
  getSearchedProjects(String txt) {
    listOfFilteredAgents = [];
    for (int i = 0; i < listOfAgents.length; i++) {
      if (listOfAgents[i]['name'].toString().toLowerCase().contains(txt) ||
          listOfAgents[i]['mobile'].toString().toLowerCase().contains(txt) ||
          listOfAgents[i]['email'].toString().toLowerCase().contains(txt)) {
        if (listOfFilteredAgents.length < 20) {
          Map<String, dynamic> data = {};
          data = listOfAgents[i];
          data['index'] = i;
          listOfFilteredAgents.add(data);
        } else if (listOfFilteredAgents.length == 20) {
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
    listOfFilteredAgents = [];
    for (int i = firstIndex; i < listOfAgents.length; i++) {
      if (listOfAgents[i]['name'].toString().toLowerCase().contains(txt) ||
          listOfAgents[i]['mobile'].toString().toLowerCase().contains(txt) ||
          listOfAgents[i]['email'].toString().toLowerCase().contains(txt)) {
        if (listOfFilteredAgents.length < 20) {
          Map<String, dynamic> data = {};
          data = listOfAgents[i];
          data['index'] = i;
          listOfFilteredAgents.add(data);
        } else if (listOfFilteredAgents.length == 20) {
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
    listOfFilteredAgents = [];
    List prev = [];
    print('[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[');
    print(lastIndex);
    for (int i = lastIndex; i >= 0; i--) {
      if (listOfAgents[i]['name'].toString().toLowerCase().contains(txt) ||
          listOfAgents[i]['mobile'].toString().toLowerCase().contains(txt) ||
          listOfAgents[i]['email'].toString().toLowerCase().contains(txt)) {
        if (prev.length < 20) {
          Map<String, dynamic> data = {};
          data = listOfAgents[i];
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
    listOfFilteredAgents = prev.reversed.toList();

    print(firstIndex);
    print(lastIndex);

    // listOfFilteredProjects.reversed;

    setState(() {});
  }

  @override
  void initState() {
    super.initState();

    listOfFilteredAgents = [];
    getAgents();
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
                        'Customer Lists',
                        style: FlutterFlowTheme.bodyText1.override(
                            fontFamily: 'Poppins',
                            fontSize: 25,
                            fontWeight: FontWeight.w600),
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
                                      listOfFilteredAgents.clear();
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
              listOfFilteredAgents.length == 0
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
                            label: Text("Sl. No.",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize:
                                        MediaQuery.of(context).size.width *
                                            0.008)),
                          ),

                          DataColumn(
                            label: Text("Name",
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
                            label: Text("Place",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize:
                                        MediaQuery.of(context).size.width *
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
                              child: Text("Status",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize:
                                          MediaQuery.of(context).size.width *
                                              0.008)),
                            ),
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
                          listOfFilteredAgents.length,
                          (index) {
                            // getCount(data[index].id);

                            String name = listOfFilteredAgents[index]['name'];
                            String place = listOfFilteredAgents[index]['place'];
                            String mobile =
                                listOfFilteredAgents[index]['mobileNumber'];
                            String email = listOfFilteredAgents[index]['email'];

                            int count = listOfFilteredAgents[index]['index'];

                            return DataRow(
                              color: index.isOdd
                                  ? MaterialStateProperty.all(
                                      Colors.blueGrey.shade50.withOpacity(0.7))
                                  : MaterialStateProperty.all(
                                      Colors.blueGrey.shade50),
                              cells: [
                                DataCell(SelectableText(
                                  '${count + 1}',
                                  style: FlutterFlowTheme.bodyText2.override(
                                    fontFamily: 'Lexend Deca',
                                    color: Colors.black,
                                    fontSize:
                                        MediaQuery.of(context).size.width *
                                            0.008,
                                    fontWeight: FontWeight.bold,
                                  ),
                                )),

                                DataCell(
                                  SelectableText(
                                    name,
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
                                // DataCell(SelectableText(place,
                                //     style: FlutterFlowTheme.bodyText2
                                //         .override(
                                //       fontFamily: 'Lexend Deca',
                                //       color: Colors.black,
                                //       fontSize: 11,
                                //       fontWeight: FontWeight.bold,
                                //     ))),
                                DataCell(
                                  Text(place,
                                      style:
                                          FlutterFlowTheme.bodyText2.override(
                                        fontFamily: 'Lexend Deca',
                                        color: Colors.black,
                                        fontSize:
                                            MediaQuery.of(context).size.width *
                                                0.008,
                                        fontWeight: FontWeight.bold,
                                      )),
                                ),
                                DataCell(
                                  Text(
                                      listOfFilteredAgents[index]['verified'] ==
                                              true
                                          ? 'Active'
                                          : 'Blocked',
                                      style:
                                          FlutterFlowTheme.bodyText2.override(
                                        fontFamily: 'Lexend Deca',
                                        color: listOfFilteredAgents[index]
                                                    ['verified'] ==
                                                true
                                            ? Color(0xff0054FF)
                                            : Colors.red,
                                        fontSize:
                                            MediaQuery.of(context).size.width *
                                                0.008,
                                        fontWeight: FontWeight.bold,
                                      )),
                                ),
                                DataCell(
                                  Row(
                                    children: [
                                      FFButtonWidget(
                                        onPressed: () async {
                                          // Navigator.push(
                                          //     context,
                                          //     MaterialPageRoute(
                                          //         builder: (context) =>
                                          //             CustomerSinglePage(
                                          //               id: listOfFilteredAgents[
                                          //                       index]
                                          //                   ['customerID'],
                                          //               selectedIndex: 0,
                                          //               tab: false,
                                          //               project: {},
                                          //             )));

                                          bool pressed = await alert(
                                              context,
                                              listOfFilteredAgents[index]
                                                          ['verified'] ==
                                                      true
                                                  ? 'Do u want to Block This User'
                                                  : 'Do u want to Unblock This User');

                                          if (pressed) {
                                            listOfFilteredAgents[index]
                                                        ['verified'] ==
                                                    true
                                                ? FirebaseFirestore.instance
                                                    .collection('agents')
                                                    .doc(listOfFilteredAgents[
                                                        index]['uid'])
                                                    .update({
                                                    'verified': false,
                                                  })
                                                : FirebaseFirestore.instance
                                                    .collection('agents')
                                                    .doc(listOfFilteredAgents[
                                                        index]['uid'])
                                                    .update({
                                                    'verified': true,
                                                  });
                                          }
                                        },
                                        text: listOfFilteredAgents[index]
                                                    ['verified'] ==
                                                true
                                            ? 'Block'
                                            : 'Unblock',
                                        options: FFButtonOptions(
                                          width: 120,
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
                    lastIndex + 1 < listOfAgents.length
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
