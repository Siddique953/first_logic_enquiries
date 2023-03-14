import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:csv/csv.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:month_picker_dialog_2/month_picker_dialog_2.dart';
import '../../../../flutter_flow/flutter_flow_icon_button.dart';
import '../../../../flutter_flow/flutter_flow_theme.dart';
import '../../../../flutter_flow/flutter_flow_util.dart';
import '../../../../flutter_flow/flutter_flow_widgets.dart';
import '../../../../flutter_flow/upload_media.dart';
import '../../../app_widget.dart';
import '../../../pages/home_page/home.dart';
import 'package:excel/excel.dart';
import 'dart:typed_data';

import 'BankSlip/bankSlip.dart';

class AddAttendance extends StatefulWidget {
  const AddAttendance({
    Key key,
  }) : super(key: key);

  @override
  _AddAttendanceState createState() => _AddAttendanceState();
}

class _AddAttendanceState extends State<AddAttendance> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  String filename = '';

  /*Map<String, Map<String, dynamic>>*/
  var employeeDetails = {};
  var employeeAttendance = {};
  bool closed = false;

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

  List<List<dynamic>> rowDetail;

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
        employeeAttendance[empCode] = {};

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

          /// SAVING ATTENDANCE DETAILS
          List toDay = [];
          print(rowDetail[j][0].toString().contains('/'));
          rowDetail[j][0].toString().contains('/')
              ? toDay = rowDetail[j][0].toString().split('/')
              : toDay = rowDetail[j][0].toString().split('-');
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

          int hours = 0;
          int minuit = 0;

          try {
            hours = int.tryParse(rowDetail[j][4].toString().split(':')[0]);
            minuit = int.tryParse(rowDetail[j][4].toString().split(':')[1]);
          } catch (e) {
            hours = 0;
            minuit = 0;
          }

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
          employeeAttendance[empCode][DateFormat('dd-MM-yyyy').format(day)] = {
            'branch': currentBranchId,
            'date': day,
            'empId': empCode,
            'inTime': inTime,
            'outTime': outTime,
            'totalWorkingHour': totalWorkHour,
            'leave': fullDayLeave,
            'halfDay': half,
            'offDay': off,
          };

          // FirebaseFirestore.instance
          //     .collection('employeeAttendance')
          //     .where('date', isEqualTo: day)
          //     .where('empId', isEqualTo: empCode)
          //     .get()
          //     .then((value) {
          //   if (value.docs.isEmpty) {
          //     FirebaseFirestore.instance.collection('employeeAttendance').add({
          //       'branch': currentBranchId,
          //       'date': day,
          //       'empId': empCode,
          //       'inTime': inTime,
          //       'outTime': outTime,
          //       'totalWorkingHour': totalWorkHour,
          //       'leave': fullDayLeave,
          //       'halfDay': half,
          //       'offDay': off,
          //     }).then((value) {
          //       value.update({
          //         'id': value.id,
          //       });
          //     });
          //   }
          // });
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

    uploadFileToFireBase(
        dateTimeFormat(
            'MMM y',
            DateTime(
              DateTime.now().year,
              DateTime.now().month - 1,
              DateTime.now().day,
            )),
        bytes,
        'csv');

    print('[[[[[[[[[[[[[[[[[[[[[[[[employeeAttendance]]]]]]]]]]]]]]]]]]]]]]]]');
    print(employeeAttendance);

    setState(() {});
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
            ))}/attendanceFile--$name.$ext')
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
        .set({
      'attendanceFile': urlDownload,
    });
  }

  Future updateFileInFireBase(String name, fileBytes, String ext) async {
    // final path='file/${pickFile.name}';
    // final file=File(pickFile.path);

    // final ref=FirebaseStorage.instance.ref().child(path);
    // uploadTask = ref.putFile(file);
    var uploadTask = FirebaseStorage.instance
        .ref('Pay Slips/${dateTimeFormat('MMMM y', DateTime(
              DateTime.now().year,
              DateTime.now().month - 1,
              DateTime.now().day,
            ))}/salarySlip--$name.$ext')
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
      'salarySlip': urlDownload,
    });
  }

  @override
  void initState() {
    super.initState();
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
                      Navigator.pop(context);
                    },
                    icon: Icon(Icons.arrow_back_ios_new),
                  ),
                  Expanded(
                    child: Text(
                      'Generate Pay Roll',
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
              child: Material(
                color: Colors.transparent,
                elevation: 10,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        blurRadius: 5,
                        color: Color(0x44111417),
                        offset: Offset(0, 2),
                      ),
                    ],
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(4, 4, 4, 4),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(8, 4, 8, 4),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Container(
                                height: 60,
                                width: MediaQuery.of(context).size.width * 0.6,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    FlutterFlowIconButton(
                                      borderColor: Colors.transparent,
                                      borderRadius: 30,
                                      borderWidth: 1,
                                      buttonSize: 50,
                                      icon: Icon(
                                        Icons.calendar_month_outlined,
                                        color: Colors.black,
                                        size: 25,
                                      ),
                                      onPressed: () async {
                                        showMonthPicker(
                                          context: context,
                                          firstDate: DateTime(
                                              DateTime.now().year - 100, 5),
                                          lastDate: DateTime(
                                              DateTime.now().year + 100, 12),
                                          initialDate: DateTime.now(),

                                          confirmText: Text(
                                            'Choose',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: Colors.black),
                                          ),
                                          cancelText: Text('Cancel'),
                                          // yearFirst: true,
                                        ).then((date) {
                                          if (date != null) {
                                            print(
                                                dateTimeFormat('MMMM y', date));

                                            try {
                                              FirebaseFirestore.instance
                                                  .collection('paySlipInfo')
                                                  .doc(dateTimeFormat(
                                                      'MMMM y', date))
                                                  .get()
                                                  .then((value) {
                                                employeeDetails =
                                                    value['salaryInfo'];
                                                employeeAttendance =
                                                    value['attendanceInfo'];
                                                closed = value['closed'];
                                                showUploadMessage(context,
                                                    'Details Successfully Updated...');
                                                setState(() {});
                                              }).onError((error, stackTrace) {
                                                print(error);
                                                showUploadMessage(context,
                                                    'No Data Found...');
                                              });
                                            } catch (err) {
                                              print(err);
                                              showUploadMessage(
                                                  context, 'No Data Found...');
                                            }
                                          }
                                        });
                                      },
                                    ),
                                    SizedBox(
                                      width: 20,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: InkWell(
                                        onTap: () {
                                          pickFile();
                                        },
                                        child: Container(
                                          decoration: BoxDecoration(
                                            color: Colors.grey[200],
                                            borderRadius:
                                                BorderRadius.circular(8),
                                            border: Border.all(
                                              color: Colors.grey,
                                            ),
                                          ),
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.25,
                                          height: 50,
                                          child: Center(
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Icon(Icons.file_present_sharp),
                                                filename == ''
                                                    ? Text('Pick file')
                                                    : Text(filename),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 20,
                                    ),
                                    employeeDetails.keys.toList().isNotEmpty
                                        ? closed
                                            ? SizedBox()
                                            : FlutterFlowIconButton(
                                                borderColor: Colors.transparent,
                                                borderRadius: 30,
                                                borderWidth: 1,
                                                buttonSize: 50,
                                                icon: Icon(
                                                  Icons.cloud_upload_sharp,
                                                  color: Colors.teal,
                                                  size: 25,
                                                ),
                                                onPressed: () async {
                                                  bool pressed = await alert(
                                                      context,
                                                      'Do you want Upload');

                                                  if (pressed) {
                                                    FirebaseFirestore.instance
                                                        .collection(
                                                            'paySlipInfo')
                                                        .doc(dateTimeFormat(
                                                            'MMMM y',
                                                            DateTime(
                                                              DateTime.now()
                                                                  .year,
                                                              DateTime.now()
                                                                      .month -
                                                                  1,
                                                              DateTime.now()
                                                                  .day,
                                                            )))
                                                        .set({
                                                      'salaryInfo':
                                                          employeeDetails,
                                                      'attendanceInfo':
                                                          employeeAttendance,
                                                      'closed': false,
                                                    });

                                                    showUploadMessage(context,
                                                        'Details Uploaded Success...');
                                                    setState(() {});
                                                  }
                                                },
                                              )
                                        : SizedBox(),
                                    SizedBox(
                                      width: 20,
                                    ),
                                    // employeeDetails.keys.toList().isNotEmpty
                                    //     ? closed
                                    //         ? SizedBox()
                                    //         : FlutterFlowIconButton(
                                    //             borderColor: Colors.transparent,
                                    //             borderRadius: 30,
                                    //             borderWidth: 1,
                                    //             buttonSize: 50,
                                    //             icon: Icon(
                                    //               Icons.upload,
                                    //               color: Colors.teal,
                                    //               size: 25,
                                    //             ),
                                    //             onPressed: () async {
                                    //               bool pressed = await alert(
                                    //                   context,
                                    //                   'Do you want Upload');
                                    //
                                    //               if (pressed) {
                                    //                 DateTime monthDay =
                                    //                     DateTime(
                                    //                         DateTime.now().year,
                                    //                         DateTime.now()
                                    //                             .month,
                                    //                         0);
                                    //                 int lastDay = monthDay.day;
                                    //                 for (int i = 0;
                                    //                     i < employeeList.length;
                                    //                     i++) {
                                    //                   if (employeeDetails[
                                    //                               employeeList[
                                    //                                       i]
                                    //                                   ['empId']]
                                    //                           ['takeHome'] ==
                                    //                       0) {
                                    //                     continue;
                                    //                   }
                                    //
                                    //                   FirebaseFirestore.instance
                                    //                       .collection(
                                    //                           'employees')
                                    //                       .doc(employeeList[i]
                                    //                           ['empId'])
                                    //                       .collection(
                                    //                           'attendance')
                                    //                       .doc(dateTimeFormat(
                                    //                           'MMM y',
                                    //                           DateTime(
                                    //                             DateTime.now()
                                    //                                 .year,
                                    //                             DateTime.now()
                                    //                                     .month -
                                    //                                 1,
                                    //                             DateTime.now()
                                    //                                 .day,
                                    //                           )))
                                    //                       .set({
                                    //                     'attendance':
                                    //                         employeeAttendance[
                                    //                             employeeList[i]
                                    //                                 ['empId']],
                                    //                     'month': dateTimeFormat(
                                    //                         'MMM y',
                                    //                         DateTime(
                                    //                           DateTime.now()
                                    //                               .year,
                                    //                           DateTime.now()
                                    //                                   .month -
                                    //                               1,
                                    //                           DateTime.now()
                                    //                               .day,
                                    //                         )),
                                    //                   });
                                    //
                                    //                   FirebaseFirestore.instance
                                    //                       .collection(
                                    //                           'employees')
                                    //                       .doc(employeeList[i]
                                    //                           ['empId'])
                                    //                       .collection(
                                    //                           'salaryInfo')
                                    //                       .doc(dateTimeFormat(
                                    //                           'MMM y',
                                    //                           DateTime(
                                    //                             DateTime.now()
                                    //                                 .year,
                                    //                             DateTime.now()
                                    //                                     .month -
                                    //                                 1,
                                    //                             DateTime.now()
                                    //                                 .day,
                                    //                           )))
                                    //                       .set({
                                    //                     'totalWorkingDays': (lastDay -
                                    //                         (employeeDetails[employeeList[
                                    //                                         i][
                                    //                                     'empId']]
                                    //                                 [
                                    //                                 'offDay'] ??
                                    //                             4)),
                                    //                     'totalLeave':
                                    //                         employeeDetails[
                                    //                                 employeeList[
                                    //                                         i][
                                    //                                     'empId']]
                                    //                             ['leave'],
                                    //                     'basicSalary':
                                    //                         empDataById[
                                    //                                 employeeList[
                                    //                                         i][
                                    //                                     'empId']]
                                    //                             .ctc,
                                    //                     'payableSalary':
                                    //                         employeeDetails[
                                    //                                 employeeList[
                                    //                                         i][
                                    //                                     'empId']]
                                    //                             ['payable'],
                                    //                     'incentive':
                                    //                         employeeDetails[
                                    //                                 employeeList[
                                    //                                         i][
                                    //                                     'empId']]
                                    //                             ['incentive'],
                                    //                     'overTime':
                                    //                         employeeDetails[
                                    //                                 employeeList[
                                    //                                         i]
                                    //                                     [
                                    //                                     'empId']]
                                    //                             ['ot'],
                                    //                     'deduction':
                                    //                         employeeDetails[
                                    //                                 employeeList[
                                    //                                         i][
                                    //                                     'empId']]
                                    //                             ['deduction'],
                                    //                     'takeHome':
                                    //                         employeeDetails[
                                    //                                 employeeList[
                                    //                                         i]
                                    //                                     [
                                    //                                     'empId']]
                                    //                             ['takeHome'],
                                    //                     'month': dateTimeFormat(
                                    //                         'MMM y',
                                    //                         DateTime(
                                    //                           DateTime.now()
                                    //                               .year,
                                    //                           DateTime.now()
                                    //                                   .month -
                                    //                               1,
                                    //                           DateTime.now()
                                    //                               .day,
                                    //                         )),
                                    //                   });
                                    //                 }
                                    //               }
                                    //             },
                                    //           )
                                    //     : SizedBox(),
                                  ],
                                ),
                              ),
                              employeeDetails.keys.toList().isNotEmpty
                                  ? closed
                                      ? SizedBox()
                                      : Row(
                                          children: [
                                            FFButtonWidget(
                                              onPressed: () {
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) =>
                                                          BankSlipPage(
                                                        paySlip:
                                                            employeeDetails,
                                                      ),
                                                    ));
                                              },
                                              text: 'Bank Slip',
                                              options: FFButtonOptions(
                                                width: 150,
                                                height: 49,
                                                color: Color(0xFF0F1113),
                                                textStyle: FlutterFlowTheme
                                                    .subtitle2
                                                    .override(
                                                  fontFamily: 'Poppins',
                                                  color: Color(0xFFF1F4F8),
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.normal,
                                                ),
                                                borderSide: BorderSide(
                                                  color: Colors.transparent,
                                                  width: 1,
                                                ),
                                                borderRadius: 12,
                                              ),
                                            ),
                                            SizedBox(
                                              width: 20,
                                            ),
                                            FFButtonWidget(
                                              onPressed: () {
                                                FirebaseFirestore.instance
                                                    .collection('paySlipInfo')
                                                    .doc(dateTimeFormat(
                                                        'MMMM y',
                                                        DateTime(
                                                          DateTime.now().year,
                                                          DateTime.now().month -
                                                              1,
                                                          DateTime.now().day,
                                                        )))
                                                    .set({
                                                  'salaryInfo': employeeDetails,
                                                  'attendanceInfo':
                                                      employeeAttendance,
                                                  'closed': false,
                                                }).then((value) {
                                                  try {
                                                    importData();
                                                  } catch (e) {
                                                    print(e);

                                                    return showDialog(
                                                        context: context,
                                                        builder: (context) {
                                                          return AlertDialog(
                                                            title:
                                                                Text('error'),
                                                            content: Text(
                                                                e.toString()),
                                                            actions: <Widget>[
                                                              ElevatedButton(
                                                                child: new Text(
                                                                    'ok'),
                                                                onPressed: () {
                                                                  Navigator.of(
                                                                          context)
                                                                      .pop();
                                                                },
                                                              )
                                                            ],
                                                          );
                                                        });
                                                  }
                                                });
                                              },
                                              text: 'Generate Excel',
                                              options: FFButtonOptions(
                                                width: 150,
                                                height: 49,
                                                color: Color(0xFF0F1113),
                                                textStyle: FlutterFlowTheme
                                                    .subtitle2
                                                    .override(
                                                  fontFamily: 'Poppins',
                                                  color: Color(0xFFF1F4F8),
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.normal,
                                                ),
                                                borderSide: BorderSide(
                                                  color: Colors.transparent,
                                                  width: 1,
                                                ),
                                                borderRadius: 12,
                                              ),
                                            ),
                                            SizedBox(
                                              width: 20,
                                            ),
                                            FFButtonWidget(
                                              onPressed: () async {
                                                bool pressed = await alert(
                                                    context,
                                                    'Confirm to send Pay Slip');

                                                if (pressed) {
                                                  FirebaseFirestore.instance
                                                      .collection('paySlipInfo')
                                                      .doc(dateTimeFormat(
                                                          'MMMM y',
                                                          DateTime(
                                                            DateTime.now().year,
                                                            DateTime.now()
                                                                    .month -
                                                                1,
                                                            DateTime.now().day,
                                                          )))
                                                      .set({
                                                    'salaryInfo':
                                                        employeeDetails,
                                                    'attendanceInfo':
                                                        employeeAttendance,
                                                    'closed': true,
                                                  }).then((value) {
                                                    sendMail();
                                                  });
                                                }
                                              },
                                              text: 'Send Email',
                                              options: FFButtonOptions(
                                                width: 150,
                                                height: 49,
                                                color: Color(0xFF0F1113),
                                                textStyle: FlutterFlowTheme
                                                    .subtitle2
                                                    .override(
                                                  fontFamily: 'Poppins',
                                                  color: Color(0xFFF1F4F8),
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.normal,
                                                ),
                                                borderSide: BorderSide(
                                                  color: Colors.transparent,
                                                  width: 1,
                                                ),
                                                borderRadius: 12,
                                              ),
                                            ),
                                          ],
                                        )
                                  : SizedBox(),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(20, 20, 0, 10),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Expanded(
                    child: Text(
                      'Salary Details',
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
                            child: Text(
                              'No File Uploaded',
                              style: FlutterFlowTheme.bodyText2.override(
                                  fontFamily: 'Montserrat',
                                  color: Color(0xFF8B97A2),
                                  fontWeight: FontWeight.bold,
                                  fontSize: 13),
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
                                          child: Text("Number Of Leave",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 12)),
                                        ),
                                      ),
                                      DataColumn(
                                        label: Flexible(
                                          child: Text("Basic Salary",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 12)),
                                        ),
                                      ),
                                      DataColumn(
                                        label: Flexible(
                                          child: Text("Payable Salary",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 12)),
                                        ),
                                      ),
                                      DataColumn(
                                        label: Flexible(
                                          child: Text("Incentive",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 12)),
                                        ),
                                      ),
                                      DataColumn(
                                        label: Flexible(
                                          child: Text("Over Time",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 12)),
                                        ),
                                      ),
                                      DataColumn(
                                        label: Flexible(
                                          child: Text("Advance",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 12)),
                                        ),
                                      ),
                                      DataColumn(
                                        label: Flexible(
                                          child: Text("Take Home",
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

                                        if (employeeDetails.keys
                                            .toList()
                                            .isNotEmpty) {
                                          if (employeeDetails[data] == null) {
                                            employeeDetails[data] = {
                                              "workDay": 0,
                                              "offDay": 0,
                                              "lateCut": 0,
                                              "halfDay": 0,
                                              "leave": 0,
                                              "payable": 0,
                                              "incentive": 0,
                                              "ot": 0,
                                              "deduction": 0,
                                              "takeHome": 0,
                                            };
                                          }
                                        }

                                        TextEditingController workingDays =
                                            TextEditingController(
                                                text: employeeDetails[data] !=
                                                            null &&
                                                        employeeDetails[data]
                                                                ['offDay'] !=
                                                            null
                                                    ? (30 -
                                                            (employeeDetails[
                                                                        data][
                                                                    'offDay'] ??
                                                                0))
                                                        .toString()
                                                    : '');

                                        TextEditingController incentive =
                                            TextEditingController(
                                                text: employeeDetails[data] !=
                                                        null
                                                    ? employeeDetails[data]
                                                            ['incentive']
                                                        .toString()
                                                    : '');

                                        TextEditingController deduction =
                                            TextEditingController(
                                                text: employeeDetails[data] !=
                                                        null
                                                    ? employeeDetails[data]
                                                            ['deduction']
                                                        .toString()
                                                    : '');

                                        TextEditingController ot =
                                            TextEditingController(
                                                text: employeeDetails[data] !=
                                                        null
                                                    ? employeeDetails[data]
                                                            ['ot']
                                                        .toString()
                                                    : '');

                                        TextEditingController payable =
                                            TextEditingController(
                                                text: employeeDetails[data] !=
                                                        null
                                                    ? employeeDetails[data]
                                                            ['payable']
                                                        .toString()
                                                    : '');

                                        String name =
                                            empDataById[data].name ?? '';

                                        // String totalDays =
                                        //     employeeDetails[data] != null &&
                                        //             employeeDetails[data]
                                        //                     ['offDay'] !=
                                        //                 null
                                        //         ? (30 -
                                        //                 (employeeDetails[data]
                                        //                         ['offDay'] ??
                                        //                     0))
                                        //             .toString()
                                        //         : '';

                                        String leaves = employeeDetails[data] !=
                                                    null &&
                                                employeeDetails[data]
                                                        ['leave'] !=
                                                    null
                                            ? (employeeDetails[data]['leave'] ??
                                                    0)
                                                .toString()
                                            : '';

                                        double basicSalary = double.tryParse(
                                            empDataById[data].ctc.toString());

                                        // int halfDays = employeeDetails[data]['halfDay'];
                                        //
                                        // int lateCut = employeeDetails[data]['lateCut'];
                                        //
                                        // double presentDays =
                                        //     employeeDetails[data]['workDay'];

                                        // String payable = employeeDetails[data] !=
                                        //             null &&
                                        //         employeeDetails[data]['payable'] !=
                                        //             null
                                        //     ? (employeeDetails[data]['payable'] ?? 0)
                                        //         .toStringAsFixed(2)
                                        //     : '';

                                        String takeHome =
                                            employeeDetails[data] != null &&
                                                    employeeDetails[data]
                                                            ['takeHome'] !=
                                                        null
                                                ? (employeeDetails[data]
                                                            ['takeHome'] ??
                                                        0)
                                                    .toString()
                                                : '';

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

                                            //EDIT TOTAL WORKING DAYS TO CHANGE ALL 30

                                            DataCell(
                                              TextFormField(
                                                readOnly: closed,
                                                controller: workingDays,
                                                obscureText: false,

                                                //ADD VALUE TO TAKE VALUE

                                                // onTap: () {
                                                //   if (payable.text == '0') {
                                                //     payable.text = '';
                                                //   }
                                                // },

                                                onFieldSubmitted: (s) {
                                                  print(
                                                      "[[[[[[[[[[[[[[[[[[[workingDays.text]]]]]]]]]]]]]]]]]]]");
                                                  print(workingDays.text);
                                                  try {
                                                    for (var id
                                                        in employeeDetails.keys
                                                            .toList()) {
                                                      if (30 -
                                                              (employeeDetails[
                                                                          id][
                                                                      'offDay'] ??
                                                                  0) ==
                                                          30) {
                                                        employeeDetails[id]
                                                                ['offDay'] =
                                                            (30 -
                                                                int.tryParse(
                                                                    workingDays
                                                                        .text));
                                                      }
                                                    }

                                                    setState(() {});
                                                  } catch (err) {
                                                    print(err);
                                                    showUploadMessage(context,
                                                        'Unexpected error occurred!!!');
                                                  }
                                                },

                                                decoration: InputDecoration(
                                                  border: InputBorder.none,
                                                ),
                                                style: FlutterFlowTheme
                                                    .bodyText2
                                                    .override(
                                                  fontFamily: 'Montserrat',
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                            ),

                                            DataCell(
                                              Text('$leaves',
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 12)),
                                            ),

                                            DataCell(
                                              Text(basicSalary.toString(),
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 12)),
                                            ),

                                            //TEXT FORM FIELD TO INSERT Payable

                                            DataCell(
                                              TextFormField(
                                                readOnly: closed,
                                                controller: payable,
                                                obscureText: false,

                                                //ADD VALUE TO TAKE VALUE

                                                onTap: () {
                                                  if (payable.text == '0') {
                                                    payable.text = '';
                                                  }
                                                },

                                                onFieldSubmitted: (s) {
                                                  try {
                                                    print('0');

                                                    if (payable.text != '') {
                                                      print('1');
                                                      double salary =
                                                          double.tryParse(
                                                              payable.text);

                                                      print('1.1');
                                                      double incentiv =
                                                          double.tryParse(
                                                              incentive.text ==
                                                                      ''
                                                                  ? '0'
                                                                  : incentive
                                                                      .text);

                                                      double otAmt =
                                                          double.tryParse(
                                                              ot.text == ''
                                                                  ? '0'
                                                                  : ot.text);

                                                      double ded =
                                                          double.tryParse(
                                                              deduction.text ==
                                                                      ''
                                                                  ? '0'
                                                                  : deduction
                                                                      .text);

                                                      print('2');

                                                      employeeDetails[data]
                                                              ['takeHome'] =
                                                          salary +
                                                              (incentiv +
                                                                  otAmt) -
                                                              ded;

                                                      print('3');

                                                      employeeDetails[data]
                                                          ['payable'] = salary;

                                                      print('4');

                                                      setState(() {});
                                                    } else {
                                                      double salary =
                                                          double.tryParse(
                                                              payable.text);

                                                      print('1.1');
                                                      double incentiv =
                                                          double.tryParse(
                                                              incentive.text ==
                                                                      ''
                                                                  ? '0'
                                                                  : payable
                                                                      .text);

                                                      double otAmt =
                                                          double.tryParse(
                                                              ot.text == ''
                                                                  ? '0'
                                                                  : payable
                                                                      .text);

                                                      double ded =
                                                          double.tryParse(
                                                              deduction.text ==
                                                                      ''
                                                                  ? '0'
                                                                  : payable
                                                                      .text);

                                                      print('2');

                                                      employeeDetails[data]
                                                              ['takeHome'] =
                                                          salary +
                                                              (incentiv +
                                                                  otAmt) -
                                                              ded;

                                                      employeeDetails[data]
                                                          ['payable'] = salary;

                                                      setState(() {});
                                                    }
                                                  } catch (err) {
                                                    print(err);
                                                    showUploadMessage(context,
                                                        'Provide Only Digit');
                                                  }
                                                },

                                                decoration: InputDecoration(
                                                  border: InputBorder.none,
                                                ),
                                                style: FlutterFlowTheme
                                                    .bodyText2
                                                    .override(
                                                  fontFamily: 'Montserrat',
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                            ),

                                            //TEXT FORM FIELD TO INSERT INCENTIVE

                                            DataCell(
                                              TextFormField(
                                                readOnly: closed,
                                                controller: incentive,
                                                obscureText: false,

                                                //ADD VALUE TO TAKE VALUE

                                                onTap: () {
                                                  if (incentive.text == '0') {
                                                    incentive.text = '';
                                                  }
                                                },

                                                onFieldSubmitted: (s) {
                                                  try {
                                                    print('0');
                                                    // if (employeeDetails[data]==null||employeeDetails[data]['ot'] ==
                                                    //     null) {
                                                    //   employeeDetails[data] = {'ot':0};
                                                    // } else if (employeeDetails[data]==null||employeeDetails[data]
                                                    //         ['deduction'] ==
                                                    //     null) {
                                                    //   employeeDetails[data] = {'deduction':0};
                                                    // } else if (employeeDetails[data]==null||employeeDetails[data]
                                                    //         ['incentive'] ==
                                                    //     null) {
                                                    //   employeeDetails[data] = {'incentive':0};
                                                    // }

                                                    if (incentive.text != '') {
                                                      print('1');
                                                      int incentives =
                                                          double.tryParse(
                                                                  incentive
                                                                      .text)
                                                              .round();

                                                      print('1.1');
                                                      int pay =
                                                          employeeDetails[data]
                                                                  ['payable']
                                                              .round();

                                                      print('2');

                                                      employeeDetails[data]
                                                          ['takeHome'] = pay +
                                                              (incentives +
                                                                      employeeDetails[
                                                                              data]
                                                                          [
                                                                          'ot'] ??
                                                                  0) -
                                                              employeeDetails[
                                                                      data][
                                                                  'deduction'] ??
                                                          0;

                                                      print('3');

                                                      employeeDetails[data]
                                                              ['incentive'] =
                                                          incentives;
                                                      print('4');

                                                      setState(() {});
                                                    } else {
                                                      double incentives =
                                                          double.tryParse('0');
                                                      double pay =
                                                          employeeDetails[data]
                                                                  ['payable']
                                                              .round();

                                                      employeeDetails[data]
                                                          ['takeHome'] = pay +
                                                              (incentives +
                                                                      employeeDetails[
                                                                              data]
                                                                          [
                                                                          'ot'] ??
                                                                  0) -
                                                              employeeDetails[
                                                                      data][
                                                                  'deduction'] ??
                                                          0;

                                                      employeeDetails[data]
                                                              ['incentive'] =
                                                          incentives;

                                                      setState(() {});
                                                    }
                                                  } catch (err) {
                                                    print(err);
                                                    showUploadMessage(context,
                                                        'Provide Only Digit');
                                                  }
                                                },

                                                decoration: InputDecoration(
                                                  border: InputBorder.none,
                                                ),
                                                style: FlutterFlowTheme
                                                    .bodyText2
                                                    .override(
                                                  fontFamily: 'Montserrat',
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                            ),

                                            //TEXT FORM FIELD TO INSERT OT

                                            DataCell(
                                              TextFormField(
                                                readOnly: closed,
                                                controller: ot,
                                                obscureText: false,

                                                //ADD VALUE TO TAKE VALUE

                                                onTap: () {
                                                  if (ot.text == '0') {
                                                    ot.text = '';
                                                  }
                                                },

                                                onFieldSubmitted: (s) {
                                                  try {
                                                    if (ot.text != '') {
                                                      double otAmount =
                                                          double.tryParse(
                                                              ot.text);

                                                      double pay =
                                                          employeeDetails[data]
                                                                  ['payable']
                                                              .round();

                                                      employeeDetails[data]
                                                          ['takeHome'] = pay +
                                                              (otAmount +
                                                                      employeeDetails[
                                                                              data]
                                                                          [
                                                                          'incentive'] ??
                                                                  0) -
                                                              employeeDetails[
                                                                      data][
                                                                  'deduction'] ??
                                                          0;

                                                      employeeDetails[data]
                                                          ['ot'] = otAmount;

                                                      setState(() {});
                                                    } else {
                                                      double otAmount =
                                                          double.tryParse('0');

                                                      double pay =
                                                          employeeDetails[data]
                                                                  ['payable']
                                                              .round();

                                                      employeeDetails[data]
                                                          ['takeHome'] = pay +
                                                              (otAmount +
                                                                      employeeDetails[
                                                                              data]
                                                                          [
                                                                          'incentive'] ??
                                                                  0) -
                                                              employeeDetails[
                                                                      data][
                                                                  'deduction'] ??
                                                          0;

                                                      employeeDetails[data]
                                                          ['ot'] = otAmount;

                                                      setState(() {});
                                                    }
                                                  } catch (err) {
                                                    print(err);
                                                    showUploadMessage(context,
                                                        'Provide Only Digit');
                                                  }
                                                },

                                                decoration: InputDecoration(
                                                  border: InputBorder.none,
                                                ),

                                                style: FlutterFlowTheme
                                                    .bodyText2
                                                    .override(
                                                  fontFamily: 'Montserrat',
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                            ),

                                            //TEXT FORM FIELD TO INSERT DEDUCTION

                                            DataCell(
                                              TextFormField(
                                                readOnly: closed,
                                                controller: deduction,
                                                obscureText: false,

                                                //ADD VALUE TO TAKE VALUE

                                                onTap: () {
                                                  if (deduction.text == '0') {
                                                    deduction.text = '';
                                                  }
                                                },

                                                onFieldSubmitted: (s) {
                                                  try {
                                                    // if (employeeDetails[data]['ot'] ==
                                                    //     null) {
                                                    //   employeeDetails[data]['ot'] = 0;
                                                    // } else if (employeeDetails[data]
                                                    //         ['deduction'] ==
                                                    //     null) {
                                                    //   employeeDetails[data]
                                                    //       ['deduction'] = 0;
                                                    // } else if (employeeDetails[data]
                                                    //         ['incentive'] ==
                                                    //     null) {
                                                    //   employeeDetails[data]
                                                    //       ['incentive'] = 0;
                                                    // }

                                                    if (deduction.text != '') {
                                                      double deductionAmount =
                                                          double.tryParse(
                                                              deduction.text);
                                                      double pay =
                                                          employeeDetails[data]
                                                                  ['payable']
                                                              .round();

                                                      employeeDetails[data]
                                                          ['takeHome'] = (pay +
                                                              (employeeDetails[
                                                                          data]
                                                                      ['ot'] ??
                                                                  0) +
                                                              (employeeDetails[
                                                                          data][
                                                                      'incentive'] ??
                                                                  0)) -
                                                          deductionAmount;

                                                      employeeDetails[data]
                                                              ['deduction'] =
                                                          deductionAmount;

                                                      setState(() {});
                                                    } else {
                                                      double deductionAmount =
                                                          double.tryParse('0');

                                                      double pay =
                                                          employeeDetails[data]
                                                                  ['payable']
                                                              .round();

                                                      employeeDetails[data]
                                                          ['takeHome'] = ((pay +
                                                                      employeeDetails[
                                                                              data]
                                                                          [
                                                                          'ot'] ??
                                                                  0) +
                                                              (employeeDetails[
                                                                          data][
                                                                      'incentive'] ??
                                                                  0)) -
                                                          deductionAmount;

                                                      employeeDetails[data]
                                                              ['deduction'] =
                                                          deductionAmount;

                                                      setState(() {});
                                                    }
                                                  } catch (err) {
                                                    print(err);
                                                    showUploadMessage(context,
                                                        'Provide Only Digit');
                                                  }
                                                },

                                                decoration: InputDecoration(
                                                  border: InputBorder.none,
                                                ),

                                                style: FlutterFlowTheme
                                                    .bodyText2
                                                    .override(
                                                  fontFamily: 'Montserrat',
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                            ),

                                            DataCell(
                                              Text(
                                                takeHome,
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 12,
                                                ),
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
            )
          ],
        ),
      ),
    );
  }

  Future<void> importData() async {
    print('1');
    var excel = Excel.createExcel();

    Sheet sheetObject = excel['Pay Slip'];
    CellStyle cellStyle = CellStyle(
        // backgroundColorHex: "#1AFF1A",
        fontFamily: getFontFamily(FontFamily.Calibri));

    print('2');

    //HEADINGS

    if (employeeDetails.keys.toList().length > 0) {
      var cell1 = sheetObject.cell(CellIndex.indexByString("A1"));
      cell1.value = 'SL NO';
      cell1.cellStyle = cellStyle;
      var cell2 = sheetObject.cell(CellIndex.indexByString("B1"));
      cell2.value = 'EMPLOYEE ID'; // dynamic values support provided;
      cell2.cellStyle = cellStyle;
      var cell3 = sheetObject.cell(CellIndex.indexByString("C1"));
      cell3.value = 'NAME'; // dynamic values support provided;
      cell3.cellStyle = cellStyle;
      var cell4 = sheetObject.cell(CellIndex.indexByString("D1"));
      cell4.value = 'TOTAL WORKING DAYS'; // dynamic values support provided;
      cell4.cellStyle = cellStyle;
      var cell5 = sheetObject.cell(CellIndex.indexByString("E1"));
      cell5.value = 'TOTAL LEAVE'; // dynamic values support provided;
      cell5.cellStyle = cellStyle;
      var cell6 = sheetObject.cell(CellIndex.indexByString("F1"));
      cell6.value = 'BASIC SALARY'; // dynamic values support provided;
      cell6.cellStyle = cellStyle;
      var cell7 = sheetObject.cell(CellIndex.indexByString("G1"));
      cell7.value = 'PAYABLE SALARY'; // dynamic values support provided;
      cell7.cellStyle = cellStyle;
      var cell8 = sheetObject.cell(CellIndex.indexByString("H1"));
      cell8.value = 'INCENTIVE'; // dynamic values support provided;
      cell8.cellStyle = cellStyle;
      var cell9 = sheetObject.cell(CellIndex.indexByString("I1"));
      cell9.value = 'OVER TIME'; // dynamic values support provided;
      cell9.cellStyle = cellStyle;
      var cell10 = sheetObject.cell(CellIndex.indexByString("J1"));
      cell10.value = 'ADVANCE'; // dynamic values support provided;
      cell10.cellStyle = cellStyle;
      var cell11 = sheetObject.cell(CellIndex.indexByString("K1"));
      cell11.value = 'TAKE HOME'; // dynamic values support provided;
      cell11.cellStyle = cellStyle;
    }

    print(employeeDetails.keys.toList().length);

    //CELL VALUES

    for (int i = 0; i < employeeList.length; i++) {
      String id = employeeList[i]['empId'];

      print(employeeDetails[id]['takeHome']);

      var cell1 = sheetObject.cell(CellIndex.indexByString("A${i + 2}"));
      cell1.value = '${i + 1}'; // dynamic values support provided;
      cell1.cellStyle = cellStyle;
      var cell2 = sheetObject.cell(CellIndex.indexByString("B${i + 2}"));
      cell2.value = id.toString(); // dynamic values support provided;
      cell2.cellStyle = cellStyle;
      var cell3 = sheetObject.cell(CellIndex.indexByString("C${i + 2}"));
      cell3.value = empDataById[id].name; // dynamic values support provided;
      cell3.cellStyle = cellStyle;
      var cell4 = sheetObject.cell(CellIndex.indexByString("D${i + 2}"));
      cell4.value = (30 -
          employeeDetails[id]['offDay']); // dynamic values support provided;
      cell4.cellStyle = cellStyle;
      var cell5 = sheetObject.cell(CellIndex.indexByString("E${i + 2}"));
      cell5.value =
          employeeDetails[id]['leave']; // dynamic values support provided;
      cell5.cellStyle = cellStyle;
      var cell6 = sheetObject.cell(CellIndex.indexByString("F${i + 2}"));
      cell6.value = double.tryParse(empDataById[id].ctc)
          .toString(); // dynamic values support provided;
      cell6.cellStyle = cellStyle;
      var cell7 = sheetObject.cell(CellIndex.indexByString("G${i + 2}"));
      cell7.value =
          employeeDetails[id]['payable']; // dynamic values support provided;
      cell7.cellStyle = cellStyle;
      var cell8 = sheetObject.cell(CellIndex.indexByString("H${i + 2}"));
      cell8.value =
          employeeDetails[id]['incentive']; // dynamic values support provided;
      cell8.cellStyle = cellStyle;
      var cell9 = sheetObject.cell(CellIndex.indexByString("I${i + 2}"));
      cell9.value =
          employeeDetails[id]['ot']; // dynamic values support provided;
      cell9.cellStyle = cellStyle;
      var cell10 = sheetObject.cell(CellIndex.indexByString("J${i + 2}"));
      cell10.value =
          employeeDetails[id]['deduction']; // dynamic values support provided;
      cell10.cellStyle = cellStyle;
      var cell11 = sheetObject.cell(CellIndex.indexByString("K${i + 2}"));
      cell11.value =
          employeeDetails[id]['takeHome']; // dynamic values support provided;
      cell11.cellStyle = cellStyle;
    }

    excel.setDefaultSheet('Pay Slip');
    // var fileBytes = excel.encode();
    var data = excel.save(
        fileName:
            "PaySlip-${dateTimeFormat('dd MMM yyyy', DateTime.now())}.xlsx");

    Uint8List bytes = Uint8List.fromList(data);

    updateFileInFireBase(
        dateTimeFormat(
            'MMM y',
            DateTime(
              DateTime.now().year,
              DateTime.now().month - 1,
              DateTime.now().day,
            )),
        bytes,
        'xlsx');

    // final content = base64Encode(fileBytes);
    // final anchor = html.AnchorElement(
    //     href: "data:application/octet-stream;charset=utf-16le;base64,$content")
    //   ..setAttribute("download",
    //       "PaySlip-${dateTimeFormat('dd MMM yyyy', DateTime.now())}.xlsx")
    //   ..click();
  }

  sendMail() {
    DateTime monthDay = DateTime(DateTime.now().year, DateTime.now().month, 0);
    int lastDay = monthDay.day;
    for (int i = 0; i < employeeList.length; i++) {
      if (employeeDetails[employeeList[i]['empId']]['takeHome'] == 0) {
        continue;
      }

      String html = '<html>'
          '<head>'
          '<meta name="viewport" content="width=device-width, initial-scale=1">'
          '<link href="https://fonts.googleapis.com/css2?family=Gotham:wght@400;700&display=swap" rel="stylesheet">'
          '<style>'
          'body {'
          'font-family: "Gotham", sans-serif;'
          '}'
          '.header {'
          'background-color: #0058ff;'
          'color: #fff;'
          'text-align: center;'
          'padding: 10px;'
          'display: flex;'
          'align-items: center;'
          ' }'
          '.header img {'
          ' margin-right: 20px;'
          '}'
          '.container {'
          'width: 80%;'
          'margin: 0 auto;'
          'background-color: #f2f2f2;'
          'padding: 20px;'
          ' }'
          'table {'
          'width: 100%;'
          'border-collapse: collapse;'
          'margin-top: 20px;'
          '}'
          'th,'
          'td {'
          'border: 1px solid #333;'
          'padding: 10px;'
          '}'
          'th {'
          'background-color: #0058ff;'
          ' color: #fff;'
          '}'
          '@media (max-width: 767px) {'
          '.container {'
          'width: 90%;'
          '}'
          'th,'
          'td {'
          'font-size: 14px;'
          ' }'
          ' }'
          '</style>'
          ' </head>'
          '<body>'
          '<div class="header">'
          ' <img src="https://firebasestorage.googleapis.com/v0/b/first-logic-erp.appspot.com/o/webicon-01.png?alt=media&token=424afef7-b36f-47e0-aa12-ec5dd178085b" style="width:50px;height:50px;" alt="Company Logo" />'
          '<h3>First Logic Meta Lab Pvt. Ltd</h3>'
          '</div>'
          '<div class="container">'
          '<p>'
          'Dear <b>${empDataById[employeeList[i]['empId']].name}</b>,'
          '</p>'
          '<p>'
          'I hope this email finds you in good health and spirits. I am writing to '
          'inform you that your salary for the month of <b>${dateTimeFormat('MMM y', DateTime(
                DateTime.now().year,
                DateTime.now().month - 1,
                DateTime.now().day,
              ))}</b> has been '
          'credited to your account.'
          '</p>'
          '<p>'
          'Your total salary amount is <b>₹${employeeDetails[employeeList[i]['empId']]['takeHome']}</b>.'
          ' Please find the details below:'
          '</p>'
          ' <section>'
          ' <h2>Employee Information</h2>'
          ' <ul>'
          ' <li>Name: ${empDataById[employeeList[i]['empId']].name}</li>'
          ' <li>Employee ID: ${empDataById[employeeList[i]['empId']].empId}</li>'
          ' <li>Total Working Days: ${(30 - (employeeDetails[employeeList[i]['empId']]['offDay'] ?? 0))}</li>'
          '<li>Number of Leaves: ${employeeDetails[employeeList[i]['empId']]['leave']}</li>'
          ' </ul>'
          ' </section>';

      html += '<section>'
          '<h2>Salary Details</h2>'
          '<ul>'
          '<li>Basic Salary: ₹${empDataById[employeeList[i]['empId']].ctc}</li>'
          '<li>Payable Salary: ₹${employeeDetails[employeeList[i]['empId']]['payable']}</li>';

      html += employeeDetails[employeeList[i]['empId']]['incentive'] == 0
          ? ''
          : '<li>Incentive: ₹${employeeDetails[employeeList[i]['empId']]['incentive']}</li>';

      html += employeeDetails[employeeList[i]['empId']]['ot'] == 0
          ? ''
          : '<li>Over Time: ₹${employeeDetails[employeeList[i]['empId']]['ot']}</li>';

      html += employeeDetails[employeeList[i]['empId']]['deduction'] == 0
          ? ''
          : '<li>Deductions: ₹${employeeDetails[employeeList[i]['empId']]['deduction']}</li>';

      html +=
          '<li>Take Home: ₹${employeeDetails[employeeList[i]['empId']]['takeHome']}</li>'
          '</ul>'
          '</section>'
          '<p>'
          'In case of any discrepancy, please bring it to our notice within 2 days. '
          'We would be happy to assist you with any questions or concerns you may '
          'have.'
          ' </p>'
          ' <p>'
          ' Thank you for your continued contributions to the company.'
          ' </p>'
          '<p>'
          'Best regards,<br />'
          'HR Manager'
          '</p>'
          '</div>'
          ' </body>'
          '</html>';

      FirebaseFirestore.instance.collection('mail').add({
        'html': html,
        'status': 'Salary Information',
        'emailList': [empDataById[employeeList[i]['empId']].email],
      }).then((value) {
        FirebaseFirestore.instance
            .collection('employees')
            .doc(employeeList[i]['empId'])
            .collection('attendance')
            .doc(dateTimeFormat(
                'MMM y',
                DateTime(
                  DateTime.now().year,
                  DateTime.now().month - 1,
                  DateTime.now().day,
                )))
            .set({
          'attendance': employeeAttendance[employeeList[i]['empId']] ?? {},
          'month': dateTimeFormat(
              'MMM y',
              DateTime(
                DateTime.now().year,
                DateTime.now().month - 1,
                DateTime.now().day,
              )),
        });

        FirebaseFirestore.instance
            .collection('employees')
            .doc(employeeList[i]['empId'])
            .collection('salaryInfo')
            .doc(dateTimeFormat(
                'MMM y',
                DateTime(
                  DateTime.now().year,
                  DateTime.now().month - 1,
                  DateTime.now().day,
                )))
            .set({
          'totalWorkingDays': (lastDay -
              (employeeDetails[employeeList[i]['empId']]['offDay'] ?? 4)),
          'totalLeave': employeeDetails[employeeList[i]['empId']]['leave'],
          'basicSalary': empDataById[employeeList[i]['empId']].ctc,
          'payableSalary': employeeDetails[employeeList[i]['empId']]['payable'],
          'incentive': employeeDetails[employeeList[i]['empId']]['incentive'],
          'overTime': employeeDetails[employeeList[i]['empId']]['ot'],
          'deduction': employeeDetails[employeeList[i]['empId']]['deduction'],
          'takeHome': employeeDetails[employeeList[i]['empId']]['takeHome'],
          'month': dateTimeFormat(
              'MMM y',
              DateTime(
                DateTime.now().year,
                DateTime.now().month - 1,
                DateTime.now().day,
              )),
        });
      });
    }
    showUploadMessage(context, 'Pay Slip Successfully Shared..');
  }
}
