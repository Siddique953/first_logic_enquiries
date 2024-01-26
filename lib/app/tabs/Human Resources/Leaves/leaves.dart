import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';

import '../../../../flutter_flow/flutter_flow_theme.dart';

class HrLeavePage extends StatefulWidget {
  final TabController _tabController;
  const HrLeavePage({
    Key? key,
    required TabController tabController,
  })  : _tabController = tabController,
        super(key: key);

  @override
  State<HrLeavePage> createState() => _HrLeavePageState();
}

class _HrLeavePageState extends State<HrLeavePage> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  late TextEditingController search;

  late Stream<QuerySnapshot> leaveStream;
  int selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    search = TextEditingController();
    leaveStream = search.text.isEmpty
        ? FirebaseFirestore.instance
            .collection('leaveRequest')
            .orderBy('from', descending: true)
            .snapshots()
        : FirebaseFirestore.instance
            .collection('leaveRequest')
            .orderBy('from', descending: true)
            .snapshots();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(20, 15, 20, 0),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width * 0.3,
                      decoration: BoxDecoration(
                        border: Border.all(),
                      ),
                      child: TextFormField(
                        controller: search,
                        obscureText: false,
                        onChanged: (text) {
                          setState(() {});
                        },
                        decoration: InputDecoration(
                          labelText: 'Search ',
                          hintText: 'Please Enter Department or Name',
                          labelStyle: FlutterFlowTheme.bodyText2.override(
                            fontFamily: 'Poppins',
                            color: Color(0xFF7C8791),
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Color(0x00000000),
                              width: 2,
                            ),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Color(0x00000000),
                              width: 2,
                            ),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          filled: true,
                          fillColor: Colors.white,
                        ),
                        style: FlutterFlowTheme.bodyText1.override(
                          fontFamily: 'Poppins',
                          color: Color(0xFF090F13),
                          fontSize: 14,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(10, 20, 0, 20),
                    child: Text(
                      'Requests',
                      style: FlutterFlowTheme.bodyText1.override(
                          fontFamily: 'Poppins',
                          fontSize: 30,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(10, 20, 0, 20),
                    child: Row(
                      children: [
                        InkWell(
                          onTap: () {
                            leaveStream = FirebaseFirestore.instance
                                .collection('leaveRequest')
                                .where('accepted', isEqualTo: true)
                                .orderBy('from', descending: true)
                                .snapshots();
                            selectedIndex = 0;
                            setState(() {});
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: selectedIndex == 0
                                  ? Color(0xff0054FF)
                                  : Colors.transparent,
                              border: Border.all(),
                              borderRadius: BorderRadius.circular(25),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                'Accepted',
                                style: FlutterFlowTheme.bodyText1.override(
                                  fontFamily: 'Poppins',
                                  fontSize: 15,
                                  color: selectedIndex == 0
                                      ? Colors.white
                                      : Colors.black,
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        InkWell(
                          onTap: () {
                            leaveStream = FirebaseFirestore.instance
                                .collection('leaveRequest')
                                .where('accepted', isEqualTo: false)
                                .where('rejected', isEqualTo: false)
                                .orderBy('from', descending: true)
                                .snapshots();
                            selectedIndex = 1;
                            setState(() {});
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: selectedIndex == 1
                                  ? Color(0xff0054FF)
                                  : Colors.transparent,
                              border: Border.all(),
                              borderRadius: BorderRadius.circular(25),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                'Pending',
                                style: FlutterFlowTheme.bodyText1.override(
                                  fontFamily: 'Poppins',
                                  fontSize: 15,
                                  color: selectedIndex == 1
                                      ? Colors.white
                                      : Colors.black,
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        InkWell(
                          onTap: () {
                            leaveStream = FirebaseFirestore.instance
                                .collection('leaveRequest')
                                .where('rejected', isEqualTo: true)
                                .orderBy('from', descending: true)
                                .snapshots();
                            selectedIndex = 2;
                            setState(() {});
                          },
                          child: Container(
                            decoration: BoxDecoration(
                                color: selectedIndex == 2
                                    ? Color(0xff0054FF)
                                    : Colors.transparent,
                                border: Border.all(),
                                borderRadius: BorderRadius.circular(25)),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                'Rejected',
                                style: FlutterFlowTheme.bodyText1.override(
                                  fontFamily: 'Poppins',
                                  fontSize: 15,
                                  color: selectedIndex == 2
                                      ? Colors.white
                                      : Colors.black,
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 5,
                        )
                      ],
                    ),
                  ),
                ],
              ),
              search.text == ''
                  ? StreamBuilder<QuerySnapshot>(
                      stream: leaveStream,
                      builder: (context, snapshot) {
                        if (snapshot.hasError) {
                          return Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                        if (!snapshot.hasData) {
                          return Center(
                            child: LottieBuilder.network(
                              'https://assets9.lottiefiles.com/packages/lf20_HpFqiS.json',
                              height: 500,
                            ),
                          );
                        }
                        var data = snapshot.data!.docs;
                        return data.length == 0
                            ? LottieBuilder.network(
                                'https://assets9.lottiefiles.com/packages/lf20_HpFqiS.json',
                                height: 500,
                              )
                            : Container(
                                width: double.infinity,
                                child: Wrap(
                                  spacing: 15,
                                  runSpacing: 15,
                                  children: List.generate(
                                    data.length,
                                    (index) {
                                      DateTime date =
                                          data[index]['createdDate'].toDate();

                                      return Container(
                                        decoration: BoxDecoration(
                                          border: Border.all(),
                                        ),
                                        width: 250,
                                        child: Center(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              SizedBox(height: 20.0),
                                              Text(
                                                data[index]['name'],
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 16.0,
                                                ),
                                              ),
                                              SizedBox(height: 8.0),
                                              Text(
                                                (DateTime.now()
                                                            .difference(date)
                                                            .inDays)
                                                        .toString() +
                                                    ' Days ago.',
                                                // DateFormat('dd/MMM/yyyy').format(
                                                //     data[index]['createdDate']
                                                //         .toDate()),
                                                // 'Requested Date',
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 15.0,
                                                ),
                                              ),
                                              SizedBox(height: 8.0),
                                              Row(
                                                children: [
                                                  Expanded(
                                                    child: Container(
                                                      color: Colors.lightBlue
                                                          .withOpacity(0.3),
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(10.0),
                                                        child: Column(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .center,
                                                          children: [
                                                            Text(
                                                              data[index]['duration']
                                                                      .toString() +
                                                                  '  Days',
                                                              style: TextStyle(
                                                                color: Color(
                                                                    0xff0054FF),
                                                              ),
                                                            ),
                                                            SizedBox(
                                                                height: 10.0),
                                                            Text(
                                                              'From ${DateFormat('dd/MM/yyyy').format(data[index]['from'].toDate())} To ${DateFormat('dd/MM/yyyy').format(data[index]['to'].toDate())}',
                                                              style: TextStyle(
                                                                color: Colors
                                                                    .black,
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              SizedBox(height: 16.0),
                                              Text(
                                                'Reason:',
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              SizedBox(height: 8.0),
                                              Text(data[index]['reason']),
                                              SizedBox(height: 16.0),
                                              Text('Status'),
                                              SizedBox(height: 16.0),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Container(
                                                    width: 80,
                                                    height: 25,
                                                    decoration: BoxDecoration(
                                                        color: data[index][
                                                                    'leadStatus'] ==
                                                                1
                                                            ? Colors.greenAccent
                                                            : data[index][
                                                                        'leadStatus'] ==
                                                                    2
                                                                ? Colors
                                                                    .redAccent
                                                                : Colors.grey,
                                                        borderRadius:
                                                            BorderRadius.only(
                                                          bottomRight:
                                                              Radius.circular(
                                                                  10),
                                                          topRight:
                                                              Radius.circular(
                                                                  10),
                                                        )),
                                                    // padding: EdgeInsets.only(
                                                    //   left: 10,
                                                    // ),
                                                    child: Center(
                                                      child: Text(
                                                        'Project Head',
                                                        style: TextStyle(
                                                          color: data[index][
                                                                      'leadStatus'] ==
                                                                  1
                                                              ? Colors.black
                                                              : Colors.white,
                                                          fontSize: 11,
                                                          fontFamily:
                                                              'Urbanist',
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    width: 8,
                                                  ),
                                                  Expanded(
                                                    child: Container(
                                                      width: 90,
                                                      height: 25,
                                                      decoration: BoxDecoration(
                                                          color: data[index][
                                                                      'pmStatus'] ==
                                                                  1
                                                              ? Colors
                                                                  .greenAccent
                                                              : data[index][
                                                                          'pmStatus'] ==
                                                                      2
                                                                  ? Colors
                                                                      .redAccent
                                                                  : Colors.grey,
                                                          borderRadius:
                                                              BorderRadius.only(
                                                            bottomRight:
                                                                Radius.circular(
                                                                    10),
                                                            topRight:
                                                                Radius.circular(
                                                                    10),
                                                          )),
                                                      // color: data[index]
                                                      //             ['pmStatus'] ==
                                                      //         1
                                                      //     ? Colors.greenAccent
                                                      //     : data[index][
                                                      //                 'pmStatus'] ==
                                                      //             2
                                                      //         ? Colors.redAccent
                                                      //         : Colors.grey,
                                                      padding: EdgeInsets.only(
                                                        left: 10,
                                                      ),
                                                      child: Center(
                                                        child: Text(
                                                          'Project Manager',
                                                          style: TextStyle(
                                                            color: data[index][
                                                                        'pmStatus'] ==
                                                                    1
                                                                ? Colors.black
                                                                : Colors.white,
                                                            fontSize: 11,
                                                            fontFamily:
                                                                'Urbanist',
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    width: 8,
                                                  ),
                                                  Container(
                                                    width: 40,
                                                    height: 25,
                                                    decoration: BoxDecoration(
                                                      color: data[index][
                                                                  'hrStatus'] ==
                                                              1
                                                          ? Colors.greenAccent
                                                          : data[index][
                                                                      'hrStatus'] ==
                                                                  2
                                                              ? Colors.redAccent
                                                              : Colors.grey,
                                                      // borderRadius:
                                                      //     BorderRadius.only(
                                                      //   bottomRight:
                                                      //       Radius.circular(10),
                                                      //   topRight:
                                                      //       Radius.circular(10),
                                                      // ),
                                                    ),
                                                    // color: data[index]
                                                    //             ['hrStatus'] ==
                                                    //         1
                                                    //     ? Colors.greenAccent
                                                    //     : data[index][
                                                    //                 'hrStatus'] ==
                                                    //             2
                                                    //         ? Colors.redAccent
                                                    //         : Colors.grey,
                                                    padding: EdgeInsets.only(
                                                      left: 10,
                                                    ),
                                                    child: Center(
                                                      child: Text(
                                                        'HR',
                                                        style: TextStyle(
                                                          color: data[index][
                                                                      'hrStatus'] ==
                                                                  1
                                                              ? Colors.black
                                                              : Colors.white,
                                                          fontSize: 13,
                                                          fontFamily:
                                                              'Urbanist',
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              SizedBox(height: 16.0),
                                              // Row(
                                              //   mainAxisAlignment:
                                              //       MainAxisAlignment.center,
                                              //   children: [
                                              //     ElevatedButton(
                                              //       onPressed: () {
                                              //         // TODO: Handle accept button press
                                              //       },
                                              //       style:
                                              //           ElevatedButton.styleFrom(
                                              //         primary: Colors.green,
                                              //       ),
                                              //       child: Text('Accept'),
                                              //     ),
                                              //     SizedBox(
                                              //       width: 16,
                                              //     ),
                                              //     ElevatedButton(
                                              //       onPressed: () {
                                              //         // TODO: Handle reject button press
                                              //       },
                                              //       style:
                                              //           ElevatedButton.styleFrom(
                                              //         primary: Colors.red,
                                              //       ),
                                              //       child: Text('Reject'),
                                              //     ),
                                              //   ],
                                              // ),
                                              ///Reject Reason
                                              // data[index]['rejected'] == false
                                              //     ? SizedBox()
                                              //     : Text('Reject Reason'),
                                              // SizedBox(
                                              //     height: data[index]
                                              //                 ['rejected'] ==
                                              //             false
                                              //         ? 0
                                              //         : 16.0),
                                              // data[index]['rejected'] == false
                                              //     ? SizedBox()
                                              //     : Text(data[index]
                                              //         ['rejectReason']),

                                              ///
                                              SizedBox(height: 16.0),
                                            ],
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              );
                      },
                    )
                  : StreamBuilder<QuerySnapshot>(
                      stream: FirebaseFirestore.instance
                          .collection('leaveRequest')
                          .where('search', arrayContains: search.text)
                          .orderBy('from', descending: true)
                          .snapshots(),
                      builder: (context, snapshot) {
                        if (!snapshot.hasData) {
                          return Center(
                            child: LottieBuilder.network(
                              'https://assets9.lottiefiles.com/packages/lf20_HpFqiS.json',
                              height: 500,
                            ),
                          );
                        }
                        if (snapshot.hasError) {
                          return Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                        var data = snapshot.data!.docs;
                        return data.length == 0
                            ? LottieBuilder.network(
                                'https://assets9.lottiefiles.com/packages/lf20_HpFqiS.json',
                                height: 500,
                              )
                            : Container(
                                width: double.infinity,
                                child: Wrap(
                                  spacing: 15,
                                  runSpacing: 15,
                                  children: List.generate(
                                    data.length,
                                    (index) {
                                      DateTime date =
                                          data[index]['createdDate'].toDate();

                                      return Container(
                                        decoration: BoxDecoration(
                                          border: Border.all(),
                                        ),
                                        width: 250,
                                        child: Center(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              SizedBox(height: 20.0),
                                              Text(
                                                data[index]['name'],
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 16.0,
                                                ),
                                              ),
                                              SizedBox(height: 8.0),
                                              Text(
                                                (DateTime.now()
                                                            .difference(date)
                                                            .inDays)
                                                        .toString() +
                                                    ' Days ago.',
                                                // DateFormat('dd/MMM/yyyy').format(
                                                //     data[index]['createdDate']
                                                //         .toDate()),
                                                // 'Requested Date',
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 15.0,
                                                ),
                                              ),
                                              SizedBox(height: 8.0),
                                              Row(
                                                children: [
                                                  Expanded(
                                                    child: Container(
                                                      color: Colors.lightBlue
                                                          .withOpacity(0.3),
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(10.0),
                                                        child: Column(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .center,
                                                          children: [
                                                            Text(
                                                              data[index]['duration']
                                                                      .toString() +
                                                                  '  Days',
                                                              style: TextStyle(
                                                                color: Color(
                                                                    0xff0054FF),
                                                              ),
                                                            ),
                                                            SizedBox(
                                                                height: 10.0),
                                                            Text(
                                                              'From ${DateFormat('dd/MM/yyyy').format(data[index]['from'].toDate())} To ${DateFormat('dd/MM/yyyy').format(data[index]['to'].toDate())}',
                                                              style: TextStyle(
                                                                color: Colors
                                                                    .black,
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              SizedBox(height: 16.0),
                                              Text(
                                                'Reason:',
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              SizedBox(height: 8.0),
                                              Text(data[index]['reason']),
                                              SizedBox(height: 16.0),
                                              Text('Status'),
                                              SizedBox(height: 16.0),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Container(
                                                    width: 80,
                                                    height: 25,
                                                    decoration: BoxDecoration(
                                                        color: data[index][
                                                                    'leadStatus'] ==
                                                                1
                                                            ? Colors.greenAccent
                                                            : data[index][
                                                                        'leadStatus'] ==
                                                                    2
                                                                ? Colors
                                                                    .redAccent
                                                                : Colors.grey,
                                                        borderRadius:
                                                            BorderRadius.only(
                                                          bottomRight:
                                                              Radius.circular(
                                                                  10),
                                                          topRight:
                                                              Radius.circular(
                                                                  10),
                                                        )),
                                                    // padding: EdgeInsets.only(
                                                    //   left: 10,
                                                    // ),
                                                    child: Center(
                                                      child: Text(
                                                        'Project Head',
                                                        style: TextStyle(
                                                          color: data[index][
                                                                      'leadStatus'] ==
                                                                  1
                                                              ? Colors.black
                                                              : Colors.white,
                                                          fontSize: 11,
                                                          fontFamily:
                                                              'Urbanist',
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    width: 8,
                                                  ),
                                                  Expanded(
                                                    child: Container(
                                                      width: 90,
                                                      height: 25,
                                                      decoration: BoxDecoration(
                                                          color: data[index][
                                                                      'pmStatus'] ==
                                                                  1
                                                              ? Colors
                                                                  .greenAccent
                                                              : data[index][
                                                                          'pmStatus'] ==
                                                                      2
                                                                  ? Colors
                                                                      .redAccent
                                                                  : Colors.grey,
                                                          borderRadius:
                                                              BorderRadius.only(
                                                            bottomRight:
                                                                Radius.circular(
                                                                    10),
                                                            topRight:
                                                                Radius.circular(
                                                                    10),
                                                          )),
                                                      // color: data[index]
                                                      //             ['pmStatus'] ==
                                                      //         1
                                                      //     ? Colors.greenAccent
                                                      //     : data[index][
                                                      //                 'pmStatus'] ==
                                                      //             2
                                                      //         ? Colors.redAccent
                                                      //         : Colors.grey,
                                                      padding: EdgeInsets.only(
                                                        left: 10,
                                                      ),
                                                      child: Center(
                                                        child: Text(
                                                          'Project Manager',
                                                          style: TextStyle(
                                                            color: data[index][
                                                                        'pmStatus'] ==
                                                                    1
                                                                ? Colors.black
                                                                : Colors.white,
                                                            fontSize: 11,
                                                            fontFamily:
                                                                'Urbanist',
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    width: 8,
                                                  ),
                                                  Container(
                                                    width: 40,
                                                    height: 25,
                                                    decoration: BoxDecoration(
                                                      color: data[index][
                                                                  'hrStatus'] ==
                                                              1
                                                          ? Colors.greenAccent
                                                          : data[index][
                                                                      'hrStatus'] ==
                                                                  2
                                                              ? Colors.redAccent
                                                              : Colors.grey,
                                                      // borderRadius:
                                                      //     BorderRadius.only(
                                                      //   bottomRight:
                                                      //       Radius.circular(10),
                                                      //   topRight:
                                                      //       Radius.circular(10),
                                                      // ),
                                                    ),
                                                    // color: data[index]
                                                    //             ['hrStatus'] ==
                                                    //         1
                                                    //     ? Colors.greenAccent
                                                    //     : data[index][
                                                    //                 'hrStatus'] ==
                                                    //             2
                                                    //         ? Colors.redAccent
                                                    //         : Colors.grey,
                                                    padding: EdgeInsets.only(
                                                      left: 10,
                                                    ),
                                                    child: Center(
                                                      child: Text(
                                                        'HR',
                                                        style: TextStyle(
                                                          color: data[index][
                                                                      'hrStatus'] ==
                                                                  1
                                                              ? Colors.black
                                                              : Colors.white,
                                                          fontSize: 13,
                                                          fontFamily:
                                                              'Urbanist',
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              SizedBox(height: 16.0),
                                              // Row(
                                              //   mainAxisAlignment:
                                              //       MainAxisAlignment.center,
                                              //   children: [
                                              //     ElevatedButton(
                                              //       onPressed: () {
                                              //         // TODO: Handle accept button press
                                              //       },
                                              //       style:
                                              //           ElevatedButton.styleFrom(
                                              //         primary: Colors.green,
                                              //       ),
                                              //       child: Text('Accept'),
                                              //     ),
                                              //     SizedBox(
                                              //       width: 16,
                                              //     ),
                                              //     ElevatedButton(
                                              //       onPressed: () {
                                              //         // TODO: Handle reject button press
                                              //       },
                                              //       style:
                                              //           ElevatedButton.styleFrom(
                                              //         primary: Colors.red,
                                              //       ),
                                              //       child: Text('Reject'),
                                              //     ),
                                              //   ],
                                              // ),
                                              ///Reject Reason
                                              // data[index]['rejected'] == false
                                              //     ? SizedBox()
                                              //     : Text('Reject Reason'),
                                              // SizedBox(
                                              //     height: data[index]
                                              //                 ['rejected'] ==
                                              //             false
                                              //         ? 0
                                              //         : 16.0),
                                              // data[index]['rejected'] == false
                                              //     ? SizedBox()
                                              //     : Text(data[index]
                                              //         ['rejectReason']),

                                              ///
                                              SizedBox(height: 16.0),
                                            ],
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              );
                      }),
            ],
          ),
        ),
      ),
    );
  }
}
