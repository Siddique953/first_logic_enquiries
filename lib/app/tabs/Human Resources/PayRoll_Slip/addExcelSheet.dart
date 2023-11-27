import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:csv/csv.dart';
import 'package:excel/excel.dart' as ex;
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:fl_erp/app/tabs/Human%20Resources/PayRoll_Slip/paySlipPdf/paySlipModel.dart';
import 'package:fl_erp/app/tabs/Human%20Resources/PayRoll_Slip/paySlipPdf/paySlipPdf.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rounded_progress_bar/flutter_rounded_progress_bar.dart';
import 'package:flutter_rounded_progress_bar/rounded_progress_bar_style.dart';
import 'package:intl/intl.dart';
import 'package:month_picker_dialog/month_picker_dialog.dart';

// import 'package:month_picker_dialog_2/month_picker_dialog_2.dart';
import '../../../../flutter_flow/flutter_flow_icon_button.dart';
import '../../../../flutter_flow/flutter_flow_theme.dart';
import '../../../../flutter_flow/flutter_flow_util.dart';
import '../../../../flutter_flow/flutter_flow_widgets.dart';
import '../../../../flutter_flow/upload_media.dart';
import '../../../app_widget.dart';
import '../../../pages/home_page/home.dart';
import 'BankSlip/bankSlip.dart';

late DataTableSource _dataSemi;
var employeeDetails = {};
var employeeAttendance = {};

class PaySlipPage extends StatefulWidget {
  const PaySlipPage({
    Key? key,
  }) : super(key: key);

  @override
  _PaySlipPageState createState() => _PaySlipPageState();
}

