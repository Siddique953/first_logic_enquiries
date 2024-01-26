import 'dart:convert';
import 'dart:io';

import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:excel/excel.dart' as ex;
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:month_picker_dialog/month_picker_dialog.dart';
import 'package:universal_html/html.dart' as html;

import '../../../flutter_flow/flutter_flow_icon_button.dart';
import '../../../flutter_flow/flutter_flow_theme.dart';
import '../../../flutter_flow/flutter_flow_util.dart';
import '../../../flutter_flow/upload_media.dart';
import '../../app_widget.dart';
import '../../pages/home_page/home.dart';

class ExpenseReport extends StatefulWidget {
  const ExpenseReport({Key? key}) : super(key: key);

  @override
  State<ExpenseReport> createState() => _ExpenseReportState();
}

class _ExpenseReportState extends State<ExpenseReport> {
  static const _locale = 'HI';
  String _formatNumber(String s) =>
      NumberFormat.decimalPattern(_locale).format(int.parse(s));
  String get _currency =>
      NumberFormat.compactSimpleCurrency(locale: _locale, decimalDigits: 2)
          .currencySymbol;

  late TextEditingController expenseHead;

  List payments = [];
  List todayPayment = [];
  List feeList = [];
  String dropdownValue = '';
  List expenses = [];
  double totalExp=0;
  // bool sort;

  getExpenseDetails(Timestamp from, Timestamp to) async {
    await FirebaseFirestore.instance
        .collection('expense')
        .where('branchId', isEqualTo: currentBranchId)
        .orderBy('date', descending: false)
        .snapshots()
        .listen((event) {
      var expense = event.docs;
      expenses = [];
      List data = [];
      totalExp = 0;
      for (var doc in expense) {
        data.add(doc.data());
      }
      for (int i = 0; i < data.length; i++) {
        if (data[i]['date'].toDate().isAfter(from.toDate()) &&
            data[i]['date'].toDate().isBefore(to.toDate())) {
          // var head = data[i]['particular'].toString().toLowerCase();
          if (data[i]['particular'].toString().toLowerCase() ==
              dropdownValue.toLowerCase()) {
            expenses.add(data[i]);
            double exp = double.tryParse(data[i]['amount'].toString())!;
            totalExp += exp;
          } else if (dropdownValue == 'All' || dropdownValue == '') {
            expenses.add(data[i]);
            double exp = double.tryParse(data[i]['amount'].toString())!;
            totalExp += exp;
          }
        }
      }

      print(dropdownValue);
      if (mounted) {
        setState(() {});
      }
    });
  }

  late DateTime today;
  late DateTime fromDate;
  late DateTime toDate;
  late DateTime lastDate;
  List<String> currentHeadList = [];

  int i = 0;

