import 'dart:typed_data';

import 'package:csv/csv.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:month_picker_dialog_2/month_picker_dialog_2.dart';

import '../../../../backend/backend.dart';
import '../../../../flutter_flow/flutter_flow_icon_button.dart';
import '../../../../flutter_flow/flutter_flow_theme.dart';
import '../../../../flutter_flow/flutter_flow_util.dart';
import '../../../../flutter_flow/flutter_flow_widgets.dart';
import '../../../../flutter_flow/upload_media.dart';
import '../../../app_widget.dart';
import '../../../pages/home_page/home.dart';
import 'employeeAttendance.dart';

class HrAttendance extends StatefulWidget {
  final TabController _tabController;
  const HrAttendance({
    Key key,
    @required TabController tabController,
  })  : _tabController = tabController,
        super(key: key);

  @override
  State<HrAttendance> createState() => _HrAttendanceState();
}

class _HrAttendanceState extends State<HrAttendance> {
  List payments = [];

  getPaymentDetails(DateTime from, DateTime to) async {
    await FirebaseFirestore.instance
        .collection('projects')
        .where('branchId', isEqualTo: currentBranchId)
        .snapshots()
        .listen((event) {
      var student = event.docs;
      payments = [];
      for (var doc in student) {
        Map value = {};
        value = doc.data();
        value['amount'] = doc['amount'];
        value['paidDate'] = doc['datePaid'];
        value['modeOfPayment'] = doc['paymentMethod'];
        payments.add(value);
      }

      if (mounted) {
        setState(() {});
      }
    });
  }

  void pickFile() async {
    final result = await FilePicker.platform.pickFiles(
      allowMultiple: false,
      type: FileType.custom,
      allowedExtensions: ['csv'],
    );

    if (result == null) return;
    final file = result.files.first;

    Uint8List bytes = file.bytes;
    _openFile(file, bytes);
    showUploadMessage(context, 'file uploaded successfully');
  }

  Map employeeDetails = {};

  List<List<dynamic>> rowDetail;
  var filename = '';
  void _openFile(PlatformFile file, Uint8List bytes) {
    print(file.name);
    filename = file.name;

    rowDetail =
        const CsvToListConverter().convert(String.fromCharCodes(file.bytes));
    print(rowDetail);

    print('EXEL EXEL EXEL EXEL EXEL EXEL ');

    for (int i = 0; i < rowDetail.length; i++) {
      if (rowDetail[i][0] == 'Empcode') {
        double totalWork = 0;

        int cf = 0;

        String empCode = 'FL${rowDetail[i][1]}';

        int lateCount = 0;

        int lateCut = 0;

        int leave = 0;

        int halfDay = 0;

        double incentive = 0;
        double ot = 0;
        double deduction = 0;

        double payable = 0;

        double basicSalary = 0;
        if (empDataById[empCode] == null) {
          basicSalary = double.tryParse('0');
        } else {
          basicSalary = double.tryParse(empDataById[empCode].ctc ?? 0);
        }

        int j = 0;
        for (j = i + 2; j < i + 2 + 31; j++) {
          if (j == rowDetail.length) {
            break;
          }
          if (rowDetail[j][0] == 'Empcode' || rowDetail[j][0] == '') {
            i = j - 1;
            break;
          }

          List toDay = rowDetail[j][0].toString().split('/');
          print('[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[');
          print(toDay);
          // List toDayList = toDay;
          bool off = false;
          bool half = false;
          bool fullDayLeave = false;
          DateTime day = DateTime.tryParse(toDay[2] + toDay[1] + toDay[0]);

          print(
              '[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[day]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]');
          print(day.year);
          print(day.month);
          print(day.day);
          String inTime = rowDetail[j][2].toString();

          String outTime = rowDetail[j][3].toString();

          String totalWorkHour = rowDetail[j][4].toString();

          employeeDetails[empCode] = {};

          int hours = int.tryParse(rowDetail[j][4].toString().split(':')[0]);
          int minuit = int.tryParse(rowDetail[j][4].toString().split(':')[1]);

          double workHour = hours + minuit / 60.0;
          if (workHour >= 7.0) {
            totalWork = totalWork + 1.0;
          } else if (workHour >= 3.5 && workHour < 7) {
            totalWork += 0.5;
          }
          if (workHour >= 7.0 && workHour < 7.75) {
            lateCount += 1;
            if (lateCount == 3) {
              lateCut += 1;
              lateCount = 0;
            }
          }
          String cfData = rowDetail[j][7];

          if (cfData.contains('CF')) {
            cf++;
            off = true;
          } else if (workHour < 3.5) {
            leave++;
            fullDayLeave = true;
          } else if (workHour >= 3.5 && workHour < 7) {
            halfDay++;
            half = true;
          }

          /// SAVING EMPLOYEE DETAILS

          FirebaseFirestore.instance.collection('employeeAttendance').add({
            'branch': currentBranchId,
            'date': day,
            'empId': empCode,
            'inTime': inTime,
            'outTime': outTime,
            'totalWorkingHour': totalWorkHour,
            'leave': fullDayLeave,
            'halfDay': half,
            'offDay': off,
          }).then((value) {
            value.update({
              'id': value.id,
            });
          });
        }

        i = j - 1;

        //CALCULATE SALARY

        print(
            '[[[[[[[[[[[[[[[[[[[[[[[[[[[totalWork]]]]]]]]]]]]]]]]]]]]]]]]]]]');
        print(empCode);
        print(totalWork - (0.5 * lateCut));

        if ((leave + ((halfDay + lateCut) * 0.5)) > 5) {
          payable = (basicSalary / 30) * (totalWork - (0.5 * lateCut));
        } else {
          payable =
              (basicSalary / 30) * (30 - (leave + ((halfDay + lateCut) * 0.5)));
        }

        employeeDetails[empCode]['workDay'] = totalWork - (0.5 * lateCut);
        employeeDetails[empCode]['offDay'] = cf;
        employeeDetails[empCode]['lateCut'] = lateCut;
        employeeDetails[empCode]['halfDay'] = halfDay;
        employeeDetails[empCode]['leave'] = leave + ((halfDay + lateCut) * 0.5);
        employeeDetails[empCode]['payable'] = payable.round();
        employeeDetails[empCode]['incentive'] = incentive;
        employeeDetails[empCode]['ot'] = ot;
        employeeDetails[empCode]['deduction'] = deduction;
        employeeDetails[empCode]['takeHome'] =
            (payable - deduction + (incentive + ot)).round();

        // employeeDetailsList.add(employeeDetails);

      }
    }

    // uploadFileToFireBase(
    //     dateTimeFormat(
    //         'MMM y',
    //         DateTime(
    //           DateTime.now().year,
    //           DateTime.now().month - 1,
    //           DateTime.now().day,
    //         )),
    //     bytes,
    //     'csv');

    setState(() {});
  }

