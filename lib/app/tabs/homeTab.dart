import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:charts_flutter/flutter.dart' as charts;

import '../../flutter_flow/flutter_flow_icon_button.dart';
import '../../flutter_flow/upload_media.dart';
import 'Enquiry/EnquiryDetails.dart';

class HomeTab extends StatefulWidget {
  const HomeTab({Key key}) : super(key: key);

  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  //Todays Date

  Color firstColor = Colors.blue.shade50;
  Color textColor = Colors.black;
  Color borderColor = Colors.black;
  final List<SubscriberSeries> data2 = [
    SubscriberSeries(
        year: "2008",
        subscribers: 10000000,
        barColor: charts.ColorUtil.fromDartColor(Colors.blue),
        enquiry: 324535,
        completed: 132545),
    SubscriberSeries(
        year: "2009",
        subscribers: 11000000,
        barColor: charts.ColorUtil.fromDartColor(Colors.blue),
        enquiry: 324735,
        completed: 132555),
    SubscriberSeries(
        year: "2010",
        subscribers: 12000000,
        barColor: charts.ColorUtil.fromDartColor(Colors.blue),
        enquiry: 354535,
        completed: 332545),
    SubscriberSeries(
        year: "2011",
        subscribers: 10000000,
        barColor: charts.ColorUtil.fromDartColor(Colors.blue),
        enquiry: 654535,
        completed: 134545),
    SubscriberSeries(
        year: "2012",
        subscribers: 8500000,
        barColor: charts.ColorUtil.fromDartColor(Colors.blue),
        enquiry: 324535,
        completed: 132545),
    SubscriberSeries(
        year: "2013",
        subscribers: 7700000,
        barColor: charts.ColorUtil.fromDartColor(Colors.blue),
        enquiry: 329535,
        completed: 132095),
    SubscriberSeries(
        year: "2014",
        subscribers: 7600000,
        barColor: charts.ColorUtil.fromDartColor(Colors.blue),
        enquiry: 398535,
        completed: 452545),
    SubscriberSeries(
        year: "2015",
        subscribers: 5500000,
        barColor: charts.ColorUtil.fromDartColor(Colors.red),
        enquiry: 325635,
        completed: 332545),
  ];