  Future<void> importData() async {
    var excel = ex.Excel.createExcel();

    ex.Sheet sheetObject = excel['Expenses'];
    ex.CellStyle cellStyle = ex.CellStyle(
        verticalAlign: ex.VerticalAlign.Center,
        horizontalAlign: ex.HorizontalAlign.Center,
        // backgroundColorHex: "#1AFF1A",
        fontFamily: ex.getFontFamily(ex.FontFamily.Calibri));
    ex.CellStyle totalStyle = ex.CellStyle(
        fontFamily: ex.getFontFamily(ex.FontFamily.Calibri),
        fontSize: 16,
        bold: true);

    //HEADINGS

    if (expenses.length > 0) {
      var cell1 = sheetObject.cell(ex.CellIndex.indexByString("A1"));
      cell1.value = 'SL NO';
      cell1.cellStyle = cellStyle;
      var cell2 = sheetObject.cell(ex.CellIndex.indexByString("B1"));
      cell2.value = 'Date'; // dynamic values support provided;
      cell2.cellStyle = cellStyle;
      var cell3 = sheetObject.cell(ex.CellIndex.indexByString("C1"));
      cell3.value = 'Particular'; // dynamic values support provided;
      cell3.cellStyle = cellStyle;
      var cell4 = sheetObject.cell(ex.CellIndex.indexByString("D1"));
      cell4.value = 'Amount'; // dynamic values support provided;
      cell4.cellStyle = cellStyle;
    }


    //CELL VALUES

    for (int i = 0; i <= expenses.length; i++) {
      if (i == expenses.length) {
        var cell3 = sheetObject.cell(ex.CellIndex.indexByString("C${i + 3}"));
        cell3.value = 'Total Expenses '; // dynamic values support provided;
        cell3.cellStyle = totalStyle;

        var cell4 = sheetObject.cell(ex.CellIndex.indexByString("D${i + 3}"));
        cell4.value = totalExp; // dynamic values support provided;
        cell4.cellStyle = totalStyle;
      } else {
        var cell1 = sheetObject.cell(ex.CellIndex.indexByString("A${i + 2}"));
        cell1.value = '${i + 1}'; // dynamic values support provided;
        cell1.cellStyle = cellStyle;
        var cell2 = sheetObject.cell(ex.CellIndex.indexByString("B${i + 2}"));
        cell2.value = dateTimeFormat('d-MMM-y',
            expenses[i]['date'].toDate()); // dynamic values support provided;
        cell2.cellStyle = cellStyle;
        var cell3 = sheetObject.cell(ex.CellIndex.indexByString("C${i + 2}"));
        cell3.value =
            expenses[i]['particular']; // dynamic values support provided;
        cell3.cellStyle = cellStyle;
        var cell4 = sheetObject.cell(ex.CellIndex.indexByString("D${i + 2}"));
        cell4.value = expenses[i]['amount']; // dynamic values support provided;
        cell4.cellStyle = cellStyle;
        // var cell5 = sheetObject.cell(CellIndex.indexByString("E${i + 2}"));
        // cell5.value =
        //     payments[i]['projectName']; // dynamic values support provided;
        // cell5.cellStyle = cellStyle;
        // var cell6 = sheetObject.cell(CellIndex.indexByString("F${i + 2}"));
        // cell6.value = payments[i]['mobile']; // dynamic values support provided;
        // cell6.cellStyle = cellStyle;
        // var cell7 = sheetObject.cell(CellIndex.indexByString("G${i + 2}"));
        // cell7.value = payments[i]['modeOfPayment']
        //     .toString(); // dynamic values support provided;
        // cell7.cellStyle = cellStyle;
        // var cell8 = sheetObject.cell(CellIndex.indexByString("H${i + 2}"));
        // cell8.value =
        //     payments[i]['amount'].toString(); // dynamic values support provided;
        // cell8.cellStyle = cellStyle;
      }
    }

    excel.setDefaultSheet('Expenses');
    var fileBytes = excel.encode();
    File file;

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

    // sort = false;

    expenseHead = TextEditingController();
    today = DateTime.now();

    fromDate = DateTime(today.year, today.month, 01, 0, 0, 0);
    lastDate = DateTime(today.year, today.month + 1, 0, 23, 59, 59);
    toDate = DateTime(
        fromDate.year, fromDate.month + 1, fromDate.day - 1, 23, 59, 59);

    getExpenseDetails(Timestamp.fromDate(fromDate), Timestamp.fromDate(toDate));

    headList();
  }