class _PaySlipPageState extends State<PaySlipPage> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  String filename = '';

  /*Map<String, Map<String, dynamic>>*/
  // var employeeDetails = {};
  // var employeeAttendance = {};
  bool closed = false;

  void pickFile() async {
    final result = await FilePicker.platform.pickFiles(
      allowMultiple: false,
      type: FileType.custom,
      allowedExtensions: ['csv'],
    );

    if (result == null) return;
    final file = result.files.first;

    Uint8List? bytes = file.bytes;
    _openFile(file, bytes!);
    showUploadMessage(context, 'file uploaded successfully');
  }

  late List<List<dynamic>> rowDetail;

  void _openFile(PlatformFile file, Uint8List bytes) {
    filename = file.name;

    rowDetail =
        const CsvToListConverter().convert(String.fromCharCodes(file.bytes!));

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

        int totalWorkingDays = 0;
        int totalDays = 0;

        if (empDataById[empCode] == null) {
          basicSalary = double.tryParse('0')!;
        } else {
          basicSalary =
              double.tryParse(empDataById[empCode]!.ctc.toString()) ?? 0;
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
          rowDetail[j][0].toString().contains('/')
              ? toDay = rowDetail[j][0].toString().split('/')
              : toDay = rowDetail[j][0].toString().split('-');

          // List toDayList = toDay;
          bool off = false;
          bool half = false;
          bool fullDayLeave = false;
          totalWorkingDays++;
          totalDays++;

          // int year = int.tryParse(toDay[2])??0;
          // int month = int.tryParse(toDay[1])??0;
          // int days = int.tryParse(toDay[0])??0;

          // DateTime day = DateTime(year , month , days);
          DateTime day = DateFormat('dd/MM/yyyy').parse(rowDetail[j][0]);
          // DateTime day = DateTime.tryParse(toDay[2] + toDay[1] + toDay[0])!;

          String inTime = rowDetail[j][2].toString();

          String outTime = rowDetail[j][3].toString();

          String totalWorkHour = rowDetail[j][4].toString();

          employeeDetails[empCode] = {};

          int hours = 0;
          int minuit = 0;

          try {
            hours = int.tryParse(rowDetail[j][4].toString().split(':')[0])!;
            minuit = int.tryParse(rowDetail[j][4].toString().split(':')[1])!;
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
            totalWorkingDays--;
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
            'casualLeave': 0,
            /* casualLeaves[empCode] ?? 0,*/
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

        if ((leave + ((halfDay + lateCut) * 0.5)) > 5) {
          payable = (basicSalary / 30) * (totalWork - (0.5 * lateCut));
        } else {
          payable =
              (basicSalary / 30) * (30 - (leave + ((halfDay + lateCut) * 0.5)));

          if (empCode == 'FL108') {
            print('hellooooo');
            print(basicSalary);
            print(basicSalary / 30);
            print(leave);
            print(halfDay);
            print(lateCut);
            print((leave - ((halfDay + lateCut) * 0.5)));
            print(payable);
          }
        }

        employeeDetails[empCode]['totalDays'] = totalDays;
        employeeDetails[empCode]['totalWorkDays'] = totalWorkingDays;
        employeeDetails[empCode]['workDay'] = totalWork - (0.5 * lateCut);
        employeeDetails[empCode]['offDay'] = cf;
        employeeDetails[empCode]['lateCut'] = lateCut;
        employeeDetails[empCode]['halfDay'] = halfDay;
        employeeDetails[empCode]['casualLeave'] =
            0 /*casualLeaves[empCode] ?? 0*/;
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

    print('111111');
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

    setState(() {});
  }

  Future uploadFileToFireBase(String name, fileBytes, String ext) async {
    // final path='file/${pickFile.name}';
    // final file=File(pickFile.path);

    // final ref=FirebaseStorage.instance.ref().child(path);
    // uploadTask = ref.putFile(file);
    ///
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

  /// GET CASUAL LEAVES IN LAST MONTH
  late DateTime lastMonthStart;
  late DateTime lastMonthEnd;
  // Map casualLeaves = {};

  // getLeaves() {
  //   FirebaseFirestore.instance
  //       .collection('leaveRequest')
  //       .where('accepted', isEqualTo: true)
  //       .where('type', isEqualTo: 'Casual Leave')
  //       .where('from', isGreaterThanOrEqualTo: lastMonthStart)
  //       // .where('to', isLessThanOrEqualTo: lastMonthEnd)
  //       .get()
  //       .then((value) {
  //     for (var doc in value.docs) {
  //       DateTime from = doc['from'].toDate();
  //       DateTime to = doc['to'].toDate();
  //
  //       if ((lastMonthStart.isBefore(from) || lastMonthStart == from) &&
  //           (lastMonthEnd.isAfter(to) || lastMonthEnd == to)) {
  //         try {
  //           casualLeaves[doc['empId']] = casualLeaves[doc['empId']] + 1;
  //         } catch (er) {
  //           a(er);
  //           casualLeaves[doc['empId']] = 1;
  //         }
  //       }
  //     }
  //     setState(() {});
  //   });
  // }

  /// PAGINATED DATA TABLE
  final paginateKey = new GlobalKey<PaginatedDataTableState>();
  ScrollController scrollController = ScrollController();
  int _rowPerPage = 10;

  /// EMPLOYEE LIST SORTED
  List employeeListFull =
      employeeList.where((element) => element['delete'] == false).toList();
  List sortedEmployeeList = [];
  TextEditingController search = TextEditingController();

  ///SHOW PROGRESSBAR
  bool sendMailProgressShow = false;
  double percent = 0;

  @override
  void initState() {
    DateTime now = DateTime.now();
    lastMonthStart = DateTime(now.year, now.month - 1, 1);
    lastMonthEnd = DateTime(now.year, now.month, 0);

    employeeListFull =
        employeeList.where((element) => element['delete'] == false).toList();
    sortedEmployeeList =
        employeeList.where((element) => element['delete'] == false).toList();

    // getLeaves();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  refresh() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    _dataSemi = MyData(context, refresh, closed, sortedEmployeeList);

    return Scaffold(
      key: scaffoldKey,
      backgroundColor: Colors.white,
      body: sendMailProgressShow
          ? Center(
              child: Container(
                width: 300,
                child: RoundedProgressBar(
                  height: 30,
                  style: RoundedProgressBarStyle(
                      backgroundProgress: Colors.transparent,
                      widthShadow: 5,
                      colorProgress: Color(0xFF0F1113),
                      colorProgressDark: Colors.transparent,
                      borderWidth: 0),

                  childCenter: Text("${percent.toStringAsFixed(2)}%",
                      style: TextStyle(color: Colors.white)),
                  percent: percent,

                  // theme: RoundedProgressBarTheme.red,
                ),
              ),
            )
          : SafeArea(
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
                                padding:
                                    EdgeInsetsDirectional.fromSTEB(8, 4, 8, 4),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    Container(
                                      height: 60,
                                      width: MediaQuery.of(context).size.width *
                                          0.6,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
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
                                                    DateTime.now().year - 100,
                                                    5),
                                                lastDate: DateTime(
                                                    DateTime.now().year + 100,
                                                    12),
                                                initialDate: DateTime.now(),

                                                // confirmText: Text(
                                                //   'Choose',
                                                //   style: TextStyle(
                                                //       fontWeight: FontWeight.bold,
                                                //       color: Colors.black),
                                                // ),
                                                // cancelText: Text('Cancel'),
                                                // yearFirst: true,
                                              ).then((date) async {
                                                if (date != null) {
                                                  try {
                                                    final value =
                                                        await FirebaseFirestore
                                                            .instance
                                                            .collection(
                                                                'paySlipInfo')
                                                            .doc(dateTimeFormat(
                                                                'MMMM y', date))
                                                            .get();
                                                    employeeDetails =
                                                        value['salaryInfo'];

                                                    closed = value['closed'];
                                                    showUploadMessage(context,
                                                        'Details Successfully Updated...');
                                                    setState(() {});

                                                    ///

                                                    FirebaseFirestore.instance
                                                        .collection(
                                                            'paySlipInfo')
                                                        .doc(dateTimeFormat(
                                                            'MMMM y', date))
                                                        .collection(
                                                            'attendanceInfo')
                                                        .get()
                                                        .then((value) {
                                                      for (var i in value.docs) {
                                                        employeeAttendance[
                                                                i.id] =
                                                            i['attendance'];
                                                      }

                                                      setState(() {

                                                      });

                                                    });
                                                  } catch (err) {
                                                    print(err);
                                                    showUploadMessage(context,
                                                        'No Data Found...');
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
                                                width: MediaQuery.of(context).size.width * 0.25,
                                                height: 50,
                                                child: Center(
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      Icon(Icons
                                                          .file_present_sharp),
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
                                          employeeDetails.keys
                                                  .toList()
                                                  .isNotEmpty
                                              ? closed
                                                  ? SizedBox()
                                                  : FlutterFlowIconButton(
                                                      borderColor:
                                                          Colors.transparent,
                                                      borderRadius: 30,
                                                      borderWidth: 1,
                                                      buttonSize: 50,
                                                      icon: Icon(
                                                        Icons
                                                            .cloud_upload_sharp,
                                                        color: Colors.teal,
                                                        size: 25,
                                                      ),
                                                      onPressed: () async {
                                                        print(
                                                            '""""employeeAttendance""""');
                                                        print(
                                                            employeeAttendance);
                                                        print(
                                                            '"""""""employeeDetails"""""""');
                                                        print(employeeDetails);
                                                        bool pressed = await alert(
                                                            context,
                                                            'Do you want Upload');

                                                        if (pressed) {
                                                          // FirebaseFirestore.instance
                                                          //     .collection(
                                                          //         'paySlipInfo')
                                                          //     .doc(dateTimeFormat(
                                                          //         'MMMM y',
                                                          //         DateTime(
                                                          //           DateTime.now()
                                                          //               .year,
                                                          //           DateTime.now()
                                                          //                   .month -
                                                          //               1,
                                                          //           DateTime.now()
                                                          //               .day,
                                                          //         )))
                                                          //     .set({
                                                          //   'salaryInfo':
                                                          //       employeeDetails,
                                                          //   // 'attendanceInfo':
                                                          //   //     employeeAttendance,
                                                          //   'closed': false,
                                                          // });
                                                          FirebaseFirestore
                                                              .instance
                                                              .collection(
                                                                  'paySlipInfo')
                                                              .doc(
                                                                  dateTimeFormat(
                                                                      'MMMM y',
                                                                      DateTime(
                                                                        DateTime.now()
                                                                            .year,
                                                                        DateTime.now().month -
                                                                            1,
                                                                        DateTime.now()
                                                                            .day,
                                                                      )))
                                                              .set({
                                                            'salaryInfo':
                                                                employeeDetails,
                                                            // 'attendanceInfo':
                                                            //     employeeAttendance,
                                                            'closed': false,
                                                          }).then((value) {
                                                            for (String i
                                                                in employeeAttendance
                                                                    .keys) {
                                                              FirebaseFirestore
                                                                  .instance
                                                                  .collection(
                                                                      'paySlipInfo')
                                                                  .doc(
                                                                      dateTimeFormat(
                                                                          'MMMM y',
                                                                          DateTime(
                                                                            DateTime.now().year,
                                                                            DateTime.now().month -
                                                                                1,
                                                                            DateTime.now().day,
                                                                          )))
                                                                  .collection(
                                                                      'attendanceInfo')
                                                                  .doc(i)
                                                                  .set({
                                                                'attendance':
                                                                    employeeAttendance[
                                                                        i],
                                                              });
                                                            }
                                                            showUploadMessage(
                                                                context,
                                                                'Details Uploaded Success...');

                                                            setState(() {});
                                                          });
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
                                                      textStyle:
                                                          FlutterFlowTheme
                                                              .subtitle2
                                                              .override(
                                                        fontFamily: 'Poppins',
                                                        color:
                                                            Color(0xFFF1F4F8),
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.normal,
                                                      ),
                                                      borderSide: BorderSide(
                                                        color:
                                                            Colors.transparent,
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
                                                      final pressed = await alert(context, 'Do you want to generate Excel');
                                                      if (pressed) {
                                                        // FirebaseFirestore.instance
                                                        //     .collection(
                                                        //         'paySlipInfo')
                                                        //     .doc(dateTimeFormat(
                                                        //         'MMMM y',
                                                        //         DateTime(
                                                        //           DateTime.now()
                                                        //               .year,
                                                        //           DateTime.now()
                                                        //                   .month -
                                                        //               1,
                                                        //           DateTime.now()
                                                        //               .day,
                                                        //         )))
                                                        //     .set({
                                                        //   'salaryInfo':
                                                        //       employeeDetails,
                                                        //   // 'attendanceInfo':
                                                        //   //     employeeAttendance,
                                                        //   'closed': false,
                                                        // });
                                                        FirebaseFirestore
                                                            .instance
                                                            .collection(
                                                            'paySlipInfo')
                                                            .doc(
                                                            dateTimeFormat(
                                                                'MMMM y',
                                                                DateTime(
                                                                  DateTime.now()
                                                                      .year,
                                                                  DateTime.now().month -
                                                                      1,
                                                                  DateTime.now()
                                                                      .day,
                                                                )))
                                                            .set({
                                                          'salaryInfo':
                                                          employeeDetails,
                                                          // 'attendanceInfo':
                                                          //     employeeAttendance,
                                                          'closed': false,
                                                        }).then((value) {
                                                          for (String i
                                                          in employeeAttendance
                                                              .keys) {
                                                            FirebaseFirestore
                                                                .instance
                                                                .collection(
                                                                'paySlipInfo')
                                                                .doc(
                                                                dateTimeFormat(
                                                                    'MMMM y',
                                                                    DateTime(
                                                                      DateTime.now().year,
                                                                      DateTime.now().month -
                                                                          1,
                                                                      DateTime.now().day,
                                                                    )))
                                                                .collection(
                                                                'attendanceInfo')
                                                                .doc(i)
                                                                .set({
                                                              'attendance':
                                                              employeeAttendance[
                                                              i],
                                                            });
                                                          }



                                                        });
                                                      }

                                                      try {
                                                        importData();
                                                      } catch (e) {
                                                        print(e);

                                                        return showDialog(
                                                            context: context,
                                                            builder: (context) {
                                                              return AlertDialog(
                                                                title: Text(
                                                                    'error'),
                                                                content: Text(e
                                                                    .toString()),
                                                                actions: <Widget>[
                                                                  ElevatedButton(
                                                                    child:
                                                                        new Text(
                                                                            'ok'),
                                                                    onPressed:
                                                                        () {
                                                                      Navigator.of(
                                                                              context)
                                                                          .pop();
                                                                    },
                                                                  )
                                                                ],
                                                              );
                                                            });
                                                      }
                                                      // });
                                                    },
                                                    text: 'Generate Excel',
                                                    options: FFButtonOptions(
                                                      width: 150,
                                                      height: 49,
                                                      color: Color(0xFF0F1113),
                                                      textStyle:
                                                          FlutterFlowTheme
                                                              .subtitle2
                                                              .override(
                                                        fontFamily: 'Poppins',
                                                        color:
                                                            Color(0xFFF1F4F8),
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.normal,
                                                      ),
                                                      borderSide: BorderSide(
                                                        color:
                                                            Colors.transparent,
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

                                                        FirebaseFirestore
                                                            .instance
                                                            .collection(
                                                            'paySlipInfo')
                                                            .doc(
                                                            dateTimeFormat(
                                                                'MMMM y',
                                                                DateTime(
                                                                  DateTime.now()
                                                                      .year,
                                                                  DateTime.now().month -
                                                                      1,
                                                                  DateTime.now()
                                                                      .day,
                                                                )))
                                                            .set({
                                                          'salaryInfo':
                                                          employeeDetails,
                                                          // 'attendanceInfo':
                                                          //     employeeAttendance,
                                                          'closed': true,
                                                        })
                                                            .then((value) {
                                                          for (String i
                                                          in employeeAttendance
                                                              .keys) {
                                                            FirebaseFirestore
                                                                .instance
                                                                .collection(
                                                                'paySlipInfo')
                                                                .doc(
                                                                dateTimeFormat(
                                                                    'MMMM y',
                                                                    DateTime(
                                                                      DateTime.now().year,
                                                                      DateTime.now().month -
                                                                          1,
                                                                      DateTime.now().day,
                                                                    )))
                                                                .collection(
                                                                'attendanceInfo')
                                                                .doc(i)
                                                                .set({
                                                              'attendance':
                                                              employeeAttendance[
                                                              i],
                                                            });
                                                          }



                                                        });
                                                      }


                                                      sendMail();
                                                    },
                                                    text: 'Send Email',
                                                    options: FFButtonOptions(
                                                      width: 150,
                                                      height: 49,
                                                      color: Color(0xFF0F1113),
                                                      textStyle:
                                                          FlutterFlowTheme
                                                              .subtitle2
                                                              .override(
                                                        fontFamily: 'Poppins',
                                                        color:
                                                            Color(0xFFF1F4F8),
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.normal,
                                                      ),
                                                      borderSide: BorderSide(
                                                        color:
                                                            Colors.transparent,
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
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Salary Details',
                          style: FlutterFlowTheme.bodyText1.override(
                              fontFamily: 'Poppins',
                              fontSize: 20,
                              fontWeight: FontWeight.w600),
                        ),
                        Container(
                          width: 350,
                          height: 40,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(
                              color: Colors.black,
                            ),
                          ),
                          child: Padding(
                            padding: EdgeInsets.fromLTRB(16, 0, 0, 0),
                            child: TextFormField(
                              controller: search,
                              obscureText: false,
                              onChanged: (text) {
                                // setState(() {
                                sortedEmployeeList.clear();
                                if (search.text == '') {
                                  // listOfFilteredProjects
                                  //     .addAll(listOfActiveProjects);


                                  sortedEmployeeList.addAll(employeeListFull);
                                  setState(() {});
                                } else {
                                  getSearchedProjects(text.toLowerCase());
                                }
                                // });
                              },
                              decoration: InputDecoration(
                                labelText: 'Search',
                                labelStyle: FlutterFlowTheme.bodyText2.override(
                                    fontFamily: 'Montserrat',
                                    color: Colors.black,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 12),
                                hintText: 'Search for Employees',
                                hintStyle: FlutterFlowTheme.bodyText2.override(
                                    fontFamily: 'Montserrat',
                                    color: Colors.black,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 12),
                                enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.transparent,
                                    width: 1,
                                  ),
                                  borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(4.0),
                                    topRight: Radius.circular(4.0),
                                  ),
                                ),
                                focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.transparent,
                                    width: 1,
                                  ),
                                  borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(4.0),
                                    topRight: Radius.circular(4.0),
                                  ),
                                ),
                              ),
                              style: FlutterFlowTheme.bodyText2.override(
                                  fontFamily: 'Montserrat',
                                  color: Color(0xFF8B97A2),
                                  fontWeight: FontWeight.w500,
                                  fontSize: 13),
                            ),
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
                                      child: SizedBox(
                                        child: SingleChildScrollView(
                                          child: Theme(
                                            data: ThemeData(
                                                cardColor:
                                                    Theme.of(context).cardColor,
                                                textTheme: TextTheme(
                                                    bodySmall: TextStyle(
                                                        color: Colors.black))),
                                            child: PaginatedDataTable(
                                              key: paginateKey,
                                              onPageChanged: (value) {
                                                scrollController.animateTo(0,
                                                    duration: Duration(
                                                        milliseconds: 500),
                                                    curve:
                                                        Curves.fastOutSlowIn);
                                              },
                                              checkboxHorizontalMargin: 10,
                                              source: _dataSemi,
                                              columnSpacing: 10.0,
                                              horizontalMargin: 10,
                                              onRowsPerPageChanged: (r) {
                                                if (r != null) {
                                                  setState(() {
                                                    _rowPerPage = r;
                                                  });
                                                }
                                              },
                                              rowsPerPage: _rowPerPage,
                                              columns: [
                                                DataColumn(
                                                  label: Text(
                                                    "Sl No",
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 12),
                                                  ),
                                                ),
                                                DataColumn(
                                                  label: Text("Emp ID",
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 12)),
                                                ),
                                                DataColumn(
                                                  label: Text("Emp Name",
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 12)),
                                                ),
                                                DataColumn(
                                                  label: Flexible(
                                                    child: Text(
                                                        "Total Working Days",
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontSize: 12)),
                                                  ),
                                                ),
                                                DataColumn(
                                                  label: Flexible(
                                                    child: Text(
                                                        "Total Attended Days",
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontSize: 12)),
                                                  ),
                                                ),
                                                DataColumn(
                                                  label: Flexible(
                                                    child: Text(
                                                        "Number Of Leave",
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontSize: 12)),
                                                  ),
                                                ),
                                                DataColumn(
                                                  label: Flexible(
                                                    child: Text("Casual Leaves",
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontSize: 12)),
                                                  ),
                                                ),
                                                DataColumn(
                                                  label: Flexible(
                                                    child: Text("Basic Salary",
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontSize: 12)),
                                                  ),
                                                ),
                                                DataColumn(
                                                  label: Flexible(
                                                    child: Text(
                                                        "Payable Salary",
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontSize: 12)),
                                                  ),
                                                ),
                                                DataColumn(
                                                  label: Flexible(
                                                    child: Text("Incentive",
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontSize: 12)),
                                                  ),
                                                ),
                                                DataColumn(
                                                  label: Flexible(
                                                    child: Text("Over Time",
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontSize: 12)),
                                                  ),
                                                ),
                                                DataColumn(
                                                  label: Flexible(
                                                    child: Text("Advance",
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontSize: 12)),
                                                  ),
                                                ),
                                                DataColumn(
                                                  label: Flexible(
                                                    child: Text("Take Home",
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontSize: 12)),
                                                  ),
                                                ),
                                              ],
                                            ),
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
    var excel = ex.Excel.createExcel();

    ex.Sheet sheetObject = excel['Pay Slip'];
    ex.CellStyle cellStyle = ex.CellStyle(
        // backgroundColorHex: "#1AFF1A",
        fontFamily: ex.getFontFamily(ex.FontFamily.Calibri));

    //HEADINGS

    if (employeeDetails.keys.toList().length > 0) {
      var cell1 = sheetObject.cell(ex.CellIndex.indexByString("A1"));
      cell1.value = 'SL NO';
      cell1.cellStyle = cellStyle;
      var cell2 = sheetObject.cell(ex.CellIndex.indexByString("B1"));
      cell2.value = 'EMPLOYEE ID'; // dynamic values support provided;
      cell2.cellStyle = cellStyle;
      var cell3 = sheetObject.cell(ex.CellIndex.indexByString("C1"));
      cell3.value = 'NAME'; // dynamic values support provided;
      cell3.cellStyle = cellStyle;
      var cell4 = sheetObject.cell(ex.CellIndex.indexByString("D1"));
      cell4.value = 'TOTAL WORKING DAYS'; // dynamic values support provided;
      cell4.cellStyle = cellStyle;
      var cell5 = sheetObject.cell(ex.CellIndex.indexByString("E1"));
      cell5.value = 'TOTAL LEAVE'; // dynamic values support provided;
      cell5.cellStyle = cellStyle;
      var cell6 = sheetObject.cell(ex.CellIndex.indexByString("F1"));
      cell6.value = 'TOTAL CASUAL LEAVE'; // dynamic values support provided;
      cell6.cellStyle = cellStyle;

      var cell7 = sheetObject.cell(ex.CellIndex.indexByString("G1"));
      cell7.value = 'BASIC SALARY'; // dynamic values support provided;
      cell7.cellStyle = cellStyle;
      var cell8 = sheetObject.cell(ex.CellIndex.indexByString("H1"));
      cell8.value = 'PAYABLE SALARY'; // dynamic values support provided;
      cell8.cellStyle = cellStyle;
      var cell9 = sheetObject.cell(ex.CellIndex.indexByString("I1"));
      cell9.value = 'INCENTIVE'; // dynamic values support provided;
      cell9.cellStyle = cellStyle;
      var cell10 = sheetObject.cell(ex.CellIndex.indexByString("J1"));
      cell10.value = 'OVER TIME'; // dynamic values support provided;
      cell10.cellStyle = cellStyle;
      var cell11 = sheetObject.cell(ex.CellIndex.indexByString("K1"));
      cell11.value = 'ADVANCE'; // dynamic values support provided;
      cell11.cellStyle = cellStyle;
      var cell12 = sheetObject.cell(ex.CellIndex.indexByString("L1"));
      cell12.value = 'TAKE HOME'; // dynamic values support provided;
      cell12.cellStyle = cellStyle;
    }

    //CELL VALUES

    List employeeListActive =
        employeeList.where((element) => element['delete'] == false).toList();

    for (int i = 0; i < employeeListActive.length; i++) {
      String id = employeeListActive[i]['empId'];

      var cell1 = sheetObject.cell(ex.CellIndex.indexByString("A${i + 2}"));
      cell1.value = '${i + 1}'; // dynamic values support provided;
      cell1.cellStyle = cellStyle;
      var cell2 = sheetObject.cell(ex.CellIndex.indexByString("B${i + 2}"));
      cell2.value = id.toString(); // dynamic values support provided;
      cell2.cellStyle = cellStyle;
      var cell3 = sheetObject.cell(ex.CellIndex.indexByString("C${i + 2}"));
      cell3.value = empDataById[id]!.name; // dynamic values support provided;
      cell3.cellStyle = cellStyle;
      var cell4 = sheetObject.cell(ex.CellIndex.indexByString("D${i + 2}"));
      cell4.value = (30 -
          (employeeDetails[id] == null
              ? 30
              : employeeDetails[id]
                  ['offDay'])); // dynamic values support provided;
      cell4.cellStyle = cellStyle;
      var cell5 = sheetObject.cell(ex.CellIndex.indexByString("E${i + 2}"));
      cell5.value = employeeDetails[id] == null
          ? ''
          : employeeDetails[id]['leave']; // dynamic values support provided;
      cell5.cellStyle = cellStyle;
      var cell6 = sheetObject.cell(ex.CellIndex.indexByString("F${i + 2}"));
      cell6.value = employeeDetails[id] == null
          ? ''
          : employeeDetails[id]
              ['casualLeave']; // dynamic values support provided;
      cell6.cellStyle = cellStyle;

      var cell7 = sheetObject.cell(ex.CellIndex.indexByString("G${i + 2}"));
      cell7.value = double.tryParse(empDataById[id]!.ctc.toString())!
          .toString(); // dynamic values support provided;
      cell7.cellStyle = cellStyle;
      var cell8 = sheetObject.cell(ex.CellIndex.indexByString("H${i + 2}"));
      cell8.value = employeeDetails[id] == null
          ? ''
          : employeeDetails[id]['payable']; // dynamic values support provided;
      cell8.cellStyle = cellStyle;
      var cell9 = sheetObject.cell(ex.CellIndex.indexByString("I${i + 2}"));
      cell9.value = employeeDetails[id] == null
          ? ''
          : employeeDetails[id]
              ['incentive']; // dynamic values support provided;
      cell9.cellStyle = cellStyle;
      var cell10 = sheetObject.cell(ex.CellIndex.indexByString("J${i + 2}"));
      cell10.value = employeeDetails[id] == null
          ? ''
          : employeeDetails[id]['ot']; // dynamic values support provided;
      cell10.cellStyle = cellStyle;
      var cell11 = sheetObject.cell(ex.CellIndex.indexByString("K${i + 2}"));
      cell11.value = employeeDetails[id] == null
          ? ''
          : employeeDetails[id]
              ['deduction']; // dynamic values support provided;
      cell11.cellStyle = cellStyle;
      var cell12 = sheetObject.cell(ex.CellIndex.indexByString("L${i + 2}"));
      cell12.value = employeeDetails[id] == null
          ? ''
          : employeeDetails[id]['takeHome']; // dynamic values support provided;
      cell12.cellStyle = cellStyle;
    }

    excel.setDefaultSheet('Pay Slip');
    // var fileBytes = excel.encode();
    var data = excel.save(
        fileName: "PaySlip-${dateTimeFormat('dd MMM yyyy', (DateTime(
              DateTime.now().year,
              DateTime.now().month - 1,
              DateTime.now().day,
            )))}.xlsx");

    Uint8List bytes = Uint8List.fromList(data!);

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

  sendMail() async {
    List availableEmployees =
        employeeList.where((element) => element['delete'] == false).toList();
    DateTime monthDay = DateTime(DateTime.now().year, DateTime.now().month, 0);
    int lastDay = monthDay.day;
    sendMailProgressShow = true;
    percent = 0;
    setState(() {});
    for (int i = 0; i < availableEmployees.length; i++) {
      if (employeeDetails[availableEmployees[i]['empId']]['takeHome'] == 0) {
        continue;
      } else {
        int offDays = int.tryParse(
            (employeeDetails[availableEmployees[i]['empId']]['offDay'] ?? 4)
                .toString())!;
        int workingDays = int.tryParse((30 - offDays).toString())!;
        double payable = double.tryParse(
            empDataById[availableEmployees[i]['empId']]!.ctc ?? '0')!;
        double leaveCut = payable -
            employeeDetails[availableEmployees[i]['empId']]['takeHome'];

        PaySlipModel data = PaySlipModel(
          workingDays: workingDays,
          pto: leaveCut.toString(),
          totalDeduction: ((employeeDetails[availableEmployees[i]['empId']]
                      ['deduction']) +
                  leaveCut)
              .toString(),
          spAllowance: '',
          pan: empDataById[availableEmployees[i]['empId']]?.pan ?? '',
          netSalary: employeeDetails[availableEmployees[i]['empId']]['takeHome']
              .toString(),
          month: dateTimeFormat(
              'MMM y',
              DateTime(
                DateTime.now().year,
                DateTime.now().month - 1,
                DateTime.now().day,
              )),
          medicalAlowance: '',
          leaves: '',
          leavesTaken: employeeDetails[availableEmployees[i]['empId']]['leave'],
          incentives:
              employeeDetails[availableEmployees[i]['empId']]['incentive'] == 0
                  ? ''
                  : employeeDetails[availableEmployees[i]['empId']]['incentive']
                      .toString(),
          hra: '',
          dearnessAllo: '',
          code: availableEmployees[i]['empId'],
          cityAllow: '',
          balanceLeaves: 0,
          basicPay: empDataById[availableEmployees[i]['empId']]!.ctc ?? '',
          attended: employeeDetails[availableEmployees[i]['empId']]['workDay'],
          advance: employeeDetails[availableEmployees[i]['empId']]['deduction']
              .toString(),
          accNumber: empDataById[availableEmployees[i]['empId']]!.accountNumber,
          total: (employeeDetails[availableEmployees[i]['empId']]['incentive'] +
                  double.tryParse(empDataById[availableEmployees[i]['empId']]!
                      .ctc
                      .toString())!)
              .toString(),
          name: empDataById[availableEmployees[i]['empId']]!.name,
          bankName: empDataById[availableEmployees[i]['empId']]!.bankName,
          designation: empDataById[availableEmployees[i]['empId']]!.designation,
        );
        PaySlip.downloadPdf(data, employeeDetails, employeeAttendance,
            availableEmployees[i]['empId'], lastDay);

        await Future.delayed(Duration(seconds: 10));
        percent = (i / availableEmployees.length) * 100;
        setState(() {
          
        });
      }

      // if(kDebugMode) {
      //   print('"""""""""empId"""""""""');
      //   print(availableEmployees[i]['empId']);
      // }
    }
    showUploadMessage(context, 'Pay Slip Successfully Shared..');
  }

  /// SEARCH FOR EMPLOYEE

