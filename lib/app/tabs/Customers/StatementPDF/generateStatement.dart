//@dart=2.9
import 'dart:io';
import 'dart:typed_data';
import 'package:fl_erp/app/app_widget.dart';
import 'package:fl_erp/app/tabs/Customers/StatementPDF/statementModel.dart';
import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:pdf/widgets.dart';
import 'package:printing/printing.dart';
import 'package:universal_html/html.dart' as html;

import '../../../../flutter_flow/flutter_flow_util.dart';
// import 'package:universal_html/html.dart' as html;

List<TableRow> rows = [];
var image;
// var locationIcon;
// var phoneIcon;
// var mailIcon;
// var globIcon;
double balanceNumber = 0;
var format = NumberFormat.simpleCurrency(locale: 'en_in');

class StatementPDF {
  static Future<File> downloadPdf(StatementModel invoice, List datas,
      double creditTotal, double debitTotal) async {
    print('PDFFFFFFFFFF ');

    double balance = 0;

    ///FORMAT AMOUNT
    const _locale = 'HI';
    String _formatNumber(String s) =>
        NumberFormat.decimalPattern(_locale).format(int.parse(s));



    ///CREATING PDF

    final pdf = Document();
    image = await imageFromAssetBundle('assets/images/fl_new.jpg');
    // locationIcon =
    //     await imageFromAssetBundle('assets/recipt Items/location-01.png');
    // phoneIcon = await imageFromAssetBundle('assets/recipt Items/phone-01.png');
    // mailIcon = await imageFromAssetBundle('assets/recipt Items/mail-01.png');
    // globIcon = await imageFromAssetBundle('assets/recipt Items/glob_icon.png');
    pdf.addPage(
      MultiPage(
        mainAxisAlignment: MainAxisAlignment.start,
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
        build: (context) => [
          Center(
            child: Text(
              'CUSTOMER STATEMENT',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                wordSpacing: 1.5,
              ),
            ),
          ),
          pw.SizedBox(height: 20),
          Container(
            // width: double.infinity,

            child: Column(children: [
              Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'To,',
                            style: pw.TextStyle(
                              fontSize: 14,
                              fontWeight: pw.FontWeight.bold,
                            ),
                          ),
                          pw.SizedBox(height: 5),
                          Text(
                            invoice.customerName,
                            style: pw.TextStyle(
                              fontSize: 12,
                            ),
                          ),
                          Text(
                            invoice.address,
                            style: pw.TextStyle(
                              fontSize: 12,
                            ),
                          ),
                          Text(
                            invoice.customerPhoneNo,
                            style: pw.TextStyle(
                              fontSize: 12,
                            ),
                          ),
                          pw.SizedBox(height: 8),
                        ],
                      ),
                    ),
                    pw.SizedBox(width: 5),
                    Expanded(
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'From,',
                              style: pw.TextStyle(
                                fontSize: 14,
                                fontWeight: pw.FontWeight.bold,
                              ),
                            ),
                            pw.SizedBox(height: 5),
                            Text(
                              currentbranchName,
                              // 'First Logic Meta Lab Pvt. Ltd',
                              style: pw.TextStyle(
                                fontSize: 12,
                              ),
                            ),
                            Text(
                              currentbranchAddress,
                              // '',
                              style: pw.TextStyle(
                                fontSize: 12,
                              ),
                            ),
                            Text(
                              currentbranchphoneNumber,
                              style: pw.TextStyle(
                                fontSize: 12,
                              ),
                            ),
                          ]),
                    )
                  ]),
              // pw.SizedBox(height: 25),
              // pw.Row(children: [
              //   pw.Expanded(
              //     child: pw.Row(children: [
              //       pw.Expanded(
              //         child: pw.Container(
              //           height: 50,
              //           color: PdfColors.grey300,
              //           child: pw.Center(
              //             child: pw.Column(
              //               mainAxisAlignment:
              //                   pw.MainAxisAlignment.center,
              //               crossAxisAlignment:
              //                   pw.CrossAxisAlignment.start,
              //               children: [
              //                 pw.Text('Date'),
              //                 pw.SizedBox(height: 5),
              //                 pw.Text(invoice.date,
              //                     style: pw.TextStyle(
              //                       fontWeight: pw.FontWeight.bold,
              //                       fontSize: 13,
              //                     )),
              //               ],
              //             ),
              //           ),
              //         ),
              //       ),
              //       pw.SizedBox(width: 3),
              //       pw.Expanded(
              //         child: pw.Container(
              //             height: 50,
              //             color: PdfColors.grey300,
              //             child: pw.Center(
              //               child: pw.Column(
              //                 mainAxisAlignment:
              //                     pw.MainAxisAlignment.center,
              //                 crossAxisAlignment:
              //                     pw.CrossAxisAlignment.start,
              //                 children: [
              //                   pw.Text('Receipt No.'),
              //                   pw.SizedBox(height: 5),
              //                   pw.Text(invoice.receiptNo,
              //                       style: pw.TextStyle(
              //                         fontWeight: pw.FontWeight.bold,
              //                         fontSize: 13,
              //                       )),
              //                 ],
              //               ),
              //             )),
              //       )
              //     ]),
              //   ),
              //   pw.SizedBox(width: 5),
              //   pw.Expanded(
              //     child: pw.Row(
              //         mainAxisAlignment: pw.MainAxisAlignment.start,
              //         crossAxisAlignment: pw.CrossAxisAlignment.start,
              //         children: [
              //           pw.Expanded(
              //             child: pw.Container(
              //               height: 50,
              //               color: PdfColors.grey300,
              //               child: pw.Center(
              //                 child: pw.Column(
              //                   mainAxisAlignment:
              //                       pw.MainAxisAlignment.center,
              //                   crossAxisAlignment:
              //                       pw.CrossAxisAlignment.start,
              //                   children: [
              //                     pw.Text('Mode of Payment'),
              //                     pw.SizedBox(height: 5),
              //                     pw.Text(invoice.paymentMethod,
              //                         style: pw.TextStyle(
              //                           fontWeight: pw.FontWeight.bold,
              //                           fontSize: 13,
              //                         )),
              //                   ],
              //                 ),
              //               ),
              //             ),
              //           ),
              //           pw.SizedBox(width: 3),
              //           pw.Expanded(
              //             child: pw.Container(
              //               height: 50,
              //               color: PdfColors.grey300,
              //               child: pw.Center(
              //                 child: pw.Column(
              //                   mainAxisAlignment:
              //                       pw.MainAxisAlignment.center,
              //                   crossAxisAlignment:
              //                       pw.CrossAxisAlignment.start,
              //                   children: [
              //                     pw.Text('Due Amount.'),
              //                     pw.SizedBox(height: 5),
              //                     pw.Text(
              //                         ' ${invoice.totalDue.toStringAsFixed(2)}',
              //                         style: pw.TextStyle(
              //                           fontWeight: pw.FontWeight.bold,
              //                           fontSize: 13,
              //                         )),
              //                   ],
              //                 ),
              //               ),
              //             ),
              //           )
              //         ]),
              //   )
              // ]),
            ]),
          ),
          pw.SizedBox(height: 25),

          ///

          ///TABLE

          pw.Table.fromTextArray(
            cellAlignment: Alignment.center,
            context: context,
            headers: [
              'Date',
              'Particulars',
              'Debit',
              'Credit',
              'Balance',
            ],
            data: List.generate(datas.length + 1, (index) {
              // final summary = datas[index];

              if (index < datas.length) {
                if (datas[index]['debit'] == null) {
                  balance += datas[index]['credit'];
                } else {
                  balance -= datas[index]['debit'];
                }
              }

              print(index);
              print(datas.length);

              return index == datas.length
                  ? [
                      '',
                      '',
                      debitTotal > creditTotal
                          ? _formatNumber(
                              debitTotal.toString().replaceAll(',', ''))
                          : _formatNumber(
                              creditTotal.toString().replaceAll(',', '')),
                      debitTotal > creditTotal
                          ? _formatNumber(
                              debitTotal.toString().replaceAll(',', ''))
                          : _formatNumber(
                              creditTotal.toString().replaceAll(',', '')),
                      '',
                    ]
                  : [
                      dateTimeFormat('d-MMM-y', datas[index]['date'].toDate()),
                      datas[index]['particular'],
                      datas[index]['debit'] == null
                          ? ''
                          : _formatNumber(datas[index]['debit']
                              .toString()
                              .replaceAll(',', '')),
                      datas[index]['credit'] == null
                          ? ''
                          : _formatNumber(datas[index]['credit']
                              .toString()
                              .replaceAll(',', '')),
                      _formatNumber(balance.toString().replaceAll(',', ''))
                    ];
            }),
          ),
        ],
      ),
    );

    //WEB DOWNLOAD

    var data = await pdf.save();
    Uint8List bytes = Uint8List.fromList(data);
    final blob = html.Blob([bytes], 'application/pdf');
    final url = html.Url.createObjectUrlFromBlob(blob);
    final anchor = html.document.createElement('a') as html.AnchorElement
      ..href = url
      ..style.display = 'none'
      ..download = '${invoice.customerName}.pdf';

    html.document.body.children.add(anchor);
    anchor.click();
    html.document.body.children.remove(anchor);
    html.Url.revokeObjectUrl(url);

    //android
    // return PdfApi.saveDocument(name: '${invoice.name}+feedetail.pdf', pdf: pdf);
  }

  ///

}
