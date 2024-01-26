import 'dart:io';
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:fl_erp/app/pages/home_page/home.dart';
import 'package:intl/intl.dart';
import 'package:number_to_words/number_to_words.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:pdf/widgets.dart';
import 'package:universal_html/html.dart' as html;

import '../../../../../flutter_flow/flutter_flow_util.dart';

var image;
var format = NumberFormat.simpleCurrency(locale: 'en_in');

class BankSlipGenerate {
  List<List<dynamic>> first10TableData = [];
  List<List<dynamic>> secondTableData = [];

  Future<File?> downloadPdf(
      Map bankSlip, String chq, double total, List employee) async {
    for (int i = 0; i < employee.length + 2; i++) {
      // List<List<String>> subTableData = tableData.sublist(i, i + rowsPerPage);

      if (i < 16) {
        i == employee.length
            ? first10TableData.add([
                '',
                '',
                '',
                '',
              ])
            : i == employee.length + 1
                ? first10TableData.add([
                    '',
                    'Total',
                    '',
                    total.round().toStringAsFixed(2),
                  ])
                : first10TableData.add([
                    (i + 1).toString(),
                    empDataById[employee[i]['empId']]!.name,
                    empDataById[employee[i]['empId']]!.accountNumber,
                    bankSlip[employee[i]['empId']]['takeHome']
                  ]);
      } else {
        i == employee.length
            ? secondTableData.add([
                '',
                '',
                '',
                '',
              ])
            : i == employee.length + 1
                ? secondTableData.add([
                    '',
                    'Total',
                    '',
                    total.round().toStringAsFixed(2),
                  ])
                : secondTableData.add([
                    (i + 1).toString(),
                    empDataById[employee[i]['empId']]!.name,
                    empDataById[employee[i]['empId']]!.accountNumber,
                    bankSlip[employee[i]['empId']]['takeHome']
                  ]);
      }
    }


    final pdf = Document();

    pdf.addPage(MultiPage(
      maxPages: 100,
      build: (context) => [
        pw.SizedBox(height: 50),
        pw.Padding(
          padding: pw.EdgeInsets.all(10),
          child: pw.Container(
              child: pw.Column(
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  mainAxisAlignment: pw.MainAxisAlignment.start,
                  children: [
                pw.Text('To,',
                    style: pw.TextStyle(
                      fontSize: 13,
                    )),
                pw.SizedBox(height: 10),
                pw.Text('The Manager,',
                    style: pw.TextStyle(
                      fontSize: 13,
                    )),
                pw.SizedBox(height: 5),
                pw.Text('HDFC Bank',
                    style: pw.TextStyle(
                      fontSize: 13,
                    )),
                pw.Text('Perinthalmanna II',
                    style: pw.TextStyle(
                      fontSize: 13,
                    )),

                pw.SizedBox(height: 30),
                pw.Text('Sub : Staff details for Salary credit.',
                    style: pw.TextStyle(
                        fontSize: 17, fontWeight: FontWeight.bold)),
                pw.SizedBox(height: 20),

                // pw.Padding(
                //   padding: pw.EdgeInsets.all(15),
                //   child:
                pw.Container(
                  width: double.infinity,
                  // decoration: pw.BoxDecoration(
                  //   border: pw.Border.all(width: 1.5, color: PdfColors.black),
                  // ),
                  child: pw.Column(
                      crossAxisAlignment: pw.CrossAxisAlignment.start,
                      mainAxisAlignment: pw.MainAxisAlignment.center,
                      children: [
                        pw.SizedBox(height: 8),
                        pw.Text(
                            'Please find attached Chq.No. $chq Dated:${dateTimeFormat('dd/mm/yyyy', DateTime.now())} amounted to Rs. \n ${total.toStringAsFixed(2)}/-',
                            style: pw.TextStyle(
                              fontSize: 12,
                            )),
                        pw.SizedBox(height: 8),
                        pw.Divider(
                            height: 1.5,
                            color: PdfColors.black,
                            thickness: 1.5),
                        pw.SizedBox(height: 10),
                        pw.Text(
                            'Request you to Transfer Salary for the month ${dateTimeFormat('MMMM y', DateTime(
                                  DateTime.now().year,
                                  DateTime.now().month - 1,
                                  DateTime.now().day,
                                ))} of Rupees ${NumberToWord().convert('en-in', total.round())} only.',
                            style: pw.TextStyle(
                              fontSize: 12,
                            )),
                        pw.SizedBox(height: 8),
                        pw.Divider(
                            height: 1.5,
                            color: PdfColors.black,
                            thickness: 1.5),
                      ]),
                ),
                // ),
                // firstPageTable(bankSlip, total),

                pw.Table.fromTextArray(
                    context: context,
                    headerStyle:
                        TextStyle(fontSize: 7, fontWeight: FontWeight.bold),
                    headerDecoration: BoxDecoration(color: PdfColors.grey300),
                    cellStyle: TextStyle(
                      fontSize: 7,
                    ),
                    // cellHeight: 25,
                    // columnWidths: {
                    //   0: FlexColumnWidth(3),
                    //   1: FlexColumnWidth(9),
                    //   2: FlexColumnWidth(8),
                    //   3: FlexColumnWidth(8),
                    // },
                    // cellAlignments: {
                    //   0: Alignment.center,
                    //   1: Alignment.centerLeft,
                    //   2: Alignment.centerRight,
                    //   3: Alignment.centerRight,
                    // },
                    headers: [
                      'Sl.no',
                      'Employee Name',
                      'Account No.',
                      'Amount',
                    ],
                    data: first10TableData
                    // List.generate(employee.length + 2, (index) {
                    //   return index == employee.length
                    //       ? [
                    //           '',
                    //           '',
                    //           '',
                    //           '',
                    //         ]
                    //       : index == employee.length + 1
                    //           ? [
                    //               '',
                    //               'Total',
                    //               '',
                    //               total.round().toStringAsFixed(2),
                    //             ]
                    //           : [
                    //               (index + 1).toString(),
                    //               empDataById[employee[index]['empId']].name,
                    //               empDataById[employee[index]['empId']]
                    //                   .accountNumber,
                    //               bankSlip[employee[index]['empId']]['takeHome']
                    //             ];
                    // }),
                    ),

                pw.SizedBox(height: 20),

                pw.Table.fromTextArray(
                    context: context,
                    headerStyle:
                        TextStyle(fontSize: 7, fontWeight: FontWeight.bold),
                    headerDecoration: BoxDecoration(color: PdfColors.grey300),
                    cellStyle: TextStyle(
                      fontSize: 7,
                    ),
                    // cellHeight: 25,
                    // columnWidths: {
                    //   0: FlexColumnWidth(3),
                    //   1: FlexColumnWidth(9),
                    //   2: FlexColumnWidth(8),
                    //   3: FlexColumnWidth(8),
                    // },
                    // cellAlignments: {
                    //   0: Alignment.center,
                    //   1: Alignment.centerLeft,
                    //   2: Alignment.centerRight,
                    //   3: Alignment.centerRight,
                    // },
                    headers: [
                      'Sl.no',
                      'Employee Name',
                      'Account No.',
                      'Amount',
                    ],
                    data: secondTableData
                    // List.generate(employee.length + 2, (index) {
                    //   return index == employee.length
                    //       ? [
                    //           '',
                    //           '',
                    //           '',
                    //           '',
                    //         ]
                    //       : index == employee.length + 1
                    //           ? [
                    //               '',
                    //               'Total',
                    //               '',
                    //               total.round().toStringAsFixed(2),
                    //             ]
                    //           : [
                    //               (index + 1).toString(),
                    //               empDataById[employee[index]['empId']].name,
                    //               empDataById[employee[index]['empId']]
                    //                   .accountNumber,
                    //               bankSlip[employee[index]['empId']]['takeHome']
                    //             ];
                    // }),
                    ),

                pw.SizedBox(height: 20),

                pw.Text('Thanking You,',
                    style: pw.TextStyle(
                      fontSize: 13,
                    )),
                pw.SizedBox(height: 3),
                pw.Text('Muhammed Shabeeb',
                    style: pw.TextStyle(
                      fontSize: 13,
                    )),
                pw.Text('Director',
                    style: pw.TextStyle(
                      fontSize: 13,
                    )),
                pw.Text('First Logic Meta Lab Pvt.Ltd',
                    style: pw.TextStyle(
                      fontSize: 13,
                    )),

                pw.SizedBox(height: 30),
                // Text('your return from information indicate that you are in a credit position, your credit amount will be carried forward for next filing',style: TextStyle(fontSize: 9,)),
                // pw.SizedBox(height: 10),
              ])),
        )
      ],
    ));

    //WEB DOWNLOAD

    var data = await pdf.save();
    Uint8List bytes = Uint8List.fromList(data);
    uploadFileToFireBase(
        dateTimeFormat(
            'MMM y',
            DateTime(
              DateTime.now().year,
              DateTime.now().month - 1,
              DateTime.now().day,
            )),
        bytes,
        'pdf');
    final blob = html.Blob([bytes], 'application/pdf');
    final url = html.Url.createObjectUrlFromBlob(blob);
    final anchor = html.document.createElement('a') as html.AnchorElement
      ..href = url
      ..style.display = 'none'
      ..download = 'bank Slip -${dateTimeFormat('MMM y', DateTime(
            DateTime.now().year,
            DateTime.now().month - 1,
            DateTime.now().day,
          ))}.pdf';

    html.document.body!.children.add(anchor);
    anchor.click();
    html.document.body!.children.remove(anchor);
    html.Url.revokeObjectUrl(url);

    //android
    // return PdfApi.saveDocument(name: '${invoice.name}+feedetail.pdf', pdf: pdf);
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
        .doc(dateTimeFormat(
            'MMMM y',
            DateTime(
              DateTime.now().year,
              DateTime.now().month - 1,
              DateTime.now().day,
            )))
        .update({
      'bankSlip': urlDownload,
    });
  }
}
