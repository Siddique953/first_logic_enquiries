import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:pie_chart/pie_chart.dart';

import '../../../../flutter_flow/flutter_flow_icon_button.dart';
import '../../../../flutter_flow/flutter_flow_util.dart';
import '../../../pages/home_page/home.dart';

class EmployeeAttendance extends StatefulWidget {
  final String empId;
  final String id;
  final String empName;
  final DateTime date;
  final double totalWork;
  final double holidays;
  final double leave;
  final double half;
  final double late;
  final Map empAttendanceDetails;
  const EmployeeAttendance(
      {Key? key,
     required this.empId,
     required this.id,
     required this.empName,
     required this.date,
     required this.totalWork,
     required this.holidays,
     required this.leave,
     required this.half,
     required this.late, required this.empAttendanceDetails})
      : super(key: key);

  @override
  State<EmployeeAttendance> createState() => _EmployeeAttendanceState();
}

class _EmployeeAttendanceState extends State<EmployeeAttendance> {
  Map<String, dynamic> attendanceDetails = {};
  Map<String, dynamic> attendanceDetailsMap = {};

  // late StreamSubscription attendanceDoc;
  // getPaymentDetails() {
  //   print('"""""""""""""""""""widget.id"""""""""""""""""""');
  //   print(widget.id);
  //   Map attendance = {};
  //  attendanceDoc= FirebaseFirestore.instance
  //       .collection('employees')
  //       .doc(widget.empId)
  //       .collection('attendance')
  //       .doc(widget.id)
  //       // .where('date', isLessThanOrEqualTo: toDate)
  //       // .orderBy('date', descending: false)
  //       .snapshots()
  //       .listen((event) {
  //         if(event.exists){
  //           print('doc existsssssssssssssss');
  //           attendanceDetails = event.data()!;
  //           attendance = event['attendance'];
  //
  //           if (mounted) {
  //             var sortedByKeyMap = Map.fromEntries(attendance.entries.toList()
  //               ..sort((e1, e2) => e1.value['date'].compareTo(e2.value['date'])));
  //             attendanceDetails['attendance'] = sortedByKeyMap;
  //
  //             setState(() {});
  //           }
  //         } else {
  //
  //           print('no  SUB COLL DOcccccccccccccccc');
  //           FirebaseFirestore.instance
  //               .collection('paySlipInfo')
  //               .doc(widget.id).get()
  //               .then((value) {
  //                 print('here');
  //                 print(widget.id);
  //                 if(value.exists){
  //                   print('PAySLIP INFOOOOOOOOOOOO');
  //                   attendance = event['attendanceInfo'][widget.empId];
  //
  //                   var sortedByKeyMap = Map.fromEntries(attendance.entries.toList()
  //                     ..sort((e1, e2) => e1.value['date'].compareTo(e2.value['date'])));
  //                   attendanceDetails['attendance'] = sortedByKeyMap;
  //
  //                 }
  //                 if(mounted) {
  //                   setState(() {
  //
  //                   });
  //                 }
  //           });
  //         }
  //
  //   });
  // }

  bool showChart = true;

  DateTime? fromDate;
  DateTime? toDate;

  int i = 0;

