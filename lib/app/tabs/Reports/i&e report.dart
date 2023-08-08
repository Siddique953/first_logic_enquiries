import 'dart:convert';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:month_picker_dialog/month_picker_dialog.dart';
import 'package:month_year_picker/month_year_picker.dart';
import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:excel/excel.dart' as ex;
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import '../../../auth/auth_util.dart';
import 'package:universal_html/html.dart' as html;
import '../../../flutter_flow/flutter_flow_icon_button.dart';
import '../../../flutter_flow/flutter_flow_theme.dart';
import '../../../flutter_flow/flutter_flow_util.dart';
import '../../../flutter_flow/upload_media.dart';
import '../../app_widget.dart';
import '../../pages/home_page/home.dart';

class FirmReport extends StatefulWidget {
  const FirmReport({Key? key}) : super(key: key);

  @override
  State<FirmReport> createState() => _FirmReportState();
}

class _FirmReportState extends State<FirmReport> {
  static const _locale = 'HI';
  String _formatNumber(String s) =>
      NumberFormat.decimalPattern(_locale).format(int.parse(s));
  String get _currency =>
      NumberFormat.compactSimpleCurrency(locale: _locale, decimalDigits: 2)
          .currencySymbol;

  late TextEditingController amount;
  late TextEditingController narration;
  late TextEditingController expenseHead;
  late Timestamp expenseDate;
  DateTime? today;

  DateTime fromDate = DateTime.now();
  DateTime toDate = DateTime.now();
  DateTime lastDate = DateTime.now();
  DateTime paymentDate = DateTime.now();

  //Radio Button Ingredients

  bool radioSelected1 = true;
  bool cash = false;
  bool bank = false;
  String radioVal = '';

  //Lists to store Table Values
  List expensesByCash = [];
  List expensesByBank = [];
  List paymentsToCash = [];
  List paymentsToBank = [];

  double totalExpInCash = 0;
  double totalExpInBank = 0;
  double totalPaymentInCash = 0;
  double totalPaymentInBank = 0;

  int cashTableLength = 0;
  int bankTableLength = 0;

  //BALANCES

  double cashInHand = 0;
  double cashAtBank = 0;

  getBalance() async {
    cashInHand = 0;
    cashAtBank = 0;

    DocumentSnapshot doc = await FirebaseFirestore.instance
        .collection('settings')
        .doc(currentBranchId)
        .get();
    cashInHand = double.tryParse(doc['cashInHand'].toString())!;
    cashAtBank = double.tryParse(doc['cashAtBank'].toString())!;

    if (mounted) {
      setState(() {
        print('---------------------BALANCE------------------------');
        print(cashInHand);
        print(cashAtBank);
      });
    }
  }

  getExpenseDetails(Timestamp from, Timestamp to) async {
    expensesByCash = [];
    await FirebaseFirestore.instance
        .collection('expense')
        .where('branchId', isEqualTo: currentBranchId)
        .orderBy('date', descending: false)
        .snapshots()
        .listen((event) {
      var expense = event.docs;
      expensesByCash = [];
      expensesByBank = [];
      List data = [];
      totalExpInBank = 0;
      totalExpInCash = 0;
      for (var doc in expense) {
        data.add(doc.data());
      }
      for (int i = 0; i < data.length; i++) {
        if (data[i]['date'].toDate().isAfter(from.toDate()) &&
            data[i]['date'].toDate().isBefore(to.toDate())) {
          if (data[i]['paymentMethode'] == 'Cash') {
            expensesByCash.add(data[i]);
            double exp = double.tryParse(data[i]['amount'].toString())!;
            totalExpInCash += exp;
          }
          if (data[i]['paymentMethode'] == 'Bank') {
            expensesByBank.add(data[i]);
            double exp = double.tryParse(data[i]['amount'].toString())!;
            totalExpInBank += exp;
          }
        }
      }

      print('EXPENSSSSSSSSSSSSSSSSSSSSS');
      print(expensesByBank);
      print(expensesByCash);
      if (mounted) {
        setState(() {});
      }
    });
  }

