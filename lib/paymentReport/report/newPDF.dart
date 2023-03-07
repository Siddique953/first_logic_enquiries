//@dart=2.9
import 'dart:io';
import 'dart:typed_data';
import 'package:intl/intl.dart';
import 'package:pdf/pdf.dart';
import 'package:flutter/material.dart' as mt;
import 'package:pdf/widgets.dart' as pw;
import 'package:pdf/widgets.dart';
import 'package:printing/printing.dart';
import '../../app/app_widget.dart';
import 'Invoice.dart';
import 'package:universal_html/html.dart' as html;

var image;
var format = NumberFormat.simpleCurrency(locale: 'en_in');

class CreateNewPdf {
  static Future<File> downloadPdf(paymentDetail invoice) async {
    final pdf = Document();
    image = await imageFromAssetBundle('assets/images/fl_new.png');
    pdf.addPage(MultiPage(
      build: (context) => [
        pw.SizedBox(height: 50),
        pw.Container(
            child: pw.Column(
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                mainAxisAlignment: pw.MainAxisAlignment.start,
                children: [
              pw.Container(
                height: 100,
                width: 700,
                child: pw.Row(
                    mainAxisAlignment: pw.MainAxisAlignment.start,
                    children: [
                      pw.Padding(
                          padding: EdgeInsets.only(left: 50),
                          child: pw.Image(image,
                              width: 150, height: 150, fit: pw.BoxFit.contain)),
                      pw.Column(
                          crossAxisAlignment: pw.CrossAxisAlignment.end,
                          children: [
                            pw.Row(children: [
                              pw.Text('www.firstlogicmetalab.com',
                                  style: pw.TextStyle(
                                    fontSize: 8.6,
                                  )),
                              pw.Icon(
                                IconData(mt.Icons.check.codePoint),
                                color: PdfColors.blue,
                              )
                            ]),
                            pw.SizedBox(height: 5),
                            pw.Divider(thickness: 5, color: PdfColors.blue),
                            pw.Divider(thickness: 3, color: PdfColors.grey),
                          ])
                    ]),
              ),

              pw.Divider(thickness: 0.5, color: PdfColors.black),
              pw.Row(mainAxisAlignment: pw.MainAxisAlignment.center, children: [
                pw.Text(
                  'RECEIPT VOUCHER',
                  style: TextStyle(
                    fontSize: 18.6,
                  ),
                ),
              ]),
              pw.Divider(thickness: 0.5, color: PdfColors.black),

              pw.SizedBox(height: 20),

              pw.Padding(
                padding: EdgeInsets.only(left: 40, right: 40),
              ),

              // pw.Text(currentbranchName,
              //     style: pw.TextStyle(
              //         fontSize: 17,
              //         fontWeight: FontWeight.bold,
              //         color: PdfColors.blue)),
              // pw.SizedBox(height: 10),
              // pw.Text(currentbranchAddress,
              //     style:
              //         pw.TextStyle(fontSize: 13, fontWeight: FontWeight.bold)),
              // pw.SizedBox(height: 5),
              // pw.Text('ph : ' + currentbranchphoneNumber,
              //     style:
              //         pw.TextStyle(fontSize: 13, fontWeight: FontWeight.bold)),
              // pw.SizedBox(height: 20),
              // pw.Divider(thickness: 0.5, color: PdfColors.blue),
              // pw.SizedBox(height: 20),
              //
              // pw.Row(children: [
              //   pw.Container(
              //     width: 120,
              //     child: pw.Text('Customer Name',
              //         style: pw.TextStyle(
              //           fontSize: 15,
              //         )),
              //   ),
              //   pw.Container(
              //     width: 250,
              //     child: pw.Text(invoice.name,
              //         style: pw.TextStyle(
              //           fontSize: 15,
              //         )),
              //   ),
              // ]),
              // pw.SizedBox(height: 5),
              // pw.Row(children: [
              //   pw.Container(
              //     width: 120,
              //     child: pw.Text('Date',
              //         style: pw.TextStyle(
              //           fontSize: 15,
              //         )),
              //   ),
              //   pw.Container(
              //     width: 250,
              //     child: pw.Text(invoice.date,
              //         style: pw.TextStyle(
              //           fontSize: 15,
              //         )),
              //   ),
              // ]),
              // pw.SizedBox(height: 5),
              // // pw.Row(
              // //   children:[
              // //     pw.Container(width: 120,child:  pw.Text('Project Type',style: pw.TextStyle(fontSize: 15,)),),
              // //     pw.Container(width: 250,child:  pw.Text(invoice.selectedProjectType,style: pw.TextStyle(fontSize: 15,)),),
              // //   ]
              // // ),
              // // pw.SizedBox(height: 5),
              // pw.Row(children: [
              //   pw.Container(
              //     width: 120,
              //     child: pw.Text('Project Name',
              //         style: pw.TextStyle(
              //           fontSize: 15,
              //         )),
              //   ),
              //   pw.Container(
              //     width: 250,
              //     child: pw.Text(invoice.nameOfProject,
              //         style: pw.TextStyle(
              //           fontSize: 15,
              //         )),
              //   ),
              // ]),
              //
              // pw.SizedBox(height: 30),
              //
              // pw.Table(
              //     tableWidth: TableWidth.max,
              //     border: pw.TableBorder.all(width: 1, color: PdfColors.grey),
              //     children: [
              //       pw.TableRow(children: [
              //         pw.Container(
              //             color: PdfColors.blue,
              //             height: 20,
              //             child: pw.Text('Sl.no',
              //                 style: pw.TextStyle(color: PdfColors.white))),
              //         pw.Container(
              //             color: PdfColors.blue,
              //             height: 20,
              //             child: pw.Text('Description',
              //                 style: pw.TextStyle(color: PdfColors.white))),
              //         pw.Container(
              //             color: PdfColors.blue,
              //             height: 20,
              //             child: pw.Text('Amount',
              //                 style: pw.TextStyle(color: PdfColors.white))),
              //       ]),
              //       pw.TableRow(children: [
              //         pw.Container(height: 20, child: pw.Text('1')),
              //         pw.Container(
              //             height: 20, child: pw.Text('Total Project Cost')),
              //         pw.Container(
              //             height: 20,
              //             child: pw.Text(invoice.TotalProjectCost.toString())),
              //       ]),
              //       pw.TableRow(children: [
              //         pw.Container(height: 20, child: pw.Text('2')),
              //         pw.Container(
              //             height: 20, child: pw.Text('Current Payment')),
              //         pw.Container(
              //             height: 20,
              //             child: pw.Text(invoice.lastPaymentAmount.toString())),
              //       ]),
              //       pw.TableRow(children: [
              //         pw.Container(height: 20, child: pw.Text('3')),
              //         pw.Container(
              //             height: 20, child: pw.Text('Mode Of Payment')),
              //         pw.Container(
              //             height: 20, child: pw.Text(invoice.paymentMethod)),
              //       ]),
              //       pw.TableRow(children: [
              //         pw.Container(height: 20, child: pw.Text('4')),
              //         pw.Container(
              //             height: 20, child: pw.Text('Total Amount Paid')),
              //         pw.Container(
              //             height: 20,
              //             child: pw.Text(invoice.TotalAmountPaid.toString())),
              //       ]),
              //       pw.TableRow(children: [
              //         pw.Container(height: 20, child: pw.Text('5')),
              //         pw.Container(height: 20, child: pw.Text('Balance Due')),
              //         pw.Container(
              //             height: 20,
              //             child: pw.Text(
              //               (invoice.TotalProjectCost - invoice.TotalAmountPaid)
              //                   .toString(),
              //               // invoice.TotalDue.toString())
              //             )),
              //       ]),
              //     ]),
              //
              // pw.SizedBox(height: 50),
              // pw.Text('Signature :',
              //     style: pw.TextStyle(
              //       fontSize: 15,
              //     )),
              // pw.SizedBox(height: 30),
              // Text('your return from information indicate that you are in a credit position, your credit amount will be carried forward for next filing',style: TextStyle(fontSize: 9,)),
              // pw.SizedBox(height: 10),
            ])),
      ],
    ));

    //WEB DOWNLOAD

    var data = await pdf.save();
    Uint8List bytes = Uint8List.fromList(data);
    final blob = html.Blob([bytes], 'application/pdf');
    final url = html.Url.createObjectUrlFromBlob(blob);
    final anchor = html.document.createElement('a') as html.AnchorElement
      ..href = url
      ..style.display = 'none'
      ..download = '${invoice.name}.pdf';

    html.document.body.children.add(anchor);
    anchor.click();
    html.document.body.children.remove(anchor);
    html.Url.revokeObjectUrl(url);

    //android
    // return PdfApi.saveDocument(name: '${invoice.name}+feedetail.pdf', pdf: pdf);
  }
}
