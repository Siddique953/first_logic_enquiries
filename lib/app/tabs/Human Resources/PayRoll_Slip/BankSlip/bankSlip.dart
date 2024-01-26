import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:excel/excel.dart' as ex;
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:number_to_words/number_to_words.dart';

import '../../../../../flutter_flow/flutter_flow_icon_button.dart';
import '../../../../../flutter_flow/flutter_flow_theme.dart';
import '../../../../../flutter_flow/flutter_flow_util.dart';
import '../../../../../flutter_flow/flutter_flow_widgets.dart';
import '../../../../../flutter_flow/upload_media.dart';
import '../../../../pages/home_page/home.dart';

class BankSlipPage extends StatefulWidget {
  final Map paySlip;
  const BankSlipPage({Key? key, required this.paySlip}) : super(key: key);

  @override
  State<BankSlipPage> createState() => _BankSlipPageState();
}

class _BankSlipPageState extends State<BankSlipPage> {
  late TextEditingController chequeNumber;
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  List slipNames = [];
  List empNamesList = [];

  // listOfCustomers
  @override
  void initState() {
    empNamesList=employeeList.where((element) => element['delete']==false).toList();
    super.initState();

    for (int i = 0; i < empNamesList.length; i++) {
      if(widget.paySlip[empNamesList[i]['empId']]==null){
        continue;
        // widget.paySlip[empNamesList[i]['empId']]['takeHome']=0;
      }
      if (widget.paySlip[empNamesList[i]['empId']]['takeHome'] != 0) {
        slipNames.add(empNamesList[i]);
      }
    }

    chequeNumber = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    chequeNumber.text = '';
  }

  double total = 0;