  getPaymentDetails(Timestamp from, Timestamp to) async {
    await FirebaseFirestore.instance
        .collection('projects')
        .where('branchId', isEqualTo: currentBranchId)
        .snapshots()
        .listen((event) {
      var student = event.docs;
      paymentsToCash = [];
      paymentsToBank = [];
      totalPaymentInBank = 0;
      totalPaymentInCash = 0;
      for (var doc in student) {
        List data = doc['paymentDetails'];
        for (int i = 0; i < data.length; i++) {
          if (data[i]['datePaid'].toDate().isAfter(from.toDate()) &&
              data[i]['datePaid'].toDate().isBefore(to.toDate())) {
            if (data[i]['paymentMethod'] == 'Cash') {
              Map value = {};
              // value = doc.data();

              value['amount'] = data[i]['amount'].toString();
              value['date'] = data[i]['datePaid'];

              value['paymentMethode'] = data[i]['paymentMethod'];
              value['projectName'] = data[i]['projectName'];

              value['description'] = data[i]['description'];
              value['projectId'] = data[i]['projectId'];

              paymentsToCash.add(value);

              double amt = double.tryParse(data[i]['amount'].toString())!;
              totalPaymentInCash += amt;
            } else if (data[i]['paymentMethod'] == 'Bank') {
              Map value = {};
              // value = doc.data();

              value['amount'] = data[i]['amount'].toString();
              value['date'] = data[i]['datePaid'];

              value['modeOfPayment'] = data[i]['paymentMethod'];
              value['projectName'] = data[i]['projectName'];

              value['description'] = data[i]['description'];
              value['projectId'] = data[i]['projectId'];

              paymentsToBank.add(value);

              double exp = double.tryParse(data[i]['amount'].toString())!;
              totalPaymentInBank += exp;
            }
          }
        }
      }
      print('PAYMENTSSSSSSSSSSSSSSSSSSSS');
      print(paymentsToBank);
      print(paymentsToCash);
      if (mounted) {
        setState(() {});
      }
    });
  }

  //EXCEL INVOICE

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