  // Future<void> importData() async {
  //   var excel = Excel.createExcel();
  //
  //   Sheet sheetObject = excel['sales'];
  //   CellStyle cellStyle = CellStyle(
  //     // backgroundColorHex: "#1AFF1A",
  //       fontFamily: getFontFamily(FontFamily.Calibri));
  //
  //   //HEADINGS
  //
  //   if (payments.length > 0) {
  //     var cell1 = sheetObject.cell(CellIndex.indexByString("A1"));
  //     cell1.value = 'SL NO';
  //     cell1.cellStyle = cellStyle;
  //     var cell2 = sheetObject.cell(CellIndex.indexByString("B1"));
  //     cell2.value = 'CUSTOMER ID'; // dynamic values support provided;
  //     cell2.cellStyle = cellStyle;
  //     var cell3 = sheetObject.cell(CellIndex.indexByString("C1"));
  //     cell3.value = 'DATE'; // dynamic values support provided;
  //     cell3.cellStyle = cellStyle;
  //     var cell4 = sheetObject.cell(CellIndex.indexByString("D1"));
  //     cell4.value = 'NAME'; // dynamic values support provided;
  //     cell4.cellStyle = cellStyle;
  //     var cell5 = sheetObject.cell(CellIndex.indexByString("E1"));
  //     cell5.value = 'PROJECT NAME'; // dynamic values support provided;
  //     cell5.cellStyle = cellStyle;
  //     var cell6 = sheetObject.cell(CellIndex.indexByString("F1"));
  //     cell6.value = 'MOBILE'; // dynamic values support provided;
  //     cell6.cellStyle = cellStyle;
  //     var cell7 = sheetObject.cell(CellIndex.indexByString("G1"));
  //     cell7.value = 'MODE OF PAYMENT'; // dynamic values support provided;
  //     cell7.cellStyle = cellStyle;
  //     var cell8 = sheetObject.cell(CellIndex.indexByString("H1"));
  //     cell8.value = 'AMOUNT'; // dynamic values support provided;
  //     cell8.cellStyle = cellStyle;
  //   }
  //
  //   print(payments.length);
  //
  //   //CELL VALUES
  //
  //   for (int i = 0; i < payments.length; i++) {
  //     var cell1 = sheetObject.cell(CellIndex.indexByString("A${i + 2}"));
  //     cell1.value = '${i + 1}'; // dynamic values support provided;
  //     cell1.cellStyle = cellStyle;
  //     var cell2 = sheetObject.cell(CellIndex.indexByString("B${i + 2}"));
  //     cell2.value = payments[i]['customerID']
  //         .toString(); // dynamic values support provided;
  //     cell2.cellStyle = cellStyle;
  //     var cell3 = sheetObject.cell(CellIndex.indexByString("C${i + 2}"));
  //     cell3.value = dateTimeFormat('d-MMM-y',
  //         payments[i]['paidDate'].toDate()); // dynamic values support provided;
  //     cell3.cellStyle = cellStyle;
  //     var cell4 = sheetObject.cell(CellIndex.indexByString("D${i + 2}"));
  //     cell4.value = payments[i]['name']; // dynamic values support provided;
  //     cell4.cellStyle = cellStyle;
  //     var cell5 = sheetObject.cell(CellIndex.indexByString("E${i + 2}"));
  //     cell5.value =
  //     payments[i]['projectName']; // dynamic values support provided;
  //     cell5.cellStyle = cellStyle;
  //     var cell6 = sheetObject.cell(CellIndex.indexByString("F${i + 2}"));
  //     cell6.value = payments[i]['mobile']; // dynamic values support provided;
  //     cell6.cellStyle = cellStyle;
  //     var cell7 = sheetObject.cell(CellIndex.indexByString("G${i + 2}"));
  //     cell7.value = payments[i]['modeOfPayment']
  //         .toString(); // dynamic values support provided;
  //     cell7.cellStyle = cellStyle;
  //     var cell8 = sheetObject.cell(CellIndex.indexByString("H${i + 2}"));
  //     cell8.value =
  //         payments[i]['amount'].toString(); // dynamic values support provided;
  //     cell8.cellStyle = cellStyle;
  //
  //     print("hereeee");
  //
  //     print(payments[i]['studentId'].toString());
  //   }
  //
  //   excel.setDefaultSheet('sales');
  //   var fileBytes = excel.encode();
  //
  //   final content = base64Encode(fileBytes);
  //   final anchor = html.AnchorElement(
  //       href: "data:application/octet-stream;charset=utf-16le;base64,$content")
  //     ..setAttribute(
  //         "download", "${DateTime.now().toString().substring(0, 10)}.xlsx")
  //     ..click();
  // }

  Map<String, double> dataMap = {
    "Holidays": 0,
    "Leave": 0,
    "Present": 0,
  };

  Map <String, double> leaveDataMap ={
    "Full Day": 0,
    "Half Day": 0,
    "Late Cut": 0,
  };

  @override
  void initState() {
    double holidays = widget.holidays;
    double leave = widget.leave;
    double present = widget.totalWork;
    double full = widget.leave - ((widget.half * 0.5) + (widget.late * 0.5));
    double half = widget.half;
    double late = widget.late;

    var sortedByKeyMap = Map.fromEntries( widget.empAttendanceDetails.entries.toList()
      ..sort((e1, e2) => e1.value['date'].compareTo(e2.value['date'])));
    attendanceDetails['attendance'] = sortedByKeyMap;

    dataMap = <String, double>{
      "Holidays": holidays,
      "Leave": leave,
      "Present": present,
    };

    leaveDataMap = <String, double>{
      "Full Day": full,
      "Half Day": half,
      "Late Cut": late,
    };

    super.initState();
    print('[[[[[[[[[[[[[[[[[[[[[[[[date]]]]]]]]]]]]]]]]]]]]]]]]');
    print(widget.date);
    fromDate = widget.date;
    toDate = DateTime(fromDate!.year, fromDate!.month + 1, 0, 23, 59, 59);

    // getPaymentDetails();
  }

