import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:csv/csv.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:month_picker_dialog/month_picker_dialog.dart';

import '../../../../flutter_flow/flutter_flow_util.dart';
import '../../../../flutter_flow/upload_media.dart';
import '../../../app_widget.dart';
import '../../../pages/home_page/home.dart';

class AddAttendancePage extends StatefulWidget {
  final TabController _tabController;
  const AddAttendancePage({
    Key? key,
    required TabController tabController,
  })  : _tabController = tabController,
        super(key: key);

  @override
  State<AddAttendancePage> createState() => _AddAttendancePageState();
}

class _AddAttendancePageState extends State<AddAttendancePage> {
  DateTime? selectedDate ;
  Map employeeAttendance = {};
  Map paySlipInfo = {};

  final toolTipKey = new GlobalKey();



  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    final height = MediaQuery.sizeOf(context).height;
    return Padding(
      padding:  EdgeInsets.all(width * 0.02),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(onPressed: (){
                    widget._tabController.animateTo(5);
                  }, icon: Icon(Icons.arrow_back_ios,size: width*0.02,)),
                  Tooltip(
                    message: 'Please Choose a Month',
                    key: toolTipKey,
                    child: Container(
                      child: Row(
                        children: [
                          GestureDetector(
                            onTap:(){
                              showMonthPicker(context: context, initialDate: DateTime.now(), firstDate: DateTime(2000), lastDate: DateTime.now()).then((value) {
                                if(value!=null){
                                  selectedDate=value;
                                  setState(() {

                                  });
                                }
                              });
                            },
                            child: Container(
                              width: 50,
                              height: 40,
                              decoration: BoxDecoration(
                                  color: Color(0xffD9D9D9),
                                  borderRadius: BorderRadius.circular(10)),
                              child: Icon(
                                Icons.calendar_month_outlined,
                                size: 25,
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 15,
                          ),
                          Text( selectedDate == null?'Please Choose Month':
                            DateFormat('MMMM yyyy')
                                .format(selectedDate!)
                                .toUpperCase(),
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 20,
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
            SizedBox(
              height: 60,
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,

                children: [
                  GestureDetector(
                    onTap: () {
                      if (selectedDate == null) {
                         dynamic tooltip = toolTipKey.currentState;
                        tooltip.ensureTooltipVisible();
                        return showUploadMessage(
                            context, 'Please choose a month');

                      } else {
                        getNewAttendanceFile();
                      }
                    },
                    child: Container(
                      width: width *0.23,
                      height: width *0.2,
                      decoration: BoxDecoration(
                        color: Color(0xffD9D9D9),
                        borderRadius: BorderRadius.circular(width * 0.045),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SvgPicture.asset('assets/HR Dashboard/upload_file.svg'),
                          Text('Upload File',
                              style: TextStyle(
                                fontSize: width * 0.015,
                                fontWeight: FontWeight.w500,
                              )),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  ///LOCAL FUNCTIONS
  void getNewAttendanceFile() async {
    final result = await FilePicker.platform.pickFiles(
      allowMultiple: false,
      type: FileType.custom,
      allowedExtensions: ['csv'],
    );

    if (result == null) return;
    final file = result.files.first;

    Uint8List? bytes = file.bytes;

    showUploadMessage(context, 'File uploaded successfully');
    showUploadMessage(context, 'Reading file data !!', showLoading: true);
    _openFile(file, bytes!);
  }

  /// READ SELECTED CSV FILE AND CREATE ATTENDANCE DETAILS
  late List<List<dynamic>> rowDetail;

  void _openFile(PlatformFile file, Uint8List bytes) async{
    // filename = file.name;

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
          // List toDay = [];
          // rowDetail[j][0].toString().contains('/')
          //     ? toDay = rowDetail[j][0].toString().split('/')
          //     : toDay = rowDetail[j][0].toString().split('-');

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

          late DateTime day;
          try {
            day = DateFormat('dd/MM/yyyy').parse(rowDetail[j][0]);
          } catch (e) {
            day = DateFormat('dd-MM-yyyy').parse(rowDetail[j][0]);
          }
          // DateTime day = DateTime.tryParse(toDay[2] + toDay[1] + toDay[0])!;

          String inTime = rowDetail[j][2].toString();

          String outTime = rowDetail[j][3].toString();

          late double inT  ;
          late double outT  ;
          try {
           final hours = int.tryParse(inTime.split(':')[0])!;
            final minuit = int.tryParse(inTime.split(':')[1])!;

            inT = hours + minuit / 60.0;

          } catch (e) {
            inT = 0;


          }

          try {
           final hours = int.tryParse(outTime.split(':')[0])!;
            final minuit = int.tryParse(outTime.split(':')[1])!;

            outT = hours + minuit / 60.0;

          } catch (e) {
            outT = 0;


          }



          String totalWorkHour = rowDetail[j][4].toString();


          print('======================================');
          print(DateFormat('dd-MM-yyyy').format(day));
          print(empCode);
          print(totalWorkHour);
          print(inT);
          print(outT);
          print(outT-inT);
          print('======================================');

          paySlipInfo[empCode] = {};

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
        }



        paySlipInfo[empCode]['totalDays'] = totalDays;
        paySlipInfo[empCode]['totalWorkDays'] = totalWorkingDays;
        paySlipInfo[empCode]['workDay'] = totalWork - (0.5 * lateCut);
        paySlipInfo[empCode]['offDay'] = cf;
        paySlipInfo[empCode]['lateCut'] = lateCut;
        paySlipInfo[empCode]['halfDay'] = halfDay;
        paySlipInfo[empCode]['casualLeave'] = 0 /*casualLeaves[empCode] ?? 0*/;
        paySlipInfo[empCode]['leave'] = leave + ((halfDay + lateCut) * 0.5);
        paySlipInfo[empCode]['payable'] = payable.round();
        paySlipInfo[empCode]['incentive'] = incentive;
        paySlipInfo[empCode]['ot'] = ot;
        paySlipInfo[empCode]['deduction'] = deduction;
        paySlipInfo[empCode]['takeHome'] =
            (payable - deduction + (incentive + ot)).round();

        // employeeDetailsList.add(employeeDetails);
      }
    }

    await Future.delayed(Duration(milliseconds: 200));
    print('hereeeeeeeeeeeeeeeeeee222222222222222222');
    showUploadMessage(context, 'Data Reading completed successfully');

    showUploadMessage(context, 'Saving new attendance data');
    // uploadFileToFireBase(bytes,
    //     name: dateTimeFormat('dd MMM y', DateTime.now()), ext: 'csv', fileName: file.name);

    createAttendance();
  }

  /// Upload Attendance Details
  Future uploadFileToFireBase(fileBytes,
      {required String name, required String ext,required String fileName}) async {
    // final path='file/${pickFile.name}';
    // final file=File(pickFile.path);

    // final ref=FirebaseStorage.instance.ref().child(path);
    // uploadTask = ref.putFile(file);
    ///
    var uploadTask = FirebaseStorage.instance
        .ref(
            'Pay Slips/${dateTimeFormat('MMMM y', selectedDate!)}/attendanceFile--$name($fileName).$ext')
        .putData(fileBytes);
    final snapshot = await uploadTask.whenComplete(() {});
    final urlDownload = await snapshot.ref.getDownloadURL();

    FirebaseFirestore.instance
        .collection('paySlips')
        .doc(dateTimeFormat('MMMM y', selectedDate!))
        .update({
      'attendanceFile': FieldValue.arrayUnion([urlDownload]),
    }).onError((error, stackTrace) {
      FirebaseFirestore.instance
          .collection('paySlips')
          .doc(dateTimeFormat('MMMM y', selectedDate!))
          .set({
        'attendanceFiles': [urlDownload],
      });
    });
  }

  createAttendance() async {
    Map savedPaySlipInfo = {};
    Map savedAttendanceDetails = {};
    final value = await FirebaseFirestore.instance
        .collection('paySlipInfo')
        .doc(dateTimeFormat('MMMM y', selectedDate!))
        .get();
    if (value.exists) {
      savedPaySlipInfo = value['salaryInfo'];

      ///

      final attendanceDocs =
          await value.reference.collection('attendanceInfo').get();
      for (var i in attendanceDocs.docs) {
        savedAttendanceDetails[i.id] = i['attendance'];
      }
      await Future.delayed(Duration(seconds: 2));

      /// MERGE OLD AND NEW ATTENDANCE FILES
      for (var i in employeeAttendance.keys) {
        print(i);
        Map singleAttendance = employeeAttendance[i];
        for(var d in singleAttendance.keys){
          // print(savedAttendanceDetails[i][d]);
          // print('\n\n');
          // print(employeeAttendance[i][d]);
          if(savedAttendanceDetails[i]==null){
            savedAttendanceDetails[i]={};
          }


          savedAttendanceDetails[i][d]=employeeAttendance[i][d];
        }
      }

      /// MERGE OLD AND NEW PAYSLIPS
      for (var empCode in paySlipInfo.keys) {

        Map singlePayslip = paySlipInfo[empCode];

        if(savedPaySlipInfo[empCode]==null){
          savedPaySlipInfo[empCode]={};
        }

        for(var mapKeys in singlePayslip.keys){
          // savedpaySlipInfo[empCode][d]=paySlipInfo[empCode][d];
          // singlePayslip.update(d, (num value) =>
          //   value+paySlipInfo[empCode][d]
          // ,ifAbsent: paySlipInfo[empCode][d]);

          ///


          late double savedPayslipData;
          late double currentPaySlipData;

          if(savedPaySlipInfo[empCode][mapKeys]==null || savedPaySlipInfo[empCode]==null) {
            savedPayslipData=0;
            // b=0;
          }

          else {
            savedPayslipData = savedPaySlipInfo[empCode]?[mapKeys] ?? 0;

          }

          if(paySlipInfo[empCode][mapKeys]==null || paySlipInfo[empCode]==null) {
            currentPaySlipData=0;
          } else {
            currentPaySlipData = paySlipInfo[empCode]?[mapKeys] ?? 0;
          }

          savedPaySlipInfo[empCode][mapKeys]=savedPayslipData + currentPaySlipData;


        }

        final leave = savedPaySlipInfo[empCode]['leave'];
        final halfDay = savedPaySlipInfo[empCode]['halfDay'];
        final lateCut = savedPaySlipInfo[empCode]['lateCut'];
        final totalWork = savedPaySlipInfo[empCode]['workDay'];
        final basicSalary = double.tryParse(empDataById[empCode]?.ctc??'0')??0;



        if ((leave + ((halfDay + lateCut) * 0.5)) > 5) {
          print('ifffffff');
          print(((basicSalary / 30) * (totalWork - (0.5 * lateCut))).round());
          print((totalWork - (0.5 * lateCut)));
          print(((0.5 * lateCut)));
          // savedPaySlipInfo[empCode]['payable'] = ((basicSalary / 30) * (totalWork - (0.5 * lateCut))).round();
          // savedPaySlipInfo[empCode]['takeHome'] = ((basicSalary / 30) * (totalWork - (0.5 * lateCut))).round();

           savedPaySlipInfo[empCode]['payable'] = ((basicSalary / 30) * (totalWork )).round();
          savedPaySlipInfo[empCode]['takeHome'] = ((basicSalary / 30) * (totalWork )).round();


        } else {
          print('elseeeeee');
          savedPaySlipInfo[empCode]['payable'] = ((basicSalary / 30) * (30 - (leave + ((halfDay + lateCut) * 0.5)))).round();
          savedPaySlipInfo[empCode]['takeHome'] = ((basicSalary / 30) * (30 - (leave + ((halfDay + lateCut) * 0.5)))).round();
        }


      }
       // print('"""""""""""""""""savedAttendanceDetails"""""""""""""""""\n \n');
       // print(savedAttendanceDetails);
       //
       // print('\n\n""""""""""""""""""""savedPaySlipInfo""""""""""""""""""""\n\n');
       // print(savedPaySlipInfo);

      ///

      // uploadAttendance(attendance: savedAttendanceDetails, paySlip: savedPaySlipInfo);
      print('hereeeeeeeeeeeeeeeeeee1111111111111111111111111111');
      await Future.delayed(Duration(seconds: 1));
      showUploadMessage(context, 'Attendance File Successfully Saved ');

    }
    ///
    else {
      // uploadAttendance(attendance: employeeAttendance,paySlip: paySlipInfo);
      await Future.delayed(Duration(seconds: 1));
      showUploadMessage(context, 'Attendance File Successfully Saved ');
    }



  }


  uploadAttendance ({required Map attendance,required Map paySlip})  async {

    FirebaseFirestore.instance
        .collection('paySlipInfo')
        .doc(dateTimeFormat('MMMM y', selectedDate!))
        .set({
      'salaryInfo': paySlip,

      'closed': false,
    });
    for (String i in attendance.keys) {
      FirebaseFirestore.instance
          .collection('paySlipInfo')
          .doc(dateTimeFormat('MMMM y', selectedDate!))
          .collection('attendanceInfo')
          .doc(i)
          .set({
        'attendance': attendance[i],
      });
      FirebaseFirestore.instance
          .collection('employees')
          .doc(i)
          .collection('attendance')
          .doc(dateTimeFormat('MMM y', selectedDate!))
          .set({
        'attendance': attendance[i] ?? {},
        'month': dateTimeFormat('MMM y', selectedDate!),
      });
      FirebaseFirestore.instance
          .collection('employees')
          .doc(i)
          .collection('salaryInfo')
          .doc(dateTimeFormat('MMM y', selectedDate!))
          .set({
        'totalWorkingDays': (paySlip[i]['totalWorkDays']),
        'totalLeave': paySlip[i]['leave'],
        'basicSalary': empDataById[i]?.ctc??0,
        'payableSalary': paySlip[i]['payable'],
        'incentive': paySlip[i]['incentive'],
        'overTime': paySlip[i]['ot'],
        'deduction': paySlip[i]['deduction'],
        'takeHome': paySlip[i]['takeHome'],
        'document': '',
        'month': dateTimeFormat('MMM y', selectedDate!),
      }).whenComplete(() {
        FirebaseFirestore.instance.collection('sendNotification').add({
          'createdDate':FieldValue.serverTimestamp(),
          'name':DateFormat('MMM y').format(selectedDate!)
        });
      });
    }

    print('hereeeeeeeeeeeeeeeeeee');
  }
  
  deleteAttData() {
    print('"""""deleteing"""""');
    FirebaseFirestore.instance.collection('employees').get().then((value) {
      for(DocumentSnapshot doc in value.docs) {
        doc.reference.collection('attendance').doc('Dec 2023').delete();
      }
    });
  }
  
}
