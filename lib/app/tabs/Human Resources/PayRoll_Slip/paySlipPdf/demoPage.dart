// import 'package:fl_erp/app/tabs/Human%20Resources/PayRoll_Slip/paySlipPdf/paySlipModel.dart';
// import 'package:fl_erp/app/tabs/Human%20Resources/PayRoll_Slip/paySlipPdf/paySlipPdf.dart';
// import 'package:flutter/material.dart';
//
// class DemoClass extends StatefulWidget {
//   const DemoClass({Key key}) : super(key: key);
//
//   @override
//   State<DemoClass> createState() => _DemoClassState();
// }
//
// class _DemoClassState extends State<DemoClass> {
//   download() async {
//     PaySlipModel data = PaySlipModel(
//       designation: 'CTO',
//       bankName: 'HDFC BANK',
//       name: 'ABU',
//       total: '30,000',
//       accNumber: '232323232323',
//       advance: '1,000',
//       attended: 25,
//       balanceLeaves: 1,
//       basicPay: '30,000',
//       cityAllow: '',
//       code: 'FL119',
//       dearnessAllo: '',
//       hra: '',
//       incentives: '',
//       leaves: '2',
//       leavesTaken: 2,
//       medicalAlowance: '',
//       month: 'FEB-23',
//       netSalary: '30,000',
//       pan: 'BSED123423',
//       spAllowance: '',
//       totalDeduction: '',
//       workingDays: 26,
//     );
//     PaySlip.downloadPdf(data);
//   }
//
//   @override
//   void initState() {
//     super.initState();
//     download();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Center(
//         child: Column(
//           children: [
//             Container(
//               height: 50,
//               width: 500,
//               decoration: BoxDecoration(
//                   color: Color(0xffD89795),
//                   border: Border.all(width: 1, color: Colors.black)),
//               child: Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   crossAxisAlignment: CrossAxisAlignment.end,
//                   children: [
//                     Padding(
//                       padding: const EdgeInsets.all(5.0),
//                       child: Text('FIRST LOGIC META LAB',
//                           style: TextStyle(
//                               fontSize: 10,
//                               fontWeight: FontWeight.bold,
//                               color: Colors.black)),
//                     )
//                   ]),
//             ),
//             Container(
//               height: 20,
//               decoration: BoxDecoration(
//                   border: Border(
//                 bottom: BorderSide(width: 1, color: Colors.black),
//                 left: BorderSide(width: 1, color: Colors.black),
//                 right: BorderSide(width: 1, color: Colors.black),
//               )),
//               child: Row(
//                 children: [
//                   Container(
//                     width: 300,
//                     decoration: BoxDecoration(
//                         border: Border(
//                       // bottom: BorderSide(width: 1, color: Colors.black),
//                       // left: BorderSide(width: 1, color: Colors.black),
//                       right: BorderSide(width: 1, color: Colors.black),
//                     )),
//                     child: Column(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         crossAxisAlignment: CrossAxisAlignment.center,
//                         children: [
//                           Text('Salary Slip',
//                               style: TextStyle(
//                                   fontSize: 8,
//                                   fontWeight: FontWeight.bold,
//                                   color: Colors.black))
//                         ]),
//                   ),
//                   Container(
//                     width: 200,
//                     decoration: BoxDecoration(
//                         //   border:
//                         //   Border(
//                         //   bottom: BorderSide(width: 1, color: Colors.black),
//                         //   left: BorderSide(width: 1, color: Colors.black),
//                         //   right: BorderSide(width: 1, color: Colors.black),
//                         // )
//                         ),
//                     child: Row(
//                       children: [
//                         Container(
//                           width: 100,
//                           decoration: BoxDecoration(
//                             border: Border(
//                               // bottom: BorderSide(
//                               //     width: 1, color: Colors.black),
//                               // left: BorderSide(
//                               //     width: 1, color: Colors.black),
//                               right: BorderSide(width: 1, color: Colors.black),
//                             ),
//                           ),
//                           child: Column(
//                               mainAxisAlignment: MainAxisAlignment.center,
//                               crossAxisAlignment: CrossAxisAlignment.center,
//                               children: [
//                                 Text('Month',
//                                     style: TextStyle(
//                                         fontSize: 8,
//                                         fontWeight: FontWeight.bold,
//                                         color: Colors.black))
//                               ]),
//                         ),
//                         Container(
//                           width: 100,
//                           // decoration: BoxDecoration(
//                           //     border: Border.all(
//                           //         width: 1, color: Colors.black)),
//                           child: Column(
//                               mainAxisAlignment: MainAxisAlignment.center,
//                               crossAxisAlignment: CrossAxisAlignment.center,
//                               children: [
//                                 Text('FEB-23',
//                                     style: TextStyle(
//                                         fontSize: 8,
//                                         fontWeight: FontWeight.bold,
//                                         color: Colors.black))
//                               ]),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             Container(
//               height: 20,
//               decoration: BoxDecoration(
//                   border: Border(
//                 bottom: BorderSide(width: 1, color: Colors.black),
//                 left: BorderSide(width: 1, color: Colors.black),
//                 right: BorderSide(width: 1, color: Colors.black),
//               )),
//               child: Row(
//                 children: [
//                   Container(
//                     width: 300,
//                     decoration: BoxDecoration(
//                         border: Border(
//                       // bottom: BorderSide(width: 1, color: Colors.black),
//                       // left: BorderSide(width: 1, color: Colors.black),
//                       right: BorderSide(width: 1, color: Colors.black),
//                     )),
//                     child: Row(
//                       children: [
//                         Container(
//                           width: 80,
//                           decoration: BoxDecoration(
//                               border: Border(
//                             // bottom: BorderSide(width: 1, color: Colors.black),
//                             // left: BorderSide(width: 1, color: Colors.black),
//                             right: BorderSide(width: 1, color: Colors.black),
//                           )),
//                           child: Column(
//                               mainAxisAlignment: MainAxisAlignment.center,
//                               crossAxisAlignment: CrossAxisAlignment.center,
//                               children: [
//                                 Text('Employee Name',
//                                     style: TextStyle(
//                                         fontSize: 7, color: Colors.black))
//                               ]),
//                         ),
//                         Container(
//                           width: 120,
//                           decoration: BoxDecoration(
//                               border: Border(
//                             // bottom: BorderSide(width: 1, color: Colors.black),
//                             // left: BorderSide(width: 1, color: Colors.black),
//                             right: BorderSide(width: 1, color: Colors.black),
//                           )),
//                           child: Column(
//                               mainAxisAlignment: MainAxisAlignment.center,
//                               crossAxisAlignment: CrossAxisAlignment.center,
//                               children: [
//                                 Text('NITHIN PD',
//                                     style: TextStyle(
//                                         fontSize: 7, color: Colors.black))
//                               ]),
//                         ),
//                         Container(
//                           width: 100,
//                           child: Column(
//                               mainAxisAlignment: MainAxisAlignment.center,
//                               crossAxisAlignment: CrossAxisAlignment.center,
//                               children: [
//                                 Text('Total Working Days',
//                                     style: TextStyle(
//                                         fontSize: 7, color: Colors.black))
//                               ]),
//                         ),
//                       ],
//                     ),
//                   ),
//                   Container(
//                     width: 200,
//                     decoration: BoxDecoration(
//                         //   border:
//                         //   Border(
//                         //   bottom: BorderSide(width: 1, color: Colors.black),
//                         //   left: BorderSide(width: 1, color: Colors.black),
//                         //   right: BorderSide(width: 1, color: Colors.black),
//                         // )
//                         ),
//                     child: Row(
//                       children: [
//                         Expanded(
//                           child: Container(
//                             // decoration: BoxDecoration(
//                             //     border: Border.all(
//                             //         width: 1, color: Colors.black)),
//                             child: Column(
//                                 mainAxisAlignment: MainAxisAlignment.center,
//                                 crossAxisAlignment: CrossAxisAlignment.center,
//                                 children: [
//                                   Text('26',
//                                       style: TextStyle(
//                                           fontSize: 7, color: Colors.black))
//                                 ]),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             Container(
//               height: 20,
//               decoration: BoxDecoration(
//                   border: Border(
//                 bottom: BorderSide(width: 1, color: Colors.black),
//                 left: BorderSide(width: 1, color: Colors.black),
//                 right: BorderSide(width: 1, color: Colors.black),
//               )),
//               child: Row(
//                 children: [
//                   Container(
//                     width: 300,
//                     decoration: BoxDecoration(
//                         border: Border(
//                       // bottom: BorderSide(width: 1, color: Colors.black),
//                       // left: BorderSide(width: 1, color: Colors.black),
//                       right: BorderSide(width: 1, color: Colors.black),
//                     )),
//                     child: Row(
//                       children: [
//                         Container(
//                           width: 80,
//                           decoration: BoxDecoration(
//                               border: Border(
//                             // bottom: BorderSide(width: 1, color: Colors.black),
//                             // left: BorderSide(width: 1, color: Colors.black),
//                             right: BorderSide(width: 1, color: Colors.black),
//                           )),
//                           child: Column(
//                               mainAxisAlignment: MainAxisAlignment.center,
//                               crossAxisAlignment: CrossAxisAlignment.center,
//                               children: [
//                                 Text('Employee Code',
//                                     style: TextStyle(
//                                         fontSize: 7, color: Colors.black))
//                               ]),
//                         ),
//                         Container(
//                           width: 120,
//                           decoration: BoxDecoration(
//                               border: Border(
//                             // bottom: BorderSide(width: 1, color: Colors.black),
//                             // left: BorderSide(width: 1, color: Colors.black),
//                             right: BorderSide(width: 1, color: Colors.black),
//                           )),
//                           child: Column(
//                               mainAxisAlignment: MainAxisAlignment.center,
//                               crossAxisAlignment: CrossAxisAlignment.center,
//                               children: [
//                                 Text('FL110',
//                                     style: TextStyle(
//                                         fontSize: 7, color: Colors.black))
//                               ]),
//                         ),
//                         Container(
//                           width: 100,
//                           child: Column(
//                               mainAxisAlignment: MainAxisAlignment.center,
//                               crossAxisAlignment: CrossAxisAlignment.center,
//                               children: [
//                                 Text('Number of Working Days Attended',
//                                     style: TextStyle(
//                                         fontSize: 7, color: Colors.black))
//                               ]),
//                         ),
//                       ],
//                     ),
//                   ),
//                   Container(
//                     width: 200,
//                     decoration: BoxDecoration(
//                         //   border:
//                         //   Border(
//                         //   bottom: BorderSide(width: 1, color: Colors.black),
//                         //   left: BorderSide(width: 1, color: Colors.black),
//                         //   right: BorderSide(width: 1, color: Colors.black),
//                         // )
//                         ),
//                     child: Row(
//                       children: [
//                         Expanded(
//                           child: Container(
//                             // decoration: BoxDecoration(
//                             //     border: Border.all(
//                             //         width: 1, color: Colors.black)),
//                             child: Column(
//                                 mainAxisAlignment: MainAxisAlignment.center,
//                                 crossAxisAlignment: CrossAxisAlignment.center,
//                                 children: [
//                                   Text('26',
//                                       style: TextStyle(
//                                           fontSize: 7, color: Colors.black))
//                                 ]),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             Container(
//               height: 20,
//               decoration: BoxDecoration(
//                   border: Border(
//                 bottom: BorderSide(width: 1, color: Colors.black),
//                 left: BorderSide(width: 1, color: Colors.black),
//                 right: BorderSide(width: 1, color: Colors.black),
//               )),
//               child: Row(
//                 children: [
//                   Container(
//                     width: 300,
//                     decoration: BoxDecoration(
//                         border: Border(
//                       // bottom: BorderSide(width: 1, color: Colors.black),
//                       // left: BorderSide(width: 1, color: Colors.black),
//                       right: BorderSide(width: 1, color: Colors.black),
//                     )),
//                     child: Row(
//                       children: [
//                         Container(
//                           width: 80,
//                           decoration: BoxDecoration(
//                               border: Border(
//                             // bottom: BorderSide(width: 1, color: Colors.black),
//                             // left: BorderSide(width: 1, color: Colors.black),
//                             right: BorderSide(width: 1, color: Colors.black),
//                           )),
//                           child: Column(
//                               mainAxisAlignment: MainAxisAlignment.center,
//                               crossAxisAlignment: CrossAxisAlignment.center,
//                               children: [
//                                 Text('Designation',
//                                     style: TextStyle(
//                                         fontSize: 7, color: Colors.black))
//                               ]),
//                         ),
//                         Container(
//                           width: 120,
//                           decoration: BoxDecoration(
//                               border: Border(
//                             // bottom: BorderSide(width: 1, color: Colors.black),
//                             // left: BorderSide(width: 1, color: Colors.black),
//                             right: BorderSide(width: 1, color: Colors.black),
//                           )),
//                           child: Column(
//                               mainAxisAlignment: MainAxisAlignment.center,
//                               crossAxisAlignment: CrossAxisAlignment.center,
//                               children: [
//                                 Text('Software Developer',
//                                     style: TextStyle(
//                                         fontSize: 7, color: Colors.black))
//                               ]),
//                         ),
//                         Container(
//                           width: 100,
//                           child: Column(
//                               mainAxisAlignment: MainAxisAlignment.center,
//                               crossAxisAlignment: CrossAxisAlignment.center,
//                               children: [
//                                 Text('',
//                                     style: TextStyle(
//                                         fontSize: 7, color: Colors.black))
//                               ]),
//                         ),
//                       ],
//                     ),
//                   ),
//                   Container(
//                     width: 200,
//                     decoration: BoxDecoration(
//                         //   border:
//                         //   Border(
//                         //   bottom: BorderSide(width: 1, color: Colors.black),
//                         //   left: BorderSide(width: 1, color: Colors.black),
//                         //   right: BorderSide(width: 1, color: Colors.black),
//                         // )
//                         ),
//                     child: Row(
//                       children: [
//                         Expanded(
//                           child: Container(
//                             // decoration: BoxDecoration(
//                             //     border: Border.all(
//                             //         width: 1, color: Colors.black)),
//                             child: Column(
//                                 mainAxisAlignment: MainAxisAlignment.center,
//                                 crossAxisAlignment: CrossAxisAlignment.center,
//                                 children: [
//                                   Text('',
//                                       style: TextStyle(
//                                           fontSize: 7, color: Colors.black))
//                                 ]),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//
//             Container(
//               height: 20,
//               decoration: BoxDecoration(
//                   border: Border(
//                 bottom: BorderSide(width: 1, color: Colors.black),
//                 left: BorderSide(width: 1, color: Colors.black),
//                 right: BorderSide(width: 1, color: Colors.black),
//               )),
//               child: Row(
//                 children: [
//                   Container(
//                     width: 300,
//                     decoration: BoxDecoration(
//                         border: Border(
//                       // bottom: BorderSide(width: 1, color: Colors.black),
//                       // left: BorderSide(width: 1, color: Colors.black),
//                       right: BorderSide(width: 1, color: Colors.black),
//                     )),
//                     child: Row(
//                       children: [
//                         Container(
//                           width: 80,
//                           decoration: BoxDecoration(
//                               border: Border(
//                             // bottom: BorderSide(width: 1, color: Colors.black),
//                             // left: BorderSide(width: 1, color: Colors.black),
//                             right: BorderSide(width: 1, color: Colors.black),
//                           )),
//                           child: Column(
//                               mainAxisAlignment: MainAxisAlignment.center,
//                               crossAxisAlignment: CrossAxisAlignment.center,
//                               children: [
//                                 Text('PAN',
//                                     style: TextStyle(
//                                         fontSize: 7, color: Colors.black))
//                               ]),
//                         ),
//                         Container(
//                           width: 120,
//                           decoration: BoxDecoration(
//                               border: Border(
//                             // bottom: BorderSide(width: 1, color: Colors.black),
//                             // left: BorderSide(width: 1, color: Colors.black),
//                             right: BorderSide(width: 1, color: Colors.black),
//                           )),
//                           child: Column(
//                               mainAxisAlignment: MainAxisAlignment.center,
//                               crossAxisAlignment: CrossAxisAlignment.center,
//                               children: [
//                                 Text('EDFGHT57789',
//                                     style: TextStyle(
//                                         fontSize: 7, color: Colors.black))
//                               ]),
//                         ),
//                         Container(
//                           width: 100,
//                           child: Column(
//                               mainAxisAlignment: MainAxisAlignment.center,
//                               crossAxisAlignment: CrossAxisAlignment.center,
//                               children: [
//                                 Text('Leaves',
//                                     style: TextStyle(
//                                         fontSize: 6,
//                                         fontWeight: FontWeight.bold,
//                                         color: Colors.black))
//                               ]),
//                         ),
//                       ],
//                     ),
//                   ),
//                   Container(
//                     width: 200,
//                     decoration: BoxDecoration(
//                         //   border:
//                         //   Border(
//                         //   bottom: BorderSide(width: 1, color: Colors.black),
//                         //   left: BorderSide(width: 1, color: Colors.black),
//                         //   right: BorderSide(width: 1, color: Colors.black),
//                         // )
//                         ),
//                     child: Row(
//                       children: [
//                         Container(
//                           width: 100,
//                           decoration: BoxDecoration(
//                             border: Border(
//                               // bottom: BorderSide(
//                               //     width: 1, color: Colors.black),
//                               // left: BorderSide(
//                               //     width: 1, color: Colors.black),
//                               right: BorderSide(width: 1, color: Colors.black),
//                             ),
//                           ),
//                           child: Column(
//                               mainAxisAlignment: MainAxisAlignment.center,
//                               crossAxisAlignment: CrossAxisAlignment.center,
//                               children: [
//                                 Text('P',
//                                     style: TextStyle(
//                                         fontSize: 8,
//                                         fontWeight: FontWeight.bold,
//                                         color: Colors.black))
//                               ]),
//                         ),
//                         Container(
//                           width: 100,
//                           // decoration: BoxDecoration(
//                           //     border: Border.all(
//                           //         width: 1, color: Colors.black)),
//                           child: Column(
//                               mainAxisAlignment: MainAxisAlignment.center,
//                               crossAxisAlignment: CrossAxisAlignment.center,
//                               children: [
//                                 Text('S',
//                                     style: TextStyle(
//                                         fontSize: 8,
//                                         fontWeight: FontWeight.bold,
//                                         color: Colors.black))
//                               ]),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             Container(
//               height: 20,
//               decoration: BoxDecoration(
//                   border: Border(
//                 bottom: BorderSide(width: 1, color: Colors.black),
//                 left: BorderSide(width: 1, color: Colors.black),
//                 right: BorderSide(width: 1, color: Colors.black),
//               )),
//               child: Row(
//                 children: [
//                   Container(
//                     width: 300,
//                     decoration: BoxDecoration(
//                         border: Border(
//                       // bottom: BorderSide(width: 1, color: Colors.black),
//                       // left: BorderSide(width: 1, color: Colors.black),
//                       right: BorderSide(width: 1, color: Colors.black),
//                     )),
//                     child: Row(
//                       children: [
//                         Container(
//                           width: 80,
//                           decoration: BoxDecoration(
//                               border: Border(
//                             // bottom: BorderSide(width: 1, color: Colors.black),
//                             // left: BorderSide(width: 1, color: Colors.black),
//                             right: BorderSide(width: 1, color: Colors.black),
//                           )),
//                           child: Column(
//                               mainAxisAlignment: MainAxisAlignment.center,
//                               crossAxisAlignment: CrossAxisAlignment.center,
//                               children: [
//                                 Text('Account Number',
//                                     style: TextStyle(
//                                         fontSize: 7, color: Colors.black))
//                               ]),
//                         ),
//                         Container(
//                           width: 120,
//                           decoration: BoxDecoration(
//                               border: Border(
//                             // bottom: BorderSide(width: 1, color: Colors.black),
//                             // left: BorderSide(width: 1, color: Colors.black),
//                             right: BorderSide(width: 1, color: Colors.black),
//                           )),
//                           child: Column(
//                               mainAxisAlignment: MainAxisAlignment.center,
//                               crossAxisAlignment: CrossAxisAlignment.center,
//                               children: [
//                                 Text('12334456567',
//                                     style: TextStyle(
//                                         fontSize: 7, color: Colors.black))
//                               ]),
//                         ),
//                         Container(
//                           width: 100,
//                           child: Column(
//                               mainAxisAlignment: MainAxisAlignment.center,
//                               crossAxisAlignment: CrossAxisAlignment.center,
//                               children: [
//                                 Text('Leaves Taken',
//                                     style: TextStyle(
//                                         fontSize: 6,
//                                         fontWeight: FontWeight.bold,
//                                         color: Colors.black))
//                               ]),
//                         ),
//                       ],
//                     ),
//                   ),
//                   Container(
//                     width: 200,
//                     decoration: BoxDecoration(
//                         //   border:
//                         //   Border(
//                         //   bottom: BorderSide(width: 1, color: Colors.black),
//                         //   left: BorderSide(width: 1, color: Colors.black),
//                         //   right: BorderSide(width: 1, color: Colors.black),
//                         // )
//                         ),
//                     child: Row(
//                       children: [
//                         Container(
//                           width: 100,
//                           decoration: BoxDecoration(
//                             border: Border(
//                               // bottom: BorderSide(
//                               //     width: 1, color: Colors.black),
//                               // left: BorderSide(
//                               //     width: 1, color: Colors.black),
//                               right: BorderSide(width: 1, color: Colors.black),
//                             ),
//                           ),
//                           child: Column(
//                               mainAxisAlignment: MainAxisAlignment.center,
//                               crossAxisAlignment: CrossAxisAlignment.center,
//                               children: [
//                                 Text('0',
//                                     style: TextStyle(
//                                         fontSize: 8,
//                                         fontWeight: FontWeight.bold,
//                                         color: Colors.black))
//                               ]),
//                         ),
//                         Container(
//                           width: 100,
//                           // decoration: BoxDecoration(
//                           //     border: Border.all(
//                           //         width: 1, color: Colors.black)),
//                           child: Column(
//                               mainAxisAlignment: MainAxisAlignment.center,
//                               crossAxisAlignment: CrossAxisAlignment.center,
//                               children: [
//                                 Text('0',
//                                     style: TextStyle(
//                                         fontSize: 8,
//                                         fontWeight: FontWeight.bold,
//                                         color: Colors.black))
//                               ]),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             Container(
//               height: 20,
//               decoration: BoxDecoration(
//                   border: Border(
//                 bottom: BorderSide(width: 1, color: Colors.black),
//                 left: BorderSide(width: 1, color: Colors.black),
//                 right: BorderSide(width: 1, color: Colors.black),
//               )),
//               child: Row(
//                 children: [
//                   Container(
//                     width: 300,
//                     decoration: BoxDecoration(
//                         border: Border(
//                       // bottom: BorderSide(width: 1, color: Colors.black),
//                       // left: BorderSide(width: 1, color: Colors.black),
//                       right: BorderSide(width: 1, color: Colors.black),
//                     )),
//                     child: Row(
//                       children: [
//                         Container(
//                           width: 80,
//                           decoration: BoxDecoration(
//                               border: Border(
//                             // bottom: BorderSide(width: 1, color: Colors.black),
//                             // left: BorderSide(width: 1, color: Colors.black),
//                             right: BorderSide(width: 1, color: Colors.black),
//                           )),
//                           child: Column(
//                               mainAxisAlignment: MainAxisAlignment.center,
//                               crossAxisAlignment: CrossAxisAlignment.center,
//                               children: [
//                                 Text('Bank Name',
//                                     style: TextStyle(
//                                         fontSize: 7, color: Colors.black))
//                               ]),
//                         ),
//                         Container(
//                           width: 120,
//                           decoration: BoxDecoration(
//                               border: Border(
//                             // bottom: BorderSide(width: 1, color: Colors.black),
//                             // left: BorderSide(width: 1, color: Colors.black),
//                             right: BorderSide(width: 1, color: Colors.black),
//                           )),
//                           child: Column(
//                               mainAxisAlignment: MainAxisAlignment.center,
//                               crossAxisAlignment: CrossAxisAlignment.center,
//                               children: [
//                                 Text('HDFC BANK',
//                                     style: TextStyle(
//                                         fontSize: 7, color: Colors.black))
//                               ]),
//                         ),
//                         Container(
//                           width: 100,
//                           child: Column(
//                               mainAxisAlignment: MainAxisAlignment.center,
//                               crossAxisAlignment: CrossAxisAlignment.center,
//                               children: [
//                                 Text('Balance Leaves',
//                                     style: TextStyle(
//                                         fontSize: 6,
//                                         fontWeight: FontWeight.bold,
//                                         color: Colors.black))
//                               ]),
//                         ),
//                       ],
//                     ),
//                   ),
//                   Container(
//                     width: 200,
//                     decoration: BoxDecoration(
//                         //   border:
//                         //   Border(
//                         //   bottom: BorderSide(width: 1, color: Colors.black),
//                         //   left: BorderSide(width: 1, color: Colors.black),
//                         //   right: BorderSide(width: 1, color: Colors.black),
//                         // )
//                         ),
//                     child: Row(
//                       children: [
//                         Container(
//                           width: 100,
//                           decoration: BoxDecoration(
//                             border: Border(
//                               // bottom: BorderSide(
//                               //     width: 1, color: Colors.black),
//                               // left: BorderSide(
//                               //     width: 1, color: Colors.black),
//                               right: BorderSide(width: 1, color: Colors.black),
//                             ),
//                           ),
//                           child: Column(
//                               mainAxisAlignment: MainAxisAlignment.center,
//                               crossAxisAlignment: CrossAxisAlignment.center,
//                               children: [
//                                 Text('',
//                                     style: TextStyle(
//                                         fontSize: 8,
//                                         fontWeight: FontWeight.bold,
//                                         color: Colors.black))
//                               ]),
//                         ),
//                         Container(
//                           width: 100,
//                           // decoration: BoxDecoration(
//                           //     border: Border.all(
//                           //         width: 1, color: Colors.black)),
//                           child: Column(
//                               mainAxisAlignment: MainAxisAlignment.center,
//                               crossAxisAlignment: CrossAxisAlignment.center,
//                               children: [
//                                 Text('',
//                                     style: TextStyle(
//                                         fontSize: 8,
//                                         fontWeight: FontWeight.bold,
//                                         color: Colors.black))
//                               ]),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//
//             Container(
//               height: 20,
//               decoration: BoxDecoration(
//                   border: Border(
//                 bottom: BorderSide(width: 1, color: Colors.black),
//                 left: BorderSide(width: 1, color: Colors.black),
//                 right: BorderSide(width: 1, color: Colors.black),
//               )),
//             ),
//
//             /// INCOME AND DEDUCTIONS
//             Container(
//               height: 20,
//               decoration: BoxDecoration(
//                   border: Border(
//                 bottom: BorderSide(width: 1, color: Colors.black),
//                 left: BorderSide(width: 1, color: Colors.black),
//                 right: BorderSide(width: 1, color: Colors.black),
//               )),
//               child: Row(
//                 children: [
//                   Container(
//                     width: 250,
//                     decoration: BoxDecoration(
//                         border: Border(
//                       // bottom: BorderSide(width: 1, color: Colors.black),
//                       // left: BorderSide(width: 1, color: Colors.black),
//                       right: BorderSide(width: 1, color: Colors.black),
//                     )),
//                     child: Column(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         crossAxisAlignment: CrossAxisAlignment.center,
//                         children: [
//                           Text('Income',
//                               style: TextStyle(
//                                   fontSize: 7,
//                                   fontWeight: FontWeight.bold,
//                                   color: Colors.black))
//                         ]),
//                   ),
//                   Container(
//                     width: 250,
//                     decoration: BoxDecoration(
//                         //   border:
//                         //   Border(
//                         //   bottom: BorderSide(width: 1, color: Colors.black),
//                         //   left: BorderSide(width: 1, color: Colors.black),
//                         //   right: BorderSide(width: 1, color: Colors.black),
//                         // )
//                         ),
//                     child: Column(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         crossAxisAlignment: CrossAxisAlignment.center,
//                         children: [
//                           Text('Deductions',
//                               style: TextStyle(
//                                   fontSize: 7,
//                                   fontWeight: FontWeight.bold,
//                                   color: Colors.black))
//                         ]),
//                   ),
//                 ],
//               ),
//             ),
//
//             ///SUB HEAD
//
//             Container(
//               height: 20,
//               decoration: BoxDecoration(
//                   border: Border(
//                 bottom: BorderSide(width: 1, color: Colors.black),
//                 left: BorderSide(width: 1, color: Colors.black),
//                 right: BorderSide(width: 1, color: Colors.black),
//               )),
//               child: Row(
//                 children: [
//                   Container(
//                     width: 125,
//                     decoration: BoxDecoration(
//                         border: Border(
//                       // bottom: BorderSide(width: 1, color: Colors.black),
//                       // left: BorderSide(width: 1, color: Colors.black),
//                       right: BorderSide(width: 1, color: Colors.black),
//                     )),
//                     child: Column(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         crossAxisAlignment: CrossAxisAlignment.center,
//                         children: [
//                           Text('Particulars',
//                               style:
//                                   TextStyle(fontSize: 7, color: Colors.black))
//                         ]),
//                   ),
//                   Container(
//                     width: 125,
//                     decoration: BoxDecoration(
//                         border: Border(
//                       // bottom: BorderSide(width: 1, color: Colors.black),
//                       // left: BorderSide(width: 1, color: Colors.black),
//                       right: BorderSide(width: 1, color: Colors.black),
//                     )),
//                     child: Column(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         crossAxisAlignment: CrossAxisAlignment.center,
//                         children: [
//                           Text('Amount',
//                               style:
//                                   TextStyle(fontSize: 7, color: Colors.black))
//                         ]),
//                   ),
//                   Container(
//                     width: 125,
//                     decoration: BoxDecoration(
//                         border: Border(
//                       // bottom: BorderSide(width: 1, color: Colors.black),
//                       // left: BorderSide(width: 1, color: Colors.black),
//                       right: BorderSide(width: 1, color: Colors.black),
//                     )),
//                     child: Column(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         crossAxisAlignment: CrossAxisAlignment.center,
//                         children: [
//                           Text('Particulars',
//                               style:
//                                   TextStyle(fontSize: 7, color: Colors.black))
//                         ]),
//                   ),
//                   Container(
//                     width: 125,
//                     child: Column(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         crossAxisAlignment: CrossAxisAlignment.center,
//                         children: [
//                           Text('Amount',
//                               style:
//                                   TextStyle(fontSize: 7, color: Colors.black))
//                         ]),
//                   ),
//                 ],
//               ),
//             ),
//
//             ///CONTENTS
//             Container(
//               width: 500,
//               height: 20,
//               decoration: BoxDecoration(
//                   border: Border(
//                 bottom: BorderSide(width: 1, color: Colors.black),
//                 left: BorderSide(width: 1, color: Colors.black),
//                 right: BorderSide(width: 1, color: Colors.black),
//               )),
//               child: Row(
//                 children: [
//                   Container(
//                     width: 125,
//                     decoration: BoxDecoration(
//                         border: Border(
//                       // bottom: BorderSide(width: 1, color: Colors.black),
//                       // left: BorderSide(width: 1, color: Colors.black),
//                       right: BorderSide(width: 1, color: Colors.black),
//                     )),
//                     child: Column(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Padding(
//                             padding: const EdgeInsets.only(left: 3.0),
//                             child: Text('Basic Salary',
//                                 style: TextStyle(
//                                     fontSize: 7, color: Colors.black)),
//                           )
//                         ]),
//                   ),
//                   Container(
//                     width: 125,
//                     decoration: BoxDecoration(
//                         border: Border(
//                       // bottom: BorderSide(width: 1, color: Colors.black),
//                       // left: BorderSide(width: 1, color: Colors.black),
//                       right: BorderSide(width: 1, color: Colors.black),
//                     )),
//                     child: Column(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         crossAxisAlignment: CrossAxisAlignment.end,
//                         children: [
//                           Padding(
//                             padding: const EdgeInsets.only(right: 3.0),
//                             child: Text('30,000',
//                                 style: TextStyle(
//                                     fontSize: 7, color: Colors.black)),
//                           )
//                         ]),
//                   ),
//                   Container(
//                     width: 125,
//                     decoration: BoxDecoration(
//                         border: Border(
//                       // bottom: BorderSide(width: 1, color: Colors.black),
//                       // left: BorderSide(width: 1, color: Colors.black),
//                       right: BorderSide(width: 1, color: Colors.black),
//                     )),
//                     child: Column(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Padding(
//                             padding: const EdgeInsets.only(left: 3.0),
//                             child: Text('Advance',
//                                 style: TextStyle(
//                                     fontSize: 7, color: Colors.black)),
//                           )
//                         ]),
//                   ),
//                   Container(
//                     width: 100,
//                     child: Column(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         crossAxisAlignment: CrossAxisAlignment.end,
//                         children: [
//                           Text('7,000',
//                               style:
//                                   TextStyle(fontSize: 7, color: Colors.black))
//                         ]),
//                   ),
//                 ],
//               ),
//             ),
//             Container(
//               height: 20,
//               decoration: BoxDecoration(
//                   border: Border(
//                 bottom: BorderSide(width: 1, color: Colors.black),
//                 left: BorderSide(width: 1, color: Colors.black),
//                 right: BorderSide(width: 1, color: Colors.black),
//               )),
//               child: Row(
//                 children: [
//                   Container(
//                     width: 125,
//                     decoration: BoxDecoration(
//                         border: Border(
//                       // bottom: BorderSide(width: 1, color: Colors.black),
//                       // left: BorderSide(width: 1, color: Colors.black),
//                       right: BorderSide(width: 1, color: Colors.black),
//                     )),
//                     child: Column(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Padding(
//                             padding: const EdgeInsets.only(left: 3.0),
//                             child: Text('Dearness Allowance',
//                                 style: TextStyle(
//                                     fontSize: 7, color: Colors.black)),
//                           )
//                         ]),
//                   ),
//                   Container(
//                     width: 125,
//                     decoration: BoxDecoration(
//                         border: Border(
//                       // bottom: BorderSide(width: 1, color: Colors.black),
//                       // left: BorderSide(width: 1, color: Colors.black),
//                       right: BorderSide(width: 1, color: Colors.black),
//                     )),
//                     child: Column(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         crossAxisAlignment: CrossAxisAlignment.end,
//                         children: [
//                           Padding(
//                             padding: const EdgeInsets.only(right: 3.0),
//                             child: Text('',
//                                 style: TextStyle(
//                                     fontSize: 7, color: Colors.black)),
//                           )
//                         ]),
//                   ),
//                   Container(
//                     width: 125,
//                     decoration: BoxDecoration(
//                         border: Border(
//                       // bottom: BorderSide(width: 1, color: Colors.black),
//                       // left: BorderSide(width: 1, color: Colors.black),
//                       right: BorderSide(width: 1, color: Colors.black),
//                     )),
//                     child: Column(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Padding(
//                             padding: const EdgeInsets.only(left: 3.0),
//                             child: Text('',
//                                 style: TextStyle(
//                                     fontSize: 7, color: Colors.black)),
//                           )
//                         ]),
//                   ),
//                   Container(
//                     width: 100,
//                     child: Column(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         crossAxisAlignment: CrossAxisAlignment.end,
//                         children: [
//                           Text('',
//                               style:
//                                   TextStyle(fontSize: 7, color: Colors.black))
//                         ]),
//                   ),
//                 ],
//               ),
//             ),
//             Container(
//               height: 20,
//               decoration: BoxDecoration(
//                   border: Border(
//                 bottom: BorderSide(width: 1, color: Colors.black),
//                 left: BorderSide(width: 1, color: Colors.black),
//                 right: BorderSide(width: 1, color: Colors.black),
//               )),
//               child: Row(
//                 children: [
//                   Container(
//                     width: 125,
//                     decoration: BoxDecoration(
//                         border: Border(
//                       // bottom: BorderSide(width: 1, color: Colors.black),
//                       // left: BorderSide(width: 1, color: Colors.black),
//                       right: BorderSide(width: 1, color: Colors.black),
//                     )),
//                     child: Column(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Padding(
//                             padding: const EdgeInsets.all(8.0),
//                             child: Text('HRA',
//                                 style: TextStyle(
//                                     fontSize: 7, color: Colors.black)),
//                           )
//                         ]),
//                   ),
//                   Container(
//                     width: 125,
//                     decoration: BoxDecoration(
//                         border: Border(
//                       // bottom: BorderSide(width: 1, color: Colors.black),
//                       // left: BorderSide(width: 1, color: Colors.black),
//                       right: BorderSide(width: 1, color: Colors.black),
//                     )),
//                     child: Column(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         crossAxisAlignment: CrossAxisAlignment.end,
//                         children: [
//                           Padding(
//                             padding: const EdgeInsets.all(8.0),
//                             child: Text('',
//                                 style: TextStyle(
//                                     fontSize: 7, color: Colors.black)),
//                           )
//                         ]),
//                   ),
//                   Container(
//                     width: 125,
//                     decoration: BoxDecoration(
//                         border: Border(
//                       // bottom: BorderSide(width: 1, color: Colors.black),
//                       // left: BorderSide(width: 1, color: Colors.black),
//                       right: BorderSide(width: 1, color: Colors.black),
//                     )),
//                     child: Column(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Padding(
//                             padding: const EdgeInsets.all(8.0),
//                             child: Text('',
//                                 style: TextStyle(
//                                     fontSize: 7, color: Colors.black)),
//                           )
//                         ]),
//                   ),
//                   Container(
//                     width: 100,
//                     child: Column(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         crossAxisAlignment: CrossAxisAlignment.end,
//                         children: [
//                           Text('',
//                               style:
//                                   TextStyle(fontSize: 7, color: Colors.black))
//                         ]),
//                   ),
//                 ],
//               ),
//             ),
//             Container(
//               height: 20,
//               decoration: BoxDecoration(
//                   border: Border(
//                 bottom: BorderSide(width: 1, color: Colors.black),
//                 left: BorderSide(width: 1, color: Colors.black),
//                 right: BorderSide(width: 1, color: Colors.black),
//               )),
//               child: Row(
//                 children: [
//                   Container(
//                     width: 125,
//                     decoration: BoxDecoration(
//                         border: Border(
//                       // bottom: BorderSide(width: 1, color: Colors.black),
//                       // left: BorderSide(width: 1, color: Colors.black),
//                       right: BorderSide(width: 1, color: Colors.black),
//                     )),
//                     child: Column(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Padding(
//                             padding: const EdgeInsets.all(8.0),
//                             child: Text('Special Allowance',
//                                 style: TextStyle(
//                                     fontSize: 7, color: Colors.black)),
//                           )
//                         ]),
//                   ),
//                   Container(
//                     width: 125,
//                     decoration: BoxDecoration(
//                         border: Border(
//                       // bottom: BorderSide(width: 1, color: Colors.black),
//                       // left: BorderSide(width: 1, color: Colors.black),
//                       right: BorderSide(width: 1, color: Colors.black),
//                     )),
//                     child: Column(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         crossAxisAlignment: CrossAxisAlignment.end,
//                         children: [
//                           Padding(
//                             padding: const EdgeInsets.all(8.0),
//                             child: Text('',
//                                 style: TextStyle(
//                                     fontSize: 7, color: Colors.black)),
//                           )
//                         ]),
//                   ),
//                   Container(
//                     width: 125,
//                     decoration: BoxDecoration(
//                         border: Border(
//                       // bottom: BorderSide(width: 1, color: Colors.black),
//                       // left: BorderSide(width: 1, color: Colors.black),
//                       right: BorderSide(width: 1, color: Colors.black),
//                     )),
//                     child: Column(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Padding(
//                             padding: const EdgeInsets.all(8.0),
//                             child: Text('',
//                                 style: TextStyle(
//                                     fontSize: 7, color: Colors.black)),
//                           )
//                         ]),
//                   ),
//                   Container(
//                     width: 100,
//                     child: Column(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         crossAxisAlignment: CrossAxisAlignment.end,
//                         children: [
//                           Text('',
//                               style:
//                                   TextStyle(fontSize: 7, color: Colors.black))
//                         ]),
//                   ),
//                 ],
//               ),
//             ),
//             Container(
//               height: 20,
//               decoration: BoxDecoration(
//                   border: Border(
//                 bottom: BorderSide(width: 1, color: Colors.black),
//                 left: BorderSide(width: 1, color: Colors.black),
//                 right: BorderSide(width: 1, color: Colors.black),
//               )),
//               child: Row(
//                 children: [
//                   Container(
//                     width: 125,
//                     decoration: BoxDecoration(
//                         border: Border(
//                       // bottom: BorderSide(width: 1, color: Colors.black),
//                       // left: BorderSide(width: 1, color: Colors.black),
//                       right: BorderSide(width: 1, color: Colors.black),
//                     )),
//                     child: Column(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Padding(
//                             padding: const EdgeInsets.all(8.0),
//                             child: Text('City Compensatory Allowance',
//                                 style: TextStyle(
//                                     fontSize: 7, color: Colors.black)),
//                           )
//                         ]),
//                   ),
//                   Container(
//                     width: 125,
//                     decoration: BoxDecoration(
//                         border: Border(
//                       // bottom: BorderSide(width: 1, color: Colors.black),
//                       // left: BorderSide(width: 1, color: Colors.black),
//                       right: BorderSide(width: 1, color: Colors.black),
//                     )),
//                     child: Column(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         crossAxisAlignment: CrossAxisAlignment.end,
//                         children: [
//                           Padding(
//                             padding: const EdgeInsets.all(8.0),
//                             child: Text('',
//                                 style: TextStyle(
//                                     fontSize: 7, color: Colors.black)),
//                           )
//                         ]),
//                   ),
//                   Container(
//                     width: 125,
//                     decoration: BoxDecoration(
//                         border: Border(
//                       // bottom: BorderSide(width: 1, color: Colors.black),
//                       // left: BorderSide(width: 1, color: Colors.black),
//                       right: BorderSide(width: 1, color: Colors.black),
//                     )),
//                     child: Column(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Padding(
//                             padding: const EdgeInsets.all(8.0),
//                             child: Text('',
//                                 style: TextStyle(
//                                     fontSize: 7, color: Colors.black)),
//                           )
//                         ]),
//                   ),
//                   Container(
//                     width: 100,
//                     child: Column(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         crossAxisAlignment: CrossAxisAlignment.end,
//                         children: [
//                           Text('',
//                               style:
//                                   TextStyle(fontSize: 7, color: Colors.black))
//                         ]),
//                   ),
//                 ],
//               ),
//             ),
//             Container(
//               height: 20,
//               decoration: BoxDecoration(
//                   border: Border(
//                 bottom: BorderSide(width: 1, color: Colors.black),
//                 left: BorderSide(width: 1, color: Colors.black),
//                 right: BorderSide(width: 1, color: Colors.black),
//               )),
//               child: Row(
//                 children: [
//                   Container(
//                     width: 125,
//                     decoration: BoxDecoration(
//                         border: Border(
//                       // bottom: BorderSide(width: 1, color: Colors.black),
//                       // left: BorderSide(width: 1, color: Colors.black),
//                       right: BorderSide(width: 1, color: Colors.black),
//                     )),
//                     child: Column(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Padding(
//                             padding: const EdgeInsets.all(8.0),
//                             child: Text('Incentives',
//                                 style: TextStyle(
//                                     fontSize: 7, color: Colors.black)),
//                           )
//                         ]),
//                   ),
//                   Container(
//                     width: 125,
//                     decoration: BoxDecoration(
//                         border: Border(
//                       // bottom: BorderSide(width: 1, color: Colors.black),
//                       // left: BorderSide(width: 1, color: Colors.black),
//                       right: BorderSide(width: 1, color: Colors.black),
//                     )),
//                     child: Column(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         crossAxisAlignment: CrossAxisAlignment.end,
//                         children: [
//                           Padding(
//                             padding: const EdgeInsets.all(8.0),
//                             child: Text('',
//                                 style: TextStyle(
//                                     fontSize: 7, color: Colors.black)),
//                           )
//                         ]),
//                   ),
//                   Container(
//                     width: 125,
//                     decoration: BoxDecoration(
//                         border: Border(
//                       // bottom: BorderSide(width: 1, color: Colors.black),
//                       // left: BorderSide(width: 1, color: Colors.black),
//                       right: BorderSide(width: 1, color: Colors.black),
//                     )),
//                     child: Column(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Padding(
//                             padding: const EdgeInsets.all(8.0),
//                             child: Text('',
//                                 style: TextStyle(
//                                     fontSize: 7, color: Colors.black)),
//                           )
//                         ]),
//                   ),
//                   Container(
//                     width: 100,
//                     child: Column(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         crossAxisAlignment: CrossAxisAlignment.end,
//                         children: [
//                           Padding(
//                             padding: const EdgeInsets.all(8.0),
//                             child: Text('',
//                                 style: TextStyle(
//                                     fontSize: 7, color: Colors.black)),
//                           )
//                         ]),
//                   ),
//                 ],
//               ),
//             ),
//             Container(
//               height: 20,
//               decoration: BoxDecoration(
//                   border: Border(
//                 bottom: BorderSide(width: 1, color: Colors.black),
//                 left: BorderSide(width: 1, color: Colors.black),
//                 right: BorderSide(width: 1, color: Colors.black),
//               )),
//               child: Row(
//                 children: [
//                   Container(
//                     width: 125,
//                     decoration: BoxDecoration(
//                         border: Border(
//                       // bottom: BorderSide(width: 1, color: Colors.black),
//                       // left: BorderSide(width: 1, color: Colors.black),
//                       right: BorderSide(width: 1, color: Colors.black),
//                     )),
//                     child: Column(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Padding(
//                             padding: const EdgeInsets.all(8.0),
//                             child: Text('Medical Allowance',
//                                 style: TextStyle(
//                                     fontSize: 7, color: Colors.black)),
//                           )
//                         ]),
//                   ),
//                   Container(
//                     width: 125,
//                     decoration: BoxDecoration(
//                         border: Border(
//                       // bottom: BorderSide(width: 1, color: Colors.black),
//                       // left: BorderSide(width: 1, color: Colors.black),
//                       right: BorderSide(width: 1, color: Colors.black),
//                     )),
//                     child: Column(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         crossAxisAlignment: CrossAxisAlignment.end,
//                         children: [
//                           Padding(
//                             padding: const EdgeInsets.all(8.0),
//                             child: Text('',
//                                 style: TextStyle(
//                                     fontSize: 7, color: Colors.black)),
//                           )
//                         ]),
//                   ),
//                   Container(
//                     width: 125,
//                     decoration: BoxDecoration(
//                         border: Border(
//                       // bottom: BorderSide(width: 1, color: Colors.black),
//                       // left: BorderSide(width: 1, color: Colors.black),
//                       right: BorderSide(width: 1, color: Colors.black),
//                     )),
//                     child: Column(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Padding(
//                             padding: const EdgeInsets.all(8.0),
//                             child: Text('',
//                                 style: TextStyle(
//                                     fontSize: 7, color: Colors.black)),
//                           )
//                         ]),
//                   ),
//                   Container(
//                     width: 100,
//                     child: Column(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         crossAxisAlignment: CrossAxisAlignment.end,
//                         children: [
//                           Padding(
//                             padding: const EdgeInsets.all(8.0),
//                             child: Text('',
//                                 style: TextStyle(
//                                     fontSize: 7, color: Colors.black)),
//                           )
//                         ]),
//                   ),
//                 ],
//               ),
//             ),
//             Container(
//               height: 20,
//               decoration: BoxDecoration(
//                   border: Border(
//                 bottom: BorderSide(width: 1, color: Colors.black),
//                 left: BorderSide(width: 1, color: Colors.black),
//                 right: BorderSide(width: 1, color: Colors.black),
//               )),
//               child: Row(
//                 children: [
//                   Container(
//                     width: 125,
//                     decoration: BoxDecoration(
//                         border: Border(
//                       // bottom: BorderSide(width: 1, color: Colors.black),
//                       // left: BorderSide(width: 1, color: Colors.black),
//                       right: BorderSide(width: 1, color: Colors.black),
//                     )),
//                     child: Column(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Padding(
//                             padding: const EdgeInsets.all(8.0),
//                             child: Text('Total',
//                                 style: TextStyle(
//                                     fontSize: 7, color: Colors.black)),
//                           )
//                         ]),
//                   ),
//                   Container(
//                     width: 125,
//                     decoration: BoxDecoration(
//                         border: Border(
//                       // bottom: BorderSide(width: 1, color: Colors.black),
//                       // left: BorderSide(width: 1, color: Colors.black),
//                       right: BorderSide(width: 1, color: Colors.black),
//                     )),
//                     child: Column(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         crossAxisAlignment: CrossAxisAlignment.end,
//                         children: [
//                           Padding(
//                             padding: const EdgeInsets.all(8.0),
//                             child: Text('30,000',
//                                 style: TextStyle(
//                                     fontSize: 7, color: Colors.black)),
//                           )
//                         ]),
//                   ),
//                   Container(
//                     width: 125,
//                     decoration: BoxDecoration(
//                         border: Border(
//                       // bottom: BorderSide(width: 1, color: Colors.black),
//                       // left: BorderSide(width: 1, color: Colors.black),
//                       right: BorderSide(width: 1, color: Colors.black),
//                     )),
//                     child: Column(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Padding(
//                             padding: const EdgeInsets.all(8.0),
//                             child: Text('Total',
//                                 style: TextStyle(
//                                     fontSize: 7, color: Colors.black)),
//                           )
//                         ]),
//                   ),
//                   Container(
//                     width: 100,
//                     child: Column(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         crossAxisAlignment: CrossAxisAlignment.end,
//                         children: [
//                           Text('',
//                               style:
//                                   TextStyle(fontSize: 7, color: Colors.black))
//                         ]),
//                   ),
//                 ],
//               ),
//             ),
//
//             Container(
//               height: 20,
//               decoration: BoxDecoration(
//                   border: Border(
//                 bottom: BorderSide(width: 1, color: Colors.black),
//                 left: BorderSide(width: 1, color: Colors.black),
//                 right: BorderSide(width: 1, color: Colors.black),
//               )),
//             ),
//
//             ///NET SALARY
//             Container(
//               height: 20,
//               decoration: BoxDecoration(
//                   border: Border(
//                 bottom: BorderSide(width: 1, color: Colors.black),
//                 left: BorderSide(width: 1, color: Colors.black),
//                 right: BorderSide(width: 1, color: Colors.black),
//               )),
//               child: Row(
//                 children: [
//                   Container(
//                     width: 375,
//                     decoration: BoxDecoration(
//                         border: Border(
//                       // bottom: BorderSide(width: 1, color: Colors.black),
//                       // left: BorderSide(width: 1, color: Colors.black),
//                       right: BorderSide(width: 1, color: Colors.black),
//                     )),
//                     child: Column(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         crossAxisAlignment: CrossAxisAlignment.center,
//                         children: [
//                           Text('Net Salary',
//                               style: TextStyle(
//                                   fontSize: 8,
//                                   fontWeight: FontWeight.bold,
//                                   color: Colors.black))
//                         ]),
//                   ),
//                   Container(
//                     width: 125,
//                     decoration: BoxDecoration(
//                         //   border:
//                         //   Border(
//                         //   bottom: BorderSide(width: 1, color: Colors.black),
//                         //   left: BorderSide(width: 1, color: Colors.black),
//                         //   right: BorderSide(width: 1, color: Colors.black),
//                         // )
//                         ),
//                     child: Column(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         crossAxisAlignment: CrossAxisAlignment.center,
//                         children: [
//                           Text('23,000 /-',
//                               style:
//                                   TextStyle(fontSize: 8, color: Colors.black))
//                         ]),
//                   ),
//                 ],
//               ),
//             ),
//
//             ///
//           ],
//         ),
//       ),
//     );
//   }
// }
