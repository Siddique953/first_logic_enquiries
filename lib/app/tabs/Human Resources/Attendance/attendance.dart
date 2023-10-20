import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:month_picker_dialog/month_picker_dialog.dart';

import '../../../../flutter_flow/flutter_flow_icon_button.dart';
import '../../../../flutter_flow/flutter_flow_theme.dart';
import '../../../../flutter_flow/flutter_flow_util.dart';
import '../../../../flutter_flow/flutter_flow_widgets.dart';
import '../../../../flutter_flow/upload_media.dart';
import '../../../pages/home_page/home.dart';
import 'employeeAttendance.dart';

class HrAttendance extends StatefulWidget {
  final TabController _tabController;
  const HrAttendance({
    Key? key,
    required TabController tabController,
  })  : _tabController = tabController,
        super(key: key);

  @override
  State<HrAttendance> createState() => _HrAttendanceState();
}

class _HrAttendanceState extends State<HrAttendance> {
  Map employeeDetails = {};
  Map employeeAttendanceDetails = {};

  List localEmployeeList = [];

  DateTime fromDate = DateTime(
      DateTime.now().year, DateTime.now().month - 1, DateTime.now().day);

  int i = 0;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  getData(DateTime date) {
    print('[[[[[[[[[[[[[[[[[[[dateTimeFormat]]]]]]]]]]]]]]]]]]]');
    print(dateTimeFormat(
      'MMMM y',
      date,
    ));

    employeeDetails = {};
    employeeAttendanceDetails = {};

    FirebaseFirestore.instance
        .collection('paySlipInfo')
        .doc(
          dateTimeFormat('MMMM y', date)
        )
        .get()
        .then((value) {
      employeeDetails = value['salaryInfo'];
      employeeAttendanceDetails = value['attendanceInfo'];

      setState(() {});
    }).onError((StateError error, stackTrace) {
      print('[[[[[[[[[[[[[[[[[[[error]]]]]]]]]]]]]]]]]]]');
      print(error.message);
      if (error.message ==
              'field does not exist within the DocumentSnapshotPlatform' ||
          error.message ==
              'cannot get a field on a DocumentSnapshotPlatform which does not exist') {
        showUploadMessage(context, "Data's are not saved yet");
      }
    });
  }

