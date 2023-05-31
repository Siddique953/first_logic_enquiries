//@dart=2.9
import 'dart:io';
import 'dart:typed_data';
import 'package:intl/intl.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:pdf/widgets.dart';
import 'package:printing/printing.dart';
import '../../app/app_widget.dart';
import 'Invoice.dart';
import 'package:universal_html/html.dart' as html;

var image;
var locationIcon;
var phoneIcon;
var mailIcon;
var globIcon;
var format = NumberFormat.simpleCurrency(locale: 'en_in');

class GeneratePdf {
  static Future<File> downloadPdf(paymentDetail invoice) async {
    final pdf = Document();
    image = await imageFromAssetBundle('assets/images/fl_new.jpg');

    // locationIcon =
    //     await imageFromAssetBundle('assets/recipt Items/location-01.png');
    // phoneIcon = await imageFromAssetBundle('assets/recipt Items/phone-01.png');
    // mailIcon = await imageFromAssetBundle('assets/recipt Items/mail-01.png');
    // globIcon = await imageFromAssetBundle('assets/recipt Items/glob_icon.png');
    pdf.addPage(
      MultiPage(
        build: (context) => [
          // pw.SizedBox(height: 50),
          pw.Container(
            child: pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.stretch,
              mainAxisAlignment: pw.MainAxisAlignment.start,
              children: [
                pw.Container(
                  height: 100,
                  width: double.infinity,
                  child: pw.Row(children: [
                    pw.Container(
                      height: 80,
                      child: pw.Row(
                          mainAxisAlignment: pw.MainAxisAlignment.start,
                          children: [
                            pw.Image(image,
                                width: 150,
                                height: 150,
                                fit: pw.BoxFit.contain),
                          ]),
                    ),
                    pw.SizedBox(width: 15),
                    pw.Expanded(
                      child: pw.Container(
                        child: pw.Column(
                            mainAxisAlignment: pw.MainAxisAlignment.end,
                            crossAxisAlignment: pw.CrossAxisAlignment.end,
                            children: [
                              pw.Row(
                                  mainAxisAlignment: pw.MainAxisAlignment.end,
                                  children: [
                                    pw.Text('www.firstlogicmetalab.com'),
                                    pw.SizedBox(width: 3),
                                    // pw.Image(
                                    //   globIcon,
                                    //   width: 15,
                                    //   height: 15,
                                    //   fit: pw.BoxFit.contain,
                                    // ),
                                    pw.SizedBox(width: 5),
                                  ]),
                              pw.SizedBox(height: 5),
                              pw.Container(
                                height: 10,
                                color: PdfColors.blue,
                              ),
                              pw.Container(
                                height: 7,
                                color: PdfColors.grey,
                              ),
                            ]),
                      ),
                    ),
                  ]),
                ),
                pw.SizedBox(height: 40),
                pw.Center(
                  child: pw.Text(
                    'RECEIPT VOUCHER',
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
                                  'Receipt To,',
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
                                  pw.Text(
                                    'Received by,',
                                    style: pw.TextStyle(
                                      fontSize: 14,
                                      fontWeight: pw.FontWeight.bold,
                                    ),
                                  ),
                                  pw.SizedBox(height: 5),
                                  pw.Text(
                                    invoice.staff,
                                    style: pw.TextStyle(
                                      fontSize: 12,
                                    ),
                                  ),
                                  pw.Text(
                                    'First Logic Meta Lab Pvt. Ltd',
                                    style: pw.TextStyle(
                                      fontSize: 12,
                                    ),
                                  ),
                                  pw.Text(
                                    '',
                                    style: pw.TextStyle(
                                      fontSize: 12,
                                    ),
                                  ),
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
                                      pw.Text('Receipt No.'),
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
                            children: [
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
                                        pw.Text('Mode of Payment'),
                                        pw.SizedBox(height: 5),
                                        pw.Text(invoice.paymentMethod,
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
                                        pw.Text('Due Amount.'),
                                        pw.SizedBox(height: 5),
                                        pw.Text(
                                            ' ${invoice.totalDue.toStringAsFixed(2)}',
                                            style: pw.TextStyle(
                                              fontWeight: pw.FontWeight.bold,
                                              fontSize: 13,
                                            )),
                                      ],
                                    ),
                                  ),
                                ),
                              )
                            ]),
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
                    'Description.',
                    'Price',
                  ],
                  data: [
                    ['1', invoice.desc, '${invoice.lastPaymentAmount}']
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
                            children: [
                              pw.Text(
                                'Payment Terms :',
                                style: pw.TextStyle(
                                  fontSize: 12,
                                  // fontWeight: pw.FontWeight.bold,
                                ),
                              ),
                              pw.SizedBox(height: 15),
                              pw.Row(
                                  crossAxisAlignment:
                                      pw.CrossAxisAlignment.start,
                                  children: [
                                    pw.Text(
                                      '1. ',
                                      style: pw.TextStyle(
                                        fontSize: 11,
                                      ),
                                    ),
                                    pw.Column(
                                        crossAxisAlignment:
                                            pw.CrossAxisAlignment.start,
                                        children: [
                                          pw.Text(
                                            'This is a digitally signed document.',
                                            style: pw.TextStyle(
                                              fontSize: 11,
                                            ),
                                          ),
                                          pw.Text(
                                            'Signature not required.',
                                            style: pw.TextStyle(
                                              fontSize: 11,
                                            ),
                                          ),
                                        ])
                                  ]),
                              pw.SizedBox(height: 2),
                              pw.Row(
                                  crossAxisAlignment:
                                      pw.CrossAxisAlignment.start,
                                  children: [
                                    pw.Text(
                                      '2. ',
                                      style: pw.TextStyle(
                                        fontSize: 11,
                                      ),
                                    ),
                                    pw.Column(
                                        crossAxisAlignment:
                                            pw.CrossAxisAlignment.start,
                                        children: [
                                          pw.Text(
                                            'Due amount should be paid within the',
                                            style: pw.TextStyle(
                                              fontSize: 11,
                                            ),
                                          ),
                                          pw.Text(
                                            'due date mentioned.',
                                            style: pw.TextStyle(
                                              fontSize: 11,
                                            ),
                                          ),
                                        ])
                                  ]),
                            ],
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
      ..download = '${invoice.name} - ${invoice.desc}.pdf';

    html.document.body.children.add(anchor);
    anchor.click();
    html.document.body.children.remove(anchor);
    html.Url.revokeObjectUrl(url);

    //android
    // return PdfApi.saveDocument(name: '${invoice.name}+feedetail.pdf', pdf: pdf);
  }
}
