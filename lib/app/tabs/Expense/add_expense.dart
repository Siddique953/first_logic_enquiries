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
import '../../../auth/auth_util.dart';

import 'package:universal_html/html.dart' as html;
import '../../../flutter_flow/flutter_flow_icon_button.dart';
import '../../../flutter_flow/flutter_flow_theme.dart';
import '../../../flutter_flow/flutter_flow_util.dart';
import '../../../flutter_flow/flutter_flow_widgets.dart';
import '../../../flutter_flow/upload_media.dart';
import '../../app_widget.dart';
import '../../pages/home_page/home.dart';
import 'addExpensePopUp.dart';

class AddExpense extends StatefulWidget {
  const AddExpense({Key? key}) : super(key: key);

  @override
  _AddExpenseState createState() => _AddExpenseState();
}

class _AddExpenseState extends State<AddExpense> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final formState = GlobalKey<FormState>();

  late TextEditingController amount;
  late TextEditingController narration;
  late TextEditingController expenseHead;
  Timestamp? expenseDate;
  late DateTime today;

  DateTime fromDate = DateTime.now();
  DateTime toDate = DateTime.now();
  DateTime paymentDate = DateTime.now();
  DateTime lastDate = DateTime.now();
  List expenses = [];
  List expenseHeads = [];
  late double totalExp;

  //Radio Button Ingredients


  String radioVal = 'Cash';

  List<String> currentHeadList = [];

  getExpenseDetails(Timestamp from, Timestamp to) async {
    expenses = [];
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
          expenses.add(data[i]);
          double exp = double.tryParse(data[i]['amount'].toString())!;

          totalExp += exp;
        }
      }

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
    expenses = [];
    // getExpenseHead();
    amount = TextEditingController();
    narration = TextEditingController();
    expenseHead = TextEditingController();

    //Set FROM and TO date based on Today
    today = DateTime.now();

    fromDate = DateTime(today.year, today.month, 01, 0, 0, 0);
    toDate = DateTime(
        fromDate.year, fromDate.month + 1, fromDate.day - 1, 23, 59, 59);
    lastDate = DateTime(today.year, today.month + 1, 0, 23, 59, 59);

    //Call current Month data initially
    getExpenseDetails(Timestamp.fromDate(fromDate), Timestamp.fromDate(toDate));

    headList();
  }

  headList() {
    currentHeadList = [];
    currentHeadList = expHeadList;
    currentHeadList.remove('All');
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    expenses = [];
  }

  @override
  Widget build(BuildContext context) {
    print(expHeadList);
    return Scaffold(
      key: scaffoldKey,
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
                        'Expenses',
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
                    //             return AddExpensePage(
                    //               currentHeadList: currentHeadList,
                    //               form: formState,
                    //             );
                    //             //   form: formKey,
                    //             // );
                    //           });
                    //     },
                    //     text: '+ Add Expense',
                    //     options: FFButtonOptions(
                    //       // width: 100,
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
                    //       borderRadius: 10,
                    //     ),
                    //   ),
                    // ),
                  ],
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Divider(
                thickness: 5,
                indent: 15,
                endIndent: 15,
                color: Color(0xffD0D0D0),
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
                      //Add Expenses Title
                      Padding(
                        padding:
                            EdgeInsetsDirectional.only(top: 20, bottom: 20),
                        child: Text(
                          'Add Expenses',
                          style: FlutterFlowTheme.bodyText2.override(
                            fontFamily: 'Montserrat',
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),

                      //Add Fields
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(30, 10, 30, 5),
                        child: Row(
                          children: [
                            //Date Picker
                            Expanded(
                              child: Padding(
                                  padding: EdgeInsetsDirectional.all(8),
                                  child: InkWell(
                                    onTap: () {
                                      showDatePicker(
                                              context: context,
                                              initialDate: paymentDate,
                                              locale: Locale('en', 'IN'),
                                              firstDate: DateTime(1901, 1),
                                              lastDate: DateTime(
                                                  DateTime.now().year,
                                                  DateTime.now().month,
                                                  DateTime.now().day,
                                                  23,
                                                  59,
                                                  59))
                                          .then((value) {
                                        if(value!=null){
                                          setState(() {
                                            DateFormat("yyyy-MM-dd")
                                                .format(value);

                                            expenseDate = Timestamp.fromDate(
                                                DateTime(
                                                    value.year,
                                                    value.month,
                                                    value.day,
                                                    0,
                                                    0,
                                                    0));
                                          });
                                        }
                                      });
                                    },
                                    child: Center(
                                      child: Container(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.15,
                                        height: 60,
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(8),
                                          border: Border.all(
                                            color: Color(0xFFE6E6E6),
                                          ),
                                        ),
                                        child: expenseDate == null
                                            ? Center(
                                                child: Text(
                                                  'choose Date',
                                                  style: TextStyle(
                                                      fontSize: 18,
                                                      color: Colors.blue),
                                                ),
                                              )
                                            : Center(
                                                child: Text(
                                                  expenseDate!
                                                      .toDate()
                                                      .toString()
                                                      .substring(0, 10),
                                                ),
                                              ),
                                      ),
                                    ),
                                  )),
                            ),

                            //Expence Head Pick
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
                                    controller: expenseHead,
                                    // excludeSelected: false,
                                    onChanged: (text) {
                                      setState(() {});
                                    },
                                  ),
                                ),
                              ),
                            ),

                            //Amount TextField
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
                                    controller: amount,
                                    obscureText: false,
                                    decoration: InputDecoration(
                                      labelText: 'Amount',
                                      labelStyle: FlutterFlowTheme.bodyText2
                                          .override(
                                              fontFamily: 'Montserrat',
                                              color: Colors.black,
                                              fontWeight: FontWeight.w500,
                                              fontSize: 12),
                                      hintText: 'Please Enter Amount',
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

                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.006,
                            ),

                            //Narration
                            Expanded(
                              child: Container(
                                width: 150,
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
                                    controller: narration,
                                    obscureText: false,
                                    decoration: InputDecoration(
                                      labelText: 'Narration (Optional)',
                                      labelStyle: FlutterFlowTheme.bodyText2
                                          .override(
                                              fontFamily: 'Montserrat',
                                              color: Colors.black,
                                              fontWeight: FontWeight.w500,
                                              fontSize: 12),
                                      hintText: 'Please Enter Narration',
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

                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.006,
                            ),

                            //Radio Buttons (BANK & CASH)
                            Text('Bank'),
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.002,
                            ),
                            Radio<String>(
                              activeColor: Colors.yellow,
                              fillColor:
                                  MaterialStateProperty.all(Colors.black),
                              overlayColor:
                                  MaterialStateProperty.all(Colors.grey[200]),
                              focusColor: Colors.green,
                              value: 'Bank',
                              onChanged: (value) {
                                if(value!=null){
                                  setState(() {

                                    radioVal = value;
                                  });
                                }
                              },
                              groupValue: radioVal,

                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.006,
                            ),
                            Text('Cash'),
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.002,
                            ),
                            Radio<String>(
                              activeColor: Colors.yellow,
                              fillColor:
                                  MaterialStateProperty.all(Colors.black),
                              overlayColor:
                                  MaterialStateProperty.all(Colors.grey[200]),
                              focusColor: Colors.green,
                              value: 'Cash',
                              onChanged: (value) {


                                if(value!=null){
                                  setState(() {
                                    radioVal = value;

                                  });
                                }
                              },
                              groupValue: radioVal,
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.006,
                            ),

                            //Button
                            Padding(
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(15, 10, 30, 5),
                              child: InkWell(
                                  onTap: () async {
                                    if (amount.text != '' &&
                                        expenseHead.text != '' &&
                                        radioVal != '') {
                                      double amountValue =
                                          double.tryParse(amount.text)!;
                                      FirebaseFirestore.instance
                                          .collection('expenseHead')
                                          .doc(currentBranchId)
                                          .update({
                                        '${expenseHead.text}':
                                            FieldValue.increment(amountValue)
                                      });

                                      FirebaseFirestore.instance
                                          .collection('expense')
                                          .add({
                                        'date': expenseDate == null
                                            ? DateTime.now()
                                            : expenseDate,
                                        'amount': double.tryParse(amount.text),
                                        'particular': expenseHead.text,
                                        'narration': narration.text,
                                        'paymentMethode': radioVal,
                                        'user': currentUserUid,
                                        'branchId': currentBranchId,
                                      }).then((value) {
                                        value.update({'dId': value.id});
                                        if (radioVal == 'Cash') {
                                          FirebaseFirestore.instance
                                              .collection('settings')
                                              .doc(currentBranchId)
                                              .update({
                                            'cashInHand': FieldValue.increment(
                                                -1 * amountValue)
                                          });
                                        }
                                        if (radioVal == 'Bank') {
                                          FirebaseFirestore.instance
                                              .collection('settings')
                                              .doc(currentBranchId)
                                              .update({
                                            'cashAtBank': FieldValue.increment(
                                                -1 * amountValue)
                                          });
                                        }
                                      });

                                      amount.text = '';
                                      expenseHead.text = '';

                                      narration.clear();
                                      showUploadMessage(context,
                                          'Expense Added Successfully');
                                    } else {
                                      amount.text == ''
                                          ? showUploadMessage(
                                              context, 'Please Enter Amount')
                                          : expenseHead.text == ''
                                              ? showUploadMessage(context,
                                                  'Please Select particular')
                                              : showUploadMessage(context,
                                                  'Please Select Payment Methode');
                                    }
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
                                      'Add',
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
              Row(
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
                          fromDate = DateTime(
                              fromDate.year, fromDate.month - 1, fromDate.day);

                          toDate = DateTime(fromDate.year, fromDate.month + 1,
                              fromDate.day - 1, 23, 59, 59);
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
                        firstDate: DateTime(2010, 1),
                        lastDate: lastDate,
                        initialDate: fromDate,

                        //show only even months

                        // headerColor: Colors.purple,
                        // headerTextColor: Colors.orange,
                        // selectedMonthBackgroundColor: Colors.amber[900],
                        // selectedMonthTextColor: Colors.white,
                        // unselectedMonthTextColor: Colors.green,
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

                            toDate = DateTime(fromDate.year, fromDate.month + 1,
                                fromDate.day - 1, 23, 59, 59);
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
                          fromDate = DateTime(
                              fromDate.year, fromDate.month + 1, fromDate.day);

                          toDate = DateTime(fromDate.year, fromDate.month + 1,
                              fromDate.day - 1, 23, 59, 59);
                        });
                        getExpenseDetails(Timestamp.fromDate(fromDate),
                            Timestamp.fromDate(toDate));
                      },
                    ),
                  ),
                ],
              ),
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
                                "S.Id ",
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
                                          style: FlutterFlowTheme.bodyText2
                                              .override(
                                            fontFamily: 'Lexend Deca',
                                            color: Colors.black,
                                            fontSize: 12,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        )),
                                        DataCell(Container(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
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
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.1,
                                          child: SelectableText(
                                            totalExp.toString(),
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
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
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
                                          style: FlutterFlowTheme.bodyText2
                                              .override(
                                            fontFamily: 'Lexend Deca',
                                            color: Colors.black,
                                            fontSize: 12,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        )),
                                        DataCell(Container(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
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
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.1,
                                          child: SelectableText(
                                            expenses[index]['amount']
                                                .toString(),
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
              )
            ],
          ),
        ),
      ),
    );
  }
}