    if (expensesByCash.length > 0) {
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

    for (int i = 0; i <= expensesByCash.length; i++) {
      if (i == expensesByCash.length) {
        var cell3 = sheetObject.cell(ex.CellIndex.indexByString("C${i + 3}"));
        cell3.value = 'Total Expenses '; // dynamic values support provided;
        cell3.cellStyle = totalStyle;

        var cell4 = sheetObject.cell(ex.CellIndex.indexByString("D${i + 3}"));
        cell4.value = totalExpInBank; // dynamic values support provided;
        cell4.cellStyle = totalStyle;
      } else {
        var cell1 = sheetObject.cell(ex.CellIndex.indexByString("A${i + 2}"));
        cell1.value = '${i + 1}'; // dynamic values support provided;
        cell1.cellStyle = cellStyle;
        var cell2 = sheetObject.cell(ex.CellIndex.indexByString("B${i + 2}"));
        cell2.value = dateTimeFormat(
            'd-MMM-y',
            expensesByCash[i]['date']
                .toDate()); // dynamic values support provided;
        cell2.cellStyle = cellStyle;
        var cell3 = sheetObject.cell(ex.CellIndex.indexByString("C${i + 2}"));
        cell3.value =
            expensesByCash[i]['particular']; // dynamic values support provided;
        cell3.cellStyle = cellStyle;
        var cell4 = sheetObject.cell(ex.CellIndex.indexByString("D${i + 2}"));
        cell4.value =
            expensesByCash[i]['amount']; // dynamic values support provided;
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
    expensesByCash = [];
    amount = TextEditingController();
    narration = TextEditingController();
    expenseHead = TextEditingController();

    //Set FROM and TO date based on Today
    today = DateTime.now();

    fromDate = DateTime(today!.year, today!.month, 01, 0, 0, 0);
    lastDate = DateTime(today!.year, today!.month + 1, 0, 23, 59, 59);
    print('---------------------Last Day------------------');
    print(lastDate);
    toDate = DateTime(
        fromDate.year, fromDate.month + 1, fromDate.day - 1, 23, 59, 59);

    //Call current Month data initially
    getExpenseDetails(Timestamp.fromDate(fromDate), Timestamp.fromDate(toDate));
    getPaymentDetails(Timestamp.fromDate(fromDate), Timestamp.fromDate(toDate));

    //GetBalance
    getBalance();
  }

  @override
  void dispose() {
    super.dispose();
    expensesByCash = [];
  }

  @override
  Widget build(BuildContext context) {
    if (expensesByCash.length >= paymentsToCash.length) {
      cashTableLength = expensesByCash.length;
    }
    if (expensesByCash.length <= paymentsToCash.length) {
      cashTableLength = paymentsToCash.length;
    }
    if (expensesByBank.length >= paymentsToBank.length) {
      bankTableLength = expensesByBank.length;
    }
    if (expensesByBank.length <= paymentsToBank.length) {
      bankTableLength = paymentsToBank.length;
    }

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
                        'Income & Expenditure Report',
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
                        getExpenseDetails(Timestamp.fromDate(fromDate),
                            Timestamp.fromDate(toDate));
                        getPaymentDetails(Timestamp.fromDate(fromDate),
                            Timestamp.fromDate(toDate));
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
                          setState(() {
                            toDate = DateTime(
                                value!.year, value.month, value.day, 23, 59, 59);
                          });
                          getExpenseDetails(Timestamp.fromDate(fromDate),
                              Timestamp.fromDate(toDate));
                          getPaymentDetails(Timestamp.fromDate(fromDate),
                              Timestamp.fromDate(toDate));
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

                  // //Search Icon
                  // FlutterFlowIconButton(
                  //   borderColor: Colors.transparent,
                  //   borderRadius: 30,
                  //   borderWidth: 1,
                  //   buttonSize: 50,
                  //   icon: const FaIcon(
                  //     FontAwesomeIcons.search,
                  //     color: Colors.black,
                  //     size: 30,
                  //   ),
                  //   onPressed: () async {
                  //     if (fromDate != null && toDate != null) {
                  //       print('pressed');
                  //       getExpenseDetails(Timestamp.fromDate(fromDate),
                  //           Timestamp.fromDate(toDate));
                  //       // sort = true;
                  //       print('pressed1');
                  //     } else {
                  //       fromDate == null
                  //           ? showUploadMessage(
                  //               context, 'Please Choose Starting Date')
                  //           : showUploadMessage(
                  //               context, 'Please Choose Ending Date');
                  //     }
                  //   },
                  // ),

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
                              initialDate: toDate,

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

                                getExpenseDetails(Timestamp.fromDate(fromDate),
                                    Timestamp.fromDate(toDate));
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(left: 10),
                                    child: Text(
                                        dateTimeFormat('yMMM', fromDate),
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
                              getPaymentDetails(Timestamp.fromDate(fromDate),
                                  Timestamp.fromDate(toDate));
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                        right: MediaQuery.of(context).size.width * 0.05),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          'Cash in hand : ${_formatNumber(cashInHand.truncate().toString().replaceAll(',', ''))}',
                          style: TextStyle(
                              fontSize: 17, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          'Cash at Bank : ${_formatNumber(cashAtBank.truncate().toString().replaceAll(',', ''))}',
                          style: TextStyle(
                              fontSize: 17, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  )
                ],
              ),
              bankTableLength == 0 && cashTableLength == 0
                  ? LottieBuilder.network(
                      'https://assets9.lottiefiles.com/packages/lf20_HpFqiS.json',
                      height: 500,
                    )
                  : Column(
                      children: [
                        // Cash Heading
                        cashTableLength == 0
                            ? SizedBox()
                            : Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'Cash',
                                    style: TextStyle(
                                        fontSize: 22,
                                        fontWeight: FontWeight.bold),
                                  )
                                ],
                              ),

                        //DR & CR
                        cashTableLength == 0
                            ? SizedBox()
                            : Padding(
                                padding: EdgeInsets.fromLTRB(
                                    MediaQuery.of(context).size.width * 0.06,
                                    10,
                                    MediaQuery.of(context).size.width * 0.06,
                                    0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Dr.',
                                      style: TextStyle(
                                          fontSize: 17,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      'Cr.',
                                      style: TextStyle(
                                          fontSize: 17,
                                          fontWeight: FontWeight.bold),
                                    )
                                  ],
                                ),
                              ),