  // @override
  // void dispose() {
  //   attendanceDoc.cancel();
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  FlutterFlowIconButton(
                    borderColor: Colors.transparent,
                    borderRadius: 30,
                    borderWidth: 1,
                    buttonSize: 50,
                    icon: const Icon(
                      Icons.arrow_back_ios_new_outlined,
                      color: Colors.blue,
                    ),
                    onPressed: () async {
                      Navigator.pop(context);
                    },
                  ),
                  SizedBox(
                    width: 30,
                  ),
                  Text(
                    dateTimeFormat(
                      'MMMM y',
                      widget.date,
                    ),
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),

              SizedBox(
                height: 10,
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
                        )
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
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(left: 20),
                                  child: Container(
                                    height: 150,
                                    // width:
                                    //     MediaQuery.of(context).size.width * 0.6,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(10.0),
                                          child:  empDataById[widget
                                              .empId]!
                                              .profile ==
                                              '' ||
                                              empDataById[widget
                                                  .empId]!
                                                  .profile ==
                                                  null
                                              ?Container(
                                            height: 130,
                                            width: 130,
                                            decoration: BoxDecoration(
                                                color: Colors.grey,
                                                ),
                                            child: Image.asset('assets/HR Dashboard/emp.png'),
                                          )
                                              :Container(
                                            height: 130,
                                            width: 130,
                                            decoration: BoxDecoration(
                                                color: Colors.grey,
                                                ),
                                            child: Image.network(empDataById[widget
                                                .empId]!
                                                .profile ??
                                                ''),
                                          ),
                                        ),
                                        SizedBox(
                                          width: 20,
                                        ),
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              empDataById[widget.empId]!.name??'Employee',
                                              style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 15,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                            Text(
                                              empDataById[widget.empId]!
                                                  .designation??'DEVELOPER',
                                              style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 18,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                            Text(
                                              empDataById[widget.empId]!.phone??'',
                                              style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 18,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                            Text(
                                              empDataById[widget.empId]!.email??'',
                                              style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 18,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          width: 20,
                                        ),
                                        !showChart
                                            ? SizedBox()
                                            : Padding(
                                                padding:
                                                    const EdgeInsets.all(10.0),
                                                child: PieChart(
                                                  dataMap: dataMap,
                                                  animationDuration:
                                                      Duration(seconds: 2),
                                                  chartLegendSpacing: 32,
                                                  chartRadius: 150,
                                                  colorList: colorList,
                                                  initialAngleInDegree: 0,
                                                  chartType: ChartType.disc,
                                                  ringStrokeWidth: 32,
                                                  centerText: "",
                                                  legendOptions: LegendOptions(
                                                    showLegendsInRow: false,
                                                    legendPosition:
                                                        LegendPosition.right,
                                                    showLegends: true,
                                                    legendShape:
                                                        BoxShape.circle,
                                                    legendTextStyle: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w700,
                                                    ),
                                                  ),
                                                  chartValuesOptions:
                                                      ChartValuesOptions(
                                                    showChartValueBackground:
                                                        false,
                                                    showChartValues: true,
                                                    showChartValuesInPercentage:
                                                        false,
                                                    showChartValuesOutside:
                                                        false,
                                                    decimalPlaces: 1,
                                                  ),
                                                  // gradientList: ---To add gradient colors---
                                                  // emptyColorGradient: ---Empty Color gradient---
                                                ),
                                              ),
                                        SizedBox(
                                          width: 20,
                                        ),
                                        !showChart
                                            ? SizedBox()
                                            : Padding(
                                                padding:
                                                    const EdgeInsets.all(10.0),
                                                child: PieChart(
                                                  dataMap: leaveDataMap,
                                                  animationDuration:
                                                      Duration(seconds: 2),
                                                  chartLegendSpacing: 32,
                                                  chartRadius: 150,
                                                  colorList: leaveColorList,
                                                  initialAngleInDegree: 0,
                                                  chartType: ChartType.disc,
                                                  ringStrokeWidth: 32,
                                                  centerText: "",
                                                  legendOptions: LegendOptions(
                                                    showLegendsInRow: false,
                                                    legendPosition:
                                                        LegendPosition.right,
                                                    showLegends: true,
                                                    legendShape:
                                                        BoxShape.circle,
                                                    legendTextStyle: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w700,
                                                    ),
                                                  ),
                                                  chartValuesOptions:
                                                      ChartValuesOptions(
                                                    showChartValueBackground:
                                                        false,
                                                    showChartValues: true,
                                                    showChartValuesInPercentage:
                                                        false,
                                                    showChartValuesOutside:
                                                        false,
                                                    decimalPlaces: 1,
                                                  ),
                                                  // gradientList: ---To add gradient colors---
                                                  // emptyColorGradient: ---Empty Color gradient---
                                                ),
                                              ),
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
                  ),
                ),
              ),

              SizedBox(
                height: 10,
              ),

              attendanceDetails.entries.isEmpty
                  ? LottieBuilder.network(
                      'https://assets9.lottiefiles.com/packages/lf20_HpFqiS.json',
                      height: 500,
                    )
                  : SizedBox(
                      width: double.infinity,
                      child: DataTable(
                        horizontalMargin: 10,
                        columns: [
                          DataColumn(
                            label: Text(
                              "Date",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 12),
                            ),
                          ),
                          DataColumn(
                            label: Text("In ",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 12)),
                          ),
                          DataColumn(
                            label: Text("Out ",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 12)),
                          ),
                          DataColumn(
                            label: Text("Total Working Hour",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 12)),
                          ),
                          DataColumn(
                            label: Text("Status",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 12)),
                          ),
                        ],
                        rows: List.generate(
                          attendanceDetails['attendance'].length,
                          (index) {
                            int hours = 0;
                            int minuit = 0;

                            String dayIndex = attendanceDetails['attendance']
                                .keys
                                .toList()[index];

                            DateTime day = attendanceDetails['attendance']
                                    [dayIndex]['date']
                                .toDate();
                            String strIn = attendanceDetails['attendance']
                                [dayIndex]['inTime'];
                            String strOut = attendanceDetails['attendance']
                                [dayIndex]['outTime'];

                            DateTime? inTime;
                            DateTime? outTime;

                            try {
                              hours = int.tryParse(
                                  attendanceDetails['attendance'][dayIndex]
                                          ['totalWorkingHour']
                                      .toString()
                                      .split(':')[0])!;
                              minuit = int.tryParse(
                                  attendanceDetails['attendance'][dayIndex]
                                          ['totalWorkingHour']
                                      .toString()
                                      .split(':')[1])!;
                            } catch (e) {
                              hours = 0;
                              minuit = 0;
                            }

                            double workHour = hours + minuit / 60.0;

                            if (strIn != '--:--') {
                              inTime = DateTime(
                                day.year,
                                day.month,
                                day.day,
                                int.tryParse(strIn.split(':')[0])!,
                                int.tryParse(strIn.split(':')[1])!,
                              );

                              outTime = DateTime(
                                day.year,
                                day.month,
                                day.day,
                                int.tryParse(strOut.split(':')[0])!,
                                int.tryParse(strOut.split(':')[1])!,
                              );
                            }

                            return DataRow(
                              color: index.isOdd
                                  ? MaterialStateProperty.all(
                                      Colors.blueGrey.shade50.withOpacity(0.7))
                                  : MaterialStateProperty.all(
                                      Colors.blueGrey.shade50),
                              cells: [
                                DataCell(
                                  Text(
                                    DateFormat('d-MMM-y')
                                        .format(attendanceDetails['attendance']
                                                [dayIndex]['date']
                                            .toDate())
                                        .toString(),
                                    style: TextStyle(
                                      fontFamily: 'Lexend Deca',
                                      color: Colors.black,
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                DataCell(
                                  Text( inTime==null? '--:--':
                                    attendanceDetails['attendance'][dayIndex]
                                                ['inTime'] ==
                                            '--:--'
                                        ? '--:--'
                                        : DateFormat.jm().format(inTime),
                                    style: TextStyle(
                                      fontFamily: 'Lexend Deca',
                                      color: Colors.black,
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                DataCell(
                                  Text(outTime==null? '--:--':
                                    attendanceDetails['attendance'][dayIndex]
                                                ['outTime'] ==
                                            '--:--'
                                        ? '--:--'
                                        : DateFormat.jm().format(outTime),
                                    style: TextStyle(
                                      fontFamily: 'Lexend Deca',
                                      color: Colors.black,
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),

                                DataCell(
                                  Text(
                                    attendanceDetails['attendance'][dayIndex]
                                            ['totalWorkingHour']
                                        // dateTimeFormat(
                                        //         // 'hh:mm',
                                        //         'jm',
                                        //
                                        //             .toDate())
                                        .toString(),
                                    style: TextStyle(
                                      fontFamily: 'Lexend Deca',
                                      color: workHour >= 7.0 && workHour < 7.75
                                          ? Colors.orange
                                          : Colors.black,
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                DataCell(Text(
                                  attendanceDetails['attendance'][dayIndex]
                                              ['halfDay'] ==
                                          true
                                      ? 'HALF DAY'
                                      : attendanceDetails['attendance']
                                                  [dayIndex]['leave'] ==
                                              true
                                          ? 'LEAVE'
                                          : attendanceDetails['attendance']
                                                      [dayIndex]['offDay'] ==
                                                  true
                                              ? 'HOLIDAY'
                                              : 'PRESENT'
                                                  // dateTimeFormat(
                                                  //         // 'hh:mm',
                                                  //         'jm',
                                                  //         attendanceDetails[index]
                                                  //                 ['totalWorkingHour']
                                                  //             .toDate())
                                                  .toString(),
                                  style: TextStyle(
                                    fontFamily: 'Lexend Deca',
                                    color: attendanceDetails['attendance']
                                                [dayIndex]['halfDay'] ==
                                            true
                                        ? Colors.black
                                        : attendanceDetails['attendance']
                                                    [dayIndex]['leave'] ==
                                                true
                                            ? Colors.red
                                            : attendanceDetails['attendance']
                                                        [dayIndex]['offDay'] ==
                                                    true
                                                ? Colors.redAccent
                                                : Colors.teal,
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                  ),
                                )),

                                // DataCell(Text(fileInfo.size)),
                              ],
                            );
                          },
                        ),
                      ),
                    ),
              // payments.length != 0
              //     ? Padding(
              //   padding: const EdgeInsets.only(top: 15, left: 8),
              //   child: TextButton(
              //       child: const Text('Generate Excel'),
              //       style: TextButton.styleFrom(
              //         foregroundColor: Colors.white,
              //         backgroundColor: Color(0xff0054FF),
              //         disabledForegroundColor:
              //         Colors.grey.withOpacity(0.38),
              //       ),
              //       onPressed: () {
              //         try {
              //           importData();
              //         } catch (e) {
              //           print(e);
              //
              //           return showDialog(
              //               context: context,
              //               builder: (context) {
              //                 return AlertDialog(
              //                   title: Text('error'),
              //                   content: Text(e.toString()),
              //                   actions: <Widget>[
              //                     ElevatedButton(
              //                       child: new Text('ok'),
              //                       onPressed: () {
              //                         Navigator.of(context).pop();
              //                       },
              //                     )
              //                   ],
              //                 );
              //               });
              //         }
              //       }),
              // )
              //     : Container(),
            ],
          ),
        ),
      ),
    );
  }

  final colorList = <Color>[
    const Color(0xfffdcb6e),
    // const Color(0xff0984e3),
    const Color(0xfffd79a8),
    const Color(0xffe17055),
    const Color(0xff6c5ce7),
  ];

  final leaveColorList = <Color>[
    const Color.fromRGBO(223, 250, 92, 1),
    // const Color.fromRGBO(129, 250, 112, 1),
    const Color.fromRGBO(129, 182, 205, 1),
    // const Color.fromRGBO(91, 253, 199, 1),
    const Color.fromRGBO(175, 63, 62, 1.0),
    const Color.fromRGBO(254, 154, 92, 1),

    const Color(0xfffdcb6e),
    // const Color(0xff0984e3),
    const Color(0xfffd79a8),
    const Color(0xffe17055),
    const Color(0xff6c5ce7),
  ];

  final legendLabels = <String, String>{
    "Flutter": "Flutter legend",
    "React": "React legend",
    "Xamarin": "Xamarin legend",
    "Ionic": "Ionic legend",
  };
}
