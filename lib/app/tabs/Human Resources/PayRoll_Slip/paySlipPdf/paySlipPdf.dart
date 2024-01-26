import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:fl_erp/app/tabs/Human%20Resources/PayRoll_Slip/paySlipPdf/paySlipModel.dart';
import 'package:intl/intl.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:pdf/widgets.dart';
import 'package:printing/printing.dart';

import '../../../../../flutter_flow/flutter_flow_util.dart';
import '../../../../pages/home_page/home.dart';

var format = NumberFormat.simpleCurrency(locale: 'en_in');
var image;


class PaySlip {
  static downloadPdf(PaySlipModel invoice, Map employeeDetails,
      Map employeeAttendance, String empId, int lastDay,DateTime selectedDay) async {

    // 
    // 
    // 
    //
    // String attendedDays =  invoice.attended.toString().split('.')[1]=='0'
    //     ? (invoice.attended??0.0).truncate().toString()
    //     :invoice.attended.toString();

    const _locale = 'HI';
    String _formatNumber(String s) =>
        NumberFormat.decimalPattern(_locale).format(int.parse(s));

    final pdf = Document();
    image = await imageFromAssetBundle('assets/images/fl_new.jpg');

    pdf.addPage(
      MultiPage(
        margin: EdgeInsets.all(25),
        header: (context) => Padding(
            padding: EdgeInsets.only(bottom: 50),
            child: Container(
              height: 100,
              width: double.infinity,
              child: Row(children: [
                Container(
                  height: 80,
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Image(image,
                            width: 150, height: 150, fit: pw.BoxFit.contain),
                      ]),
                ),
                pw.SizedBox(width: 15),
                Expanded(
                  child: Container(
                    child: Column(
                        mainAxisAlignment: pw.MainAxisAlignment.end,
                        crossAxisAlignment: pw.CrossAxisAlignment.end,
                        children: [
                          Row(
                              mainAxisAlignment: pw.MainAxisAlignment.end,
                              children: [
                                Text('www.firstlogicmetalab.com'),
                                pw.SizedBox(width: 3),
                                // Image(
                                //   globIcon,
                                //   width: 20,
                                //   height: 20,
                                //   fit: pw.BoxFit.contain,
                                // ),
                                // pw.SizedBox(width: 5),
                              ]),
                          pw.SizedBox(height: 5),
                          Container(
                            height: 10,
                            color: PdfColors.blue,
                          ),
                          Container(
                            height: 7,
                            color: PdfColors.grey,
                          ),
                        ]),
                  ),
                ),
              ]),
            )),
        build: (context) {
          return [
            Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 50,
                  width: 550,
                  decoration: BoxDecoration(
                      color: PdfColor.fromHex('D89795'),
                      border: Border.all(width: 1, color: PdfColors.black)),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Text('FIRST LOGIC META LAB',
                              style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold,
                                  color: PdfColors.black)),
                        )
                      ]),
                ),
                Container(
                  height: 20,
                  decoration: BoxDecoration(
                      color: PdfColor.fromHex('F2DDDB'),
                      border: Border(
                        bottom: BorderSide(width: 1, color: PdfColors.black),
                        left: BorderSide(width: 1, color: PdfColors.black),
                        right: BorderSide(width: 1, color: PdfColors.black),
                      )),
                  child: Row(
                    children: [
                      Container(
                        width: 400,
                        decoration: BoxDecoration(
                            border: Border(
                          // bottom: BorderSide(width: 1, color: PdfColors.black),
                          // left: BorderSide(width: 1, color: PdfColors.black),
                          right: BorderSide(width: 1, color: PdfColors.black),
                        )),
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text('Salary Slip',
                                  style: TextStyle(
                                      fontSize: 8,
                                      fontWeight: FontWeight.bold,
                                      color: PdfColors.black))
                            ]),
                      ),
                      Container(
                        width: 100,
                        decoration: BoxDecoration(
                            //   border:
                            //   Border(
                            //   bottom: BorderSide(width: 1, color: PdfColors.black),
                            //   left: BorderSide(width: 1, color: PdfColors.black),
                            //   right: BorderSide(width: 1, color: PdfColors.black),
                            // )
                            ),
                        child: Row(
                          children: [
                            Container(
                              width: 40,
                              decoration: BoxDecoration(
                                border: Border(
                                  // bottom: BorderSide(
                                  //     width: 1, color: PdfColors.black),
                                  // left: BorderSide(
                                  //     width: 1, color: PdfColors.black),
                                  right: BorderSide(
                                      width: 1, color: PdfColors.black),
                                ),
                              ),
                              child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text('Month',
                                        style: TextStyle(
                                            fontSize: 8,
                                            fontWeight: FontWeight.bold,
                                            color: PdfColors.black))
                                  ]),
                            ),
                            Container(
                              width: 60,
                              // decoration: BoxDecoration(
                              //     border: Border.all(
                              //         width: 1, color: PdfColors.black)),
                              child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    pw.Padding(
                                      padding: EdgeInsets.only(left: 5),
                                    child: Text(invoice.month!,
                                          style: TextStyle(
                                              fontSize: 8,
                                              fontWeight: FontWeight.bold,
                                              color: PdfColors.black)),
                                    ),
                                  ]),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                /// PERSONAL DETAILS
                Container(
                  height: 20,
                  decoration: BoxDecoration(
                      border: Border(
                    bottom: BorderSide(width: 1, color: PdfColors.black),
                    left: BorderSide(width: 1, color: PdfColors.black),
                    right: BorderSide(width: 1, color: PdfColors.black),
                  )),
                  child: Row(
                    children: [
                      Container(
                        width: 400,
                        decoration: BoxDecoration(
                            border: Border(
                          // bottom: BorderSide(width: 1, color: PdfColors.black),
                          // left: BorderSide(width: 1, color: PdfColors.black),
                          right: BorderSide(width: 1, color: PdfColors.black),
                        )),
                        child: Row(
                          children: [
                            Container(
                              width: 100,
                              decoration: BoxDecoration(
                                  border: Border(
                                // bottom: BorderSide(width: 1, color: PdfColors.black),
                                // left: BorderSide(width: 1, color: PdfColors.black),
                                right: BorderSide(
                                    width: 1, color: PdfColors.black),
                              )),
                              child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text('Employee Name',
                                        style: TextStyle(
                                            fontSize: 7,
                                            color: PdfColors.black))
                                  ]),
                            ),
                            Container(
                              width: 120,
                              decoration: BoxDecoration(
                                  border: Border(
                                // bottom: BorderSide(width: 1, color: PdfColors.black),
                                // left: BorderSide(width: 1, color: PdfColors.black),
                                right: BorderSide(
                                    width: 1, color: PdfColors.black),
                              )),
                              child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(invoice.name!,
                                        style: TextStyle(
                                            fontSize: 7,
                                            color: PdfColors.black))
                                  ]),
                            ),
                            Container(
                              width: 180,
                              child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text('Total Working Days',
                                        style: TextStyle(
                                            fontSize: 7,
                                            color: PdfColors.black))
                                  ]),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        width: 100,
                        decoration: BoxDecoration(
                            //   border:
                            //   Border(
                            //   bottom: BorderSide(width: 1, color: PdfColors.black),
                            //   left: BorderSide(width: 1, color: PdfColors.black),
                            //   right: BorderSide(width: 1, color: PdfColors.black),
                            // )
                            ),
                        child: Row(
                          children: [
                            Expanded(
                              child: Container(
                                // decoration: BoxDecoration(
                                //     border: Border.all(
                                //         width: 1, color: PdfColors.black)),
                                child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Text(invoice.workingDays.toString(),
                                          style: TextStyle(
                                              fontSize: 7,
                                              color: PdfColors.black))
                                    ]),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                /// EMPLOYEE CODE
                Container(
                  height: 20,
                  decoration: BoxDecoration(
                      border: Border(
                    bottom: BorderSide(width: 1, color: PdfColors.black),
                    left: BorderSide(width: 1, color: PdfColors.black),
                    right: BorderSide(width: 1, color: PdfColors.black),
                  )),
                  child: Row(
                    children: [
                      Container(
                        width: 400,
                        decoration: BoxDecoration(
                            border: Border(
                          // bottom: BorderSide(width: 1, color: PdfColors.black),
                          // left: BorderSide(width: 1, color: PdfColors.black),
                          right: BorderSide(width: 1, color: PdfColors.black),
                        )),
                        child: Row(
                          children: [
                            Container(
                              width: 100,
                              decoration: BoxDecoration(
                                  border: Border(
                                // bottom: BorderSide(width: 1, color: PdfColors.black),
                                // left: BorderSide(width: 1, color: PdfColors.black),
                                right: BorderSide(
                                    width: 1, color: PdfColors.black),
                              )),
                              child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text('Employee Code',
                                        style: TextStyle(
                                            fontSize: 7,
                                            color: PdfColors.black))
                                  ]),
                            ),
                            Container(
                              width: 120,
                              decoration: BoxDecoration(
                                  border: Border(
                                // bottom: BorderSide(width: 1, color: PdfColors.black),
                                // left: BorderSide(width: 1, color: PdfColors.black),
                                right: BorderSide(
                                    width: 1, color: PdfColors.black),
                              )),
                              child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(invoice.code!,
                                        style: TextStyle(
                                            fontSize: 7,
                                            color: PdfColors.black))
                                  ]),
                            ),
                            Container(
                              width: 180,
                              child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text('Number of Working Days Attended',
                                        style: TextStyle(
                                            fontSize: 7,
                                            color: PdfColors.black))
                                  ]),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        width: 100,
                        decoration: BoxDecoration(
                            //   border:
                            //   Border(
                            //   bottom: BorderSide(width: 1, color: PdfColors.black),
                            //   left: BorderSide(width: 1, color: PdfColors.black),
                            //   right: BorderSide(width: 1, color: PdfColors.black),
                            // )
                            ),
                        child: Row(
                          children: [
                            Expanded(
                              child: Container(
                                // decoration: BoxDecoration(
                                //     border: Border.all(
                                //         width: 1, color: PdfColors.black)),
                                child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Text(invoice.attended.toString(),
                                          style: TextStyle(
                                              fontSize: 7,
                                              color: PdfColors.black))
                                    ]),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                /// DESIGNATION
                Container(
                  height: 20,
                  decoration: BoxDecoration(
                      border: Border(
                    bottom: BorderSide(width: 1, color: PdfColors.black),
                    left: BorderSide(width: 1, color: PdfColors.black),
                    right: BorderSide(width: 1, color: PdfColors.black),
                  )),
                  child: Row(
                    children: [
                      Container(
                        width: 400,
                        decoration: BoxDecoration(
                            border: Border(
                          // bottom: BorderSide(width: 1, color: PdfColors.black),
                          // left: BorderSide(width: 1, color: PdfColors.black),
                          right: BorderSide(width: 1, color: PdfColors.black),
                        )),
                        child: Row(
                          children: [
                            Container(
                              width: 100,
                              decoration: BoxDecoration(
                                  border: Border(
                                // bottom: BorderSide(width: 1, color: PdfColors.black),
                                // left: BorderSide(width: 1, color: PdfColors.black),
                                right: BorderSide(
                                    width: 1, color: PdfColors.black),
                              )),
                              child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text('Designation',
                                        style: TextStyle(
                                            fontSize: 7,
                                            color: PdfColors.black))
                                  ]),
                            ),
                            Container(
                              width: 120,
                              decoration: BoxDecoration(
                                  border: Border(
                                // bottom: BorderSide(width: 1, color: PdfColors.black),
                                // left: BorderSide(width: 1, color: PdfColors.black),
                                right: BorderSide(
                                    width: 1, color: PdfColors.black),
                              )),
                              child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(invoice.designation!,
                                        style: TextStyle(
                                            fontSize: 7,
                                            color: PdfColors.black))
                                  ]),
                            ),
                            Container(
                              width: 180,
                              child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text('',
                                        style: TextStyle(
                                            fontSize: 7,
                                            color: PdfColors.black))
                                  ]),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        width: 100,
                        decoration: BoxDecoration(
                            //   border:
                            //   Border(
                            //   bottom: BorderSide(width: 1, color: PdfColors.black),
                            //   left: BorderSide(width: 1, color: PdfColors.black),
                            //   right: BorderSide(width: 1, color: PdfColors.black),
                            // )
                            ),
                        child: Row(
                          children: [
                            Expanded(
                              child: Container(
                                // decoration: BoxDecoration(
                                //     border: Border.all(
                                //         width: 1, color: PdfColors.black)),
                                child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Text('',
                                          style: TextStyle(
                                              fontSize: 7,
                                              color: PdfColors.black))
                                    ]),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                /// PAN
                Container(
                  height: 20,
                  decoration: BoxDecoration(
                      border: Border(
                    bottom: BorderSide(width: 1, color: PdfColors.black),
                    left: BorderSide(width: 1, color: PdfColors.black),
                    right: BorderSide(width: 1, color: PdfColors.black),
                  )),
                  child: Row(
                    children: [
                      Container(
                        width: 400,
                        decoration: BoxDecoration(
                            border: Border(
                          // bottom: BorderSide(width: 1, color: PdfColors.black),
                          // left: BorderSide(width: 1, color: PdfColors.black),
                          right: BorderSide(width: 1, color: PdfColors.black),
                        )),
                        child: Row(
                          children: [
                            Container(
                              width: 100,
                              decoration: BoxDecoration(
                                  border: Border(
                                // bottom: BorderSide(width: 1, color: PdfColors.black),
                                // left: BorderSide(width: 1, color: PdfColors.black),
                                right: BorderSide(
                                    width: 1, color: PdfColors.black),
                              )),
                              child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text('PAN',
                                        style: TextStyle(
                                            fontSize: 7,
                                            color: PdfColors.black))
                                  ]),
                            ),
                            Container(
                              width: 120,
                              decoration: BoxDecoration(
                                  border: Border(
                                // bottom: BorderSide(width: 1, color: PdfColors.black),
                                // left: BorderSide(width: 1, color: PdfColors.black),
                                right: BorderSide(
                                    width: 1, color: PdfColors.black),
                              )),
                              child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(invoice.pan!,
                                        style: TextStyle(
                                            fontSize: 7,
                                            color: PdfColors.black))
                                  ]),
                            ),
                            Container(
                              width: 180,
                              child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text('Leaves',
                                        style: TextStyle(
                                            fontSize: 6,
                                            fontWeight: FontWeight.bold,
                                            color: PdfColors.black))
                                  ]),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        width: 100,
                        decoration: BoxDecoration(
                            //   border:
                            //   Border(
                            //   bottom: BorderSide(width: 1, color: PdfColors.black),
                            //   left: BorderSide(width: 1, color: PdfColors.black),
                            //   right: BorderSide(width: 1, color: PdfColors.black),
                            // )
                            ),
                        child: Row(
                          children: [
                            Container(
                              width: 50,
                              decoration: BoxDecoration(
                                border: Border(
                                  // bottom: BorderSide(
                                  //     width: 1, color: PdfColors.black),
                                  // left: BorderSide(
                                  //     width: 1, color: PdfColors.black),
                                  right: BorderSide(
                                      width: 1, color: PdfColors.black),
                                ),
                              ),
                              child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text('P',
                                        style: TextStyle(
                                            fontSize: 8,
                                            fontWeight: FontWeight.bold,
                                            color: PdfColors.black))
                                  ]),
                            ),
                            Container(
                              width: 50,
                              // decoration: BoxDecoration(
                              //     border: Border.all(
                              //         width: 1, color: PdfColors.black)),
                              child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text('S',
                                        style: TextStyle(
                                            fontSize: 8,
                                            fontWeight: FontWeight.bold,
                                            color: PdfColors.black))
                                  ]),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                /// ACCOUNT NUMBER
                Container(
                  height: 20,
                  decoration: BoxDecoration(
                      border: Border(
                    bottom: BorderSide(width: 1, color: PdfColors.black),
                    left: BorderSide(width: 1, color: PdfColors.black),
                    right: BorderSide(width: 1, color: PdfColors.black),
                  )),
                  child: Row(
                    children: [
                      Container(
                        width: 400,
                        decoration: BoxDecoration(
                            border: Border(
                          // bottom: BorderSide(width: 1, color: PdfColors.black),
                          // left: BorderSide(width: 1, color: PdfColors.black),
                          right: BorderSide(width: 1, color: PdfColors.black),
                        )),
                        child: Row(
                          children: [
                            Container(
                              width: 100,
                              decoration: BoxDecoration(
                                  border: Border(
                                // bottom: BorderSide(width: 1, color: PdfColors.black),
                                // left: BorderSide(width: 1, color: PdfColors.black),
                                right: BorderSide(
                                    width: 1, color: PdfColors.black),
                              )),
                              child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text('Account Number',
                                        style: TextStyle(
                                            fontSize: 7,
                                            color: PdfColors.black))
                                  ]),
                            ),
                            Container(
                              width: 120,
                              decoration: BoxDecoration(
                                  border: Border(
                                // bottom: BorderSide(width: 1, color: PdfColors.black),
                                // left: BorderSide(width: 1, color: PdfColors.black),
                                right: BorderSide(
                                    width: 1, color: PdfColors.black),
                              )),
                              child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(invoice.accNumber!,
                                        style: TextStyle(
                                            fontSize: 7,
                                            color: PdfColors.black))
                                  ]),
                            ),
                            Container(
                              width: 180,
                              child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text('Leaves Taken',
                                        style: TextStyle(
                                            fontSize: 6,
                                            fontWeight: FontWeight.bold,
                                            color: PdfColors.black))
                                  ]),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        width: 100,
                        decoration: BoxDecoration(
                            //   border:
                            //   Border(
                            //   bottom: BorderSide(width: 1, color: PdfColors.black),
                            //   left: BorderSide(width: 1, color: PdfColors.black),
                            //   right: BorderSide(width: 1, color: PdfColors.black),
                            // )
                            ),
                        child: Row(
                          children: [
                            Container(
                              width: 50,
                              decoration: BoxDecoration(
                                border: Border(
                                  // bottom: BorderSide(
                                  //     width: 1, color: PdfColors.black),
                                  // left: BorderSide(
                                  //     width: 1, color: PdfColors.black),
                                  right: BorderSide(
                                      width: 1, color: PdfColors.black),
                                ),
                              ),
                              child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text('0',
                                        style: TextStyle(
                                            fontSize: 8,
                                            fontWeight: FontWeight.bold,
                                            color: PdfColors.black))
                                  ]),
                            ),
                            Container(
                              width: 50,
                              // decoration: BoxDecoration(
                              //     border: Border.all(
                              //         width: 1, color: PdfColors.black)),
                              child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text('0',
                                        style: TextStyle(
                                            fontSize: 8,
                                            fontWeight: FontWeight.bold,
                                            color: PdfColors.black))
                                  ]),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                /// BANK NAME
                Container(
                  height: 20,
                  decoration: BoxDecoration(
                      border: Border(
                    bottom: BorderSide(width: 1, color: PdfColors.black),
                    left: BorderSide(width: 1, color: PdfColors.black),
                    right: BorderSide(width: 1, color: PdfColors.black),
                  )),
                  child: Row(
                    children: [
                      Container(
                        width: 400,
                        decoration: BoxDecoration(
                            border: Border(
                          // bottom: BorderSide(width: 1, color: PdfColors.black),
                          // left: BorderSide(width: 1, color: PdfColors.black),
                          right: BorderSide(width: 1, color: PdfColors.black),
                        )),
                        child: Row(
                          children: [
                            Container(
                              width: 100,
                              decoration: BoxDecoration(
                                  border: Border(
                                // bottom: BorderSide(width: 1, color: PdfColors.black),
                                // left: BorderSide(width: 1, color: PdfColors.black),
                                right: BorderSide(
                                    width: 1, color: PdfColors.black),
                              )),
                              child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text('Bank Name',
                                        style: TextStyle(
                                            fontSize: 7,
                                            color: PdfColors.black))
                                  ]),
                            ),
                            Container(
                              width: 120,
                              decoration: BoxDecoration(
                                  border: Border(
                                // bottom: BorderSide(width: 1, color: PdfColors.black),
                                // left: BorderSide(width: 1, color: PdfColors.black),
                                right: BorderSide(
                                    width: 1, color: PdfColors.black),
                              )),
                              child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(invoice.bankName!,
                                        style: TextStyle(
                                            fontSize: 7,
                                            color: PdfColors.black))
                                  ]),
                            ),
                            Container(
                              width: 180,
                              child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text('Balance Leaves',
                                        style: TextStyle(
                                            fontSize: 6,
                                            fontWeight: FontWeight.bold,
                                            color: PdfColors.black))
                                  ]),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        width: 100,
                        decoration: BoxDecoration(
                            //   border:
                            //   Border(
                            //   bottom: BorderSide(width: 1, color: PdfColors.black),
                            //   left: BorderSide(width: 1, color: PdfColors.black),
                            //   right: BorderSide(width: 1, color: PdfColors.black),
                            // )
                            ),
                        child: Row(
                          children: [
                            Container(
                              width: 50,
                              decoration: BoxDecoration(
                                border: Border(
                                  // bottom: BorderSide(
                                  //     width: 1, color: PdfColors.black),
                                  // left: BorderSide(
                                  //     width: 1, color: PdfColors.black),
                                  right: BorderSide(
                                      width: 1, color: PdfColors.black),
                                ),
                              ),
                              child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text('',
                                        style: TextStyle(
                                            fontSize: 8,
                                            fontWeight: FontWeight.bold,
                                            color: PdfColors.black))
                                  ]),
                            ),
                            Container(
                              width: 50,
                              // decoration: BoxDecoration(
                              //     border: Border.all(
                              //         width: 1, color: PdfColors.black)),
                              child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text('',
                                        style: TextStyle(
                                            fontSize: 8,
                                            fontWeight: FontWeight.bold,
                                            color: PdfColors.black))
                                  ]),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                
                Container(
                  height: 20,
                  decoration: BoxDecoration(
                      border: Border(
                    bottom: BorderSide(width: 1, color: PdfColors.black),
                    left: BorderSide(width: 1, color: PdfColors.black),
                    right: BorderSide(width: 1, color: PdfColors.black),
                  )),
                ),

                /// INCOME AND DEDUCTIONS
                Container(
                  height: 20,
                  decoration: BoxDecoration(
                      color: PdfColor.fromHex('D89795'),
                      border: Border(
                        top: BorderSide(width: 1, color: PdfColors.black),
                        bottom: BorderSide(width: 1, color: PdfColors.black),
                        left: BorderSide(width: 1, color: PdfColors.black),
                        right: BorderSide(width: 1, color: PdfColors.black),
                      )),
                  child: Row(
                    children: [
                      Container(
                        width: 220,
                        decoration: BoxDecoration(
                            border: Border(
                          // bottom: BorderSide(width: 1, color: PdfColors.black),
                          // left: BorderSide(width: 1, color: PdfColors.black),
                          right: BorderSide(width: 1, color: PdfColors.black),
                        )),
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text('Income',
                                  style: TextStyle(
                                      fontSize: 7,
                                      fontWeight: FontWeight.bold,
                                      color: PdfColors.black))
                            ]),
                      ),
                      Container(
                        width: 280,
                        decoration: BoxDecoration(
                            //   border:
                            //   Border(
                            //   bottom: BorderSide(width: 1, color: PdfColors.black),
                            //   left: BorderSide(width: 1, color: PdfColors.black),
                            //   right: BorderSide(width: 1, color: PdfColors.black),
                            // )
                            ),
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text('Deductions',
                                  style: TextStyle(
                                      fontSize: 7,
                                      fontWeight: FontWeight.bold,
                                      color: PdfColors.black))
                            ]),
                      ),
                    ],
                  ),
                ),

                ///SUB HEAD

                Container(
                  height: 20,
                  decoration: BoxDecoration(
                      color: PdfColor.fromHex('F2DDDB'),
                      border: Border(
                        bottom: BorderSide(width: 1, color: PdfColors.black),
                        left: BorderSide(width: 1, color: PdfColors.black),
                        right: BorderSide(width: 1, color: PdfColors.black),
                      )),
                  child: Row(
                    children: [
                      Container(
                        width: 100,
                        decoration: BoxDecoration(
                            border: Border(
                          // bottom: BorderSide(width: 1, color: PdfColors.black),
                          // left: BorderSide(width: 1, color: PdfColors.black),
                          right: BorderSide(width: 1, color: PdfColors.black),
                        )),
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text('Particulars',
                                  style: TextStyle(
                                      fontSize: 7, color: PdfColors.black))
                            ]),
                      ),
                      Container(
                        width: 120,
                        decoration: BoxDecoration(
                            border: Border(
                          // bottom: BorderSide(width: 1, color: PdfColors.black),
                          // left: BorderSide(width: 1, color: PdfColors.black),
                          right: BorderSide(width: 1, color: PdfColors.black),
                        )),
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text('Amount',
                                  style: TextStyle(
                                      fontSize: 7, color: PdfColors.black))
                            ]),
                      ),
                      Container(
                        width: 180,
                        decoration: BoxDecoration(
                            border: Border(
                          // bottom: BorderSide(width: 1, color: PdfColors.black),
                          // left: BorderSide(width: 1, color: PdfColors.black),
                          right: BorderSide(width: 1, color: PdfColors.black),
                        )),
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text('Particulars',
                                  style: TextStyle(
                                      fontSize: 7, color: PdfColors.black))
                            ]),
                      ),
                      Container(
                        width: 100,
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text('Amount',
                                  style: TextStyle(
                                      fontSize: 7, color: PdfColors.black))
                            ]),
                      ),
                    ],
                  ),
                ),

                ///CONTENTS
                Container(
                  width: 550,
                  height: 20,
                  decoration: BoxDecoration(
                      border: Border(
                    bottom: BorderSide(width: 1, color: PdfColors.black),
                    left: BorderSide(width: 1, color: PdfColors.black),
                    right: BorderSide(width: 1, color: PdfColors.black),
                  )),
                  child: Row(
                    children: [
                      Container(
                        width: 100,
                        decoration: BoxDecoration(
                            border: Border(
                          // bottom: BorderSide(width: 1, color: PdfColors.black),
                          // left: BorderSide(width: 1, color: PdfColors.black),
                          right: BorderSide(width: 1, color: PdfColors.black),
                        )),
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 3.0),
                                child: Text('Basic Salary',
                                    style: TextStyle(
                                        fontSize: 7, color: PdfColors.black)),
                              )
                            ]),
                      ),
                      Container(
                        width: 120,
                        decoration: BoxDecoration(
                            border: Border(
                          // bottom: BorderSide(width: 1, color: PdfColors.black),
                          // left: BorderSide(width: 1, color: PdfColors.black),
                          right: BorderSide(width: 1, color: PdfColors.black),
                        )),
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(right: 3.0),
                                child: Text(invoice.basicPay.toString(),
                                    style: TextStyle(
                                        fontSize: 7, color: PdfColors.black)),
                              )
                            ]),
                      ),
                      Container(
                        width: 180,
                        decoration: BoxDecoration(
                            border: Border(
                          // bottom: BorderSide(width: 1, color: PdfColors.black),
                          // left: BorderSide(width: 1, color: PdfColors.black),
                          right: BorderSide(width: 1, color: PdfColors.black),
                        )),
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 3.0),
                                child: Text('Advance',
                                    style: TextStyle(
                                        fontSize: 7, color: PdfColors.black)),
                              )
                            ]),
                      ),
                      Container(
                        width: 100,
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(invoice.advance!,
                                  style: TextStyle(
                                      fontSize: 7, color: PdfColors.black))
                            ]),
                      ),
                    ],
                  ),
                ),
                Container(
                  height: 20,
                  decoration: BoxDecoration(
                      border: Border(
                    bottom: BorderSide(width: 1, color: PdfColors.black),
                    left: BorderSide(width: 1, color: PdfColors.black),
                    right: BorderSide(width: 1, color: PdfColors.black),
                  )),
                  child: Row(
                    children: [
                      Container(
                        width: 100,
                        decoration: BoxDecoration(
                            border: Border(
                          // bottom: BorderSide(width: 1, color: PdfColors.black),
                          // left: BorderSide(width: 1, color: PdfColors.black),
                          right: BorderSide(width: 1, color: PdfColors.black),
                        )),
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 3.0),
                                child: Text('Dearness Allowance',
                                    style: TextStyle(
                                        fontSize: 7, color: PdfColors.black)),
                              )
                            ]),
                      ),
                      Container(
                        width: 120,
                        decoration: BoxDecoration(
                            border: Border(
                          // bottom: BorderSide(width: 1, color: PdfColors.black),
                          // left: BorderSide(width: 1, color: PdfColors.black),
                          right: BorderSide(width: 1, color: PdfColors.black),
                        )),
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(right: 3.0),
                                child: Text(invoice.dearnessAllo!,
                                    style: TextStyle(
                                        fontSize: 7, color: PdfColors.black)),
                              )
                            ]),
                      ),
                      Container(
                        width: 180,
                        decoration: BoxDecoration(
                            border: Border(
                          // bottom: BorderSide(width: 1, color: PdfColors.black),
                          // left: BorderSide(width: 1, color: PdfColors.black),
                          right: BorderSide(width: 1, color: PdfColors.black),
                        )),
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 3.0),
                                child: Text('PTO (Paid Time Off)',
                                    style: TextStyle(
                                        fontSize: 7, color: PdfColors.black)),
                              )
                            ]),
                      ),
                      Container(
                        width: 75,
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(invoice.pto!,
                                  style: TextStyle(
                                      fontSize: 7, color: PdfColors.black))
                            ]),
                      ),
                    ],
                  ),
                ),
                Container(
                  height: 20,
                  decoration: BoxDecoration(
                      border: Border(
                    bottom: BorderSide(width: 1, color: PdfColors.black),
                    left: BorderSide(width: 1, color: PdfColors.black),
                    right: BorderSide(width: 1, color: PdfColors.black),
                  )),
                  child: Row(
                    children: [
                      Container(
                        width: 100,
                        decoration: BoxDecoration(
                            border: Border(
                          // bottom: BorderSide(width: 1, color: PdfColors.black),
                          // left: BorderSide(width: 1, color: PdfColors.black),
                          right: BorderSide(width: 1, color: PdfColors.black),
                        )),
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 3.0),
                                child: Text('HRA',
                                    style: TextStyle(
                                        fontSize: 7, color: PdfColors.black)),
                              )
                            ]),
                      ),
                      Container(
                        width: 120,
                        decoration: BoxDecoration(
                            border: Border(
                          // bottom: BorderSide(width: 1, color: PdfColors.black),
                          // left: BorderSide(width: 1, color: PdfColors.black),
                          right: BorderSide(width: 1, color: PdfColors.black),
                        )),
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(right: 3.0),
                                child: Text(invoice.hra!,
                                    style: TextStyle(
                                        fontSize: 7, color: PdfColors.black)),
                              )
                            ]),
                      ),
                      Container(
                        width: 180,
                        decoration: BoxDecoration(
                            border: Border(
                          // bottom: BorderSide(width: 1, color: PdfColors.black),
                          // left: BorderSide(width: 1, color: PdfColors.black),
                          right: BorderSide(width: 1, color: PdfColors.black),
                        )),
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 3.0),
                                child: Text('',
                                    style: TextStyle(
                                        fontSize: 7, color: PdfColors.black)),
                              )
                            ]),
                      ),
                      Container(
                        width: 75,
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text('',
                                  style: TextStyle(
                                      fontSize: 7, color: PdfColors.black))
                            ]),
                      ),
                    ],
                  ),
                ),
                Container(
                  height: 20,
                  decoration: BoxDecoration(
                      border: Border(
                    bottom: BorderSide(width: 1, color: PdfColors.black),
                    left: BorderSide(width: 1, color: PdfColors.black),
                    right: BorderSide(width: 1, color: PdfColors.black),
                  )),
                  child: Row(
                    children: [
                      Container(
                        width: 100,
                        decoration: BoxDecoration(
                            border: Border(
                          // bottom: BorderSide(width: 1, color: PdfColors.black),
                          // left: BorderSide(width: 1, color: PdfColors.black),
                          right: BorderSide(width: 1, color: PdfColors.black),
                        )),
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 3.0),
                                child: Text('Special Allowance',
                                    style: TextStyle(
                                        fontSize: 7, color: PdfColors.black)),
                              )
                            ]),
                      ),
                      Container(
                        width: 120,
                        decoration: BoxDecoration(
                            border: Border(
                          // bottom: BorderSide(width: 1, color: PdfColors.black),
                          // left: BorderSide(width: 1, color: PdfColors.black),
                          right: BorderSide(width: 1, color: PdfColors.black),
                        )),
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(right: 3.0),
                                child: Text(invoice.spAllowance!,
                                    style: TextStyle(
                                        fontSize: 7, color: PdfColors.black)),
                              )
                            ]),
                      ),
                      Container(
                        width: 180,
                        decoration: BoxDecoration(
                            border: Border(
                          // bottom: BorderSide(width: 1, color: PdfColors.black),
                          // left: BorderSide(width: 1, color: PdfColors.black),
                          right: BorderSide(width: 1, color: PdfColors.black),
                        )),
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 3.0),
                                child: Text('',
                                    style: TextStyle(
                                        fontSize: 7, color: PdfColors.black)),
                              )
                            ]),
                      ),
                      Container(
                        width: 75,
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text('',
                                  style: TextStyle(
                                      fontSize: 7, color: PdfColors.black))
                            ]),
                      ),
                    ],
                  ),
                ),
                Container(
                  height: 20,
                  decoration: BoxDecoration(
                      border: Border(
                    bottom: BorderSide(width: 1, color: PdfColors.black),
                    left: BorderSide(width: 1, color: PdfColors.black),
                    right: BorderSide(width: 1, color: PdfColors.black),
                  )),
                  child: Row(
                    children: [
                      Container(
                        width: 100,
                        decoration: BoxDecoration(
                            border: Border(
                          // bottom: BorderSide(width: 1, color: PdfColors.black),
                          // left: BorderSide(width: 1, color: PdfColors.black),
                          right: BorderSide(width: 1, color: PdfColors.black),
                        )),
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 3.0),
                                child: Text('City Compensatory Allowance',
                                    style: TextStyle(
                                        fontSize: 7, color: PdfColors.black)),
                              )
                            ]),
                      ),
                      Container(
                        width: 120,
                        decoration: BoxDecoration(
                            border: Border(
                          // bottom: BorderSide(width: 1, color: PdfColors.black),
                          // left: BorderSide(width: 1, color: PdfColors.black),
                          right: BorderSide(width: 1, color: PdfColors.black),
                        )),
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(right: 3.0),
                                child: Text(invoice.cityAllow!,
                                    style: TextStyle(
                                        fontSize: 7, color: PdfColors.black)),
                              )
                            ]),
                      ),
                      Container(
                        width: 180,
                        decoration: BoxDecoration(
                            border: Border(
                          // bottom: BorderSide(width: 1, color: PdfColors.black),
                          // left: BorderSide(width: 1, color: PdfColors.black),
                          right: BorderSide(width: 1, color: PdfColors.black),
                        )),
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 3.0),
                                child: Text('',
                                    style: TextStyle(
                                        fontSize: 7, color: PdfColors.black)),
                              )
                            ]),
                      ),
                      Container(
                        width: 75,
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text('',
                                  style: TextStyle(
                                      fontSize: 7, color: PdfColors.black))
                            ]),
                      ),
                    ],
                  ),
                ),
                Container(
                  height: 20,
                  decoration: BoxDecoration(
                      border: Border(
                    bottom: BorderSide(width: 1, color: PdfColors.black),
                    left: BorderSide(width: 1, color: PdfColors.black),
                    right: BorderSide(width: 1, color: PdfColors.black),
                  )),
                  child: Row(
                    children: [
                      Container(
                        width: 100,
                        decoration: BoxDecoration(
                            border: Border(
                          // bottom: BorderSide(width: 1, color: PdfColors.black),
                          // left: BorderSide(width: 1, color: PdfColors.black),
                          right: BorderSide(width: 1, color: PdfColors.black),
                        )),
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 3.0),
                                child: Text('Incentives',
                                    style: TextStyle(
                                        fontSize: 7, color: PdfColors.black)),
                              )
                            ]),
                      ),
                      Container(
                        width: 120,
                        decoration: BoxDecoration(
                            border: Border(
                          // bottom: BorderSide(width: 1, color: PdfColors.black),
                          // left: BorderSide(width: 1, color: PdfColors.black),
                          right: BorderSide(width: 1, color: PdfColors.black),
                        )),
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 3.0),
                                child: Text(invoice.incentives!,
                                    style: TextStyle(
                                        fontSize: 7, color: PdfColors.black)),
                              )
                            ]),
                      ),
                      Container(
                        width: 180,
                        decoration: BoxDecoration(
                            border: Border(
                          // bottom: BorderSide(width: 1, color: PdfColors.black),
                          // left: BorderSide(width: 1, color: PdfColors.black),
                          right: BorderSide(width: 1, color: PdfColors.black),
                        )),
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(right: 3.0),
                                child: Text('',
                                    style: TextStyle(
                                        fontSize: 7, color: PdfColors.black)),
                              )
                            ]),
                      ),
                      Container(
                        width: 75,
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 3.0),
                                child: Text('',
                                    style: TextStyle(
                                        fontSize: 7, color: PdfColors.black)),
                              )
                            ]),
                      ),
                    ],
                  ),
                ),
                Container(
                  height: 20,
                  decoration: BoxDecoration(
                      border: Border(
                    bottom: BorderSide(width: 1, color: PdfColors.black),
                    left: BorderSide(width: 1, color: PdfColors.black),
                    right: BorderSide(width: 1, color: PdfColors.black),
                  )),
                  child: Row(
                    children: [
                      Container(
                        width: 100,
                        decoration: BoxDecoration(
                            border: Border(
                          // bottom: BorderSide(width: 1, color: PdfColors.black),
                          // left: BorderSide(width: 1, color: PdfColors.black),
                          right: BorderSide(width: 1, color: PdfColors.black),
                        )),
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 3.0),
                                child: Text('Medical Allowance',
                                    style: TextStyle(
                                        fontSize: 7, color: PdfColors.black)),
                              )
                            ]),
                      ),
                      Container(
                        width: 120,
                        decoration: BoxDecoration(
                            border: Border(
                          // bottom: BorderSide(width: 1, color: PdfColors.black),
                          // left: BorderSide(width: 1, color: PdfColors.black),
                          right: BorderSide(width: 1, color: PdfColors.black),
                        )),
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(right: 3.0),
                                child: Text(invoice.medicalAlowance!,
                                    style: TextStyle(
                                        fontSize: 7, color: PdfColors.black)),
                              )
                            ]),
                      ),
                      Container(
                        width: 180,
                        decoration: BoxDecoration(
                            border: Border(
                          // bottom: BorderSide(width: 1, color: PdfColors.black),
                          // left: BorderSide(width: 1, color: PdfColors.black),
                          right: BorderSide(width: 1, color: PdfColors.black),
                        )),
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 3.0),
                                child: Text('',
                                    style: TextStyle(
                                        fontSize: 7, color: PdfColors.black)),
                              )
                            ]),
                      ),
                      Container(
                        width: 75,
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 3.0),
                                child: Text('',
                                    style: TextStyle(
                                        fontSize: 7, color: PdfColors.black)),
                              )
                            ]),
                      ),
                    ],
                  ),
                ),
                Container(
                  height: 20,
                  decoration: BoxDecoration(
                      border: Border(
                    bottom: BorderSide(width: 1, color: PdfColors.black),
                    left: BorderSide(width: 1, color: PdfColors.black),
                    right: BorderSide(width: 1, color: PdfColors.black),
                  )),
                  child: Row(
                    children: [
                      Container(
                        width: 100,
                        decoration: BoxDecoration(
                            border: Border(
                          // bottom: BorderSide(width: 1, color: PdfColors.black),
                          // left: BorderSide(width: 1, color: PdfColors.black),
                          right: BorderSide(width: 1, color: PdfColors.black),
                        )),
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 3.0),
                                child: Text('Total',
                                    style: TextStyle(
                                        fontSize: 7, color: PdfColors.black)),
                              )
                            ]),
                      ),
                      Container(
                        width: 120,
                        decoration: BoxDecoration(
                            border: Border(
                          // bottom: BorderSide(width: 1, color: PdfColors.black),
                          // left: BorderSide(width: 1, color: PdfColors.black),
                          right: BorderSide(width: 1, color: PdfColors.black),
                        )),
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(right: 3.0),
                                child: Text(invoice.total.toString(),
                                    style: TextStyle(
                                        fontSize: 7, color: PdfColors.black)),
                              )
                            ]),
                      ),
                      Container(
                        width: 180,
                        decoration: BoxDecoration(
                            border: Border(
                          // bottom: BorderSide(width: 1, color: PdfColors.black),
                          // left: BorderSide(width: 1, color: PdfColors.black),
                          right: BorderSide(width: 1, color: PdfColors.black),
                        )),
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 3.0),
                                child: Text('Total',
                                    style: TextStyle(
                                        fontSize: 7, color: PdfColors.black)),
                              )
                            ]),
                      ),
                      Container(
                        width: 75,
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(invoice.totalDeduction!,
                                  style: TextStyle(
                                      fontSize: 7, color: PdfColors.black))
                            ]),
                      ),
                    ],
                  ),
                ),

                Container(
                  height: 20,
                  decoration: BoxDecoration(
                      border: Border(
                    bottom: BorderSide(width: 1, color: PdfColors.black),
                    left: BorderSide(width: 1, color: PdfColors.black),
                    right: BorderSide(width: 1, color: PdfColors.black),
                  )),
                ),

                ///NET SALARY
                Container(
                  height: 20,
                  decoration: BoxDecoration(
                      color: PdfColor.fromHex('D89795'),
                      border: Border(
                        top: BorderSide(width: 1, color: PdfColors.black),
                        bottom: BorderSide(width: 1, color: PdfColors.black),
                        left: BorderSide(width: 1, color: PdfColors.black),
                        right: BorderSide(width: 1, color: PdfColors.black),
                      )),
                  child: Row(
                    children: [
                      Container(
                        width: 400,
                        decoration: BoxDecoration(
                            border: Border(
                          // bottom: BorderSide(width: 1, color: PdfColors.black),
                          // left: BorderSide(width: 1, color: PdfColors.black),
                          right: BorderSide(width: 1, color: PdfColors.black),
                        )),
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text('Net Salary',
                                  style: TextStyle(
                                      fontSize: 8,
                                      fontWeight: FontWeight.bold,
                                      color: PdfColors.black))
                            ]),
                      ),
                      Container(
                        width: 75,
                        decoration: BoxDecoration(
                            //   border:
                            //   Border(
                            //   bottom: BorderSide(width: 1, color: PdfColors.black),
                            //   left: BorderSide(width: 1, color: PdfColors.black),
                            //   right: BorderSide(width: 1, color: PdfColors.black),
                            // )
                            ),
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text('${invoice.netSalary} /-',
                                  style: TextStyle(
                                      fontSize: 8, color: PdfColors.black))
                            ]),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 10),
                Container(
                  height: 20,
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Verified, Signature not Required.',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 7,
                            ))
                      ]),
                ),

                ///
              ],
            ),
          ),
          ];
        },
      ),
    );

    var data = await pdf.save();
    Uint8List bytes = Uint8List.fromList(data);

    //WEB DOWNLOAD

    // // var data = await pdf.save();
    // // Uint8List bytes = Uint8List.fromList(data);
    // final blob = html.Blob([bytes], 'application/pdf');
    // final url = html.Url.createObjectUrlFromBlob(blob);
    // final anchor = html.document.createElement('a') as html.AnchorElement
    //   ..href = url
    //   ..style.display = 'none'
    //   ..download = '${invoice.name}.pdf';
    //
    // html.document.body.children.add(anchor);
    // anchor.click();
    // html.document.body.children.remove(anchor);
    // html.Url.revokeObjectUrl(url);

    uploadFileToFireBase(invoice.name!, bytes, 'pdf', employeeDetails,
        employeeAttendance, empId, lastDay,selectedDay);