  headList() {
    currentHeadList = ['All'];
    for (int i = 0; i < expHeadList.length; i++) {
      currentHeadList.add(expHeadList[i]);
    }
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
                  "Expense Reports",
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
                    dateTimeFormat('dd-MM-yyyy', fromDate),
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

                //TO DATE
                TextButton(
                    onPressed: () {
                      showDatePicker(
                              context: context,
                              initialDate: toDate,
                              firstDate: DateTime(1901, 1),
                              lastDate: lastDate)
                          .then((value) {
                        if(value!=null){
                          setState(() {
                            toDate = DateTime(
                                value.year, value.month, value.day, 23, 59, 59);
                          });
                        }
                      });
                    },
                    child: Text(
                      dateTimeFormat('dd-MM-yyyy', toDate),
                      style: FlutterFlowTheme.bodyText1.override(
                        fontFamily: 'Poppins',
                        color: Colors.blue,
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                      ),
                    )),

                //Search Icon
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
                      getExpenseDetails(Timestamp.fromDate(fromDate),
                          Timestamp.fromDate(toDate));
                      // sort = true;
                    } else {
                      fromDate == null
                          ? showUploadMessage(
                              context, 'Please Choose Starting Date')
                          : showUploadMessage(
                              context, 'Please Choose Ending Date');
                    }
                  },
                ),

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
                            getExpenseDetails(Timestamp.fromDate(fromDate),
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

                              getExpenseDetails(Timestamp.fromDate(fromDate),
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
                            getExpenseDetails(Timestamp.fromDate(fromDate),
                                Timestamp.fromDate(toDate));
                          },
                        ),
                      ),
                    ],
                  ),
                ),

                //EXPENSE HEAD
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
                        items: currentHeadList,

                        // excludeSelected: false,

                        controller: expenseHead,
                        onChanged: (val) {
                          setState(() {
                            dropdownValue = val;
                            getExpenseDetails(Timestamp.fromDate(fromDate),
                                Timestamp.fromDate(toDate));
                            // sort = true;
                          });
                        },
                      ),
                    ),
                  ),
                ),
              ],
            ),
            //Expense List
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(30, 10, 30, 5),
              child: expenses.length == 0
                  ? LottieBuilder.network(
                      'https://assets9.lottiefiles.com/packages/lf20_HpFqiS.json',
                      height: 500,
                    )
                  : SizedBox(
                      width: MediaQuery.of(context).size.width * 0.7,
                      child: DataTable(
                        horizontalMargin: 10,
                        columnSpacing: 20,
                        columns: [
                          DataColumn(
                            label: Text(
                              "Sl.No ",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 11),
                            ),
                          ),
                          DataColumn(
                            label: Text(
                              "Date",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 11),
                            ),
                          ),
                          DataColumn(
                            label: Text(
                              "Particular",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 11),
                            ),
                          ),
                          DataColumn(
                            label: Text(
                              "Amount",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 11),
                            ),
                          ),
                        ],
                        rows: List.generate(
                          expenses.length + 1,
                          (index) {
                            return index == expenses.length
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
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.05,
                                          child: SelectableText(
                                            '',
                                            style: FlutterFlowTheme.bodyText2
                                                .override(
                                              fontFamily: 'Lexend Deca',
                                              color: Colors.black,
                                              fontSize: 11,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                      ),
                                      DataCell(Text(
                                        '',
                                        style:
                                            FlutterFlowTheme.bodyText2.override(
                                          fontFamily: 'Lexend Deca',
                                          color: Colors.black,
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      )),
                                      DataCell(Container(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.1,
                                        child: SelectableText(
                                          'Total Expenses',
                                          style: FlutterFlowTheme.bodyText2
                                              .override(
                                            fontFamily: 'Lexend Deca',
                                            color: Colors.black,
                                            fontSize: 17,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      )),
                                      DataCell(Container(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.1,
                                        child: SelectableText(
                                          _formatNumber(totalExp
                                              .truncate()
                                              .toString()
                                              .replaceAll(',', '')),
                                          style: FlutterFlowTheme.bodyText2
                                              .override(
                                            fontFamily: 'Lexend Deca',
                                            color: Colors.black,
                                            fontSize: 11,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      )),
                                    ],
                                  )
                                :
                                //Index Row
                                DataRow(
                                    color: index.isOdd
                                        ? MaterialStateProperty.all(Colors
                                            .blueGrey.shade50
                                            .withOpacity(0.7))
                                        : MaterialStateProperty.all(
                                            Colors.blueGrey.shade50),
                                    cells: [
                                      DataCell(Container(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.05,
                                        child: SelectableText(
                                          '${(index + 1).toString()}',
                                          style: FlutterFlowTheme.bodyText2
                                              .override(
                                            fontFamily: 'Lexend Deca',
                                            color: Colors.black,
                                            fontSize: 11,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      )),
                                      DataCell(Text(
                                        dateTimeFormat('d-MMM-y',
                                            expenses[index]['date'].toDate()),
                                        style:
                                            FlutterFlowTheme.bodyText2.override(
                                          fontFamily: 'Lexend Deca',
                                          color: Colors.black,
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      )),
                                      DataCell(Container(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.1,
                                        child: SelectableText(
                                          expenses[index]['particular'],
                                          style: FlutterFlowTheme.bodyText2
                                              .override(
                                            fontFamily: 'Lexend Deca',
                                            color: Colors.black,
                                            fontSize: 11,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      )),
                                      DataCell(Container(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.1,
                                        child: SelectableText(
                                          _formatNumber(expenses[index]
                                                  ['amount']
                                              .toString()
                                              .replaceAll(',', '')),
                                          style: FlutterFlowTheme.bodyText2
                                              .override(
                                            fontFamily: 'Lexend Deca',
                                            color: Colors.black,
                                            fontSize: 11,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      )),
                                    ],
                                  );
                          },
                        ),
                      ),
                    ),
            ),

            expenses.length != 0
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 15, left: 30),
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
                      ),
                    ],
                  )
                : Container(),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.1,
            ),

            SizedBox(
              height: MediaQuery.of(context).size.height * 0.1,
            ),
          ],
        ),
      ),
    );
  }
}