  DateTime fromDate = DateTime.now();

  int i = 0;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  getData(DateTime date) {
    print('[[[[[[[[[[[[[[[[[[[dateTimeFormat]]]]]]]]]]]]]]]]]]]');
    print(dateTimeFormat(
      'MMMM y',
      date,
    ));

    FirebaseFirestore.instance
        .collection('paySlipInfo')
        .doc(
          dateTimeFormat(
            'MMMM y',
            date,
          ),
        )
        .get()
        .then((value) {
      employeeDetails = value['salaryInfo'];

      setState(() {});
    }).onError((StateError error, stackTrace) {
      print('[[[[[[[[[[[[[[[[[[[error]]]]]]]]]]]]]]]]]]]');
      print(error.message);
      if (error.message ==
              'field does not exist within the DocumentSnapshotPlatform' ||
          error.message ==
              'cannot get a field on a DocumentSnapshotPlatform which does not exist') {
        showUploadMessage(context, 'Datas are not saved yet');
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
                              lastDate: DateTime(DateTime.now().year + 100,
                                  DateTime.now().month),
                              initialDate: fromDate,

                              confirmText: Text(
                                'Select',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              cancelText: Text('Cancel'),
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
                                          DateTime.now().month)
                                  ? Colors.grey
                                  : Colors.blue,
                            ),
                            onPressed: () async {
                              if (DateTime(fromDate.year, fromDate.month) !=
                                  DateTime(DateTime.now().year,
                                      DateTime.now().month)) {
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
                  InkWell(
                    onTap: () {
                      pickFile();
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
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 10),
                              child: Text(dateTimeFormat('yMMM', fromDate),
                                  style: TextStyle(color: Colors.blue)),
                            )
                          ]),
                    ),
                  ),

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
                    employeeList.isEmpty
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
                                      employeeList.length,
                                      (index) {
                                        final data =
                                            employeeList[index]['empId'];

                                        String name =
                                            empDataById[data].name ?? '';

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
                                                        workingDays ?? '0')) -
                                                (leaves == ''
                                                    ? 0
                                                    : double.tryParse(leaves)))
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
                                                                date: fromDate,
                                                                empId:
                                                                    data ?? '',
                                                                empName:
                                                                    name ?? '',
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
          ],
        ),
      ),
    );
  }
}
