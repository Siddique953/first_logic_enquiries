import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:excel/excel.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:universal_html/html.dart' as html;
import 'package:intl/intl.dart';

import '../../../../flutter_flow/flutter_flow_drop_down.dart';

import '../../../../flutter_flow/flutter_flow_theme.dart';

import '../../../../flutter_flow/flutter_flow_util.dart';

import '../../../../flutter_flow/flutter_flow_widgets.dart';
import '../../../pages/home_page/home.dart';
import 'customerListPage.dart';

class CustomerStatement extends StatefulWidget {
  final TabController _tabController;
  const CustomerStatement({
    Key? key,
    required TabController tabController,
  })  : _tabController = tabController,
        super(key: key);

  @override
  State<CustomerStatement> createState() => _CustomerStatementState();
}

class _CustomerStatementState extends State<CustomerStatement> {
  static const _locale = 'HI';
  String _formatNumber(String s) =>
      NumberFormat.decimalPattern(_locale).format(int.parse(s));
  String get _currency =>
      NumberFormat.compactSimpleCurrency(locale: _locale, decimalDigits: 2)
          .currencySymbol;

  double debitTotal = 0;
  double creditTotal = 0;

  List statementData = [];
  List projectData = [];
  List serviceData = [];

  getProjectData() {
    print(customerId);
    FirebaseFirestore.instance
        .collection('projects')
        .where('customerID', isEqualTo: customerId)
        .snapshots()
        .listen((event) {
      projectData = [];

      for (var doc in event.docs) {
        print('2');
        projectData.add({
          'date': doc['date'],
          'particular': doc['projectName'],
          'credit': doc['projectCost'],
        });
        print('[[[[[[[[[[[[[2]]]]]]]]]]]]]');
        print('2');

        List data = doc['paymentDetails'];

        print('[[[[[[[[[[[[[[[[3]]]]]]]]]]]]]]]]');
        print('3');

        for (var item in data) {
          print('[[[[[[[[[[[[[[[[4]]]]]]]]]]]]]]]]');
          print('4');
          projectData.add({
            'date': item['datePaid'],
            'particular': item['description'],
            'debit': item['amount'],
          });
        }
      }

      if (mounted) {
        statementData = [];

        statementData.addAll(projectData);
        statementData.addAll(serviceData);

        statementData.sort((a, b) => a['date'].compareTo(b['date']));
        setState(() {});
      }
    });
  }

  getServiceData() {
    print(customerId);
    FirebaseFirestore.instance
        .collection('customerServices')
        .where('customerId', isEqualTo: customerId)
        .where('delete', isEqualTo: false)
        .snapshots()
        .listen((event) {
      serviceData = [];

      for (var doc in event.docs) {
        print('2');
        serviceData.add({
          'date': doc['serviceStartingDate'],
          'particular': doc['serviceName'],
          'credit': doc['serviceAmount'],
        });
        print('[[[[[[[[[[[[[2]]]]]]]]]]]]]');
        print('2');

        List data = doc['paymentDetails'];

        print('[[[[[[[[[[[[[[[[3]]]]]]]]]]]]]]]]');
        print('3');

        for (var item in data) {
          print('[[[[[[[[[[[[[[[[4]]]]]]]]]]]]]]]]');
          print('4');
          serviceData.add({
            'date': item['datePaid'],
            'particular': item['description'],
            'debit': item['amount'],
          });
        }
      }

      if (mounted) {
        statementData = [];

        statementData.addAll(projectData);
        statementData.addAll(serviceData);

        statementData.sort((a, b) => a['date'].compareTo(b['date']));
        setState(() {});
      }
    });
  }