///
    //android
    // return PdfApi.saveDocument(name: '${invoice.name}+feedetail.pdf', pdf: pdf);
  }

  ///
  static uploadFileToFireBase(
      String name,
      fileBytes,
      String ext,
      Map employeeDetails,
      Map employeeAttendance,
      String empId,
      int lastDay,
      DateTime selectedDay,
      ) async {
    // final path='file/${pickFile.name}';
    // final file=File(pickFile.path);

    // final ref=FirebaseStorage.instance.ref().child(path);
    // uploadTask = ref.putFile(file);

    var uploadTask = FirebaseStorage.instance
        .ref('Pay Slips/${dateTimeFormat('MMMM y', selectedDay)}/BankSlip--$name.$ext')
        .putData(fileBytes);
    final snapshot = await uploadTask.whenComplete(() {});
    snapshot.ref.getDownloadURL().then((url) {
      sendMail(url, employeeDetails, employeeAttendance, empId, lastDay,selectedDay);
    });
  }

  ///
  static sendMail(String url, Map employeeDetails, Map employeeAttendance,
      String empId, int lastDay,DateTime selectedDay) {
    // String html = '<!DOCTYPE html>'
    //     '<html>'
    //     '<head>'
    //     '<title>Salary Slip</title>'
    //     '</head>'
    //     ' <body>'
    //     '<header>'
    //     '<img src="https://firebasestorage.googleapis.com/v0/b/first-logic-erp.appspot.com/o/fl_new.png?alt=media&token=2300d95a-a061-4b9c-a06d-8e3f5906c24f" style="width:120px" alt="Company Logo">'
    //     '<h1>First Logic Meta Lab</h1>'
    //     '</header>'
    //     ' <section>'
    //     ' <h2>Employee Information</h2>'
    //     ' <ul>'
    //     ' <li>Name: John Doe</li>'
    //     ' <li>Employee ID: 12345</li>'
    //     ' <li>Department: Finance</li>'
    //     ' </ul>'
    //     ' </section>'
    //     '<section>'
    //     '<h2>Salary Details</h2>'
    //     '<ul>'
    //     '<li>Gross Salary: \$5,000</li>'
    //     '<li>Deductions: \$500</li>'
    //     '<li>Net Salary: \$4,500</li>'
    //     '</ul>'
    //     '</section>'
    //     '<section>'
    //     '<h2>Payment Details</h2>'
    //     '<ul>'
    //     '<li>Bank Account Number: 123456789</li>'
    //     '<li>Payment Date: 01/01/2023</li>'
    //     '</ul>'
    //     '</section>'
    //     ' <footer>'
    //     ' <p>Contact us at: <a href="mailto:hr@firstlogicmetalab.com">hr@firstlogicmetalab.com</a></p>'
    //     ' <p>Legal Disclosures: This salary slip is for informational purposes only and should not be considered as an official document.</p>'
    //     '</footer>'
    //     ' </body>'
    //     '</html>';

    // String html = '<html>'
    //     '<head>'
    //     '<meta name="viewport" content="width=device-width, initial-scale=1">'
    //     '<link href="https://fonts.googleapis.com/css2?family=Gotham:wght@400;700&display=swap" rel="stylesheet">'
    //     '<style>'
    //     'body {'
    //     'font-family: "Gotham", sans-serif;'
    //     '}'
    //     '.header {'
    //     'background-color: #0058ff;'
    //     'color: #fff;'
    //     'text-align: center;'
    //     'padding: 10px;'
    //     'display: flex;'
    //     'align-items: center;'
    //     ' }'
    //     '.header img {'
    //     ' margin-right: 20px;'
    //     '}'
    //     '.container {'
    //     'width: 80%;'
    //     'margin: 0 auto;'
    //     'background-color: #f2f2f2;'
    //     'padding: 20px;'
    //     ' }'
    //     'table {'
    //     'width: 100%;'
    //     'border-collapse: collapse;'
    //     'margin-top: 20px;'
    //     '}'
    //     'th,'
    //     'td {'
    //     'border: 1px solid #333;'
    //     'padding: 10px;'
    //     '}'
    //     'th {'
    //     'background-color: #0058ff;'
    //     ' color: #fff;'
    //     '}'
    //     '@media (max-width: 767px) {'
    //     '.container {'
    //     'width: 90%;'
    //     '}'
    //     'th,'
    //     'td {'
    //     'font-size: 14px;'
    //     ' }'
    //     ' }'
    //     '</style>'
    //     ' </head>'
    //     '<body>'
    //     '<div class="header">'
    //     ' <img src="https://via.placeholder.com/50x50" alt="Company Logo" />'
    //     '<h3>First Logic Meta Lab Pvt. Ltd</h3>'
    //     '</div>'
    //     '<div class="container">'
    //     '<p>'
    //     'Dear [Employee Name],'
    //     '</p>'
    //     '<p>'
    //     'I hope this email finds you in good health and spirits. I am writing to'
    //     'inform you that your salary for the month of [Month, Year] has been'
    //     'credited to your account.'
    //     '</p>'
    //     '<p>'
    //     'Your total salary amount is [Amount]. Please find the details of your'
    //     'leaves below:'
    //     '</p>'
    //     '<p>'
    //     'In case of any discrepancy, please bring it to our notice within 2 days.'
    //     'We would be happy to assist you with any questions or concerns you may'
    //     'have.'
    //     ' </p>'
    //     ' <p>'
    //     ' Thank you for your continued contributions to the company.'
    //     ' </p>'
    //     '<p>'
    //     'Best regards,<br />'
    //     'HR Manager'
    //     '</p>'
    //     '</div>'
    //     ' </body>'
    //     '</html>';
    // '<html>'
    // '<head>'
    // '<title>Salary Credit Notification</title>'
    // ' </head>'
    // '<body>'
    // '<header>'
    // '<img src="https://firebasestorage.googleapis.com/v0/b/first-logic-erp.appspot.com/o/new_logo.jpeg?alt=media&token=981d964a-7480-420d-a9c6-341e8948922b" style="width:100px" alt="Company Logo">'
    // //     '<h1>First Logic Meta Lab</h1>'
    // '</header>'
    // '<p>Dear <b>Employee</b>,</p>'
    // '<p>I hope this email finds you in good health and spirits. I am writing to inform you that your salary for the month of <b>${dateTimeFormat('MMM y', DateTime(
    //       DateTime.now().year,
    //       DateTime.now().month - 1,
    //       DateTime.now().day,
    //     ))}</b> has been credited to your account.</p>'
    // '<p>Your total salary amount is <b>₹10000</b>. Please find the details of your leaves below:</p>'
    // '<br>'
    // '<ul>'
    // '<li>Total Working Days: 26</li>'
    // '<li>Number of Leaves: 10</li>'
    // '</ul>'
    // '<br>'
    // '<p>In case of any discrepancy, please bring it to our notice within 2 days. We would be happy to assist you with any questions or concerns you may have.</p>'
    // '<p>Thank you for your continued contributions to the company.</p>'
    // '<br>'
    // '<p>Best regards,</p>'
    // '<p>HR Manager<br>'
    // 'First Logic Meta Lab Pvt. Ltd</p>'
    // '</body>'
    // '</html>';

    String html = '<html>'
        '<head>'
        '<meta name="viewport" content="width=device-width, initial-scale=1">'
        '<link href="https://fonts.googleapis.com/css2?family=Gotham:wght@400;700&display=swap" rel="stylesheet">'
        '<style>'
        'body {'
        'font-family: "Gotham", sans-serif;'
        '}'
        '.header {'
        'background-color: #0058ff;'
        'color: #fff;'
        'text-align: center;'
        'padding: 10px;'
        'display: flex;'
        'align-items: center;'
        ' }'
        '.header img {'
        ' margin-right: 20px;'
        '}'
        '.container {'
        'width: 80%;'
        'margin: 0 auto;'
        'background-color: #f2f2f2;'
        'padding: 20px;'
        ' }'
        'table {'
        'width: 100%;'
        'border-collapse: collapse;'
        'margin-top: 20px;'
        '}'
        'th,'
        'td {'
        'border: 1px solid #333;'
        'padding: 10px;'
        '}'
        'th {'
        'background-color: #0058ff;'
        ' color: #fff;'
        '}'
        '@media (max-width: 767px) {'
        '.container {'
        'width: 90%;'
        '}'
        'th,'
        'td {'
        'font-size: 14px;'
        ' }'
        ' }'
        '</style>'
        ' </head>'
        '<body>'
        '<div class="header">'
        ' <img src="https://firebasestorage.googleapis.com/v0/b/first-logic-erp.appspot.com/o/webicon-01.png?alt=media&token=424afef7-b36f-47e0-aa12-ec5dd178085b" style="width:50px;height:50px;" alt="Company Logo" />'
        '<h3>First Logic Meta Lab Pvt. Ltd</h3>'
        '</div>'
        '<div class="container">'
        '<p>'
        'Dear <b>${empDataById[empId]!.name}</b>,'
        '</p>'
        '<p>'
        'I hope this email finds you in good health and spirits. I am writing to '
        'inform you that your salary for the month of <b>${dateTimeFormat('MMM y', selectedDay)}</b> has been '
        'credited to your account.'
        '</p>'
        '<p>'
        'Your total salary amount is <b>₹${employeeDetails[empId]['takeHome']}</b>.'
        ' Please find the details below:'
        '</p>'
        ' <section>'
        ' <h2>Employee Information</h2>'
        ' <ul>'
        ' <li>Name: ${empDataById[empId]!.name}</li>'
        ' <li>Employee ID: ${empDataById[empId]!.empId}</li>'
        ' <li>Total Working Days: ${(lastDay - (employeeDetails[empId]['offDay'] ?? 0))}</li>'
        '<li>Number of Leaves: ${employeeDetails[empId]['leave']}</li>'
        ' </ul>'
        ' </section>';

    html += '<section>'
        '<h2>Salary Details</h2>'
        '<ul>'
        '<li>Basic Salary: ₹${empDataById[empId]!.ctc}</li>'
        '<li>Payable Salary: ₹${employeeDetails[empId]['payable']}</li>';

    html += employeeDetails[empId]['incentive'] == 0
        ? ''
        : '<li>Incentive: ₹${employeeDetails[empId]['incentive']}</li>';

    html += employeeDetails[empId]['ot'] == 0
        ? ''
        : '<li>Over Time: ₹${employeeDetails[empId]['ot']}</li>';

    html += employeeDetails[empId]['deduction'] == 0
        ? ''
        : '<li>Deductions: ₹${employeeDetails[empId]['deduction']}</li>';

    html += '<li>Take Home: ₹${employeeDetails[empId]['takeHome']}</li>'
        '</ul>'
        '</section>'
        '<p>'
        'In case of any discrepancy, please bring it to our notice within 2 days. '
        'We would be happy to assist you with any questions or concerns you may '
        'have.'
        ' </p>'
        ' <p>'
        ' Thank you for your continued contributions to the company.'
        ' </p>'
        '<p>'
        'Best regards,<br />'
        'HR Manager'
        '</p>'
        '</div>'
        ' </body>'
        '</html>';

    FirebaseFirestore.instance.collection('mail').add({
      'html': html,
      'status': 'Salary Information',
      'att': url,
      'emailList': [empDataById[empId]!.email],
      'date':FieldValue.serverTimestamp(),
    }).then((value) {
      FirebaseFirestore.instance
          .collection('employees')
          .doc(empId)
          .collection('attendance')
          .doc(dateTimeFormat('MMM y', selectedDay))
          .set({
        'attendance': employeeAttendance[empId] ?? {},
        'month': dateTimeFormat('MMM y', selectedDay),
      });

      FirebaseFirestore.instance
          .collection('employees')
          .doc(empId)
          .collection('salaryInfo')
          .doc(dateTimeFormat('MMM y', selectedDay))
          .set({
        'totalWorkingDays': (lastDay - (employeeDetails[empId]['offDay'] ?? 4)),
        'totalLeave': employeeDetails[empId]['leave'],
        'basicSalary': empDataById[empId]!.ctc,
        'payableSalary': employeeDetails[empId]['payable'],
        'incentive': employeeDetails[empId]['incentive'],
        'overTime': employeeDetails[empId]['ot'],
        'deduction': employeeDetails[empId]['deduction'],
        'takeHome': employeeDetails[empId]['takeHome'],
        'document': url,
        'month': dateTimeFormat('MMM y', selectedDay),
      });

      /// Update PAYSLIPS with this PDF FILE
      FirebaseFirestore.instance
          .collection('paySlips')
          .doc(dateTimeFormat('MMMM y', selectedDay))
          .update({
        'paySlipFiles.$empId': url,
      });
    });
  }

  ///
}