  @override
  Widget build(BuildContext context) {
    total = 0;
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
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
                            Navigator.pop(context);
                          },
                          icon: Icon(Icons.arrow_back_ios_new)),
                      SizedBox(
                        width: 15,
                      ),
                      Expanded(
                        child: Text(
                          'Bank Slip',
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
                            // BankSlipGenerate().downloadPdf(widget.paySlip,
                            //     chequeNumber.text, total, slipNames);

                            if (chequeNumber.text != '') {
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
                            } else {
                              showUploadMessage(
                                  context, 'Please Enter Cheque Number.');
                            }
                          },
                          text: 'Download',
                          options: FFButtonOptions(
                            width: 130,
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
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(30, 15, 30, 5),
                  child: Row(
                    children: [
                      Expanded(
                        child: Container(
                          width: 330,
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
                              controller: chequeNumber,
                              obscureText: false,
                              onChanged: ((v) {
                                // v = v.replaceAll(' ', '').toLowerCase();
                                // email.text = '$v@gmail.com';
                              }),
                              decoration: InputDecoration(
                                labelText: 'Cheque Number',
                                labelStyle: FlutterFlowTheme.bodyText2.override(
                                  fontFamily: 'Montserrat',
                                  color: Color(0xFF8B97A2),
                                  fontWeight: FontWeight.w500,
                                  fontSize: 12,
                                ),
                                hintText: 'Please Enter Cheque Number',
                                hintStyle: FlutterFlowTheme.bodyText2.override(
                                  fontFamily: 'Montserrat',
                                  color: Color(0xFF8B97A2),
                                  fontWeight: FontWeight.w500,
                                  fontSize: 12,
                                ),
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
                                fontSize: 12,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Spacer(),
                      Spacer(),
                    ],
                  ),
                ),
                slipNames.length == 0
                    ? LottieBuilder.network(
                        'https://assets9.lottiefiles.com/packages/lf20_HpFqiS.json',
                        height: 500,
                      )
                    : SizedBox(
                        width: MediaQuery.of(context).size.width,
                        child: Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: DataTable(
                            horizontalMargin: 10,
                            columns: [
                              DataColumn(
                                label: Text("Sl.No.",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize:
                                            MediaQuery.of(context).size.width *
                                                0.008)),
                              ),
                              DataColumn(
                                label: Text("Employee Name",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize:
                                            MediaQuery.of(context).size.width *
                                                0.008)),
                              ),
                              DataColumn(
                                label: Text("Account No.",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize:
                                            MediaQuery.of(context).size.width *
                                                0.008)),
                              ),
                              DataColumn(
                                label: Text("Amount",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize:
                                            MediaQuery.of(context).size.width *
                                                0.008)),
                              ),
                              DataColumn(
                                label: Text("",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize:
                                            MediaQuery.of(context).size.width *
                                                0.008)),
                              ),
                            ],
                            rows: List.generate(
                              slipNames.length + 2,
                              (index) {
                                String id = '';


                                if (index < slipNames.length) {
                                  id = slipNames[index]['empId'];

                                  total = total +
                                      (widget.paySlip[id] == null
                                          ? 0
                                          : double.tryParse((widget.paySlip[id]
                                                      ['takeHome'] ??
                                                  '0')
                                              .toString())!);
                                }

                                return index == slipNames.length
                                    ? DataRow(
                                        color: index.isOdd
                                            ? MaterialStateProperty.all(Colors
                                                .blueGrey.shade50
                                                .withOpacity(0.7))
                                            : MaterialStateProperty.all(
                                                Colors.blueGrey.shade50),
                                        cells: [
                                          DataCell(
                                            Text(
                                              '',
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
                                          DataCell(SelectableText(
                                            '',
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
                                          )),
                                          DataCell(Text(
                                            '',
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
                                          )),
                                          DataCell(Text(
                                            '',
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
                                          )),
                                          DataCell(
                                            Text(
                                              '',
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

                                          // DataCell(Text(fileInfo.size)),
                                        ],
                                      )
                                    : index > slipNames.length
                                        ? DataRow(
                                            color: index.isOdd
                                                ? MaterialStateProperty.all(
                                                    Colors.blueGrey.shade50
                                                        .withOpacity(0.7))
                                                : MaterialStateProperty.all(
                                                    Colors.blueGrey.shade50),
                                            cells: [
                                              DataCell(
                                                SelectableText(
                                                  '',
                                                  style: FlutterFlowTheme
                                                      .bodyText2
                                                      .override(
                                                    fontFamily: 'Lexend Deca',
                                                    color: Colors.black,
                                                    fontSize:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width *
                                                            0.008,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ),
                                              DataCell(
                                                Text(
                                                  'Total',
                                                  style: FlutterFlowTheme
                                                      .bodyText2
                                                      .override(
                                                    fontFamily: 'Lexend Deca',
                                                    color: Colors.black,
                                                    fontSize:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width *
                                                            0.007,
                                                    fontWeight: FontWeight.bold,
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
                                                    fontSize:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width *
                                                            0.008,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ),
                                              DataCell(
                                                Text(
                                                  total.round().toString(),
                                                  style: FlutterFlowTheme
                                                      .bodyText2
                                                      .override(
                                                    fontFamily: 'Lexend Deca',
                                                    color: Colors.black,
                                                    fontSize:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width *
                                                            0.008,
                                                    fontWeight: FontWeight.bold,
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
                                                    fontSize:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width *
                                                            0.008,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ),

                                              // DataCell(Text(fileInfo.size)),
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
                                                SelectableText(
                                                  '${index + 1}',
                                                  style: FlutterFlowTheme
                                                      .bodyText2
                                                      .override(
                                                    fontFamily: 'Lexend Deca',
                                                    color: Colors.black,
                                                    fontSize:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width *
                                                            0.008,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ),
                                              DataCell(
                                                Text(
                                                  empDataById[id]!.name ?? '',
                                                  style: FlutterFlowTheme
                                                      .bodyText2
                                                      .override(
                                                    fontFamily: 'Lexend Deca',
                                                    color: Colors.black,
                                                    fontSize:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width *
                                                            0.007,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ),
                                              DataCell(
                                                Text(
                                                  empDataById[id]!.accountNumber!,
                                                  style: FlutterFlowTheme
                                                      .bodyText2
                                                      .override(
                                                    fontFamily: 'Lexend Deca',
                                                    color: Colors.black,
                                                    fontSize:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width *
                                                            0.008,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ),
                                              DataCell(
                                                Text(
                                                  (widget.paySlip[id] == null
                                                          ? 0
                                                          : (widget.paySlip[id][
                                                                  'takeHome'] ??
                                                              0))
                                                      .round()
                                                      .toString(),
                                                  style: FlutterFlowTheme
                                                      .bodyText2
                                                      .override(
                                                    fontFamily: 'Lexend Deca',
                                                    color: Colors.black,
                                                    fontSize:
                                                        MediaQuery.of(context)
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
                                                    // Generated code for this Button Widget...
                                                    FlutterFlowIconButton(
                                                      borderColor:
                                                          Colors.transparent,
                                                      borderRadius: 30,
                                                      borderWidth: 1,
                                                      buttonSize: 50,
                                                      icon: Icon(
                                                        Icons.delete,
                                                        color:
                                                            Color(0xFFEE0000),
                                                        size: 25,
                                                      ),
                                                      onPressed: () async {
                                                        bool pressed = await alert(
                                                            context,
                                                            'Do you want Delete');

                                                        if (pressed) {
                                                          slipNames
                                                              .removeAt(index);

                                                          showUploadMessage(
                                                              context,
                                                              'Item Deleted...');
                                                          setState(() {});
                                                        }
                                                      },
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
                SizedBox(
                  height: 50,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> importData() async {

    var excel = ex.Excel.createExcel();

    ex.Sheet sheetObject = excel['Bank Slip'];
    ex.CellStyle cellStyle = ex.CellStyle(
      fontSize: 10,
      fontFamily: ex.getFontFamily(ex.FontFamily.Calibri),

      // textWrapping: TextWrapping.WrapText,
    );

    ex.CellStyle fromAndToStyle = ex.CellStyle(
      fontSize: 13,
      fontFamily: ex.getFontFamily(ex.FontFamily.Calibri),

      // textWrapping: TextWrapping.WrapText,
    );

    var cell1 = sheetObject.cell(ex.CellIndex.indexByString("B5"));
    cell1.value = 'To,';
    cell1.cellStyle = fromAndToStyle;

    var cell2 = sheetObject.cell(ex.CellIndex.indexByString("B6"));
    cell2.value = 'The Manager,';
    cell2.cellStyle = fromAndToStyle;

    var cell3 = sheetObject.cell(ex.CellIndex.indexByString("B7"));
    cell3.value = 'HDFC Bank';
    cell3.cellStyle = fromAndToStyle;

    var cell4 = sheetObject.cell(ex.CellIndex.indexByString("B8"));
    cell4.value = 'Perinthalmanna II';
    cell4.cellStyle = fromAndToStyle;

    sheetObject.merge(
        ex.CellIndex.indexByString("B10"), ex.CellIndex.indexByString("F10"));

    sheetObject.merge(
        ex.CellIndex.indexByString("B12"), ex.CellIndex.indexByString("G13"));

    sheetObject.merge(
        ex.CellIndex.indexByString("B14"), ex.CellIndex.indexByString("G16"));

    sheetObject.setColWidth(2, 25);
    sheetObject.setColWidth(3, 20);
    sheetObject.setColWidth(4, 15);

    var sub = sheetObject.cell(ex.CellIndex.indexByString("B10"));
    sub.value = 'Sub : Staff details for Salary credit.';
    sub.cellStyle = ex.CellStyle(
        bold: true,
        fontSize: 17,
        fontFamily: ex.getFontFamily(ex.FontFamily.Calibri));

    var desc1 = sheetObject.cell(ex.CellIndex.indexByString("B12"));
    desc1.value =
        'Please find attached Chq.No. ${chequeNumber.text} Dated:${dateTimeFormat('dd/mm/yyyy', DateTime.now())} amounted to Rs. '
        ' ${total.toStringAsFixed(2)}/-';

    desc1.cellStyle = ex.CellStyle(
      fontSize: 12,
      fontFamily: ex.getFontFamily(ex.FontFamily.Calibri),
      textWrapping: ex.TextWrapping.WrapText,
      horizontalAlign: ex.HorizontalAlign.Center,
      verticalAlign: ex.VerticalAlign.Center,
    );

    var desc2 = sheetObject.cell(ex.CellIndex.indexByString("B14"));
    desc2.value =
        'Request you to Transfer Salary for the month ${dateTimeFormat('MMMM y', DateTime(
              DateTime.now().year,
              DateTime.now().month - 1,
              DateTime.now().day,
            ))} of Rupees ${NumberToWord().convert('en-in', total.round())} only.';
    desc2.cellStyle = ex.CellStyle(
      fontSize: 12,
      fontFamily: ex.getFontFamily(ex.FontFamily.Calibri),
      textWrapping: ex.TextWrapping.WrapText,
      horizontalAlign: ex.HorizontalAlign.Center,
      verticalAlign: ex.VerticalAlign.Center,
    );

    //HEADINGS

    if (slipNames.length > 0) {
      var cell1 = sheetObject.cell(ex.CellIndex.indexByString("B18"));
      cell1.value = 'SL NO';
      cell1.cellStyle = cellStyle;
      var cell2 = sheetObject.cell(ex.CellIndex.indexByString("C18"));
      cell2.value = 'EMPLOYEE NAME'; // dynamic values support provided;
      cell2.cellStyle = cellStyle;
      var cell3 = sheetObject.cell(ex.CellIndex.indexByString("D18"));
      cell3.value = 'ACCOUNT NUMBER'; // dynamic values support provided;
      cell3.cellStyle = cellStyle;
      var cell4 = sheetObject.cell(ex.CellIndex.indexByString("E18"));
      cell4.value = 'AMOUNT'; // dynamic values support provided;
      cell4.cellStyle = cellStyle;
    }

    // CELL VALUES

    int currentIndex = 17;
    int num = 0;

    for (int i = 18; i < slipNames.length + 20; i++) {
      currentIndex = i;

      if (num == slipNames.length) {
        num += 1;
        var cell1 = sheetObject.cell(ex.CellIndex.indexByString("B${i + 2}"));
        cell1.value = ''; // dynamic values support provided;
        cell1.cellStyle = cellStyle;
        var cell2 = sheetObject.cell(ex.CellIndex.indexByString("C${i + 2}"));
        cell2.value = ''; // dynamic values support provided;
        cell2.cellStyle = cellStyle;
        var cell3 = sheetObject.cell(ex.CellIndex.indexByString("D${i + 2}"));
        cell3.value = ''; // dynamic values support provided;
        cell3.cellStyle = cellStyle;
        var cell4 = sheetObject.cell(ex.CellIndex.indexByString("E${i + 2}"));
        cell4.value = ''; // dynamic values support provided;
        cell4.cellStyle = cellStyle;
      } else if (num > slipNames.length) {
        var cell1 = sheetObject.cell(ex.CellIndex.indexByString("B${i + 2}"));
        cell1.value = ''; // dynamic values support provided;
        cell1.cellStyle = cellStyle;
        var cell2 = sheetObject.cell(ex.CellIndex.indexByString("C${i + 2}"));
        cell2.value = 'Total '; // dynamic values support provided;
        cell2.cellStyle = cellStyle;
        var cell3 = sheetObject.cell(ex.CellIndex.indexByString("D${i + 2}"));
        cell3.value = ''; // dynamic values support provided;
        cell3.cellStyle = cellStyle;
        var cell4 = sheetObject.cell(ex.CellIndex.indexByString("E${i + 2}"));
        cell4.value =
            total.toStringAsFixed(2); // dynamic values support provided;
        cell4.cellStyle = ex.CellStyle(
          fontSize: 10,
          fontFamily: ex.getFontFamily(ex.FontFamily.Calibri),
          horizontalAlign: ex.HorizontalAlign.Right,
          verticalAlign: ex.VerticalAlign.Center,
        );
      } else {
        var cell1 = sheetObject.cell(ex.CellIndex.indexByString("B${i + 2}"));
        cell1.value = '${num + 1}'; // dynamic values support provided;
        cell1.cellStyle = ex.CellStyle(
          fontSize: 10,
          fontFamily: ex.getFontFamily(ex.FontFamily.Calibri),
          horizontalAlign: ex.HorizontalAlign.Center,
          verticalAlign: ex.VerticalAlign.Center,
        );

        var cell2 = sheetObject.cell(ex.CellIndex.indexByString("C${i + 2}"));
        cell2.value = empDataById[slipNames[num]['empId']]!
            .name
            .toString(); // dynamic values support provided;
        cell2.cellStyle = cellStyle;
        var cell3 = sheetObject.cell(ex.CellIndex.indexByString("D${i + 2}"));
        cell3.value = empDataById[slipNames[num]['empId']]!
            .accountNumber; // dynamic values support provided;
        cell3.cellStyle = ex.CellStyle(
          fontSize: 10,
          fontFamily: ex.getFontFamily(ex.FontFamily.Calibri),
          horizontalAlign: ex.HorizontalAlign.Right,
          verticalAlign: ex.VerticalAlign.Center,
        );
        var cell4 = sheetObject.cell(ex.CellIndex.indexByString("E${i + 2}"));
        cell4.value = (widget.paySlip[slipNames[num]['empId']] == null
                ? 0
                : (widget.paySlip[slipNames[num]['empId']]['takeHome'] ?? 0))
            .round()
            .toString(); // dynamic values support provided;
        cell4.cellStyle = ex.CellStyle(
          fontSize: 10,
          fontFamily: ex.getFontFamily(ex.FontFamily.Calibri),
          horizontalAlign: ex.HorizontalAlign.Right,
          verticalAlign: ex.VerticalAlign.Center,
        );
        num += 1;
      }
    }

    var thanks =
        sheetObject.cell(ex.CellIndex.indexByString("B${currentIndex + 5}"));
    thanks.value = 'Thanking you,';
    thanks.cellStyle = fromAndToStyle;

    var name =
        sheetObject.cell(ex.CellIndex.indexByString("B${currentIndex + 6}"));
    name.value = 'Muhammed Shabeeb';
    name.cellStyle = fromAndToStyle;

    var position =
        sheetObject.cell(ex.CellIndex.indexByString("B${currentIndex + 7}"));
    position.value = 'Director';
    position.cellStyle = fromAndToStyle;

    var company =
        sheetObject.cell(ex.CellIndex.indexByString("B${currentIndex + 8}"));
    company.value = 'First Logic Meta Lab Pvt. Ltd';
    company.cellStyle = fromAndToStyle;

    excel.setDefaultSheet('Bank Slip');

    // var fileBytes = excel.encode();

    // final content = base64Encode(fileBytes);
    // final anchor = html.AnchorElement(
    //     href: "data:application/octet-stream;charset=utf-16le;base64,$content")
    //   ..setAttribute(
    //       "download", "${DateTime.now().toString().substring(0, 10)}.xlsx")
    //   ..click();

    var data = excel.save(
        fileName: 'Bank Slip ${dateTimeFormat('MMM y', DateTime(
              DateTime.now().year,
              DateTime.now().month - 1,
              DateTime.now().day,
            ))}.xlsx');
    Uint8List bytes = Uint8List.fromList(data!);
    uploadFileToFireBase(
      dateTimeFormat(
          'MMM y',
          DateTime(
            DateTime.now().year,
            DateTime.now().month - 1,
            DateTime.now().day,
          )),
      bytes,
      'xlsx',
    );
  }

  Future uploadFileToFireBase(String name, fileBytes, String ext) async {
    // final path='file/${pickFile.name}';
    // final file=File(pickFile.path);

    // final ref=FirebaseStorage.instance.ref().child(path);
    // uploadTask = ref.putFile(file);
    var uploadTask = FirebaseStorage.instance
        .ref('Pay Slips/${dateTimeFormat('MMMM y', DateTime(
              DateTime.now().year,
              DateTime.now().month - 1,
              DateTime.now().day,
            ))}/BankSlip--$name.$ext')
        .putData(fileBytes);
    final snapshot = await uploadTask.whenComplete(() {});
    final urlDownload = await snapshot.ref.getDownloadURL();

    FirebaseFirestore.instance
        .collection('paySlips')
        .doc(
          dateTimeFormat(
              'MMMM y',
              DateTime(
                DateTime.now().year,
                DateTime.now().month - 1,
                DateTime.now().day,
              )),
        )
        .update({
      'bankSlip': urlDownload,
    });
  }
}
