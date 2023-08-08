import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:excel/excel.dart' as ex;
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lottie/lottie.dart';
import 'package:intl/intl.dart';
import 'package:month_picker_dialog/month_picker_dialog.dart';

import '../../../flutter_flow/flutter_flow_drop_down.dart';
import '../../../flutter_flow/flutter_flow_icon_button.dart';
import '../../../flutter_flow/flutter_flow_theme.dart';
import '../../../flutter_flow/flutter_flow_util.dart';
import '../../../flutter_flow/upload_media.dart';
import '../../app_widget.dart';

import 'package:universal_html/html.dart' as html;

import '../../pages/home_page/home.dart';

class Reports extends StatefulWidget {
  const Reports({Key? key}) : super(key: key);

  @override
  _ReportsState createState() => _ReportsState();
}

class _ReportsState extends State<Reports> {
  List payments = [];
  String dropdownValue = '';

  getPaymentDetails(Timestamp from, Timestamp to) async {
    await FirebaseFirestore.instance
        .collection('projects')
        .where('branchId', isEqualTo: currentBranchId)
        .snapshots()
        .listen((event) {
      var student = event.docs;
      payments = [];
      for (var doc in student) {
        List data = doc['paymentDetails'];
        for (int i = 0; i < data.length; i++) {
          if (data[i]['datePaid'].toDate().isAfter(from.toDate()) &&
              data[i]['datePaid'].toDate().isBefore(to.toDate())) {
            if (data[i]['paymentMethod'] == 'Cash' && dropdownValue == 'Cash') {
              Map value = {};
              value = doc.data();
              print('|||||||||||||||||||||${data[i]['amount']}');
              value['amount'] = data[i]['amount'];
              value['paidDate'] = data[i]['datePaid'];
              value['modeOfPayment'] = data[i]['paymentMethod'];
              payments.add(value);
            } else if (data[i]['paymentMethod'] == 'Bank' &&
                dropdownValue == 'Bank') {
              Map value = {};
              value = doc.data();
              print('|||||||||||||||||||||${data[i]['feepaid']}');
              value['amount'] = data[i]['amount'];
              value['paidDate'] = data[i]['datePaid'];
              value['modeOfPayment'] = data[i]['paymentMethod'];
              payments.add(value);
            } else if (dropdownValue == '') {
              Map value = {};
              value = doc.data();
              print('|||||||||||||||||||||${data[i]['amount']}');
              value['amount'] = data[i]['amount'];
              value['paidDate'] = data[i]['datePaid'];
              value['modeOfPayment'] = data[i]['paymentMethod'];
              payments.add(value);
            }
          }
        }
      }

      print(payments.toString());
      if (mounted) {
        setState(() {});
      }
    });
  }

  late DateTime today;
  late DateTime fromDate;
  late DateTime toDate;
  late DateTime lastDate;

  int i = 0;