                        //Cash Table
                        cashTableLength == 0
                            ? SizedBox(
                                child: Center(
                                  child: Text(
                                      'There Is No Cash Transaction This Month.'),
                                ),
                              )
                            : Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    30, 10, 30, 5),
                                child: SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 0.7,
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
                                        label: Text(
                                          "Date ",
                                        ),
                                      ),
                                      DataColumn(
                                        label: Text(
                                          "Particulars",
                                        ),
                                      ),
                                      DataColumn(
                                        label: Icon(
                                            Icons.currency_rupee_outlined,
                                            size: 15,
                                            color: Color(0xff0054FF)),
                                      ),
                                      DataColumn(
                                        label: Text(
                                          "Date ",
                                        ),
                                      ),
                                      DataColumn(
                                        label: Text(
                                          "Particulars",
                                        ),
                                      ),
                                      DataColumn(
                                        label: Icon(
                                            Icons.currency_rupee_outlined,
                                            size: 15,
                                            color: Color(0xff0054FF)),
                                      ),
                                    ],
                                    rows: List.generate(
                                      cashTableLength + 1,
                                      (index) {
                                        return index == cashTableLength
                                            ?
                                            //Index+1 Row
                                            DataRow(
                                                color: index.isOdd
                                                    ? MaterialStateProperty.all(
                                                        Colors.blueGrey.shade50
                                                            .withOpacity(0.7))
                                                    : MaterialStateProperty.all(
                                                        Colors
                                                            .blueGrey.shade50),
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
                                                  DataCell(Text(
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
                                                  )),
                                                  DataCell(SelectableText(
                                                    totalExpInCash.toString(),
                                                    style: FlutterFlowTheme
                                                        .bodyText2
                                                        .override(
                                                      fontFamily: 'Lexend Deca',
                                                      color: Colors.black,
                                                      fontSize: 15,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  )),
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
                                                  DataCell(Text(
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
                                                  )),
                                                  DataCell(SelectableText(
                                                    totalPaymentInCash
                                                        .toString(),
                                                    style: FlutterFlowTheme
                                                        .bodyText2
                                                        .override(
                                                      fontFamily: 'Lexend Deca',
                                                      color: Colors.black,
                                                      fontSize: 15,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  )),
                                                ],
                                              )
                                            : index >= expensesByCash.length
                                                ? DataRow(
                                                    color: index.isOdd
                                                        ? MaterialStateProperty
                                                            .all(Colors.blueGrey
                                                                .shade50
                                                                .withOpacity(
                                                                    0.7))
                                                        : MaterialStateProperty
                                                            .all(Colors.blueGrey
                                                                .shade50),
                                                    cells: [
                                                      DataCell(Container(
                                                        child: SelectableText(
                                                          '',
                                                          style:
                                                              FlutterFlowTheme
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
                                                      )),
                                                      DataCell(Text(
                                                        '',
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
                                                      )),
                                                      DataCell(SelectableText(
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
                                                      )),
                                                      DataCell(SelectableText(
                                                        dateTimeFormat(
                                                            'd-MMM-y',
                                                            paymentsToCash[
                                                                        index]
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
                                                      )),
                                                      DataCell(Container(
                                                        width: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .width *
                                                            0.08,
                                                        child: Text(
                                                          '${paymentsToCash[index]['description']} from ${projectDataById[paymentsToCash[index]['projectId']]['projectName']}',
                                                          style:
                                                              FlutterFlowTheme
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
                                                      )),
                                                      DataCell(SelectableText(
                                                        _formatNumber(
                                                            paymentsToCash[
                                                                        index]
                                                                    ['amount']
                                                                .toString()
                                                                .replaceAll(
                                                                    ',', '')),
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
                                                      )),
                                                    ],
                                                  )
                                                : index >= paymentsToCash.length
                                                    ? DataRow(
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
                                                          DataCell(
                                                              SelectableText(
                                                            dateTimeFormat(
                                                                'd-MMM-y',
                                                                expensesByCash[
                                                                            index]
                                                                        ['date']
                                                                    .toDate()),
                                                            style:
                                                                FlutterFlowTheme
                                                                    .bodyText2
                                                                    .override(
                                                              fontFamily:
                                                                  'Lexend Deca',
                                                              color:
                                                                  Colors.black,
                                                              fontSize: 11,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                            ),
                                                          )),
                                                          DataCell(Container(
                                                            width: MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .width *
                                                                0.08,
                                                            child: Text(
                                                              expensesByCash[
                                                                      index][
                                                                  'particular'],
                                                              style:
                                                                  FlutterFlowTheme
                                                                      .bodyText2
                                                                      .override(
                                                                fontFamily:
                                                                    'Lexend Deca',
                                                                color: Colors
                                                                    .black,
                                                                fontSize: 12,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                              ),
                                                            ),
                                                          )),
                                                          DataCell(
                                                              SelectableText(
                                                            _formatNumber(
                                                                expensesByCash[
                                                                            index]
                                                                        [
                                                                        'amount']
                                                                    .toString()
                                                                    .replaceAll(
                                                                        ',',
                                                                        '')),
                                                            style:
                                                                FlutterFlowTheme
                                                                    .bodyText2
                                                                    .override(
                                                              fontFamily:
                                                                  'Lexend Deca',
                                                              color:
                                                                  Colors.black,
                                                              fontSize: 11,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                            ),
                                                          )),
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
                                                              fontSize: 11,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                            ),
                                                          )),
                                                          DataCell(Text(
                                                            '',
                                                            style:
                                                                FlutterFlowTheme
                                                                    .bodyText2
                                                                    .override(
                                                              fontFamily:
                                                                  'Lexend Deca',
                                                              color:
                                                                  Colors.black,
                                                              fontSize: 12,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                            ),
                                                          )),
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
                                                              fontSize: 11,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                            ),
                                                          )),
                                                        ],
                                                      )
                                                    //Index Row
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
                                                          DataCell(
                                                              SelectableText(
                                                            dateTimeFormat(
                                                                'd-MMM-y',
                                                                expensesByCash[
                                                                            index]
                                                                        ['date']
                                                                    .toDate()),
                                                            style:
                                                                FlutterFlowTheme
                                                                    .bodyText2
                                                                    .override(
                                                              fontFamily:
                                                                  'Lexend Deca',
                                                              color:
                                                                  Colors.black,
                                                              fontSize: 11,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                            ),
                                                          )),
                                                          DataCell(Container(
                                                            width: MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .width *
                                                                0.15,
                                                            child: Text(
                                                              expensesByCash[
                                                                      index][
                                                                  'particular'],
                                                              style:
                                                                  FlutterFlowTheme
                                                                      .bodyText2
                                                                      .override(
                                                                fontFamily:
                                                                    'Lexend Deca',
                                                                color: Colors
                                                                    .black,
                                                                fontSize: 12,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                              ),
                                                            ),
                                                          )),
                                                          DataCell(
                                                              SelectableText(
                                                            _formatNumber(
                                                                expensesByCash[
                                                                            index]
                                                                        [
                                                                        'amount']
                                                                    .toString()
                                                                    .replaceAll(
                                                                        ',',
                                                                        '')),
                                                            style:
                                                                FlutterFlowTheme
                                                                    .bodyText2
                                                                    .override(
                                                              fontFamily:
                                                                  'Lexend Deca',
                                                              color:
                                                                  Colors.black,
                                                              fontSize: 11,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                            ),
                                                          )),
                                                          DataCell(
                                                              SelectableText(
                                                            dateTimeFormat(
                                                                'd-MMM-y',
                                                                paymentsToCash[
                                                                            index]
                                                                        ['date']
                                                                    .toDate()),
                                                            style:
                                                                FlutterFlowTheme
                                                                    .bodyText2
                                                                    .override(
                                                              fontFamily:
                                                                  'Lexend Deca',
                                                              color:
                                                                  Colors.black,
                                                              fontSize: 11,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                            ),
                                                          )),
                                                          DataCell(Container(
                                                            width: MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .width *
                                                                0.15,
                                                            child: Text(
                                                              '${paymentsToCash[index]['description']} from ${projectDataById[paymentsToCash[index]['projectId']]['projectName']}',
                                                              style:
                                                                  FlutterFlowTheme
                                                                      .bodyText2
                                                                      .override(
                                                                fontFamily:
                                                                    'Lexend Deca',
                                                                color: Colors
                                                                    .black,
                                                                fontSize: 12,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                              ),
                                                            ),
                                                          )),
                                                          DataCell(
                                                              SelectableText(
                                                            _formatNumber(
                                                                paymentsToCash[
                                                                            index]
                                                                        [
                                                                        'amount']
                                                                    .toString()
                                                                    .replaceAll(
                                                                        ',',
                                                                        '')),
                                                            style:
                                                                FlutterFlowTheme
                                                                    .bodyText2
                                                                    .override(
                                                              fontFamily:
                                                                  'Lexend Deca',
                                                              color:
                                                                  Colors.black,
                                                              fontSize: 11,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                            ),
                                                          )),
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

                        //BANK Heading
                        bankTableLength == 0
                            ? SizedBox()
                            : Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'Bank',
                                    style: TextStyle(
                                        fontSize: 22,
                                        fontWeight: FontWeight.bold),
                                  )
                                ],
                              ),

                        // DR & CR TEXTS
                        bankTableLength == 0
                            ? SizedBox()
                            : Padding(
                                padding: EdgeInsets.fromLTRB(
                                    MediaQuery.of(context).size.width * 0.06,
                                    10,
                                    MediaQuery.of(context).size.width * 0.06,
                                    0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Dr.',
                                      style: TextStyle(
                                          fontSize: 17,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      'Cr.',
                                      style: TextStyle(
                                          fontSize: 17,
                                          fontWeight: FontWeight.bold),
                                    )
                                  ],
                                ),
                              ),

                        //Bank Table
                        bankTableLength == 0
                            ? SizedBox(
                                child: Center(
                                  child: Text(
                                      'There Is No Bank Transaction This Month'),
                                ),
                              )
                            : Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    30, 10, 30, 5),
                                child: SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 0.7,
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
                                        label: Container(
                                          child: Center(
                                            child: Text(
                                              "Date ",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 11),
                                            ),
                                          ),
                                        ),
                                      ),
                                      DataColumn(
                                        label: Text(
                                          "Particulars",
                                        ),
                                      ),
                                      DataColumn(
                                        label: Icon(
                                            Icons.currency_rupee_outlined,
                                            size: 15,
                                            color: Color(0xff0054FF)),
                                      ),
                                      DataColumn(
                                        label: Text(
                                          "Date ",
                                        ),
                                      ),
                                      DataColumn(
                                        label: Text(
                                          "Particulars",
                                        ),
                                      ),
                                      DataColumn(
                                        label: Icon(
                                          Icons.currency_rupee_outlined,
                                          size: 15,
                                          color: Color(0xff0054FF),
                                        ),
                                      ),
                                    ],
                                    rows: List.generate(
                                      bankTableLength + 1,
                                      (index) {
                                        return index == bankTableLength
                                            ?
                                            //Index+1 Row
                                            DataRow(
                                                color: index.isOdd
                                                    ? MaterialStateProperty.all(
                                                        Colors.blueGrey.shade50
                                                            .withOpacity(0.7))
                                                    : MaterialStateProperty.all(
                                                        Colors
                                                            .blueGrey.shade50),
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
                                                  DataCell(Text(
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
                                                  )),
                                                  DataCell(SelectableText(
                                                    totalExpInBank.toString(),
                                                    style: FlutterFlowTheme
                                                        .bodyText2
                                                        .override(
                                                      fontFamily: 'Lexend Deca',
                                                      color: Colors.black,
                                                      fontSize: 15,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  )),
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
                                                  DataCell(Text(
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
                                                  )),
                                                  DataCell(SelectableText(
                                                    totalPaymentInBank
                                                        .toString(),
                                                    style: FlutterFlowTheme
                                                        .bodyText2
                                                        .override(
                                                      fontFamily: 'Lexend Deca',
                                                      color: Colors.black,
                                                      fontSize: 15,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  )),
                                                ],
                                              )
                                            : index >= expensesByBank.length
                                                ? DataRow(
                                                    color: index.isOdd
                                                        ? MaterialStateProperty
                                                            .all(Colors.blueGrey
                                                                .shade50
                                                                .withOpacity(
                                                                    0.7))
                                                        : MaterialStateProperty
                                                            .all(Colors.blueGrey
                                                                .shade50),
                                                    cells: [
                                                      DataCell(SelectableText(
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
                                                      )),
                                                      DataCell(Text(
                                                        '',
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
                                                      )),
                                                      DataCell(SelectableText(
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
                                                      )),
                                                      DataCell(Container(
                                                        child: Center(
                                                          child: SelectableText(
                                                            dateTimeFormat(
                                                                'd-MMM-y',
                                                                paymentsToBank[
                                                                            index]
                                                                        ['date']
                                                                    .toDate()),
                                                            style:
                                                                FlutterFlowTheme
                                                                    .bodyText2
                                                                    .override(
                                                              fontFamily:
                                                                  'Lexend Deca',
                                                              color:
                                                                  Colors.black,
                                                              fontSize: 11,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                            ),
                                                          ),
                                                        ),
                                                      )),
                                                      DataCell(Text(
                                                        '${paymentsToBank[index]['description']} from ${projectDataById[paymentsToBank[index]['projectId']]['projectName']}',
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
                                                      )),
                                                      DataCell(SelectableText(
                                                        _formatNumber(
                                                            paymentsToBank[
                                                                        index]
                                                                    ['amount']
                                                                .toString()
                                                                .replaceAll(
                                                                    ',', '')),
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
                                                      )),
                                                    ],
                                                  )
                                                : index >= paymentsToBank.length
                                                    ? DataRow(
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
                                                          DataCell(
                                                              SelectableText(
                                                            dateTimeFormat(
                                                                'd-MMM-y',
                                                                expensesByBank[
                                                                            index]
                                                                        ['date']
                                                                    .toDate()),
                                                            style:
                                                                FlutterFlowTheme
                                                                    .bodyText2
                                                                    .override(
                                                              fontFamily:
                                                                  'Lexend Deca',
                                                              color:
                                                                  Colors.black,
                                                              fontSize: 11,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                            ),
                                                          )),
                                                          DataCell(Text(
                                                            expensesByBank[
                                                                    index]
                                                                ['particular'],
                                                            style:
                                                                FlutterFlowTheme
                                                                    .bodyText2
                                                                    .override(
                                                              fontFamily:
                                                                  'Lexend Deca',
                                                              color:
                                                                  Colors.black,
                                                              fontSize: 12,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                            ),
                                                          )),
                                                          DataCell(
                                                              SelectableText(
                                                            _formatNumber(
                                                                expensesByBank[
                                                                            index]
                                                                        [
                                                                        'amount']
                                                                    .toString()
                                                                    .replaceAll(
                                                                        ',',
                                                                        '')),
                                                            style:
                                                                FlutterFlowTheme
                                                                    .bodyText2
                                                                    .override(
                                                              fontFamily:
                                                                  'Lexend Deca',
                                                              color:
                                                                  Colors.black,
                                                              fontSize: 11,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                            ),
                                                          )),
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
                                                              fontSize: 11,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                            ),
                                                          )),
                                                          DataCell(Text(
                                                            '',
                                                            style:
                                                                FlutterFlowTheme
                                                                    .bodyText2
                                                                    .override(
                                                              fontFamily:
                                                                  'Lexend Deca',
                                                              color:
                                                                  Colors.black,
                                                              fontSize: 12,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                            ),
                                                          )),
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
                                                              fontSize: 11,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                            ),
                                                          )),
                                                        ],
                                                      )
                                                    //Index Row
                                                    : DataRow(
                                                        color: index.isOdd
                                                            ? MaterialStateProperty
                                                                .all(Colors
                                                                    .blueGrey
                                                                    .shade50
                                                                    .withOpacity(
                                                                        0.9))
                                                            : MaterialStateProperty
                                                                .all(Colors
                                                                    .blueGrey
                                                                    .shade50),
                                                        cells: [
                                                          DataCell(
                                                              SelectableText(
                                                            dateTimeFormat(
                                                                'd-MMM-y',
                                                                expensesByBank[
                                                                            index]
                                                                        ['date']
                                                                    .toDate()),
                                                            style:
                                                                FlutterFlowTheme
                                                                    .bodyText2
                                                                    .override(
                                                              fontFamily:
                                                                  'Lexend Deca',
                                                              color:
                                                                  Colors.black,
                                                              fontSize: 11,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                            ),
                                                          )),
                                                          DataCell(Container(
                                                            width: MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .width *
                                                                0.15,
                                                            child: Text(
                                                              expensesByBank[
                                                                      index][
                                                                  'particular'],
                                                              style:
                                                                  FlutterFlowTheme
                                                                      .bodyText2
                                                                      .override(
                                                                fontFamily:
                                                                    'Lexend Deca',
                                                                color: Colors
                                                                    .black,
                                                                fontSize: 12,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                              ),
                                                            ),
                                                          )),
                                                          DataCell(
                                                              SelectableText(
                                                            _formatNumber(
                                                                expensesByBank[
                                                                            index]
                                                                        [
                                                                        'amount']
                                                                    .toString()
                                                                    .replaceAll(
                                                                        ',',
                                                                        '')),
                                                            style:
                                                                FlutterFlowTheme
                                                                    .bodyText2
                                                                    .override(
                                                              fontFamily:
                                                                  'Lexend Deca',
                                                              color:
                                                                  Colors.black,
                                                              fontSize: 11,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                            ),
                                                          )),
                                                          DataCell(Container(
                                                            child: Center(
                                                              child:
                                                                  SelectableText(
                                                                dateTimeFormat(
                                                                    'd-MMM-y',
                                                                    paymentsToBank[index]
                                                                            [
                                                                            'date']
                                                                        .toDate()),
                                                                style: FlutterFlowTheme
                                                                    .bodyText2
                                                                    .override(
                                                                  fontFamily:
                                                                      'Lexend Deca',
                                                                  color: Colors
                                                                      .black,
                                                                  fontSize: 11,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                ),
                                                              ),
                                                            ),
                                                          )),
                                                          DataCell(Container(
                                                            width: MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .width *
                                                                0.15,
                                                            child: Text(
                                                              '${paymentsToBank[index]['description']} from ${projectDataById[paymentsToBank[index]['projectId']]['projectName']}',
                                                              style:
                                                                  FlutterFlowTheme
                                                                      .bodyText2
                                                                      .override(
                                                                fontFamily:
                                                                    'Lexend Deca',
                                                                color: Colors
                                                                    .black,
                                                                fontSize: 12,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                              ),
                                                            ),
                                                          )),
                                                          DataCell(
                                                              SelectableText(
                                                            _formatNumber(
                                                                paymentsToBank[
                                                                            index]
                                                                        [
                                                                        'amount']
                                                                    .toString()
                                                                    .replaceAll(
                                                                        ',',
                                                                        '')),
                                                            style:
                                                                FlutterFlowTheme
                                                                    .bodyText2
                                                                    .override(
                                                              fontFamily:
                                                                  'Lexend Deca',
                                                              color:
                                                                  Colors.black,
                                                              fontSize: 11,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                            ),
                                                          )),
                                                        ],
                                                      );
                                      },
                                    ),
                                  ),
                                ),
                              ),

                        // // EXCEL Button
                        // Row(
                        //   mainAxisAlignment: MainAxisAlignment.start,
                        //   children: [
                        //     Padding(
                        //       padding: const EdgeInsets.only(top: 15, left: 30),
                        //       child: TextButton(
                        //           child: const Text('Generate Excel'),
                        //           style: TextButton.styleFrom(
                        //             foregroundColor: Colors.white,
                        //             backgroundColor: Colors.lightBlue,
                        //             disabledForegroundColor:
                        //                 Colors.grey.withOpacity(0.38),
                        //           ),
                        //           onPressed: () {
                        //             try {
                        //               importData();
                        //             } catch (e) {
                        //               return showDialog(
                        //                   context: context,
                        //                   builder: (context) {
                        //                     return AlertDialog(
                        //                       title: Text('error'),
                        //                       content: Text(e.toString()),
                        //                       actions: <Widget>[
                        //                         ElevatedButton(
                        //                           child: new Text('ok'),
                        //                           onPressed: () {
                        //                             Navigator.of(context).pop();
                        //                           },
                        //                         )
                        //                       ],
                        //                     );
                        //                   });
                        //             }
                        //           }),
                        //     ),
                        //   ],
                        // )
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
}
