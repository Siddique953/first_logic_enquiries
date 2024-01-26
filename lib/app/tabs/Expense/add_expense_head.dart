import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../../flutter_flow/flutter_flow_theme.dart';
import '../../../flutter_flow/flutter_flow_widgets.dart';
import '../../app_widget.dart';

class ExpenseHeadPage extends StatefulWidget {
  const ExpenseHeadPage({Key? key}) : super(key: key);

  @override
  _ExpenseHeadPageState createState() => _ExpenseHeadPageState();
}

class _ExpenseHeadPageState extends State<ExpenseHeadPage> {
  bool edit = false;
 late int currentListIndex;
 late List currentList;
  var currentValue;
 late TextEditingController expenseHead;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    expenseHead = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFECF0F5),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(20, 15, 0, 0),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Expanded(
                      child: Text(
                        'Expense Head',
                        style: FlutterFlowTheme.bodyText1.override(
                            fontFamily: 'Poppins',
                            fontSize: 25,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20, bottom: 20),
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.7,
                  height: MediaQuery.of(context).size.height * 0.25,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Column(
                    children: [
                      Padding(
                        padding:
                            EdgeInsetsDirectional.only(top: 20, bottom: 20),
                        child: Text(
                          'Add Expense Head',
                          style: FlutterFlowTheme.bodyText2.override(
                            fontFamily: 'Montserrat',
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(30, 10, 30, 5),
                        child: Row(
                          children: [
                            Expanded(
                              child: Container(
                                width: 350,
                                height: 60,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(8),
                                  border: Border.all(
                                    color: Color(0xFFE6E6E6),
                                  ),
                                ),
                                child: Padding(
                                  padding: EdgeInsets.fromLTRB(16, 0, 0, 0),
                                  child: TextFormField(
                                    controller: expenseHead,
                                    obscureText: false,
                                    decoration: InputDecoration(
                                      labelText: 'Name',
                                      labelStyle: FlutterFlowTheme.bodyText2
                                          .override(
                                              fontFamily: 'Montserrat',
                                              color: Colors.black,
                                              fontWeight: FontWeight.w500,
                                              fontSize: 12),
                                      hintText: 'Please Enter Name',
                                      hintStyle: FlutterFlowTheme.bodyText2
                                          .override(
                                              fontFamily: 'Montserrat',
                                              color: Colors.black,
                                              fontWeight: FontWeight.w500,
                                              fontSize: 12),
                                      enabledBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Colors.transparent,
                                          width: 1,
                                        ),
                                        borderRadius: const BorderRadius.only(
                                          topLeft: Radius.circular(4.0),
                                          topRight: Radius.circular(4.0),
                                        ),
                                      ),
                                      focusedBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Colors.transparent,
                                          width: 1,
                                        ),
                                        borderRadius: const BorderRadius.only(
                                          topLeft: Radius.circular(4.0),
                                          topRight: Radius.circular(4.0),
                                        ),
                                      ),
                                    ),
                                    style: FlutterFlowTheme.bodyText2.override(
                                        fontFamily: 'Montserrat',
                                        color: Color(0xFF8B97A2),
                                        fontWeight: FontWeight.w500,
                                        fontSize: 13),
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  15, 10, 30, 10),
                              child: InkWell(
                                  onTap: () async {
                                    if (!edit) {
                                      List exp = [];
                                      exp.add(expenseHead.text);

                                      FirebaseFirestore.instance
                                          .collection('expenseHead')
                                          .doc(currentBranchId)
                                          .update({
                                        'expenseHead':
                                            FieldValue.arrayUnion(exp),
                                        '${expenseHead.text}': 0,
                                      });
                                    } else {
                                      var currentHeadValue;
                                      currentList[currentListIndex] =
                                          expenseHead.text;

                                      //get Current head Value
                                      DocumentSnapshot doc =
                                          await FirebaseFirestore.instance
                                              .collection('expenseHead')
                                              .doc(currentBranchId)
                                              .get();
                                      FirebaseFirestore.instance
                                          .collection('expenseHead')
                                          .doc(currentBranchId)
                                          .update({
                                        'expenseHead': currentList,
                                        '${expenseHead.text}':
                                            doc['$currentValue'],
                                        '$currentValue': FieldValue.delete()
                                      });
                                    }

                                    setState(() {
                                      edit = false;
                                      expenseHead.clear();
                                    });
                                  },
                                  child: Container(
                                    width: MediaQuery.of(context).size.width *
                                        0.05,
                                    height: 40,
                                    decoration: BoxDecoration(
                                        color: Color(0xff0054FF),
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    child: Center(
                                        child: Text(
                                      edit ? 'Update' : 'Add',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold),
                                    )),
                                  )),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(30, 10, 30, 10),
                  child: StreamBuilder<DocumentSnapshot>(
                      stream: FirebaseFirestore.instance
                          .collection('expenseHead')
                          .doc(currentBranchId)
                          .snapshots(),
                      builder: (context, snapshot) {
                        if (!snapshot.hasData) {
                          return Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                        List data = snapshot.data!['expenseHead'];
                        currentList = data;
                        return SizedBox(
                          width: MediaQuery.of(context).size.width * 0.7,
                          child: DataTable(
                            horizontalMargin: 10,
                            columnSpacing: 20,
                            columns: [
                              DataColumn(
                                label: Text(
                                  "S.Id ",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 11),
                                ),
                              ),
                              DataColumn(
                                label: Text(
                                  "expense Head",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 11),
                                ),
                              ),
                              DataColumn(
                                label: Text(
                                  "Action",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 11),
                                ),
                              ),
                            ],
                            rows: List.generate(
                              data.length,
                              (index) {
                                return DataRow(
                                  color: index.isOdd
                                      ? MaterialStateProperty.all(Colors
                                          .blueGrey.shade50
                                          .withOpacity(0.7))
                                      : MaterialStateProperty.all(
                                          Colors.blueGrey.shade50),
                                  cells: [
                                    DataCell(Container(
                                      width: MediaQuery.of(context).size.width *
                                          0.05,
                                      child: SelectableText(
                                        '${(index + 1).toString()}',
                                        style:
                                            FlutterFlowTheme.bodyText2.override(
                                          fontFamily: 'Lexend Deca',
                                          color: Colors.black,
                                          fontSize: 11,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    )),
                                    DataCell(Container(
                                      width: MediaQuery.of(context).size.width *
                                          0.1,
                                      child: SelectableText(
                                        data[index],
                                        style:
                                            FlutterFlowTheme.bodyText2.override(
                                          fontFamily: 'Lexend Deca',
                                          color: Colors.black,
                                          fontSize: 11,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    )),
                                    DataCell(
                                      Row(
                                        children: [
                                          FFButtonWidget(
                                            onPressed: () {
                                              expenseHead.text = data[index];
                                              currentValue = data[index];
                                              setState(() {
                                                edit = true;
                                                currentListIndex = index;
                                              });
                                            },
                                            text: 'Edit',
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
                                  ],
                                );
                              },
                            ),
                          ),
                        );
                      }))
            ],
          ),
        ),
      ),
    );
  }
}