  @override
  void initState() {
    super.initState();
    getProjectData();
    getServiceData();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    debitTotal = 0;

    creditTotal = 0;

    return Scaffold(
      backgroundColor: Color(0xFFECF0F5),
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
                        onPressed: () {
                          widget._tabController.animateTo(17);
                        },
                        icon: Icon(Icons.arrow_back_ios_new)),
                    Expanded(
                      child: Text(
                        'Statement of $customerName',
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
                          try {
                            importData();
                          } catch (e) {
                            print(e);

                             showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    title: Text('error'),
                                    content: Text(e.toString()),
                                    actions: <Widget>[
                                      ElevatedButton(
                                        child: new Text('ok'),
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                      ),
                                    ],
                                  );
                                });
                          }
                        },
                        text: 'Generate Excel',
                        options: FFButtonOptions(
                          width: 150,
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
                height: 30,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  //Cash Table
                  statementData.isEmpty
                      ? SizedBox(
                          child: Center(
                            child: Image.asset('assets/images/noDoc.gif'),
                          ),
                        )
                      : Padding(
                          padding:
                              EdgeInsetsDirectional.fromSTEB(30, 10, 30, 5),
                          child: SizedBox(
                            width: MediaQuery.of(context).size.width * 0.7,
                            child: DataTable(
                              border: TableBorder(
                                  verticalInside: BorderSide(
                                      color: Colors.black, width: 0.5),
                                  left: BorderSide(
                                      color: Colors.black, width: 0.5),
                                  bottom: BorderSide(
                                      color: Colors.black, width: 0.5),
                                  right: BorderSide(
                                      color: Colors.black, width: 0.5),
                                  top: BorderSide(
                                    color: Colors.black,
                                    width: 0.5,
                                  )),
                              columnSpacing: 20,
                              headingTextStyle: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                                color: Color(0xff0054FF),
                              ),
                              columns: [
                                DataColumn(
                                  label: Center(
                                    child: Text(
                                      "Date ",
                                    ),
                                  ),
                                ),
                                DataColumn(
                                  label: Center(
                                    child: Text(
                                      "Particulars",
                                    ),
                                  ),
                                ),
                                DataColumn(
                                  label: Center(
                                    child: Text(
                                      "Debit",
                                    ),
                                  ),
                                ),
                                DataColumn(
                                  label: Center(
                                    child: Text(
                                      "Credit",
                                    ),
                                  ),
                                ),
                                // DataColumn(
                                //   label: Center(
                                //     child: Text(
                                //       "Balance",
                                //     ),
                                //   ),
                                // ),
                              ],
                              rows: List.generate(
                                statementData.length + 2,
                                (index) {
                                  if (index < statementData.length) {
                                    debitTotal +=
                                        statementData[index]['debit'] ?? 0;

                                    creditTotal +=
                                        statementData[index]['credit'] ?? 0;

                                    // if (statementData[index]['debit'] == null) {
                                    //   balance += statementData[index]['credit'];
                                    // } else {
                                    //   balance -= statementData[index]['debit'];
                                    // }
                                  }

                                  return index == statementData.length
                                      ?
                                      //Index+1 Row
                                      DataRow(
                                          color: index.isOdd
                                              ? MaterialStateProperty.all(Colors
                                                  .blueGrey.shade50
                                                  .withOpacity(0.7))
                                              : MaterialStateProperty.all(
                                                  Colors.blueGrey.shade50),
                                          cells: [
                                            DataCell(
                                              Container(
                                                child: SelectableText(
                                                  '',
                                                  style: FlutterFlowTheme
                                                      .bodyText2
                                                      .override(
                                                    fontFamily: 'Lexend Deca',
                                                    color: Colors.black,
                                                    fontSize: 11,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            DataCell(
                                              Center(
                                                child: Text(
                                                  debitTotal > creditTotal
                                                      ? 'Payable (-)'
                                                      : 'Payable',
                                                  style: FlutterFlowTheme
                                                      .bodyText2
                                                      .override(
                                                    fontFamily: 'Lexend Deca',
                                                    color: Colors.black,
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            DataCell(
                                              SelectableText(
                                                debitTotal > creditTotal
                                                    ? ''
                                                    : _formatNumber(
                                                        (creditTotal -
                                                                debitTotal)
                                                            .toString()
                                                            .replaceAll(
                                                                ',', '')),
                                                // .toStringAsFixed(2),
                                                style: FlutterFlowTheme
                                                    .bodyText2
                                                    .override(
                                                  fontFamily: 'Lexend Deca',
                                                  color: Colors.black,
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ),
                                            DataCell(
                                              SelectableText(
                                                debitTotal > creditTotal
                                                    ? _formatNumber(
                                                        (debitTotal -
                                                                creditTotal)
                                                            .toString()
                                                            .replaceAll(
                                                                ',', ''))
                                                    : '',

                                                // .toStringAsFixed(2),
                                                style: FlutterFlowTheme
                                                    .bodyText2
                                                    .override(
                                                  fontFamily: 'Lexend Deca',
                                                  color: Colors.black,
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ),
                                          ],
                                        )
                                      : index == statementData.length + 1
                                          ?
                                          //Index+2 Row
                                          DataRow(
                                              color: index.isOdd
                                                  ? MaterialStateProperty.all(
                                                      Colors.blueGrey.shade50
                                                          .withOpacity(0.7))
                                                  : MaterialStateProperty.all(
                                                      Colors.blueGrey.shade50),
                                              cells: [
                                                DataCell(
                                                  Container(
                                                    child: SelectableText(
                                                      '',
                                                      style: FlutterFlowTheme
                                                          .bodyText2
                                                          .override(
                                                        fontFamily:
                                                            'Lexend Deca',
                                                        color: Colors.black,
                                                        fontSize: 11,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                DataCell(
                                                  Text(
                                                    '',
                                                    style: FlutterFlowTheme
                                                        .bodyText2
                                                        .override(
                                                      fontFamily: 'Lexend Deca',
                                                      color: Colors.black,
                                                      fontSize: 12,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                ),
                                                DataCell(
                                                  SelectableText(
                                                    debitTotal > creditTotal
                                                        ? _formatNumber(
                                                            debitTotal
                                                                .toString()
                                                                .replaceAll(
                                                                    ',', ''))
                                                        : _formatNumber(
                                                            creditTotal
                                                                .toString()
                                                                .replaceAll(
                                                                    ',', '')),
                                                    // .toStringAsFixed(2),
                                                    style: FlutterFlowTheme
                                                        .bodyText2
                                                        .override(
                                                      fontFamily: 'Lexend Deca',
                                                      color: Colors.black,
                                                      fontSize: 15,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                ),
                                                DataCell(
                                                  SelectableText(
                                                    debitTotal > creditTotal
                                                        ? _formatNumber(
                                                            debitTotal
                                                                .toString()
                                                                .replaceAll(
                                                                    ',', ''))
                                                        : _formatNumber(
                                                            creditTotal
                                                                .toString()
                                                                .replaceAll(
                                                                    ',', '')),
                                                    // .toStringAsFixed(2),
                                                    style: FlutterFlowTheme
                                                        .bodyText2
                                                        .override(
                                                      fontFamily: 'Lexend Deca',
                                                      color: Colors.black,
                                                      fontSize: 15,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            )
                                          : DataRow(
                                              color: index.isOdd
                                                  ? MaterialStateProperty.all(
                                                      Colors.blueGrey.shade50
                                                          .withOpacity(0.7))
                                                  : MaterialStateProperty.all(
                                                      Colors.blueGrey.shade50),
                                              cells: [
                                                DataCell(
                                                  Center(
                                                    child: SelectableText(
                                                      dateTimeFormat(
                                                          'd-MMM-y',
                                                          statementData[index]
                                                                  ['date']
                                                              .toDate()),
                                                      style: FlutterFlowTheme
                                                          .bodyText2
                                                          .override(
                                                        fontFamily:
                                                            'Lexend Deca',
                                                        color: Colors.black,
                                                        fontSize: 11,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                DataCell(
                                                  Container(
                                                    width:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width *
                                                            0.15,
                                                    child: Center(
                                                      child: Text(
                                                        statementData[index]
                                                            ['particular'],
                                                        style: FlutterFlowTheme
                                                            .bodyText2
                                                            .override(
                                                          fontFamily:
                                                              'Lexend Deca',
                                                          color: Colors.black,
                                                          fontSize: 12,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                DataCell(
                                                  Center(
                                                    child: SelectableText(
                                                      statementData[index]
                                                                  ['debit'] ==
                                                              null
                                                          ? ''
                                                          : _formatNumber(
                                                              statementData[
                                                                          index]
                                                                      ['debit']
                                                                  .toString()
                                                                  .replaceAll(
                                                                      ',', '')),
                                                      style: FlutterFlowTheme
                                                          .bodyText2
                                                          .override(
                                                        fontFamily:
                                                            'Lexend Deca',
                                                        color: Colors.black,
                                                        fontSize: 15,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                DataCell(
                                                  Center(
                                                    child: SelectableText(
                                                      statementData[index]
                                                                  ['credit'] ==
                                                              null
                                                          ? ''
                                                          : _formatNumber(
                                                              statementData[
                                                                          index]
                                                                      ['credit']
                                                                  .toString()
                                                                  .replaceAll(
                                                                      ',', '')),
                                                      style: FlutterFlowTheme
                                                          .bodyText2
                                                          .override(
                                                        fontFamily:
                                                            'Lexend Deca',
                                                        color: Colors.black,
                                                        fontSize: 15,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            );
                                },
                              ),
                            ),
                          ),
                        ),

                  SizedBox(
                    height: 30,
                  ),
                ],
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.1,
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<void> importData() async {
    var excel = Excel.createExcel();

    Sheet sheetObject = excel[customerName];
    CellStyle cellStyle = CellStyle(
        // backgroundColorHex: "#1AFF1A",
        fontFamily: getFontFamily(FontFamily.Calibri));

    //HEADINGS

    if (statementData.length > 0) {
      var cell1 = sheetObject.cell(CellIndex.indexByString("A1"));
      cell1.value = 'DATE';
      cell1.cellStyle = cellStyle;
      var cell2 = sheetObject.cell(CellIndex.indexByString("B1"));
      cell2.value = 'PARTICULARS'; // dynamic values support provided;
      cell2.cellStyle = cellStyle;
      var cell3 = sheetObject.cell(CellIndex.indexByString("C1"));
      cell3.value = 'DEBIT'; // dynamic values support provided;
      cell3.cellStyle = cellStyle;
      var cell4 = sheetObject.cell(CellIndex.indexByString("D1"));
      cell4.value = 'CREDIT'; // dynamic values support provided;
      cell4.cellStyle = cellStyle;
    }

    print(statementData.length);

    //CELL VALUES

    for (int i = 0; i < statementData.length + 1; i++) {
      if (i < statementData.length) {
        var cell1 = sheetObject.cell(CellIndex.indexByString("A${i + 2}"));
        cell1.value = dateTimeFormat(
            'dd MMM, yyyy',
            statementData[i]['date']
                .toDate()); // dynamic values support provided;
        cell1.cellStyle = cellStyle;
        var cell2 = sheetObject.cell(CellIndex.indexByString("B${i + 2}"));
        cell2.value = statementData[i]['particular']
            .toString(); // dynamic values support provided;
        cell2.cellStyle = cellStyle;
        var cell3 = sheetObject.cell(CellIndex.indexByString("C${i + 2}"));
        cell3.value =
            statementData[i]['debit']; // dynamic values support provided;
        cell3.cellStyle = cellStyle;
        var cell4 = sheetObject.cell(CellIndex.indexByString("D${i + 2}"));
        cell4.value =
            statementData[i]['credit']; // dynamic values support provided;
        cell4.cellStyle = cellStyle;
      } else {
        var cell1 = sheetObject.cell(CellIndex.indexByString("A${i + 2}"));
        cell1.value = ''; // dynamic values support provided;
        cell1.cellStyle = cellStyle;
        var cell2 = sheetObject.cell(CellIndex.indexByString("B${i + 2}"));
        cell2.value = ''; // dynamic values support provided;
        cell2.cellStyle = cellStyle;
        var cell3 = sheetObject.cell(CellIndex.indexByString("C${i + 2}"));
        cell3.value = debitTotal; // dynamic values support provided;
        cell3.cellStyle = cellStyle;
        var cell4 = sheetObject.cell(CellIndex.indexByString("D${i + 2}"));
        cell4.value = creditTotal; // dynamic values support provided;
        cell4.cellStyle = cellStyle;
      }
    }

    excel.setDefaultSheet(customerName);
    var fileBytes = excel.encode();

    final content = base64Encode(fileBytes!);
    final anchor = html.AnchorElement(
        href: "data:application/octet-stream;charset=utf-16le;base64,$content")
      ..setAttribute(
          "download", "${DateTime.now().toString().substring(0, 10)}.xlsx")
      ..click();
  }
}
