import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fl_erp/app/pages/home_page/home.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../../../flutter_flow/flutter_flow_theme.dart';
import '../../../flutter_flow/flutter_flow_util.dart';
import '../../../flutter_flow/flutter_flow_widgets.dart';
import '../../app_widget.dart';
import '../Customers/customer_SinglePage.dart';
import 'EnquiryDetails.dart';

class EnqyiryListWidget extends StatefulWidget {
  const EnqyiryListWidget({Key? key}) : super(key: key);

  @override
  _EnqyiryListWidgetState createState() => _EnqyiryListWidgetState();
}

class _EnqyiryListWidgetState extends State<EnqyiryListWidget> {
 late TextEditingController search;
  final scaffoldKey = GlobalKey<ScaffoldState>();
  List<DropdownMenuItem>? listofcategory;
  List<DropdownMenuItem>? listofSubcategory;
  String selectedCategory = '';
  String selectedSubCategory = '';

  String selectedCategoryId = "";
  List<DropdownMenuItem> categoryTemp = [];
  @override
  void initState() {
    super.initState();
    search = TextEditingController();
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
                        'Enquiry List',
                        style: FlutterFlowTheme.bodyText1.override(
                            fontFamily: 'Poppins',
                            fontSize: 30,
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
                                    setState(() {});
                                  },
                                  decoration: InputDecoration(
                                    labelText: 'Search ',
                                    hintText:
                                        'Please Enter Mobile Number or Name',
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
                                  setState(() {});
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
              search.text == ''
                  ? StreamBuilder<QuerySnapshot>(
                      stream: FirebaseFirestore.instance
                          .collection('enquiries')
                          .where('branchId', isEqualTo: currentBranchId)
                          .orderBy('date', descending: true)
                          .snapshots(),
                      builder: (context, snapshot) {
                        if (!snapshot.hasData) {
                          return Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                        var data = snapshot.data!.docs;
                        return data.length == 0
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
                                      label: Text(
                                        "Enquiry Id",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 12),
                                      ),
                                    ),
                                    DataColumn(
                                      label: Text("Date",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 12)),
                                    ),
                                    DataColumn(
                                      label: Text("Name",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 12)),
                                    ),
                                    DataColumn(
                                      label: Text("Mobile",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 12)),
                                    ),
                                    DataColumn(
                                      label: Text("c/o",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 12)),
                                    ),
                                    DataColumn(
                                      label: Text("Status",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 12)),
                                    ),
                                    DataColumn(
                                      label: Text("Action",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 12)),
                                    ),
                                  ],
                                  rows: List.generate(
                                    data.length,
                                    (index) {
                                      String name = data[index]['name'];

                                      String careOf = agentDataById[data[index]
                                                      ['agentId']] ==
                                                  null ||
                                              data[index]['agentId'] == ''
                                          ? ''
                                          : (agentDataById[data[index]
                                                      ['agentId']]['name'] ??
                                                  '')
                                              .toString();
                                      String mobile = data[index]['mobile'];
                                      String email = data[index]['email'];

                                      return DataRow(
                                        color: index.isOdd
                                            ? MaterialStateProperty.all(Colors
                                                .blueGrey.shade50
                                                .withOpacity(0.7))
                                            : MaterialStateProperty.all(
                                                Colors.blueGrey.shade50),
                                        cells: [
                                          DataCell(Text(
                                            data[index].id,
                                            style: FlutterFlowTheme.bodyText2
                                                .override(
                                              fontFamily: 'Lexend Deca',
                                              color: Colors.black,
                                              fontSize: 12,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          )),
                                          DataCell(Text(
                                            dateTimeFormat('d-MMM-y',
                                                data[index]['date'].toDate()),
                                            style: FlutterFlowTheme.bodyText2
                                                .override(
                                              fontFamily: 'Lexend Deca',
                                              color: Colors.black,
                                              fontSize: 12,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          )),
                                          DataCell(Text(
                                            name,
                                            style: FlutterFlowTheme.bodyText2
                                                .override(
                                              fontFamily: 'Lexend Deca',
                                              color: Colors.black,
                                              fontSize: 12,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          )),
                                          DataCell(Text(
                                            mobile,
                                            style: FlutterFlowTheme.bodyText2
                                                .override(
                                              fontFamily: 'Lexend Deca',
                                              color: Colors.black,
                                              fontSize: 12,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          )),
                                          DataCell(Text(
                                            careOf,
                                            style: FlutterFlowTheme.bodyText2
                                                .override(
                                              fontFamily: 'Lexend Deca',
                                              color: Colors.black,
                                              fontSize: 12,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          )),
                                          DataCell(InkWell(
                                            onTap: () {
                                              if (data[index]['status'] == 1) {
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            CustomerSinglePage(
                                                              id: data[index]
                                                                  ['studentId'],
                                                              project: {},
                                                              selectedIndex: 0,
                                                              tab: false,
                                                            )));
                                              }
                                            },
                                            child: Text(
                                              data[index]['status'] == 0
                                                  ? 'Pending'
                                                  : data[index]['status'] == 1
                                                      ? 'Customer'
                                                      : 'Dead',
                                              style: FlutterFlowTheme.bodyText2
                                                  .override(
                                                fontFamily: 'Lexend Deca',
                                                color: data[index]['status'] ==
                                                        1
                                                    ? Color(0xFF4B39EF)
                                                    : data[index]['status'] == 0
                                                        ? Colors.black
                                                        : Colors.red,
                                                fontSize: 12,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          )),
                                          DataCell(
                                            Row(
                                              children: [
                                                FFButtonWidget(
                                                  onPressed: () {
                                                    Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                            builder: (context) =>
                                                                EnquiryDetailsWidget(
                                                                  id: data[
                                                                          index]
                                                                      .id,
                                                                )));
                                                  },
                                                  text: 'View',
                                                  options: FFButtonOptions(
                                                    width: 90,
                                                    height: 30,
                                                    color: Color(0xff0054FF),
                                                    textStyle: FlutterFlowTheme
                                                        .subtitle2
                                                        .override(
                                                            fontFamily:
                                                                'Poppins',
                                                            color: Colors.white,
                                                            fontSize: 12,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
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
                              );
                      },
                    )
                  : StreamBuilder<QuerySnapshot>(
                      stream: FirebaseFirestore.instance
                          .collection('enquiries')
                          // .where('status', isEqualTo: 0)
                          .where('branchId', isEqualTo: currentBranchId)
                          .where('search',
                              arrayContains: search.text.toUpperCase())
                          .orderBy('date', descending: true)
                          .snapshots(),
                      builder: (context, snapshot) {
                        if (!snapshot.hasData) {
                          return Center(
                            child: LottieBuilder.network(
                              'https://assets9.lottiefiles.com/packages/lf20_HpFqiS.json',
                              height: 500,
                            ),
                          );
                        }
                        var data = snapshot.data!.docs;
                        return data.length == 0
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
                                      label: Text(
                                        "Enquiry Id",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 12),
                                      ),
                                    ),
                                    DataColumn(
                                      label: Text("Date",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 12)),
                                    ),
                                    DataColumn(
                                      label: Text("Name",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 12)),
                                    ),
                                    DataColumn(
                                      label: Text("Mobile",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 12)),
                                    ),
                                    DataColumn(
                                      label: Text("c/o",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 12)),
                                    ),
                                    DataColumn(
                                      label: Text("Status",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 12)),
                                    ),
                                    DataColumn(
                                      label: Text("Action",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 12)),
                                    ),
                                  ],
                                  rows: List.generate(
                                    data.length,
                                    (index) {
                                      String name = data[index]['name'];

                                      String careOf = agentDataById[data[index]
                                                      ['agentId']] ==
                                                  null ||
                                              data[index]['agentId'] == ''
                                          ? ''
                                          : (agentDataById[data[index]
                                                      ['agentId']]['name'] ??
                                                  '')
                                              .toString();
                                      String mobile = data[index]['mobile'];
                                      String email = data[index]['email'];

                                      return DataRow(
                                        color: index.isOdd
                                            ? MaterialStateProperty.all(Colors
                                                .blueGrey.shade50
                                                .withOpacity(0.7))
                                            : MaterialStateProperty.all(
                                                Colors.blueGrey.shade50),
                                        cells: [
                                          DataCell(Text(
                                            data[index].id,
                                            style: FlutterFlowTheme.bodyText2
                                                .override(
                                              fontFamily: 'Lexend Deca',
                                              color: Colors.black,
                                              fontSize: 12,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          )),
                                          DataCell(Text(
                                            dateTimeFormat('d-MMM-y',
                                                data[index]['date'].toDate()),
                                            style: FlutterFlowTheme.bodyText2
                                                .override(
                                              fontFamily: 'Lexend Deca',
                                              color: Colors.black,
                                              fontSize: 12,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          )),
                                          DataCell(Text(
                                            name,
                                            style: FlutterFlowTheme.bodyText2
                                                .override(
                                              fontFamily: 'Lexend Deca',
                                              color: Colors.black,
                                              fontSize: 12,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          )),
                                          DataCell(Text(
                                            mobile,
                                            style: FlutterFlowTheme.bodyText2
                                                .override(
                                              fontFamily: 'Lexend Deca',
                                              color: Colors.black,
                                              fontSize: 12,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          )),
                                          DataCell(Text(
                                            careOf,
                                            style: FlutterFlowTheme.bodyText2
                                                .override(
                                              fontFamily: 'Lexend Deca',
                                              color: Colors.black,
                                              fontSize: 12,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          )),
                                          DataCell(InkWell(
                                            onTap: () {
                                              if (data[index]['status'] == 1) {
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            CustomerSinglePage(
                                                              id: data[index]
                                                                  ['studentId'], selectedIndex: 0,
                                                              tab: false,
                                                              project: {},
                                                            )));
                                              }
                                            },
                                            child: Text(
                                              data[index]['status'] == 0
                                                  ? 'Pending'
                                                  : data[index]['status'] == 1
                                                      ? 'Customer'
                                                      : 'Dead',
                                              style: FlutterFlowTheme.bodyText2
                                                  .override(
                                                fontFamily: 'Lexend Deca',
                                                color: data[index]['status'] ==
                                                        1
                                                    ? Color(0xFF4B39EF)
                                                    : data[index]['status'] == 0
                                                        ? Colors.black
                                                        : Colors.red,
                                                fontSize: 12,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          )),
                                          DataCell(
                                            Row(
                                              children: [
                                                FFButtonWidget(
                                                  onPressed: () {
                                                    Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                            builder: (context) =>
                                                                EnquiryDetailsWidget(
                                                                  id: data[
                                                                          index]
                                                                      .id,
                                                                )));
                                                  },
                                                  text: 'View',
                                                  options: FFButtonOptions(
                                                    width: 90,
                                                    height: 30,
                                                    color: Color(0xff0054FF),
                                                    textStyle: FlutterFlowTheme
                                                        .subtitle2
                                                        .override(
                                                            fontFamily:
                                                                'Poppins',
                                                            color: Colors.white,
                                                            fontSize: 12,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
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
                              );
                      }),
            ],
          ),
        ),
      ),
    );
  }
}