//GET FIRST 20 SEARCHED DATA
  getSearchedProjects(String txt) {
    sortedEmployeeList = [];
    for (int i = 0; i < employeeListFull.length; i++) {
      if (employeeListFull[i]['name'].toString().toLowerCase().contains(txt) ||
          employeeListFull[i]['mobile']
              .toString()
              .toLowerCase()
              .contains(txt) ||
          employeeListFull[i]['email'].toString().toLowerCase().contains(txt)) {
        Map<String, dynamic> data = {};
        data = employeeListFull[i];
        data['index'] = i;
        sortedEmployeeList.add(data);

        // listOfFilteredProjects.add(listOfActiveProjects[i]);
      }
    }

    setState(() {});
  }
}

class MyData extends DataTableSource {
  var context;
  Function refresh;
  bool closed;
  List currentEmployeeList;

  MyData(BuildContext this.context, this.refresh, this.closed,
      this.currentEmployeeList);

  @override
  bool get isRowCountApproximate => false;
  @override
  int get rowCount => currentEmployeeList.length;
  @override
  int get selectedRowCount => 0;
  @override
  DataRow getRow(int index) {
    final data = currentEmployeeList[index]['empId'];

    if (employeeDetails.keys.toList().isNotEmpty) {
      if (employeeDetails[data] == null) {
        employeeDetails[data] = {
          "workDay": 0,
          "offDay": 0,
          "lateCut": 0,
          "halfDay": 0,
          "leave": 0,
          'casualLeave': 0,
          "payable": 0,
          "incentive": 0,
          "ot": 0,
          "deduction": 0,
          "takeHome": 0,
          "totalWorkDays": 0,
          "totalDays": 0,
        };
      }
    }

    TextEditingController workingDays = TextEditingController(
        text: employeeDetails[data] != null &&
                employeeDetails[data]['totalWorkDays'] != null
            ? ((employeeDetails[data]['totalWorkDays'] ?? 0)).toString()
            : '');

    TextEditingController attendedDays = TextEditingController(
        text: employeeDetails[data] != null &&
                employeeDetails[data]['workDay'] != null
            ? ((employeeDetails[data]['workDay'] ?? 0)).toString()
            : '');

    TextEditingController incentive = TextEditingController(
        text: employeeDetails[data] != null
            ? employeeDetails[data]['incentive'].toString()
            : '');

    TextEditingController deduction = TextEditingController(
        text: employeeDetails[data] != null
            ? employeeDetails[data]['deduction'].toString()
            : '');

    TextEditingController ot = TextEditingController(
        text: employeeDetails[data] != null
            ? employeeDetails[data]['ot'].toString()
            : '');

    TextEditingController payable = TextEditingController(
        text: employeeDetails[data] != null
            ? employeeDetails[data]['payable'].toString()
            : '');

    TextEditingController leave = TextEditingController(
        text: employeeDetails[data] != null &&
                employeeDetails[data]['leave'] != null
            ? (employeeDetails[data]['leave'] ?? 0).toString()
            : '');

    TextEditingController casualLeave = TextEditingController(
        text: employeeDetails[data] != null &&
                employeeDetails[data]['casualLeave'] != null
            ? (employeeDetails[data]['casualLeave'] ?? 0).toString()
            : '');

    String name = empDataById[data]!.name ?? '';

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

    // String leaves = employeeDetails[data] !=
    //             null &&
    //         employeeDetails[data]
    //                 ['leave'] !=
    //             null
    //     ? (employeeDetails[data]['leave'] ??
    //             0)
    //         .toString()
    //     : '';

    // String casualLeave =
    //     employeeDetails[data] != null &&
    //             employeeDetails[data]
    //                     ['casualLeave'] !=
    //                 null
    //         ? (employeeDetails[data]
    //                     ['casualLeave'] ??
    //                 0)
    //             .toString()
    //         : '';

    double basicSalary = double.tryParse(empDataById[data]!.ctc.toString())!;

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

    String takeHome = employeeDetails[data] != null &&
            employeeDetails[data]['takeHome'] != null
        ? (employeeDetails[data]['takeHome'] ?? 0).toString()
        : '';

    return DataRow(
        color: index.isOdd
            ? MaterialStateProperty.all(
                Colors.blueGrey.shade50.withOpacity(0.7))
            : MaterialStateProperty.all(Colors.blueGrey.shade50),
        cells: [
          DataCell(
            Text((index + 1).toString(),
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
          ),

          DataCell(
            Text(data,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
          ),

          DataCell(
            Text(name.toString(),
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
          ),

          /// EDIT TOTAL WORKING DAYS TO CHANGE

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
                try {
                  employeeDetails[data]['totalWorkDays'] =
                      (int.tryParse(workingDays.text)!);

                  // for (var id
                  //     in employeeDetails.keys
                  //         .toList()) {
                  //   if (30 -
                  //           (employeeDetails[
                  //                       id][
                  //                   'offDay'] ??
                  //               0) ==
                  //       30) {
                  //     employeeDetails[id]
                  //             ['offDay'] =
                  //         (30 -
                  //             int.tryParse(
                  //                 workingDays
                  //                     .text));
                  //   }
                  // }
                } catch (err) {
                  print(err);
                  showUploadMessage(context, 'Unexpected error occurred!!!');
                }
              },

              decoration: InputDecoration(
                border: InputBorder.none,
              ),
              style: FlutterFlowTheme.bodyText2.override(
                fontFamily: 'Montserrat',
                color: Colors.black,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),

          /// EDIT ATTENDED DAYS
          DataCell(
            TextFormField(
              readOnly: closed,
              controller: attendedDays,
              obscureText: false,

              //ADD VALUE TO TAKE VALUE

              // onTap: () {
              //   if (payable.text == '0') {
              //     payable.text = '';
              //   }
              // },

              onFieldSubmitted: (s) {
                try {
                  employeeDetails[data]['workDay'] =
                      (int.tryParse(attendedDays.text)!);

                  // for (var id
                  //     in employeeDetails.keys
                  //         .toList()) {
                  //   if (30 -
                  //           (employeeDetails[
                  //                       id][
                  //                   'offDay'] ??
                  //               0) ==
                  //       30) {
                  //     employeeDetails[id]
                  //             ['offDay'] =
                  //         (30 -
                  //             int.tryParse(
                  //                 workingDays
                  //                     .text));
                  //   }
                  // }
                } catch (err) {
                  print(err);
                  showUploadMessage(context, 'Unexpected error occurred!!!');
                }
              },

              decoration: InputDecoration(
                border: InputBorder.none,
              ),
              style: FlutterFlowTheme.bodyText2.override(
                fontFamily: 'Montserrat',
                color: Colors.black,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),

          DataCell(
            TextFormField(
              readOnly: closed,
              controller: leave,
              obscureText: false,

              //ADD VALUE TO TAKE VALUE

              // onTap: () {
              //   if (payable.text == '0') {
              //     payable.text = '';
              //   }
              // },

              onFieldSubmitted: (s) {
                try {
                  double oldLeave = employeeDetails[data]['leave'];
                  double workDay = employeeDetails[data]['workDay'];

                  double newLeave = double.tryParse(leave.text) ?? 0;

                  employeeDetails[data]['leave'] = newLeave;
                  print(1);
                  print(workDay);
                  print(newLeave);
                  print(oldLeave);
                  print(workDay - (newLeave - oldLeave));
                  employeeDetails[data]['workDay'] =
                      workDay - (newLeave - oldLeave);
                  print(2);

                  double salary = 0;

                  // if ((leave + ((halfDay + lateCut) * 0.5)) > 5) {
                  //   payable = (basicSalary / 30) * (totalWork - (0.5 * lateCut));
                  // } else {
                  //   payable =
                  //       (basicSalary / 30) * (30 - (leave - ((halfDay + lateCut) * 0.5)));
                  // }

                  if ((employeeDetails[data]['leave'] -
                          (employeeDetails[data]['casualLeave'] ?? 0)) >
                      5) {
                    print(3);
                    print(employeeDetails[data]['workDay']);
                    double bp = basicSalary / 30;
                    salary = (bp) *
                        ((employeeDetails[data]['workDay'] +
                            (employeeDetails[data]['casualLeave'] ?? 0)));
                    print(4);
                  } else {
                    salary = (basicSalary / 30) *
                        (30 -
                            ((employeeDetails[data]['leave'] -
                                (employeeDetails[data]['casualLeave'] ?? 0))));
                  }
                  employeeDetails[data]['payable'] = salary.round();
                  employeeDetails[data]['takeHome'] = (employeeDetails[data]
                              ['payable'] -
                          employeeDetails[data]['deduction']) +
                      (employeeDetails[data]['incentive'] +
                          employeeDetails[data]['ot']);

                  // for (var id
                  //     in employeeDetails.keys
                  //         .toList()) {
                  //   if (30 -
                  //           (employeeDetails[
                  //                       id][
                  //                   'offDay'] ??
                  //               0) ==
                  //       30) {
                  //     employeeDetails[id]
                  //             ['offDay'] =
                  //         (30 -
                  //             int.tryParse(
                  //                 workingDays
                  //                     .text));
                  //   }
                  // }

                  refresh();
                } catch (err) {
                  print('"""""""err"""""""');
                  print(err);
                  showUploadMessage(context, 'Unexpected error occurred!!!');
                }
              },

              decoration: InputDecoration(
                border: InputBorder.none,
              ),
              style: FlutterFlowTheme.bodyText2.override(
                fontFamily: 'Montserrat',
                color: Colors.black,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),

          DataCell(
            TextFormField(
              readOnly: closed,
              controller: casualLeave,
              obscureText: false,

              //ADD VALUE TO TAKE VALUE

              // onTap: () {
              //   if (payable.text == '0') {
              //     payable.text = '';
              //   }
              // },

              onFieldSubmitted: (s) {
                try {
                  employeeDetails[data]['casualLeave'] =
                      double.tryParse(casualLeave.text);

                  double salary = 0;

                  // if ((leave + ((halfDay + lateCut) * 0.5)) > 5) {
                  //   payable = (basicSalary / 30) * (totalWork - (0.5 * lateCut));
                  // } else {
                  //   payable =
                  //       (basicSalary / 30) * (30 - (leave - ((halfDay + lateCut) * 0.5)));
                  // }

                  if ((employeeDetails[data]['leave'] -
                          (employeeDetails[data]['casualLeave'] ?? 0)) >
                      5) {
                    double bp = basicSalary / 30;
                    salary = (bp) *
                        ((employeeDetails[data]['workDay'] +
                            (employeeDetails[data]['casualLeave'] ?? 0)));
                  } else {
                    salary = (basicSalary / 30) *
                        (30 -
                            (employeeDetails[data]['leave'] -
                                (employeeDetails[data]['casualLeave'] ?? 0)));
                  }
                  employeeDetails[data]['payable'] = salary.round();
                  employeeDetails[data]['takeHome'] = (employeeDetails[data]
                              ['payable'] -
                          employeeDetails[data]['deduction']) +
                      (employeeDetails[data]['incentive'] +
                          employeeDetails[data]['ot']);

                  // for (var id
                  //     in employeeDetails.keys
                  //         .toList()) {
                  //   if (30 -
                  //           (employeeDetails[
                  //                       id][
                  //                   'offDay'] ??
                  //               0) ==
                  //       30) {
                  //     employeeDetails[id]
                  //             ['offDay'] =
                  //         (30 -
                  //             int.tryParse(
                  //                 workingDays
                  //                     .text));
                  //   }
                  // }

                  refresh();
                } catch (err) {
                  print(err);
                  showUploadMessage(context, 'Unexpected error occurred!!!');
                }
              },

              decoration: InputDecoration(
                border: InputBorder.none,
              ),
              style: FlutterFlowTheme.bodyText2.override(
                fontFamily: 'Montserrat',
                color: Colors.black,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),

          // DataCell(
          //   Text('$casualLeave',
          //       style: TextStyle(
          //           fontWeight:
          //               FontWeight.bold,
          //           fontSize: 12)),
          // ),

          DataCell(
            Text(basicSalary.toString(),
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
          ),

          /// TEXT FORM FIELD TO INSERT Payable

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
                  if (payable.text != '') {
                    double salary = double.tryParse(payable.text)!;

                    double incentiv = double.tryParse(
                        incentive.text == '' ? '0' : incentive.text)!;

                    double otAmt =
                        double.tryParse(ot.text == '' ? '0' : ot.text)!;

                    double ded = double.tryParse(
                        deduction.text == '' ? '0' : deduction.text)!;

                    employeeDetails[data]['takeHome'] =
                        salary + (incentiv + otAmt) - ded;

                    employeeDetails[data]['payable'] = salary;

                    refresh();
                  } else {
                    double salary = double.tryParse(payable.text)!;

                    double incentiv = double.tryParse(
                        incentive.text == '' ? '0' : payable.text)!;

                    double otAmt =
                        double.tryParse(ot.text == '' ? '0' : payable.text)!;

                    double ded = double.tryParse(
                        deduction.text == '' ? '0' : payable.text)!;

                    employeeDetails[data]['takeHome'] =
                        salary + (incentiv + otAmt) - ded;

                    employeeDetails[data]['payable'] = salary;

                    refresh();
                  }
                } catch (err) {
                  print(err);
                  showUploadMessage(context, 'Provide Only Digit');
                }
              },

              decoration: InputDecoration(
                border: InputBorder.none,
              ),
              style: FlutterFlowTheme.bodyText2.override(
                fontFamily: 'Montserrat',
                color: Colors.black,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),

          /// TEXT FORM FIELD TO INSERT INCENTIVE

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
                    int incentives = double.tryParse(incentive.text)!.round();

                    int pay = employeeDetails[data]['payable'].round();

                    employeeDetails[data]['takeHome'] = pay +
                        (incentives + employeeDetails[data]['ot']) -
                        employeeDetails[data]['deduction'];

                    employeeDetails[data]['incentive'] = incentives;

                    refresh();
                  } else {
                    double incentives = double.tryParse('0')!;
                    double pay = employeeDetails[data]['payable'].round();

                    employeeDetails[data]['takeHome'] = pay +
                        (incentives + employeeDetails[data]['ot']) -
                        employeeDetails[data]['deduction'];

                    employeeDetails[data]['incentive'] = incentives;

                    refresh();
                  }
                } catch (err) {
                  print(err);
                  showUploadMessage(context, 'Provide Only Digit');
                }
              },

              decoration: InputDecoration(
                border: InputBorder.none,
              ),
              style: FlutterFlowTheme.bodyText2.override(
                fontFamily: 'Montserrat',
                color: Colors.black,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),

          /// TEXT FORM FIELD TO INSERT OT

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
                    double otAmount = double.tryParse(ot.text)!;

                    double pay = employeeDetails[data]['payable'].round();

                    employeeDetails[data]['takeHome'] = pay +
                        (otAmount + employeeDetails[data]['incentive']) -
                        employeeDetails[data]['deduction'];

                    employeeDetails[data]['ot'] = otAmount;

                    refresh();
                  } else {
                    double otAmount = double.tryParse('0')!;

                    double pay = employeeDetails[data]['payable'].round();

                    employeeDetails[data]['takeHome'] = pay +
                        (otAmount + employeeDetails[data]['incentive']) -
                        employeeDetails[data]['deduction'];

                    employeeDetails[data]['ot'] = otAmount;

                    refresh();
                  }
                } catch (err) {
                  print(err);
                  showUploadMessage(context, 'Provide Only Digit');
                }
              },

              decoration: InputDecoration(
                border: InputBorder.none,
              ),

              style: FlutterFlowTheme.bodyText2.override(
                fontFamily: 'Montserrat',
                color: Colors.black,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),

          /// TEXT FORM FIELD TO INSERT DEDUCTION

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
                    double deductionAmount = double.tryParse(deduction.text)!;
                    double pay = employeeDetails[data]['payable'].round();

                    employeeDetails[data]['takeHome'] = (pay +
                            (employeeDetails[data]['ot'] ?? 0) +
                            (employeeDetails[data]['incentive'] ?? 0)) -
                        deductionAmount;

                    employeeDetails[data]['deduction'] = deductionAmount;

                    refresh();
                  } else {
                    double deductionAmount = double.tryParse('0')!;

                    double pay = employeeDetails[data]['payable'].round();

                    employeeDetails[data]['takeHome'] =
                        ((pay + employeeDetails[data]['ot']) +
                                (employeeDetails[data]['incentive'] ?? 0)) -
                            deductionAmount;

                    employeeDetails[data]['deduction'] = deductionAmount;

                    refresh();
                  }
                } catch (err) {
                  print(err);
                  showUploadMessage(context, 'Provide Only Digit');
                }
              },

              decoration: InputDecoration(
                border: InputBorder.none,
              ),

              style: FlutterFlowTheme.bodyText2.override(
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
        ]);