  Timestamp todayDate;
  @override
  void initState() {
    DateTime today = DateTime.now();
    todayDate = Timestamp.fromDate(
        DateTime(today.year, today.month, today.day, 0, 0, 0));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List<charts.Series<SubscriberSeries, String>> series = [
      charts.Series(
          id: "Subscribers",
          data: data2,
          domainFn: (SubscriberSeries series, _) => series.year,
          measureFn: (SubscriberSeries series, _) => series.subscribers,
          colorFn: (SubscriberSeries series, _) => series.barColor)
    ];
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Container(
        color: Colors.white,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.all(width * 0.01),
                child: Row(
                  children: [
                    Container(
                      height: height * 0.25,
                      width: width * 0.25,
                      child: Stack(
                        children: [
                          Column(
                            children: [
                              Expanded(child: SizedBox()),
                              Container(
                                height: height * 0.2,
                                width: width * 0.25,
                                decoration: BoxDecoration(
                                  color: firstColor,
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(10)),
                                ),
                                child: Padding(
                                  padding: EdgeInsets.all(width * 0.01),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Expanded(child: SizedBox()),
                                      Text(
                                        'ENQUIRY',
                                        style: TextStyle(
                                            fontSize: width * 0.015,
                                            color: textColor),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      SizedBox(
                                        height: width * 0.01,
                                      ),
                                      StreamBuilder<QuerySnapshot>(
                                          stream: FirebaseFirestore.instance
                                              .collection('orders')
                                              .where('orderStatus',
                                                  isEqualTo: 4)
                                              .snapshots(),
                                          builder: (context, snapshot) {
                                            if (!snapshot.hasData) {
                                              return Center(
                                                  child:
                                                      CircularProgressIndicator());
                                            }
                                            var data = snapshot.data.docs;
                                            int totalSales = data.length;

                                            return Row(
                                              children: [
                                                Expanded(
                                                  child: Column(
                                                    children: [
                                                      Text(
                                                        'Today',
                                                        style:
                                                            GoogleFonts.roboto(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w400,
                                                                color: Colors
                                                                    .black,
                                                                fontSize:
                                                                    width *
                                                                        0.008),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            EdgeInsets.only(
                                                          left: width * 0.002,
                                                          right: width * 0.002,
                                                        ),
                                                        child: Divider(),
                                                      ),
                                                      Text(
                                                        '23',
                                                        style:
                                                            GoogleFonts.roboto(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w400,
                                                                color: Colors
                                                                    .black,
                                                                fontSize:
                                                                    width *
                                                                        0.008),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: width * 0.002,
                                                ),
                                                Expanded(
                                                  child: Column(
                                                    children: [
                                                      Text(
                                                        'Month',
                                                        style:
                                                            GoogleFonts.roboto(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w400,
                                                                color: Colors
                                                                    .black,
                                                                fontSize:
                                                                    width *
                                                                        0.008),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            EdgeInsets.only(
                                                          left: width * 0.002,
                                                          right: width * 0.002,
                                                        ),
                                                        child: Divider(),
                                                      ),
                                                      Text(
                                                        '435',
                                                        style:
                                                            GoogleFonts.roboto(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w400,
                                                                color: Colors
                                                                    .black,
                                                                fontSize:
                                                                    width *
                                                                        0.008),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: width * 0.002,
                                                ),
                                                Expanded(
                                                  child: Column(
                                                    children: [
                                                      Text(
                                                        'Year',
                                                        style:
                                                            GoogleFonts.roboto(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w400,
                                                                color: Colors
                                                                    .black,
                                                                fontSize:
                                                                    width *
                                                                        0.008),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            EdgeInsets.only(
                                                          left: width * 0.002,
                                                          right: width * 0.002,
                                                        ),
                                                        child: Divider(),
                                                      ),
                                                      Text(
                                                        '3248',
                                                        style:
                                                            GoogleFonts.roboto(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w400,
                                                                color: Colors
                                                                    .black,
                                                                fontSize:
                                                                    width *
                                                                        0.008),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: width * 0.002,
                                                ),
                                                Expanded(
                                                  child: Column(
                                                    children: [
                                                      Text(
                                                        'Total',
                                                        style:
                                                            GoogleFonts.roboto(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w400,
                                                                color: Colors
                                                                    .black,
                                                                fontSize:
                                                                    width *
                                                                        0.008),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            EdgeInsets.only(
                                                          left: width * 0.002,
                                                          right: width * 0.002,
                                                        ),
                                                        child: Divider(),
                                                      ),
                                                      Text(
                                                        //totalSales.toString(),
                                                        '89647',
                                                        style:
                                                            GoogleFonts.roboto(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w400,
                                                                color: Colors
                                                                    .black,
                                                                fontSize:
                                                                    width *
                                                                        0.008),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            );
                                          }),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Align(
                            alignment: Alignment.topCenter,
                            child: Container(
                              height: height * 0.1,
                              width: height * 0.1,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.deepOrange,
                              ),
                              child: Center(
                                child: Icon(
                                  Icons.notes,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(child: SizedBox()),
                    Container(
                      height: height * 0.25,
                      width: width * 0.25,
                      child: Stack(
                        children: [
                          Column(
                            children: [
                              Expanded(child: SizedBox()),
                              Container(
                                height: height * 0.2,
                                width: width * 0.25,
                                decoration: BoxDecoration(
                                  color: firstColor,
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(10)),
                                ),
                                child: Padding(
                                  padding: EdgeInsets.all(width * 0.01),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Expanded(child: SizedBox()),
                                      Text(
                                        'REGISTRATION',
                                        style: TextStyle(
                                            fontSize: width * 0.015,
                                            color: textColor),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      SizedBox(
                                        height: width * 0.01,
                                      ),
                                      StreamBuilder<QuerySnapshot>(
                                          stream: FirebaseFirestore.instance
                                              .collection('orders')
                                              .where('orderStatus',
                                                  isEqualTo: 4)
                                              .snapshots(),
                                          builder: (context, snapshot) {
                                            if (!snapshot.hasData) {
                                              return Center(
                                                  child:
                                                      CircularProgressIndicator());
                                            }
                                            var data = snapshot.data.docs;
                                            int totalSales = data.length;

                                            return Row(
                                              children: [
                                                Expanded(
                                                  child: Column(
                                                    children: [
                                                      Text(
                                                        'Today',
                                                        style:
                                                            GoogleFonts.roboto(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w400,
                                                                color: Colors
                                                                    .black,
                                                                fontSize:
                                                                    width *
                                                                        0.008),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            EdgeInsets.only(
                                                          left: width * 0.002,
                                                          right: width * 0.002,
                                                        ),
                                                        child: Divider(),
                                                      ),
                                                      Text(
                                                        '23',
                                                        style:
                                                            GoogleFonts.roboto(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w400,
                                                                color: Colors
                                                                    .black,
                                                                fontSize:
                                                                    width *
                                                                        0.008),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: width * 0.002,
                                                ),
                                                Expanded(
                                                  child: Column(
                                                    children: [
                                                      Text(
                                                        'Month',
                                                        style:
                                                            GoogleFonts.roboto(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w400,
                                                                color: Colors
                                                                    .black,
                                                                fontSize:
                                                                    width *
                                                                        0.008),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            EdgeInsets.only(
                                                          left: width * 0.002,
                                                          right: width * 0.002,
                                                        ),
                                                        child: Divider(),
                                                      ),
                                                      Text(
                                                        '435',
                                                        style:
                                                            GoogleFonts.roboto(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w400,
                                                                color: Colors
                                                                    .black,
                                                                fontSize:
                                                                    width *
                                                                        0.008),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: width * 0.002,
                                                ),
                                                Expanded(
                                                  child: Column(
                                                    children: [
                                                      Text(
                                                        'Year',
                                                        style:
                                                            GoogleFonts.roboto(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w400,
                                                                color: Colors
                                                                    .black,
                                                                fontSize:
                                                                    width *
                                                                        0.008),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            EdgeInsets.only(
                                                          left: width * 0.002,
                                                          right: width * 0.002,
                                                        ),
                                                        child: Divider(),
                                                      ),
                                                      Text(
                                                        '3248',
                                                        style:
                                                            GoogleFonts.roboto(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w400,
                                                                color: Colors
                                                                    .black,
                                                                fontSize:
                                                                    width *
                                                                        0.008),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: width * 0.002,
                                                ),
                                                Expanded(
                                                  child: Column(
                                                    children: [
                                                      Text(
                                                        'Total',
                                                        style:
                                                            GoogleFonts.roboto(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w400,
                                                                color: Colors
                                                                    .black,
                                                                fontSize:
                                                                    width *
                                                                        0.008),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            EdgeInsets.only(
                                                          left: width * 0.002,
                                                          right: width * 0.002,
                                                        ),
                                                        child: Divider(),
                                                      ),
                                                      Text(
                                                        //totalSales.toString(),
                                                        '89647',
                                                        style:
                                                            GoogleFonts.roboto(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w400,
                                                                color: Colors
                                                                    .black,
                                                                fontSize:
                                                                    width *
                                                                        0.008),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            );
                                          }),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Align(
                            alignment: Alignment.topCenter,
                            child: Container(
                              height: height * 0.1,
                              width: height * 0.1,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.blue,
                              ),
                              child: Center(
                                child: Icon(
                                  Icons.app_registration,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(child: SizedBox()),
                    Container(
                      height: height * 0.25,
                      width: width * 0.25,
                      child: Stack(
                        children: [
                          Column(
                            children: [
                              Expanded(child: SizedBox()),
                              Container(
                                height: height * 0.2,
                                width: width * 0.25,
                                decoration: BoxDecoration(
                                  color: firstColor,
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(10)),
                                ),
                                child: Padding(
                                  padding: EdgeInsets.all(width * 0.01),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Expanded(child: SizedBox()),
                                      Text(
                                        'COMPLETED',
                                        style: GoogleFonts.roboto(
                                            fontSize: width * 0.015,
                                            color: textColor),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      SizedBox(
                                        height: width * 0.01,
                                      ),
                                      StreamBuilder<QuerySnapshot>(
                                          stream: FirebaseFirestore.instance
                                              .collection('orders')
                                              .where('orderStatus',
                                                  isEqualTo: 4)
                                              .snapshots(),
                                          builder: (context, snapshot) {
                                            if (!snapshot.hasData) {
                                              return Center(
                                                  child:
                                                      CircularProgressIndicator());
                                            }
                                            var data = snapshot.data.docs;
                                            int totalSales = data.length;

                                            return Row(
                                              children: [
                                                Expanded(
                                                  child: Column(
                                                    children: [
                                                      Text(
                                                        'Today',
                                                        style:
                                                            GoogleFonts.roboto(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w400,
                                                                color: Colors
                                                                    .black,
                                                                fontSize:
                                                                    width *
                                                                        0.008),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            EdgeInsets.only(
                                                          left: width * 0.002,
                                                          right: width * 0.002,
                                                        ),
                                                        child: Divider(),
                                                      ),
                                                      Text(
                                                        '23',
                                                        style:
                                                            GoogleFonts.roboto(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w400,
                                                                color: Colors
                                                                    .black,
                                                                fontSize:
                                                                    width *
                                                                        0.008),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: width * 0.002,
                                                ),
                                                Expanded(
                                                  child: Column(
                                                    children: [
                                                      Text(
                                                        'Month',
                                                        style:
                                                            GoogleFonts.roboto(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w400,
                                                                color: Colors
                                                                    .black,
                                                                fontSize:
                                                                    width *
                                                                        0.008),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            EdgeInsets.only(
                                                          left: width * 0.002,
                                                          right: width * 0.002,
                                                        ),
                                                        child: Divider(),
                                                      ),
                                                      Text(
                                                        '435',
                                                        style:
                                                            GoogleFonts.roboto(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w400,
                                                                color: Colors
                                                                    .black,
                                                                fontSize:
                                                                    width *
                                                                        0.008),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: width * 0.002,
                                                ),
                                                Expanded(
                                                  child: Column(
                                                    children: [
                                                      Text(
                                                        'Year',
                                                        style:
                                                            GoogleFonts.roboto(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w400,
                                                                color: Colors
                                                                    .black,
                                                                fontSize:
                                                                    width *
                                                                        0.008),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            EdgeInsets.only(
                                                          left: width * 0.002,
                                                          right: width * 0.002,
                                                        ),
                                                        child: Divider(),
                                                      ),
                                                      Text(
                                                        '3248',
                                                        style:
                                                            GoogleFonts.roboto(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w400,
                                                                color: Colors
                                                                    .black,
                                                                fontSize:
                                                                    width *
                                                                        0.008),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: width * 0.002,
                                                ),
                                                Expanded(
                                                  child: Column(
                                                    children: [
                                                      Text(
                                                        'Total',
                                                        style:
                                                            GoogleFonts.roboto(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w400,
                                                                color: Colors
                                                                    .black,
                                                                fontSize:
                                                                    width *
                                                                        0.008),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            EdgeInsets.only(
                                                          left: width * 0.002,
                                                          right: width * 0.002,
                                                        ),
                                                        child: Divider(),
                                                      ),
                                                      Text(
                                                        //totalSales.toString(),
                                                        '89647',
                                                        style:
                                                            GoogleFonts.roboto(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w400,
                                                                color: Colors
                                                                    .black,
                                                                fontSize:
                                                                    width *
                                                                        0.008),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            );
                                          }),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Align(
                            alignment: Alignment.topCenter,
                            child: Container(
                              height: height * 0.1,
                              width: height * 0.1,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.green,
                              ),
                              child: Center(
                                child: Icon(
                                  Icons.check,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    // Padding(
                    //   padding: const EdgeInsets.all(8.0),
                    //   child: Container(
                    //     height: 100,
                    //     width: 300,
                    //     decoration: BoxDecoration(
                    //       color: secondaryColor,
                    //       borderRadius: const BorderRadius.all(Radius.circular(10)),
                    //     ),
                    //     child: Padding(
                    //       padding: const EdgeInsets.all(8.0),
                    //       child: Row(
                    //         mainAxisAlignment: MainAxisAlignment.start,
                    //         children: [
                    //           Container(
                    //             height: 50,
                    //             width: 50,
                    //             decoration: BoxDecoration(
                    //               color: Colors.white,
                    //               borderRadius: const BorderRadius.all(Radius.circular(10)),
                    //             ),
                    //             child: Center(
                    //               child: Icon( Icons.shopping_cart,
                    //                 color: secondaryColor,
                    //               ),
                    //             ),
                    //           ),
                    //           SizedBox(width: 10,),
                    //
                    //           Column(
                    //             crossAxisAlignment: CrossAxisAlignment.start,
                    //             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    //             children: [
                    //               Text(
                    //                 'Total Orders',
                    //                 style: TextStyle(fontSize: 18,color: Colors.white),
                    //                 maxLines: 1,
                    //
                    //                 overflow: TextOverflow.ellipsis,
                    //               ),
                    //               StreamBuilder<QuerySnapshot>(
                    //                 stream: FirebaseFirestore.instance.collection('orders').snapshots(),
                    //                 builder: (context, snapshot) {
                    //                   if(!snapshot.hasData){
                    //                     return Center(child: CircularProgressIndicator());
                    //                   }
                    //                   var data=snapshot.data.docs;
                    //                   int totalOrders=data.length;
                    //                   return Text(
                    //                     totalOrders.toString(),
                    //                     style: Theme.of(context)
                    //                         .textTheme
                    //                         .caption
                    //                         .copyWith(color: Colors.white,fontSize: 18,fontWeight: FontWeight.bold),
                    //                   );
                    //                 }
                    //               )
                    //             ],
                    //           ),
                    //         ],
                    //       ),
                    //     ),
                    //   ),
                    // ),
                    // Padding(
                    //   padding: const EdgeInsets.all(8.0),
                    //   child: Container(
                    //     height: 100,
                    //     width: 300,
                    //     decoration: BoxDecoration(
                    //       color: secondaryColor,
                    //       borderRadius: const BorderRadius.all(Radius.circular(10)),
                    //     ),
                    //     child: Padding(
                    //       padding: const EdgeInsets.all(8.0),
                    //       child: Row(
                    //         mainAxisAlignment: MainAxisAlignment.start,
                    //         children: [
                    //           Container(
                    //             height: 50,
                    //             width: 50,
                    //             decoration: BoxDecoration(
                    //               color: Colors.white,
                    //               borderRadius: const BorderRadius.all(Radius.circular(10)),
                    //             ),
                    //             child: Center(
                    //               child: Icon( Icons.shopping_bag,
                    //                 color: secondaryColor,
                    //               ),
                    //             ),
                    //           ),
                    //           SizedBox(width: 10,),
                    //
                    //           Column(
                    //             crossAxisAlignment: CrossAxisAlignment.start,
                    //             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    //             children: [
                    //               Text(
                    //                 'Total Enquiry',
                    //                 style: TextStyle(fontSize: 18,color: Colors.white),
                    //                 maxLines: 1,
                    //                 overflow: TextOverflow.ellipsis,
                    //               ),
                    //               StreamBuilder<QuerySnapshot>(
                    //                 stream: FirebaseFirestore.instance.collection('products').snapshots(),
                    //                 builder: (context, snapshot) {
                    //                   if(!snapshot.hasData){
                    //                     return Center(child: CircularProgressIndicator());
                    //                   }
                    //                   var data=snapshot.data.docs;
                    //
                    //                   return Text(
                    //                     data.length.toString(),
                    //                     style: Theme.of(context)
                    //                         .textTheme
                    //                         .caption
                    //                         .copyWith(color: Colors.white,fontSize: 18,fontWeight: FontWeight.bold),
                    //                   );
                    //                 }
                    //               ),
                    //             ],
                    //           ),
                    //         ],
                    //       ),
                    //     ),
                    //   ),
                    // ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.all(width * 0.01),
                child: Row(
                  children: [
                    Expanded(
                      flex: 3,
                      child: Container(
                        height: height * 0.6,
                        width: width * 0.5,
                        decoration: BoxDecoration(
                            color: Colors.blueGrey.shade50,
                            borderRadius: BorderRadius.circular(10)),
                        child: Padding(
                          padding: EdgeInsets.all(width * 0.01),
                          child: Column(
                            children: [
                              Text(
                                'REGISTRATION GRAPH',
                                style: GoogleFonts.roboto(
                                    fontSize: width * 0.02,
                                    color: textColor,
                                    fontWeight: FontWeight.bold),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Expanded(
                                  child:
                                      charts.BarChart(series, animate: true)),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: width * 0.01,
                    ),
                    Expanded(
                      flex: 2,
                      child: Container(
                        height: height * 0.6,
                        width: width * 0.3,
                        decoration: BoxDecoration(
                            color: Colors.blueGrey.shade50,
                            borderRadius: BorderRadius.circular(10)),
                        child: Padding(
                          padding: EdgeInsets.all(width * 0.01),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.calendar_today_rounded),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    'TO DO',
                                    style: GoogleFonts.roboto(
                                        fontSize: width * 0.02,
                                        color: textColor,
                                        fontWeight: FontWeight.bold),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ],
                              ),
                              Divider(),
                              Expanded(
                                child: StreamBuilder<QuerySnapshot>(
                                    stream: FirebaseFirestore.instance
                                        .collection('followUp')
                                        .where('done', isEqualTo: false)
                                        .where('next', isEqualTo: todayDate)
                                        .snapshots(),
                                    builder: (context, snapshot) {
                                      if (!snapshot.hasData) {
                                        return Center(
                                          child: CircularProgressIndicator(),
                                        );
                                      }
                                      var data = snapshot.data.docs;

                                      if (data.isEmpty) {
                                        return Center(
                                            child: Text(
                                                'No items found for Today'));
                                      }
                                      return ListView.builder(
                                        itemCount: data.length,
                                        itemBuilder: (context, index) {
                                          return InkWell(
                                            onTap: () {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                        EnquiryDetailsWidget(
                                                            id: data[index]
                                                                ['eId']),
                                                  ));
                                            },
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.only(top: 5),
                                              child: Container(
                                                height: 95,
                                                decoration: BoxDecoration(
                                                    color: Colors
                                                        .blueGrey.shade200,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10)),
                                                child: Padding(
                                                  padding: EdgeInsets.fromLTRB(
                                                    width * 0.01,
                                                    width * 0.01,
                                                    width * 0.01,
                                                    width * 0.01,
                                                  ),
                                                  child: Row(
                                                    children: [
                                                      CircleAvatar(
                                                        radius: width * 0.008,
                                                        backgroundColor:
                                                            Color(0xff0054FF),
                                                        child: Center(
                                                          child: Text(
                                                            (index + 1)
                                                                .toString(),
                                                            style: TextStyle(
                                                                fontSize: 10),
                                                          ),
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        width: width * 0.01,
                                                      ),
                                                      Expanded(
                                                          child: Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .start,
                                                        children: [
                                                          Text(
                                                            'Name : ${data[index]['name']}',
                                                            style: GoogleFonts
                                                                .roboto(
                                                                    color: Colors
                                                                        .white),
                                                          ),
                                                          Text(
                                                            'Project : ${data[index]['workName']}',
                                                            style: GoogleFonts
                                                                .roboto(
                                                                    color: Colors
                                                                        .white),
                                                          ),
                                                        ],
                                                      )),
                                                      Expanded(
                                                        child: Column(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Text(
                                                              'Phone: ${data[index]['phone']}',
                                                              style: GoogleFonts
                                                                  .roboto(
                                                                      color: Colors
                                                                          .white),
                                                            ),
                                                            data[index]['email'] ==
                                                                    ''
                                                                ? SizedBox()
                                                                : Text(
                                                                    'email : ${data[index]['email']}',
                                                                    style: GoogleFonts
                                                                        .roboto(
                                                                            color:
                                                                                Colors.white),
                                                                  ),
                                                          ],
                                                        ),
                                                      ),
                                                      FlutterFlowIconButton(
                                                        borderColor:
                                                            Colors.transparent,
                                                        borderRadius: 30,
                                                        borderWidth: 1,
                                                        buttonSize: 50,
                                                        icon: Icon(
                                                          Icons.pending,
                                                          color:
                                                              Color(0xff231F20),
                                                          size: 30,
                                                        ),
                                                        onPressed: () async {
                                                          bool pressed =
                                                              await alert(
                                                                  context,
                                                                  'Update follow up?');

                                                          if (pressed) {
                                                            FirebaseFirestore
                                                                .instance
                                                                .collection(
                                                                    'followUp')
                                                                .doc(data[index]
                                                                    ['dId'])
                                                                .update({
                                                              'done': true
                                                            }).then((value) =>
                                                                    showUploadMessage(
                                                                        context,
                                                                        'FollowUp Updated'));
                                                          }
                                                        },
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                          );
                                        },
                                      );
                                    }),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                height: height * 0.8,
                width: width * 0.8,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(3),
                    border: Border.all(color: Colors.black, width: 0.2)),
                child: Row(
                  children: [
                    Expanded(
                      flex: 2,
                      child: DefaultTabController(
                        length: 4,
                        child: Column(
                          children: [
                            TabBar(
                              tabs: [
                                Tab(
                                  text: 'Application',
                                ),
                                Tab(
                                  text: 'Enquiry',
                                ),
                                Tab(
                                  text: 'Registration',
                                ),
                                Tab(
                                  text: 'Other',
                                ),
                              ],
                              labelStyle:
                                  GoogleFonts.roboto(fontSize: width * 0.01),
                              unselectedLabelStyle:
                                  GoogleFonts.roboto(fontSize: width * 0.01),
                              indicatorColor: Colors.black,
                              labelColor: Colors.black,
                              unselectedLabelColor: Colors.blueGrey,
                            ),
                            Container(
                              color: Colors.black,
                              height: 0.1,
                            ),
                            Expanded(
                              child: TabBarView(children: [
                                Container(
                                  child: StreamBuilder<QuerySnapshot>(
                                      stream: FirebaseFirestore.instance
                                          .collection('university')
                                          .snapshots(),
                                      builder: (context, snapshot) {
                                        if (!snapshot.hasData) {
                                          return Center(
                                              child:
                                                  CircularProgressIndicator());
                                        }
                                        var data = snapshot.data.docs;
                                        if (data.isEmpty) {
                                          Center(child: Text('No Messages'));
                                        }
                                        return ListView.builder(
                                          itemCount: data.length,
                                          padding: EdgeInsets.all(
                                            width * 0.01,
                                          ),
                                          itemBuilder: (context, index) {
                                            return Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 5.0),
                                              child: Column(
                                                children: [
                                                  Row(
                                                    children: [
                                                      CircleAvatar(
                                                        radius: width * 0.02,
                                                        backgroundColor: Colors
                                                            .grey.shade200,
                                                        backgroundImage:
                                                            CachedNetworkImageProvider(
                                                                data[index]
                                                                    ['logo']),
                                                      ),
                                                      SizedBox(
                                                        width: width * 0.01,
                                                      ),
                                                      Expanded(
                                                        child: Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Text(
                                                              data[index]
                                                                  ['name'],
                                                              style: GoogleFonts
                                                                  .roboto(
                                                                fontSize:
                                                                    width *
                                                                        0.016,
                                                              ),
                                                            ),
                                                            Padding(
                                                              padding:
                                                                  EdgeInsets
                                                                      .only(
                                                                left: width *
                                                                    0.001,
                                                              ),
                                                              child: Text(
                                                                'Last message',
                                                                style:
                                                                    GoogleFonts
                                                                        .roboto(
                                                                  fontSize:
                                                                      width *
                                                                          0.008,
                                                                ),
                                                              ),
                                                            )
                                                          ],
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        width: width * 0.01,
                                                      ),
                                                      Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .end,
                                                        children: [
                                                          Text(
                                                            '08:39 PM',
                                                            style: GoogleFonts
                                                                .roboto(
                                                              fontSize:
                                                                  width * 0.007,
                                                            ),
                                                          ),
                                                          SizedBox(
                                                            height:
                                                                width * 0.005,
                                                          ),
                                                          CircleAvatar(
                                                            radius:
                                                                width * 0.005,
                                                            backgroundColor:
                                                                Colors.green
                                                                    .shade300,
                                                          )
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                  Row(
                                                    children: [
                                                      Container(
                                                        width: width * 0.04,
                                                      ),
                                                      Expanded(
                                                          child: Divider()),
                                                    ],
                                                  )
                                                ],
                                              ),
                                            );
                                          },
                                        );
                                      }),
                                ),
                                Container(),
                                Container(),
                                Container(),
                              ]),
                            )
                          ],
                        ),
                      ),
                    ),
                    Container(
                      color: Colors.black,
                      width: 0.1,
                    ),
                    Expanded(flex: 3, child: Container())
                  ],
                ),
              ),
              // RecentFiles(),
            ],
          ),
        ),
      ),
    );
  }
}

class SubscriberSeries {
  final String year;
  final int subscribers;
  final int enquiry;
  final int completed;
  final charts.Color barColor;

  SubscriberSeries(
      {@required this.enquiry,
      @required this.completed,
      @required this.year,
      @required this.subscribers,
      @required this.barColor});
}
