//@dart=2.9
import 'dart:io';
import 'package:intl/intl.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:pdf/widgets.dart';
import 'package:printing/printing.dart';
import '../../../../../paymentReport/report/Invoice.dart';


var format = NumberFormat.simpleCurrency(locale: 'en_in');

class InvoicePrintingFunction {
  static Future<File> createPrint(paymentDetail invoice) async {
    final pdf = Document();
    pdf.addPage(MultiPage(
      build: (context) => [
        pw.SizedBox(height: 50),

        pw.Container(
          child: pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.stretch,
            mainAxisAlignment: pw.MainAxisAlignment.start,
            children: [

              pw.SizedBox(height: 40),
              pw.Center(
                child: pw.Text(
                  'INVOICE',
                  style: pw.TextStyle(
                    fontSize: 20,
                    wordSpacing: 1.5,
                  ),
                ),
              ),
              pw.SizedBox(height: 40),
              pw.Container(
                // width: double.infinity,

                child: pw.Column(children: [
                  pw.Row(
                      mainAxisAlignment: pw.MainAxisAlignment.start,
                      crossAxisAlignment: pw.CrossAxisAlignment.start,
                      children: [
                        pw.Expanded(
                          child: pw.Column(
                            mainAxisAlignment: pw.MainAxisAlignment.start,
                            crossAxisAlignment: pw.CrossAxisAlignment.start,
                            children: [
                              pw.Text(
                                'Bill To,',
                                style: pw.TextStyle(
                                  fontSize: 14,
                                  fontWeight: pw.FontWeight.bold,
                                ),
                              ),
                              pw.SizedBox(height: 5),
                              pw.Text(
                                invoice.customerName,
                                style: pw.TextStyle(
                                  fontSize: 12,
                                ),
                              ),
                              pw.Text(
                                invoice.nameOfProject,
                                style: pw.TextStyle(
                                  fontSize: 12,
                                ),
                              ),
                              pw.Text(
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
                        pw.Expanded(
                          child: pw.Column(
                              mainAxisAlignment: pw.MainAxisAlignment.start,
                              crossAxisAlignment: pw.CrossAxisAlignment.start,
                              children: [
                                // pw.Text(
                                //   'Received by,',
                                //   style: pw.TextStyle(
                                //     fontSize: 14,
                                //     fontWeight: pw.FontWeight.bold,
                                //   ),
                                // ),
                                // pw.SizedBox(height: 5),
                                // pw.Text(
                                //   invoice.staff,
                                //   style: pw.TextStyle(
                                //     fontSize: 12,
                                //   ),
                                // ),
                                // pw.Text(
                                //   'First Logic Meta Lab Pvt. Ltd',
                                //   style: pw.TextStyle(
                                //     fontSize: 12,
                                //   ),
                                // ),
                                // pw.Text(
                                //   '',
                                //   style: pw.TextStyle(
                                //     fontSize: 12,
                                //   ),
                                // ),
                              ]),
                        )
                      ]),
                  pw.SizedBox(height: 25),
                  pw.Row(children: [
                    pw.Expanded(
                      child: pw.Row(children: [
                        pw.Expanded(
                          child: pw.Container(
                            height: 50,
                            color: PdfColors.grey300,
                            child: pw.Center(
                              child: pw.Column(
                                mainAxisAlignment:
                                pw.MainAxisAlignment.center,
                                crossAxisAlignment:
                                pw.CrossAxisAlignment.start,
                                children: [
                                  pw.Text('Date'),
                                  pw.SizedBox(height: 5),
                                  pw.Text(invoice.date,
                                      style: pw.TextStyle(
                                        fontWeight: pw.FontWeight.bold,
                                        fontSize: 13,
                                      )),
                                ],
                              ),
                            ),
                          ),
                        ),
                        pw.SizedBox(width: 3),
                        pw.Expanded(
                          child: pw.Container(
                              height: 50,
                              color: PdfColors.grey300,
                              child: pw.Center(
                                child: pw.Column(
                                  mainAxisAlignment:
                                  pw.MainAxisAlignment.center,
                                  crossAxisAlignment:
                                  pw.CrossAxisAlignment.start,
                                  children: [
                                    pw.Text('Invoice No.'),
                                    pw.SizedBox(height: 5),
                                    pw.Text(invoice.receiptNo,
                                        style: pw.TextStyle(
                                          fontWeight: pw.FontWeight.bold,
                                          fontSize: 13,
                                        )),
                                  ],
                                ),
                              )),
                        )
                      ]),
                    ),
                    pw.SizedBox(width: 5),
                    pw.Expanded(
                      child: pw.Row(
                        mainAxisAlignment: pw.MainAxisAlignment.start,
                        crossAxisAlignment: pw.CrossAxisAlignment.start,
                        // children: [
                        //   pw.Expanded(
                        //     child: pw.Container(
                        //       height: 50,
                        //       color: PdfColors.grey300,
                        //       child: pw.Center(
                        //         child: pw.Column(
                        //           mainAxisAlignment:
                        //           pw.MainAxisAlignment.center,
                        //           crossAxisAlignment:
                        //           pw.CrossAxisAlignment.start,
                        //           children: [
                        //             pw.Text('Mode of Payment'),
                        //             pw.SizedBox(height: 5),
                        //             pw.Text(invoice.paymentMethod,
                        //                 style: pw.TextStyle(
                        //                   fontWeight: pw.FontWeight.bold,
                        //                   fontSize: 13,
                        //                 )),
                        //           ],
                        //         ),
                        //       ),
                        //     ),
                        //   ),
                        //   pw.SizedBox(width: 3),
                        //   pw.Expanded(
                        //     child: pw.Container(
                        //       height: 50,
                        //       color: PdfColors.grey300,
                        //       child: pw.Center(
                        //         child: pw.Column(
                        //           mainAxisAlignment:
                        //           pw.MainAxisAlignment.center,
                        //           crossAxisAlignment:
                        //           pw.CrossAxisAlignment.start,
                        //           children: [
                        //             pw.Text('Due Amount.'),
                        //             pw.SizedBox(height: 5),
                        //             pw.Text(
                        //                 ' ${100.toStringAsFixed(2)}',
                        //                 style: pw.TextStyle(
                        //                   fontWeight: pw.FontWeight.bold,
                        //                   fontSize: 13,
                        //                 )),
                        //           ],
                        //         ),
                        //       ),
                        //     ),
                        //   )
                        // ],
                      ),
                    )
                  ]),
                ]),
              ),
              pw.SizedBox(height: 50),
              pw.Table.fromTextArray(
                border: pw.TableBorder(
                  left: pw.BorderSide.none,
                  right: pw.BorderSide.none,
                  bottom: pw.BorderSide.none,
                  top: pw.BorderSide.none,
                  horizontalInside: pw.BorderSide.none,
                  verticalInside: pw.BorderSide.none,
                ),
                context: context,
                headerStyle:
                pw.TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                headerDecoration: pw.BoxDecoration(color: PdfColors.grey300),
                cellStyle: pw.TextStyle(
                  fontSize: 12,
                ),

                // cellHeight: 25,
                // columnWidths: {
                //   0: FlexColumnWidth(3),
                //   1: FlexColumnWidth(9),
                //   2: FlexColumnWidth(8),
                //   3: FlexColumnWidth(8),
                // },
                cellAlignments: {
                  0: Alignment.center,
                  1: Alignment.center,
                  2: Alignment.center,
                },
                headers: [
                  'Sl.No',
                  'Name',
                  'Description.',
                  'Price',
                ],
                data: [
                  ['1',invoice.name, invoice.desc, '${invoice.lastPaymentAmount}']
                ],
              ),
              pw.SizedBox(height: 40),
              pw.Divider(),
              pw.SizedBox(height: 20),
              pw.Container(
                // width: double.infinity,

                child: pw.Row(
                    crossAxisAlignment: pw.CrossAxisAlignment.start,
                    children: [
                      pw.Expanded(
                        child: pw.Column(
                          mainAxisAlignment: pw.MainAxisAlignment.start,
                          crossAxisAlignment: pw.CrossAxisAlignment.start,

                        ),
                      ),
                      pw.SizedBox(width: 4),
                      pw.Expanded(
                        child: pw.Column(
                          mainAxisAlignment: pw.MainAxisAlignment.start,
                          crossAxisAlignment: pw.CrossAxisAlignment.center,
                          children: [
                            pw.Row(
                                crossAxisAlignment:
                                pw.CrossAxisAlignment.start,
                                mainAxisAlignment: pw.MainAxisAlignment.end,
                                children: [
                                  pw.Text(
                                    'Total :',
                                    style: pw.TextStyle(
                                      fontSize: 15,
                                      fontWeight: pw.FontWeight.bold,
                                    ),
                                  ),
                                  pw.Text(
                                    '${invoice.lastPaymentAmount.toStringAsFixed(2)}',
                                    style: pw.TextStyle(
                                      fontSize: 15,
                                      fontWeight: pw.FontWeight.bold,
                                    ),
                                  ),
                                  pw.SizedBox(width: 15)
                                ]),
                          ],
                        ),
                      ),
                    ]),
              ),
              pw.SizedBox(height: 25),
              // pw.Row(mainAxisAlignment: pw.MainAxisAlignment.center, children: [
              //   pw.Expanded(
              //     child: pw.Divider(
              //         height: 3, color: PdfColors.grey, thickness: 3),
              //   ),
              //   pw.Container(
              //       height: 30,
              //       width: 30,
              //       decoration: pw.BoxDecoration(
              //         shape: pw.BoxShape.circle,
              //         color: PdfColors.blue,
              //       ),
              //       child: pw.Center(
              //         child: pw.Image(
              //           phoneIcon,
              //           width: 20,
              //           height: 20,
              //           fit: pw.BoxFit.contain,
              //         ),
              //       )),
              //   pw.Expanded(
              //     child: pw.Divider(
              //         height: 3, color: PdfColors.grey, thickness: 3),
              //   ),
              //   pw.Container(
              //       height: 30,
              //       width: 30,
              //       decoration: pw.BoxDecoration(
              //         shape: pw.BoxShape.circle,
              //         color: PdfColors.blue,
              //       ),
              //       child: pw.Center(
              //         child: pw.Image(
              //           locationIcon,
              //           width: 20,
              //           height: 20,
              //           fit: pw.BoxFit.contain,
              //         ),
              //       )),
              //   pw.Expanded(
              //     child: pw.Divider(
              //         height: 3, color: PdfColors.grey, thickness: 3),
              //   ),
              //   pw.Container(
              //       height: 30,
              //       width: 30,
              //       decoration: pw.BoxDecoration(
              //         shape: pw.BoxShape.circle,
              //         color: PdfColors.blue,
              //       ),
              //       child: pw.Center(
              //         child: pw.Image(
              //           mailIcon,
              //           width: 20,
              //           height: 20,
              //           fit: pw.BoxFit.contain,
              //         ),
              //       )),
              //   pw.Expanded(
              //     child: pw.Divider(
              //         height: 3, color: PdfColors.grey, thickness: 3),
              //   ),
              // ]),
              // pw.SizedBox(height: 10),
              // pw.Row(mainAxisAlignment: pw.MainAxisAlignment.center, children: [
              //   pw.Spacer(),
              //   pw.Column(
              //     children: [
              //       pw.Text('+91 7012 48 38 28',
              //           style: pw.TextStyle(fontSize: 10)),
              //       pw.Text('+91 8075 22 76 85',
              //           style: pw.TextStyle(fontSize: 10)),
              //     ],
              //   ),
              //   pw.Spacer(),
              //   pw.Column(
              //     children: [
              //       pw.Text('Puthanveettil Tower, Bypass Road,',
              //           style: pw.TextStyle(fontSize: 10)),
              //       pw.Text('Perinthalmanna, Kerala, India 679322',
              //           style: pw.TextStyle(fontSize: 10)),
              //     ],
              //   ),
              //   pw.Spacer(),
              //   pw.Column(
              //     children: [
              //       pw.Text('askme@firstlogicmetalab.com',
              //           style: pw.TextStyle(fontSize: 10)),
              //     ],
              //   ),
              //   pw.Spacer(),
              // ]),
            ],
          ),
        ),


      ],
    ));

    print('aaaaaaaaaaaaaaaaaaaaaa');

    //web
    await Printing.layoutPdf(
        onLayout: (PdfPageFormat format) async => pdf.save());
    print('bbbbbbbbbbbbbbbbbbbbbbbb');

    //android
    // return PdfApi.saveDocument(name: '${invoice.name}+feedetail.pdf', pdf: pdf);
  }


}