    ///
    //   final product = orderDataSemi[index];
    //   DateTime createdDateTime =
    //   orderDataByIdSemi![product['orderId']]['createdTime'].toDate();
    //   String createdDate =
    //       "${DateFormat('dd-MMM-yyyy').format(createdDateTime)} ";
    //   // "${DateFormat.jm().format(DateFormat("hh:mm:ss").parse(DateFormat('hh:mm:ss').format(createdDateTime)))}";
    //   DateTime committedDateTime =
    //   orderDataByIdSemi![product['orderId']]['committedDate'].toDate();
    //   DateTime committedDateTimeFormatted = DateTime(
    //       committedDateTime.year, committedDateTime.month, committedDateTime.day);
    //   String committedDate =
    //       "${DateFormat('dd-MMM-yyyy').format(committedDateTime)} ";
    //   // final differenceInDays = committedDateTimeFormatted
    //   //     .difference(DateTime(
    //   //         DateTime.now().year, DateTime.now().month, DateTime.now().day))
    //   //     .inDays;
    //   return DataRow(
    //       color: index.isOdd
    //           ? MaterialStateProperty.all(
    //           Colors.blueGrey.shade50.withOpacity(0.8))
    //           : MaterialStateProperty.all(Colors.blueGrey.shade100),
    //       cells: [
    //         DataCell(
    //           Text(
    //             "${index + 1}",
    //             style: FlutterFlowTheme.bodyText2.override(
    //               fontFamily: 'Lexend Deca',
    //               color: Colors.black,
    //               fontSize: 12,
    //               fontWeight: FontWeight.bold,
    //             ),
    //           ),
    //         ),
    //         DataCell(
    //           Text(
    //             createdDate,
    //             style: FlutterFlowTheme.bodyText2.override(
    //               fontFamily: 'Lexend Deca',
    //               color: Colors.black,
    //               fontSize: 12,
    //               fontWeight: FontWeight.bold,
    //             ),
    //           ),
    //         ),
    //         DataCell(
    //           Text(
    //             committedDate,
    //             style: FlutterFlowTheme.bodyText2.override(
    //               fontFamily: 'Lexend Deca',
    //               color: Colors.black,
    //               fontSize: 12,
    //               fontWeight: FontWeight.bold,
    //             ),
    //           ),
    //         ),
    //         DataCell(
    //           Text(
    //             product.containsKey("pmnaReceivedDate") &&
    //                 product['pmnaReceivedDate'] != null
    //                 ? DateFormat('dd-MMM-yyyy')
    //                 .format(product['pmnaReceivedDate'].toDate())
    //                 : "",
    //             style: FlutterFlowTheme.bodyText2.override(
    //               fontFamily: 'Lexend Deca',
    //               color: Colors.black,
    //               fontSize: 12,
    //               fontWeight: FontWeight.bold,
    //             ),
    //           ),
    //         ),
    //         DataCell(
    //           Text(
    //             product.containsKey("pmnaStitchedDate") &&
    //                 product['pmnaStitchedDate'] != null
    //                 ? DateFormat('dd-MMM-yyyy')
    //                 .format(product['pmnaStitchedDate'].toDate())
    //                 : "",
    //             style: FlutterFlowTheme.bodyText2.override(
    //               fontFamily: 'Lexend Deca',
    //               color: Colors.black,
    //               fontSize: 12,
    //               fontWeight: FontWeight.bold,
    //             ),
    //           ),
    //         ),
    //         DataCell(Text(
    //             customerDataById[orderDataByIdSemi![product['orderId']]
    //             ['customerId']]['fullName'],
    //             style: FlutterFlowTheme.bodyText2.override(
    //               fontFamily: 'Lexend Deca',
    //               color: Colors.black,
    //               fontSize: 12,
    //               fontWeight: FontWeight.bold,
    //             ),
    //           ),
    //         ),
    //         DataCell(
    //           Text(
    //             customerDataById[orderDataByIdSemi![product['orderId']]
    //             ['customerId']]['mobileNumber'],
    //             style: FlutterFlowTheme.bodyText2.override(
    //               fontFamily: 'Lexend Deca',
    //               color: Colors.black,
    //               fontSize: 12,
    //               fontWeight: FontWeight.bold,
    //             ),
    //           ),
    //         ),
    //         DataCell(
    //           Text(
    //             orderDataByIdSemi![product['orderId']]['orderedBy'] == 'MOA'
    //                 ? 'Online'
    //                 : 'BP',
    //             style: FlutterFlowTheme.bodyText2.override(
    //               fontFamily: 'Lexend Deca',
    //               color: Colors.black,
    //               fontSize: 12,
    //               fontWeight: FontWeight.bold,
    //             ),
    //           ),
    //         ),
    //         DataCell(
    //           Text(
    //             orderDataByIdSemi![product['orderId']]['currencyType'],
    //             style: FlutterFlowTheme.bodyText2.override(
    //               fontFamily: 'Lexend Deca',
    //               color: Colors.black,
    //               fontSize: 12,
    //               fontWeight: FontWeight.bold,
    //             ),
    //           ),
    //         ),
    //         DataCell(Text(
    //           product['productOrderId'],
    //           style: FlutterFlowTheme.bodyText2.override(
    //             fontFamily: 'Lexend Deca',
    //             color: Colors.black,
    //             fontSize: 12,
    //             fontWeight: FontWeight.bold,
    //           ),
    //         )),
    //         DataCell(
    //           Text(
    //             orderDataByIdSemi![product['orderId']]['status'].last['name'],
    //             style: FlutterFlowTheme.bodyText2.override(
    //               fontFamily: 'Lexend Deca',
    //               color: Colors.black,
    //               fontSize: 12,
    //               fontWeight: FontWeight.bold,
    //             ),
    //           ),
    //         ),
    //         DataCell(
    //           FFButtonWidget(
    //             onPressed: () {
    //               showDialog(
    //                 context: context,
    //                 builder: (context) {
    //                   final audioPlayer = ap.AudioPlayer();
    //                   final isPlayingProvider =
    //                   StateProvider<bool>((ref) => false);
    //                   bool isPlaying = false;
    //
    //                   if (product['audioUrl'] != null) {
    //                     audioPlayer.setUrl(product['audioUrl']);
    //                   }
    //                   var width = MediaQuery.of(context).size.width;
    //
    //                   // final audioPlayer =
    //                   //     ap.AudioPlayer();
    //                   // bool
    //                   //     isPlaying =
    //                   //     false;
    //                   // listenAudioPlayer() {
    //                   //   audioPlayer
    //                   //       .onPlayerStateChanged
    //                   //       .listen(
    //                   //           (state) {
    //                   //     setState(
    //                   //         () {
    //                   //       isPlaying =
    //                   //           state == ap.PlayerState.PLAYING;
    //                   //     });
    //                   //   });
    //                   // }
    //                   //
    //                   // listenAudioPlayer();
    //                   // if (product[
    //                   //         'audioUrl'] !=
    //                   //     null) {
    //                   //   audioPlayer
    //                   //       .setUrl(
    //                   //           product['audioUrl']);
    //                   // }
    //                   return Consumer(builder: (context, ref, child) {
    //                     audioPlayer.onPlayerStateChanged.listen((state) {
    //                       if (state == ap.PlayerState.PLAYING) {
    //                         ref.read(isPlayingProvider.notifier).state = true;
    //                       } else if (state == ap.PlayerState.COMPLETED) {
    //                         ref.read(isPlayingProvider.notifier).state = false;
    //                       } else {
    //                         ref.read(isPlayingProvider.notifier).state = false;
    //                       }
    //                     });
    //                     return AlertDialog(
    //                       scrollable: true,
    //                       title: Text('Product Details'),
    //                       content: SizedBox(
    //                         width: 1000,
    //                         child: Container(
    //                           width: double.infinity,
    //                           padding: EdgeInsets.all(20),
    //                           child: Column(
    //                             crossAxisAlignment: CrossAxisAlignment.start,
    //                             children: [
    //                               Row(
    //                                 crossAxisAlignment: CrossAxisAlignment.start,
    //                                 children: [
    //                                   product['referenceImages'].isNotEmpty
    //                                       ? SingleChildScrollView(
    //                                     scrollDirection: Axis.horizontal,
    //                                     child: Padding(
    //                                       padding: EdgeInsets.only(
    //                                         top: MediaQuery.of(context)
    //                                             .size
    //                                             .width *
    //                                             0.02,
    //                                         bottom: MediaQuery.of(context)
    //                                             .size
    //                                             .width *
    //                                             0.02,
    //                                       ),
    //                                       child: Column(
    //                                         children: List.generate(
    //                                             product['referenceImages']
    //                                                 .length, (index) {
    //                                           return Padding(
    //                                             padding:
    //                                             const EdgeInsets.only(
    //                                                 right: 10.0),
    //                                             child: Container(
    //                                               width: 300,
    //                                               child: CachedNetworkImage(
    //                                                   imageUrl: product[
    //                                                   'referenceImages']
    //                                                   [index]),
    //                                             ),
    //                                           );
    //                                         }),
    //                                       ),
    //                                     ),
    //                                   )
    //                                       : SizedBox(),
    //                                   Expanded(
    //                                     child: Padding(
    //                                       padding: EdgeInsets.all(
    //                                           MediaQuery.of(context).size.width *
    //                                               0.02),
    //                                       child: Table(
    //                                         border: TableBorder.all(),
    //                                         children: [
    //                                           TableRow(
    //                                             children: [
    //                                               Padding(
    //                                                 padding:
    //                                                 const EdgeInsets.all(15),
    //                                                 child: Text(
    //                                                   "Item Length " +
    //                                                       isPlaying.toString(),
    //                                                   style: TextStyle(
    //                                                       fontSize: 18,
    //                                                       fontWeight:
    //                                                       FontWeight.w600),
    //                                                 ),
    //                                               ),
    //                                               Padding(
    //                                                 padding:
    //                                                 const EdgeInsets.all(15),
    //                                                 child: Text(
    //                                                   "${product['productLength']}",
    //                                                   style: TextStyle(
    //                                                       fontSize: 18,
    //                                                       fontWeight:
    //                                                       FontWeight.w600),
    //                                                 ),
    //                                               ),
    //                                             ],
    //                                           ),
    //                                           TableRow(
    //                                             children: [
    //                                               Padding(
    //                                                 padding:
    //                                                 const EdgeInsets.all(15),
    //                                                 child: Text(
    //                                                   "Bottom Length",
    //                                                   style: TextStyle(
    //                                                       fontSize: 18,
    //                                                       fontWeight:
    //                                                       FontWeight.w600),
    //                                                 ),
    //                                               ),
    //                                               Padding(
    //                                                 padding:
    //                                                 const EdgeInsets.all(15),
    //                                                 child: Text(
    //                                                   "${product['bottomLength']}",
    //                                                   style: TextStyle(
    //                                                       fontSize: 18,
    //                                                       fontWeight:
    //                                                       FontWeight.w600),
    //                                                 ),
    //                                               ),
    //                                             ],
    //                                           ),
    //                                           TableRow(
    //                                             children: [
    //                                               Padding(
    //                                                 padding:
    //                                                 const EdgeInsets.all(15),
    //                                                 child: Text(
    //                                                   "Shall Length",
    //                                                   style: TextStyle(
    //                                                       fontSize: 18,
    //                                                       fontWeight:
    //                                                       FontWeight.w600),
    //                                                 ),
    //                                               ),
    //                                               Padding(
    //                                                 padding:
    //                                                 const EdgeInsets.all(15),
    //                                                 child: Text(
    //                                                   "${product['shallLength']}",
    //                                                   style: TextStyle(
    //                                                       fontSize: 18,
    //                                                       fontWeight:
    //                                                       FontWeight.w600),
    //                                                 ),
    //                                               ),
    //                                             ],
    //                                           ),
    //                                           TableRow(
    //                                             children: [
    //                                               Padding(
    //                                                 padding:
    //                                                 const EdgeInsets.all(15),
    //                                                 child: Text(
    //                                                   "Chest Length",
    //                                                   style: TextStyle(
    //                                                       fontSize: 18,
    //                                                       fontWeight:
    //                                                       FontWeight.w600),
    //                                                 ),
    //                                               ),
    //                                               Padding(
    //                                                 padding:
    //                                                 const EdgeInsets.all(15),
    //                                                 child: Text(
    //                                                   "${product['chestLength']}",
    //                                                   style: TextStyle(
    //                                                       fontSize: 18,
    //                                                       fontWeight:
    //                                                       FontWeight.w600),
    //                                                 ),
    //                                               ),
    //                                             ],
    //                                           ),
    //                                           TableRow(
    //                                             children: [
    //                                               Padding(
    //                                                 padding:
    //                                                 const EdgeInsets.all(15),
    //                                                 child: Text(
    //                                                   "Color",
    //                                                   style: TextStyle(
    //                                                       fontSize: 18,
    //                                                       fontWeight:
    //                                                       FontWeight.w600),
    //                                                 ),
    //                                               ),
    //                                               Padding(
    //                                                 padding:
    //                                                 const EdgeInsets.all(15),
    //                                                 child: Text(
    //                                                   "${product['colour']}",
    //                                                   style: TextStyle(
    //                                                       fontSize: 18,
    //                                                       fontWeight:
    //                                                       FontWeight.w600),
    //                                                 ),
    //                                               ),
    //                                             ],
    //                                           ),
    //                                           TableRow(
    //                                             children: [
    //                                               Padding(
    //                                                 padding:
    //                                                 const EdgeInsets.all(15),
    //                                                 child: Text(
    //                                                   "Shall Color",
    //                                                   style: TextStyle(
    //                                                       fontSize: 18,
    //                                                       fontWeight:
    //                                                       FontWeight.w600),
    //                                                 ),
    //                                               ),
    //                                               Padding(
    //                                                 padding:
    //                                                 const EdgeInsets.all(15),
    //                                                 child: Text(
    //                                                   "${product['shallColour']}",
    //                                                   style: TextStyle(
    //                                                       fontSize: 18,
    //                                                       fontWeight:
    //                                                       FontWeight.w600),
    //                                                 ),
    //                                               ),
    //                                             ],
    //                                           ),
    //                                           product['frontOpen'] == true
    //                                               ? TableRow(
    //                                             children: [
    //                                               Padding(
    //                                                 padding:
    //                                                 const EdgeInsets
    //                                                     .all(15),
    //                                                 child: Text(
    //                                                   "Front Open",
    //                                                   style: TextStyle(
    //                                                       fontSize: 18,
    //                                                       fontWeight:
    //                                                       FontWeight
    //                                                           .w600),
    //                                                 ),
    //                                               ),
    //                                               Padding(
    //                                                 padding:
    //                                                 const EdgeInsets
    //                                                     .all(15),
    //                                                 child: Text(
    //                                                   "Yes",
    //                                                   style: TextStyle(
    //                                                       fontSize: 18,
    //                                                       color: product[
    //                                                       'frontOpen'] ==
    //                                                           true
    //                                                           ? Colors.black
    //                                                           : Colors.red,
    //                                                       fontWeight:
    //                                                       FontWeight
    //                                                           .w600),
    //                                                 ),
    //                                               ),
    //                                             ],
    //                                           )
    //                                               : TableRow(children: [
    //                                             SizedBox(),
    //                                             SizedBox(),
    //                                           ]),
    //                                           TableRow(
    //                                             children: [
    //                                               Padding(
    //                                                 padding:
    //                                                 const EdgeInsets.all(15),
    //                                                 child: Text(
    //                                                   "Description",
    //                                                   style: TextStyle(
    //                                                       fontSize: 18,
    //                                                       fontWeight:
    //                                                       FontWeight.w600),
    //                                                 ),
    //                                               ),
    //                                               Padding(
    //                                                 padding:
    //                                                 const EdgeInsets.all(15),
    //                                                 child: Text(
    //                                                   product['description'],
    //                                                   style: TextStyle(
    //                                                       fontSize: 18,
    //                                                       fontWeight:
    //                                                       FontWeight.w600),
    //                                                 ),
    //                                               ),
    //                                             ],
    //                                           ),
    //                                           TableRow(
    //                                             children: [
    //                                               Padding(
    //                                                 padding:
    //                                                 const EdgeInsets.all(15),
    //                                                 child: Text(
    //                                                   "Product Price",
    //                                                   style: TextStyle(
    //                                                       fontSize: 18,
    //                                                       fontWeight:
    //                                                       FontWeight.w600),
    //                                                 ),
    //                                               ),
    //                                               Padding(
    //                                                 padding:
    //                                                 const EdgeInsets.all(15),
    //                                                 child: Text(
    //                                                   product['price']
    //                                                       .toStringAsFixed(2),
    //                                                   style: TextStyle(
    //                                                       fontSize: 18,
    //                                                       fontWeight:
    //                                                       FontWeight.w600),
    //                                                 ),
    //                                               ),
    //                                             ],
    //                                           ),
    //                                           TableRow(
    //                                             children: [
    //                                               Padding(
    //                                                 padding:
    //                                                 const EdgeInsets.all(15),
    //                                                 child: Text(
    //                                                   "Addon",
    //                                                   style: TextStyle(
    //                                                       fontSize: 18,
    //                                                       fontWeight:
    //                                                       FontWeight.w600),
    //                                                 ),
    //                                               ),
    //                                               Padding(
    //                                                 padding:
    //                                                 const EdgeInsets.all(15),
    //                                                 child: Text(
    //                                                   product['addons']
    //                                                       .toStringAsFixed(2),
    //                                                   style: TextStyle(
    //                                                       fontSize: 18,
    //                                                       fontWeight:
    //                                                       FontWeight.w600),
    //                                                 ),
    //                                               ),
    //                                             ],
    //                                           ),
    //                                           TableRow(
    //                                             children: [
    //                                               Padding(
    //                                                 padding:
    //                                                 const EdgeInsets.all(15),
    //                                                 child: Text(
    //                                                   "Voice Clip",
    //                                                   style: TextStyle(
    //                                                       fontSize: 18,
    //                                                       fontWeight:
    //                                                       FontWeight.w600),
    //                                                 ),
    //                                               ),
    //                                               Padding(
    //                                                 padding:
    //                                                 const EdgeInsets.all(15),
    //                                                 child: IconButton(
    //                                                   onPressed: () async {
    //                                                     if (ref.watch(
    //                                                         isPlayingProvider)) {
    //                                                       await audioPlayer
    //                                                           .stop();
    //                                                     } else {
    //                                                       await audioPlayer
    //                                                           .resume();
    //                                                     }
    //                                                   },
    //                                                   icon: Icon(ref.watch(
    //                                                       isPlayingProvider)
    //                                                       ? Icons.stop
    //                                                       : Icons.play_arrow),
    //                                                   iconSize: 30,
    //                                                 ),
    //                                               ),
    //                                             ],
    //                                           ),
    //                                         ],
    //                                       ),
    //                                     ),
    //                                   ),
    //                                 ],
    //                               ),
    //                             ],
    //                           ),
    //                         ),
    //                       ),
    //                     );
    //                   });
    //                 },
    //               );
    //             },
    //             text: 'View',
    //             options: FFButtonOptions(
    //               width: 50,
    //               height: 30,
    //               color: Colors.teal,
    //               textStyle: FlutterFlowTheme.subtitle2.override(
    //                   fontFamily: 'Poppins',
    //                   color: Colors.white,
    //                   fontSize: 8,
    //                   fontWeight: FontWeight.bold),
    //               borderSide: BorderSide(
    //                 color: Colors.transparent,
    //                 width: 1,
    //               ),
    //               borderRadius: 8,
    //             ),
    //           ),
    //         ),
    //       ]);
  }
}