  @override
  void initState() {
    super.initState();

    getData(DateTime(
      DateTime.now().year,
      DateTime.now().month - 1,
      DateTime.now().day,
    ));

    // getPaymentDetails(fromDate, toDate);

    localEmployeeList =
        employeeList.where((element) => element['delete'] == false).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(20, 0, 0, 0),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  IconButton(
                    onPressed: () {
                      widget._tabController.animateTo(5);
                    },
                    icon: Icon(Icons.arrow_back_ios_new),
                  ),
                  Expanded(
                    child: Text(
                      'Employee Attendance',
                      style: FlutterFlowTheme.bodyText1.override(
                          fontFamily: 'Poppins',
                          fontSize: 25,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                ],
              ),
            ),

            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(16, 20, 16, 0),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.05,
                        ),
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(
                              width: 1,
                              color: Colors.black,
                            ),
                          ),
                          child: FlutterFlowIconButton(
                            borderColor: Colors.transparent,
                            borderRadius: 30,
                            borderWidth: 1,
                            buttonSize: 50,
                            icon: const Icon(
                              Icons.arrow_back_ios_new_outlined,
                              color: Colors.blue,
                            ),
                            onPressed: () async {
                              setState(() {
                                fromDate = DateTime(fromDate.year,
                                    fromDate.month - 1, fromDate.day);
                              });
                              getData(fromDate);
                            },
                          ),
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.003,
                        ),
                        InkWell(
                          onTap: () {
                            showMonthPicker(
                              context: context,
                              firstDate: DateTime(DateTime.now().year - 100, 5),
                              lastDate: DateTime(DateTime.now().year,
                                  DateTime.now().month - 1),
                              initialDate: fromDate,

                              // confirmText: Text(
                              //   'Select',
                              //   style: TextStyle(fontWeight: FontWeight.bold),
                              // ),
                              // cancelText: Text('Cancel'),
// yearFirst: true,
                            ).then((date) {
                              if (date != null) {
                                setState(() {
                                  fromDate = date;
                                });
                                getData(fromDate);
                              }
                            });
                          },
                          child: Container(
                            width: MediaQuery.of(context).size.width * 0.1,
                            height: 50,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(
                                color: Colors.black,
                              ),
                            ),
                            child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(left: 10),
                                    child: Text(
                                        dateTimeFormat('yMMM', fromDate),
                                        style: TextStyle(color: Colors.blue)),
                                  )
                                ]),
                          ),
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.003,
                        ),
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(
                              width: 1,
                              color: Colors.black,
                            ),
                          ),
                          child: FlutterFlowIconButton(
                            borderColor: Colors.transparent,
                            borderRadius: 30,
                            borderWidth: 1,
                            buttonSize: 50,
                            icon: Icon(
                              Icons.arrow_forward_ios_outlined,
                              color: DateTime(fromDate.year, fromDate.month) ==
                                      DateTime(DateTime.now().year,
                                          DateTime.now().month - 1)
                                  ? Colors.grey
                                  : Colors.blue,
                            ),
                            onPressed: () async {
                              if (DateTime(fromDate.year, fromDate.month) !=
                                  DateTime(DateTime.now().year,
                                      DateTime.now().month - 1)) {
                                setState(() {
                                  fromDate = DateTime(fromDate.year,
                                      fromDate.month + 1, fromDate.day);
                                });
                                getData(fromDate);
                              }
                            },
                          ),
                        ),
                      ],
                    ),
                  ),

                  ///UPLOAD CSV
                  ///
                  // InkWell(
                  //   onTap: () {
                  //     pickFile();
                  //   },
                  //   child: Container(
                  //     width: MediaQuery.of(context).size.width * 0.1,
                  //     height: 50,
                  //     decoration: BoxDecoration(
                  //       color: Colors.white,
                  //       borderRadius: BorderRadius.circular(8),
                  //       border: Border.all(
                  //         color: Colors.black,
                  //       ),
                  //     ),
                  //     child: Column(
                  //         mainAxisAlignment: MainAxisAlignment.spaceAround,
                  //         crossAxisAlignment: CrossAxisAlignment.center,
                  //         children: [
                  //           Padding(
                  //             padding: const EdgeInsets.only(left: 10),
                  //             child: Text(dateTimeFormat('yMMM', fromDate),
                  //                 style: TextStyle(color: Colors.blue)),
                  //           )
                  //         ]),
                  //   ),
                  // ),

                  ///
                ],
              ),
            ),
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(20, 20, 0, 10),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Expanded(
                    child: Text(
                      'Attendance Details',
                      style: FlutterFlowTheme.bodyText1.override(
                          fontFamily: 'Poppins',
                          fontSize: 20,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                ],
              ),
            ),

            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    localEmployeeList.isEmpty
                        ? Center(
                            child: LottieBuilder.network(
                              'https://assets9.lottiefiles.com/packages/lf20_HpFqiS.json',
                              height: 500,
                            ),
                          )
                        : Row(
                            children: [
                              Expanded(
                                child: FittedBox(
                                  child: DataTable(
                                    horizontalMargin: 12,
                                    columns: [
                                      DataColumn(
                                        label: Text(
                                          "Sl No",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 12),
                                        ),
                                      ),
                                      DataColumn(
                                        label: Text("Emp ID",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 12)),
                                      ),
                                      DataColumn(
                                        label: Text("Emp Name",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 12)),
                                      ),
                                      DataColumn(
                                        label: Flexible(
                                          child: Text("Total Working Days",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 12)),
                                        ),
                                      ),
                                      DataColumn(
                                        label: Flexible(
                                          child: Text("Present",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 12)),
                                        ),
                                      ),
                                      DataColumn(
                                        label: Flexible(
                                          child: Text("Number Of Leave",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 12)),
                                        ),
                                      ),
                                      DataColumn(
                                        label: Flexible(
                                          child: Text("Half Days",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 12)),
                                        ),
                                      ),
                                      DataColumn(
                                        label: Flexible(
                                          child: Text("",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 12)),
                                        ),
                                      ),
                                    ],
                                    rows: List.generate(
                                      localEmployeeList.length,
                                      (index) {
                                        final data =
                                            localEmployeeList[index]['empId'];

                                        String name =
                                            empDataById[data]?.name ?? '';

                                        String leaves = employeeDetails[data] !=
                                                    null &&
                                                employeeDetails[data]
                                                        ['leave'] !=
                                                    null
                                            ? (employeeDetails[data]['leave'] ??
                                                    0)
                                                .toString()
                                            : '';

                                        String halfDays =
                                            employeeDetails[data] != null &&
                                                    employeeDetails[data]
                                                            ['halfDay'] !=
                                                        null
                                                ? (employeeDetails[data]
                                                            ['halfDay'] ??
                                                        0)
                                                    .toString()
                                                : '';

                                        String workingDays =
                                            employeeDetails[data] != null &&
                                                    employeeDetails[data]
                                                            ['offDay'] !=
                                                        null
                                                ? (30 -
                                                        (employeeDetails[data]
                                                                ['offDay'] ??
                                                            0))
                                                    .toString()
                                                : '';

                                        print(
                                            '[[[[[[[[[[[[[[[[[[[[[[[leaves + workingDays]]]]]]]]]]]]]]]]]]]]]]]');
                                        print(leaves);
                                        print(workingDays);

                                        String present = ((workingDays == ''
                                                    ? 0
                                                    : double.tryParse(
                                                        workingDays ?? '0'))! -
                                                (leaves == ''
                                                    ? 0
                                                    : double.tryParse(leaves)!))
                                            .toString();

                                        return DataRow(
                                          color: index.isOdd
                                              ? MaterialStateProperty.all(Colors
                                                  .blueGrey.shade50
                                                  .withOpacity(0.7))
                                              : MaterialStateProperty.all(
                                                  Colors.blueGrey.shade50),
                                          cells: [
                                            DataCell(
                                              Text((index + 1).toString(),
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 12)),
                                            ),
                                            DataCell(
                                              Text(data,
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 12)),
                                            ),
                                            DataCell(
                                              Text(name.toString() ?? '',
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 12)),
                                            ),
                                            DataCell(
                                              Text(workingDays ?? '',
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 12)),
                                            ),
                                            DataCell(
                                              Text(
                                                  employeeDetails[data] == null
                                                      ? ''
                                                      : '$present',
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 12)),
                                            ),
                                            DataCell(
                                              Text('$leaves',
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 12)),
                                            ),
                                            DataCell(
                                              Text(halfDays ?? '',
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 12)),
                                            ),
                                            DataCell(
                                              Row(
                                                children: [
                                                  FFButtonWidget(
                                                    onPressed: () {
                                                      if (employeeDetails
                                                              .entries
                                                              .isNotEmpty ||
                                                          employeeDetails[
                                                                  data] !=
                                                              null) {
                                                        Navigator.push(
                                                            context,
                                                            MaterialPageRoute(
                                                              builder: (context) =>
                                                                  EmployeeAttendance(
                                                                id: dateTimeFormat(
                                                                    'yMMM',
                                                                    fromDate),
                                                                date: fromDate,
                                                                empId:
                                                                    data ?? '',
                                                                empName:
                                                                    name ?? '',
                                                                empAttendanceDetails:
                                                                    employeeAttendanceDetails[
                                                                        data],
                                                                half: employeeDetails[
                                                                            data]
                                                                        [
                                                                        'halfDay'] ??
                                                                    0,
                                                                holidays: employeeDetails[
                                                                            data]
                                                                        [
                                                                        'offDay'] ??
                                                                    0,
                                                                late: employeeDetails[
                                                                            data]
                                                                        [
                                                                        'lateCut'] ??
                                                                    0,
                                                                leave: employeeDetails[
                                                                            data]
                                                                        [
                                                                        'leave'] ??
                                                                    0,
                                                                totalWork: employeeDetails[
                                                                            data]
                                                                        [
                                                                        'workDay'] ??
                                                                    0,
                                                              ),
                                                            ));
                                                      } else {
                                                        showUploadMessage(
                                                            context,
                                                            'Nothing to view');
                                                      }
                                                    },
                                                    text: 'View',
                                                    options: FFButtonOptions(
                                                      width: 80,
                                                      height: 30,
                                                      textStyle: FlutterFlowTheme
                                                          .subtitle2
                                                          .override(
                                                              fontFamily:
                                                                  'Poppins',
                                                              color:
                                                                  Colors.white,
                                                              fontSize: 12,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                      color: employeeDetails
                                                                  .entries
                                                                  .isEmpty ||
                                                              employeeDetails[
                                                                      data] ==
                                                                  null
                                                          ? Color(0xff0054FF)
                                                              .withOpacity(0.5)
                                                          : Color(0xff0054FF),
                                                      borderSide: BorderSide(
                                                        color:
                                                            Colors.transparent,
                                                        width: 1,
                                                      ),
                                                      borderRadius: 8,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        );
                                      },
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                  ],
                ),
              ),
            ),

            ///
            //
          ],
        ),
      ),
    );
  }
}