  Future<void> importData() async {
    var excel = ex.Excel.createExcel();

    ex.Sheet sheetObject = excel['sales'];
    ex.CellStyle cellStyle = ex.CellStyle(
        // backgroundColorHex: "#1AFF1A",
        fontFamily: ex.getFontFamily(ex.FontFamily.Calibri));

    //HEADINGS

    if (payments.length > 0) {
      var cell1 = sheetObject.cell(ex.CellIndex.indexByString("A1"));
      cell1.value = 'SL NO';
      cell1.cellStyle = cellStyle;
      var cell2 = sheetObject.cell(ex.CellIndex.indexByString("B1"));
      cell2.value = 'CUSTOMER ID'; // dynamic values support provided;
      cell2.cellStyle = cellStyle;
      var cell3 = sheetObject.cell(ex.CellIndex.indexByString("C1"));
      cell3.value = 'DATE'; // dynamic values support provided;
      cell3.cellStyle = cellStyle;
      var cell4 = sheetObject.cell(ex.CellIndex.indexByString("D1"));
      cell4.value = 'NAME'; // dynamic values support provided;
      cell4.cellStyle = cellStyle;
      var cell5 = sheetObject.cell(ex.CellIndex.indexByString("E1"));
      cell5.value = 'PROJECT NAME'; // dynamic values support provided;
      cell5.cellStyle = cellStyle;
      var cell6 = sheetObject.cell(ex.CellIndex.indexByString("F1"));
      cell6.value = 'MOBILE'; // dynamic values support provided;
      cell6.cellStyle = cellStyle;
      var cell7 = sheetObject.cell(ex.CellIndex.indexByString("G1"));
      cell7.value = 'MODE OF PAYMENT'; // dynamic values support provided;
      cell7.cellStyle = cellStyle;
      var cell8 = sheetObject.cell(ex.CellIndex.indexByString("H1"));
      cell8.value = 'AMOUNT'; // dynamic values support provided;
      cell8.cellStyle = cellStyle;
    }

    print(payments.length);

    //CELL VALUES

    for (int i = 0; i < payments.length; i++) {
      var cell1 = sheetObject.cell(ex.CellIndex.indexByString("A${i + 2}"));
      cell1.value = '${i + 1}'; // dynamic values support provided;
      cell1.cellStyle = cellStyle;
      var cell2 = sheetObject.cell(ex.CellIndex.indexByString("B${i + 2}"));
      cell2.value = payments[i]['customerID']
          .toString(); // dynamic values support provided;
      cell2.cellStyle = cellStyle;
      var cell3 = sheetObject.cell(ex.CellIndex.indexByString("C${i + 2}"));
      cell3.value = dateTimeFormat('d-MMM-y',
          payments[i]['paidDate'].toDate()); // dynamic values support provided;
      cell3.cellStyle = cellStyle;
      var cell4 = sheetObject.cell(ex.CellIndex.indexByString("D${i + 2}"));
      cell4.value = payments[i]['name']; // dynamic values support provided;
      cell4.cellStyle = cellStyle;
      var cell5 = sheetObject.cell(ex.CellIndex.indexByString("E${i + 2}"));
      cell5.value =
          payments[i]['projectName']; // dynamic values support provided;
      cell5.cellStyle = cellStyle;
      var cell6 = sheetObject.cell(ex.CellIndex.indexByString("F${i + 2}"));
      cell6.value = payments[i]['mobile']; // dynamic values support provided;
      cell6.cellStyle = cellStyle;
      var cell7 = sheetObject.cell(ex.CellIndex.indexByString("G${i + 2}"));
      cell7.value = payments[i]['modeOfPayment']
          .toString(); // dynamic values support provided;
      cell7.cellStyle = cellStyle;
      var cell8 = sheetObject.cell(ex.CellIndex.indexByString("H${i + 2}"));
      cell8.value =
          payments[i]['amount'].toString(); // dynamic values support provided;
      cell8.cellStyle = cellStyle;

      print("hereeee");

      print(payments[i]['studentId'].toString());
    }

    excel.setDefaultSheet('sales');
    var fileBytes = excel.encode();

    final content = base64Encode(fileBytes!);
    final anchor = html.AnchorElement(
        href: "data:application/octet-stream;charset=utf-16le;base64,$content")
      ..setAttribute(
          "download", "${DateTime.now().toString().substring(0, 10)}.xlsx")
      ..click();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    today = DateTime.now();
    fromDate = DateTime(today.year, today.month, 01, 0, 0, 0);
    lastDate = DateTime(today.year, today.month + 1, 0, 23, 59, 59);
    print('---------------------Last Day------------------');
    print(lastDate);
    toDate = DateTime(
        fromDate.year, fromDate.month + 1, fromDate.day - 1, 23, 59, 59);

    getPaymentDetails(Timestamp.fromDate(fromDate), Timestamp.fromDate(toDate));
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                SizedBox(
                  width: 30,
                ),
                Text(
                  "Reports",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 40,
            ),
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                //FROM DATE
                TextButton(
                  onPressed: () {
                    showDatePicker(
                            context: context,
                            initialDate: fromDate,
                            firstDate: DateTime(1901, 1),
                            lastDate: lastDate)
                        .then((value) {
                      setState(() {
                        if (value != null) {
                          fromDate = value;
                        }
                      });
                    });
                  },
                  child: Text(
                    dateTimeFormat('dd-MM-yyyy', fromDate).toString(),
                    style: FlutterFlowTheme.bodyText1.override(
                      fontFamily: 'Poppins',
                      color: Colors.blue,
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),

                Text(
                  'To',
                  style: FlutterFlowTheme.bodyText1.override(
                    fontFamily: 'Poppins',
                  ),
                ),

                //TODATE
                TextButton(
                    onPressed: () {
                      showDatePicker(
                              context: context,
                              initialDate: toDate,
                              firstDate: DateTime(1901, 1),
                              lastDate: lastDate)
                          .then((value) {
                        setState(() {
                          toDate = DateTime(
                              value!.year, value!.month, value!.day, 23, 59, 59);
                        });
                      });
                    },
                    child: Text(
                      dateTimeFormat('dd-MM-yyyy', toDate).toString(),
                      style: FlutterFlowTheme.bodyText1.override(
                        fontFamily: 'Poppins',
                        color: Colors.blue,
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                      ),
                    )),

                //SEARCH ICON BUTTON
                FlutterFlowIconButton(
                  borderColor: Colors.transparent,
                  borderRadius: 30,
                  borderWidth: 1,
                  buttonSize: 50,
                  icon: const FaIcon(
                    FontAwesomeIcons.search,
                    color: Colors.black,
                    size: 30,
                  ),
                  onPressed: () async {
                    if (fromDate != null && toDate != null) {
                      print('pressed');
                      getPaymentDetails(Timestamp.fromDate(fromDate),
                          Timestamp.fromDate(toDate));
                      print('pressed1');
                    } else {
                      fromDate == null
                          ? showUploadMessage(
                              context, 'Please Choose Starting Date')
                          : showUploadMessage(
                              context, 'Please Choose Ending Date');
                    }
                  },
                ),

                //MONTH CALENDER
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.05,
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                            width: 1,
                            color: Colors.black,
                          ),
                        ),
                        child: FlutterFlowIconButton(
                          borderColor: Colors.transparent,
                          borderRadius: 30,
                          borderWidth: 1,
                          buttonSize: 50,
                          icon: const Icon(
                            Icons.arrow_back_ios_new_outlined,
                            color: Colors.blue,
                          ),
                          onPressed: () async {
                            setState(() {
                              fromDate = DateTime(fromDate.year,
                                  fromDate.month - 1, fromDate.day);

                              toDate = DateTime(
                                  fromDate.year,
                                  fromDate.month + 1,
                                  fromDate.day - 1,
                                  23,
                                  59,
                                  59);
                            });

                            getPaymentDetails(Timestamp.fromDate(fromDate),
                                Timestamp.fromDate(toDate));
                          },
                        ),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.003,
                      ),
                      InkWell(
                        onTap: () {
                          showMonthPicker(
                            context: context,
                            firstDate: DateTime(DateTime.now().year - 100, 5),
                            lastDate: DateTime(DateTime.now().year + 100, 12),
                            initialDate: fromDate,

                            // confirmText: Text(
                            //   'Select',
                            //   style: TextStyle(fontWeight: FontWeight.bold),
                            // ),
                            // cancelText: Text('Cancel'),
                            // yearFirst: true,
                          ).then((date) {
                            if (date != null) {
                              setState(() {
                                fromDate = date;

                                toDate = DateTime(
                                    fromDate.year,
                                    fromDate.month + 1,
                                    fromDate.day - 1,
                                    23,
                                    59,
                                    59);
                              });

                              getPaymentDetails(Timestamp.fromDate(fromDate),
                                  Timestamp.fromDate(toDate));
                            }
                          });
                        },
                        child: Container(
                          width: MediaQuery.of(context).size.width * 0.1,
                          height: 50,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(
                              color: Colors.black,
                            ),
                          ),
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(left: 10),
                                  child: Text(dateTimeFormat('yMMM', fromDate),
                                      style: TextStyle(color: Colors.blue)),
                                )
                              ]),
                        ),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.003,
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                            width: 1,
                            color: Colors.black,
                          ),
                        ),
                        child: FlutterFlowIconButton(
                          borderColor: Colors.transparent,
                          borderRadius: 30,
                          borderWidth: 1,
                          buttonSize: 50,
                          icon: const Icon(
                            Icons.arrow_forward_ios_outlined,
                            color: Colors.blue,
                          ),
                          onPressed: () async {
                            setState(() {
                              fromDate = DateTime(fromDate.year,
                                  fromDate.month + 1, fromDate.day);

                              toDate = DateTime(
                                  fromDate.year,
                                  fromDate.month + 1,
                                  fromDate.day - 1,
                                  23,
                                  59,
                                  59);
                            });

                            getPaymentDetails(Timestamp.fromDate(fromDate),
                                Timestamp.fromDate(toDate));
                          },
                        ),
                      ),
                    ],
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    height: 60,
                    decoration: BoxDecoration(
                        color: Colors.grey[100],
                        borderRadius: BorderRadius.circular(10)),
                    width: MediaQuery.of(context).size.width * 0.2,
                    child: FlutterFlowDropDown(
                      hintText: 'Select payment Method',
                      initialOption: dropdownValue,
                      options: ['Cash', 'Bank'],
                      onChanged: (val) {
                        setState(() {
                          dropdownValue = val;
                          getPaymentDetails(Timestamp.fromDate(fromDate),
                              Timestamp.fromDate(toDate));
                        });
                      },
                      width: double.infinity,
                      height: 60,
                      textStyle: FlutterFlowTheme.bodyText1.override(
                        fontFamily: 'Poppins',
                        color: Color(0xFF14181B),
                        fontSize: 14,
                        fontWeight: FontWeight.normal,
                      ),
                      icon: Icon(
                        Icons.keyboard_arrow_down_rounded,
                        color: Color(0xFF57636C),
                        size: 15,
                      ),
                      fillColor: Colors.white,
                      elevation: 2,
                      borderColor: Color(0xFFB2B4B7),
                      borderWidth: 1,
                      borderRadius: 8,
                      margin: EdgeInsetsDirectional.fromSTEB(24, 4, 12, 4),
                      hidesUnderline: true,
                    ),
                  ),
                ),
              ],
            ),
            payments.length == 0
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
                            "Customer Id",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 12),
                          ),
                        ),
                        DataColumn(
                          label: Text("Date",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 12)),
                        ),
                        DataColumn(
                          label: Text("Project Name",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 12)),
                        ),
                        DataColumn(
                          label: Text("Mode Of Payment",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 12)),
                        ),
                        DataColumn(
                          label: Text("Amount",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 12)),
                        ),
                      ],
                      rows: List.generate(
                        payments.length,
                        (index) {
                          print(payments.length.toString());
                          String name =
                              projectDataById[payments[index]['projectId']]
                                  ['projectName'];
                          String mobile = payments[index]['mobile'];

                          return DataRow(
                            color: index.isOdd
                                ? MaterialStateProperty.all(
                                    Colors.blueGrey.shade50.withOpacity(0.7))
                                : MaterialStateProperty.all(
                                    Colors.blueGrey.shade50),
                            cells: [
                              DataCell(Text(
                                payments[index]['customerID'],
                                style: FlutterFlowTheme.bodyText2.override(
                                  fontFamily: 'Lexend Deca',
                                  color: Colors.black,
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                ),
                              )),
                              DataCell(Text(
                                dateTimeFormat('d-MMM-y',
                                        payments[index]['paidDate'].toDate())
                                    .toString(),
                                style: FlutterFlowTheme.bodyText2.override(
                                  fontFamily: 'Lexend Deca',
                                  color: Colors.black,
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                ),
                              )),
                              DataCell(Text(
                                name,
                                style: FlutterFlowTheme.bodyText2.override(
                                  fontFamily: 'Lexend Deca',
                                  color: Colors.black,
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                ),
                              )),

                              DataCell(Text(
                                payments[index]['modeOfPayment'].toString(),
                                style: FlutterFlowTheme.bodyText2.override(
                                  fontFamily: 'Lexend Deca',
                                  color: Colors.black,
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                ),
                              )),
                              DataCell(InkWell(
                                onTap: () {},
                                child: Text(
                                    payments[index]['amount'].toString() ??
                                        '0'),
                              )),

                              // DataCell(Text(fileInfo.size)),
                            ],
                          );
                        },
                      ),
                    ),
                  ),
            payments.length != 0
                ? Padding(
                    padding: const EdgeInsets.only(top: 15, left: 8),
                    child: TextButton(
                        child: const Text('Generate Excel'),
                        style: TextButton.styleFrom(
                          foregroundColor: Colors.white,
                          backgroundColor: Color(0xff0054FF),
                          disabledForegroundColor:
                              Colors.grey.withOpacity(0.38),
                        ),
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
                                      )
                                    ],
                                  );
                                });
                          }
                        }),
                  )
                : Container(),
          ],
        ),
      ),
    );
  }
}
