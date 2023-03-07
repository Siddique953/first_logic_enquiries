//@dart=2.9
import 'dart:io';
import 'package:intl/intl.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:pdf/widgets.dart';
import 'package:printing/printing.dart';
import '../../app/app_widget.dart';
import 'Invoice.dart';

var image;
var globIcon;

var format = NumberFormat.simpleCurrency(locale: 'en_in');

class PrintingFunction {
  static Future<File> createPrint(paymentDetail invoice) async {
    final pdf = Document();
    image = await imageFromAssetBundle('assets/images/fl_new.png');
    globIcon = await imageFromAssetBundle('assets/recipt Items/glob_icon.png');
    pdf.addPage(MultiPage(
      build: (context) => [
        pw.SizedBox(height: 50),

        pw.Container(
          child: pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.stretch,
            mainAxisAlignment: pw.MainAxisAlignment.start,
            children: [
              // pw.Container(
              //   height: 100,
              //   width: double.infinity,
              //   child: pw.Row(children: [
              //     pw.Container(
              //       height: 80,
              //       child: pw.Row(
              //           mainAxisAlignment: pw.MainAxisAlignment.start,
              //           children: [
              //             pw.Image(image,
              //                 width: 150, height: 150, fit: pw.BoxFit.contain),
              //           ]),
              //     ),
              //     pw.SizedBox(width: 15),
              //     pw.Expanded(
              //       child: pw.Container(
              //         child: pw.Column(
              //             mainAxisAlignment: pw.MainAxisAlignment.end,
              //             crossAxisAlignment: pw.CrossAxisAlignment.end,
              //             children: [
              //               pw.Row(
              //                   mainAxisAlignment: pw.MainAxisAlignment.end,
              //                   children: [
              //                     pw.Text('www.firstlogicmetalab.com'),
              //                     pw.SizedBox(width: 3),
              //                     pw.Image(
              //                       globIcon,
              //                       width: 20,
              //                       height: 20,
              //                       fit: pw.BoxFit.contain,
              //                     ),
              //                     pw.SizedBox(width: 5),
              //                   ]),
              //               pw.SizedBox(height: 5),
              //               pw.Container(
              //                 height: 10,
              //                 color: PdfColors.blue,
              //               ),
              //               pw.Container(
              //                 height: 7,
              //                 color: PdfColors.grey,
              //               ),
              //             ]),
              //       ),
              //     ),
              //   ]),
              // ),
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
                                mainAxisAlignment: pw.MainAxisAlignment.center,
                                crossAxisAlignment: pw.CrossAxisAlignment.start,
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
                                crossAxisAlignment: pw.CrossAxisAlignment.start,
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
                                crossAxisAlignment: pw.CrossAxisAlignment.start,
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
                                crossAxisAlignment: pw.CrossAxisAlignment.start,
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

        // pw.Container(
        //     child: pw.Column(
        //         crossAxisAlignment: pw.CrossAxisAlignment.start,
        //         mainAxisAlignment: pw.MainAxisAlignment.start,
        //         children: [
        //       pw.Container(
        //         height: 100,
        //         width: 700,
        //         // child: pw.Row(mainAxisAlignment: pw.MainAxisAlignment.end, children: [
        //         //   pw.Image(image,
        //         //       width: 150, height: 150, fit: pw.BoxFit.contain),
        //         // ]),
        //       ),
        //
        //       pw.Text(currentbranchName,
        //           style: pw.TextStyle(
        //               fontSize: 17,
        //               fontWeight: FontWeight.bold,
        //               color: PdfColors.blue)),
        //       pw.SizedBox(height: 10),
        //       pw.Text(currentbranchAddress,
        //           style:
        //               pw.TextStyle(fontSize: 13, fontWeight: FontWeight.bold)),
        //       pw.SizedBox(height: 5),
        //       pw.Text('ph : ' + currentbranchphoneNumber,
        //           style:
        //               pw.TextStyle(fontSize: 13, fontWeight: FontWeight.bold)),
        //       pw.SizedBox(height: 20),
        //       pw.Divider(thickness: 0.5, color: PdfColors.blue),
        //       pw.SizedBox(height: 20),
        //
        //       pw.Row(children: [
        //         pw.Container(
        //           width: 120,
        //           child: pw.Text('Customer Name',
        //               style: pw.TextStyle(
        //                 fontSize: 15,
        //               )),
        //         ),
        //         pw.Container(
        //           width: 250,
        //           child: pw.Text(invoice.name,
        //               style: pw.TextStyle(
        //                 fontSize: 15,
        //               )),
        //         ),
        //       ]),
        //       pw.SizedBox(height: 5),
        //       pw.Row(children: [
        //         pw.Container(
        //           width: 120,
        //           child: pw.Text('Date',
        //               style: pw.TextStyle(
        //                 fontSize: 15,
        //               )),
        //         ),
        //         pw.Container(
        //           width: 250,
        //           child: pw.Text(invoice.date,
        //               style: pw.TextStyle(
        //                 fontSize: 15,
        //               )),
        //         ),
        //       ]),
        //       pw.SizedBox(height: 5),
        //       // pw.Row(
        //       //   children:[
        //       //     pw.Container(width: 120,child:  pw.Text('Project Type',style: pw.TextStyle(fontSize: 15,)),),
        //       //     pw.Container(width: 250,child:  pw.Text(invoice.selectedProjectType,style: pw.TextStyle(fontSize: 15,)),),
        //       //   ]
        //       // ),
        //       // pw.SizedBox(height: 5),
        //       pw.Row(children: [
        //         pw.Container(
        //           width: 120,
        //           child: pw.Text('Project Name',
        //               style: pw.TextStyle(
        //                 fontSize: 15,
        //               )),
        //         ),
        //         pw.Container(
        //           width: 250,
        //           child: pw.Text(invoice.nameOfProject,
        //               style: pw.TextStyle(
        //                 fontSize: 15,
        //               )),
        //         ),
        //       ]),
        //
        //       pw.SizedBox(height: 30),
        //
        //       pw.Table(
        //           tableWidth: TableWidth.max,
        //           border: pw.TableBorder.all(width: 1, color: PdfColors.grey),
        //           children: [
        //             pw.TableRow(children: [
        //               pw.Container(
        //                   color: PdfColors.blue,
        //                   height: 20,
        //                   child: pw.Text('Sl.no',
        //                       style: pw.TextStyle(color: PdfColors.white))),
        //               pw.Container(
        //                   color: PdfColors.blue,
        //                   height: 20,
        //                   child: pw.Text('Description',
        //                       style: pw.TextStyle(color: PdfColors.white))),
        //               pw.Container(
        //                   color: PdfColors.blue,
        //                   height: 20,
        //                   child: pw.Text('Amount',
        //                       style: pw.TextStyle(color: PdfColors.white))),
        //             ]),
        //             pw.TableRow(children: [
        //               pw.Container(height: 20, child: pw.Text('1')),
        //               pw.Container(
        //                   height: 20, child: pw.Text('Total Project Cost')),
        //               pw.Container(
        //                   height: 20,
        //                   child: pw.Text(invoice.totalProjectCost.toString())),
        //             ]),
        //             pw.TableRow(children: [
        //               pw.Container(height: 20, child: pw.Text('2')),
        //               pw.Container(
        //                   height: 20, child: pw.Text('Current Payment')),
        //               pw.Container(
        //                   height: 20,
        //                   child: pw.Text(invoice.lastPaymentAmount.toString())),
        //             ]),
        //             pw.TableRow(children: [
        //               pw.Container(height: 20, child: pw.Text('3')),
        //               pw.Container(
        //                   height: 20, child: pw.Text('Mode Of Payment')),
        //               pw.Container(
        //                   height: 20, child: pw.Text(invoice.paymentMethod)),
        //             ]),
        //             pw.TableRow(children: [
        //               pw.Container(height: 20, child: pw.Text('4')),
        //               pw.Container(
        //                   height: 20, child: pw.Text('Total Amount Paid')),
        //               pw.Container(
        //                   height: 20,
        //                   child: pw.Text(invoice.lastPaymentAmount.toString())),
        //             ]),
        //             pw.TableRow(children: [
        //               pw.Container(height: 20, child: pw.Text('5')),
        //               pw.Container(height: 20, child: pw.Text('Balance Due')),
        //               pw.Container(
        //                   height: 20,
        //                   child: pw.Text(
        //                     (invoice.totalDue).toString(),
        //                     // invoice.TotalDue.toString())
        //                   )),
        //             ]),
        //           ]),
        //
        //       pw.SizedBox(height: 50),
        //       pw.Text('Signature :',
        //           style: pw.TextStyle(
        //             fontSize: 15,
        //           )),
        //       pw.SizedBox(height: 30),
        //       // Text('your return from information indicate that you are in a credit position, your credit amount will be carried forward for next filing',style: TextStyle(fontSize: 9,)),
        //       // pw.SizedBox(height: 10),
        //     ])),
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

//
//   static buildText({
//      String title,
//      String value,
//     double width = double.infinity,
//     pw.TextStyle  titleStyle,
//     bool unite = false,
//   }) {
//      final style = titleStyle ?? pw.TextStyle(fontWeight: FontWeight.bold, );
//
//     return pw.Container(
//       width: width,
//       child: pw.Row(
//         children: [
//           pw.Expanded(child: pw.Text(title, style: style)),
//           pw.Text(value, style: unite ? style : null),
//         ],
//       ),
//     );
//   }
}
