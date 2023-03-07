// import 'package:animated_custom_dropdown/custom_dropdown.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:searchfield/searchfield.dart';
//
// import '../../../flutter_flow/flutter_flow_theme.dart';
// import '../../../flutter_flow/flutter_flow_widgets.dart';
// import '../../../flutter_flow/upload_media.dart';
//
// class AddExpensePage extends StatefulWidget {
//   final GlobalKey<FormState> form;
//   final List currentHeadList;
//   const AddExpensePage({Key key, this.form, this.currentHeadList})
//       : super(key: key);
//
//   @override
//   State<AddExpensePage> createState() => _AddExpensePageState();
// }
//
// class _AddExpensePageState extends State<AddExpensePage> {
//   TextEditingController amount;
//   TextEditingController description;
//   TextEditingController whatsAppNo;
//   TextEditingController careOf;
//   TextEditingController careOfNo;
//   String selectedCountry;
//
//   TextEditingController selectedProjectType;
//   Timestamp datePicked;
//   DateTime selectedDate = DateTime.now();
//
//   List<String> testList = [];
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     selectedProjectType = TextEditingController();
//     amount = TextEditingController();
//     description = TextEditingController();
//     whatsAppNo = TextEditingController();
//     careOf = TextEditingController();
//     careOfNo = TextEditingController();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return AlertDialog(
//       // title: Column(
//       //   children: [Text('Add Expense'), Divider()],
//       // ),
//       content: Container(
//         width: 600,
//         color: Colors.transparent,
//         child: Form(
//           key: widget.form,
//           child: Padding(
//             padding: const EdgeInsets.only(left: 10),
//             child: SingleChildScrollView(
//               child: Column(
//                 mainAxisSize: MainAxisSize.min,
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     'Add Expense',
//                     style: GoogleFonts.getFont('Roboto',
//                         color: Colors.black,
//                         fontSize: 35,
//                         fontWeight: FontWeight.bold),
//                     // TextStyle(
//                     //     fontWeight: FontWeight.bold,
//                     //     fontSize: 35,
//                     //     fontFamily: Google),
//                   ),
//                   Divider(
//                     thickness: 3,
//                   ),
//                   SizedBox(
//                     height: 10,
//                   ),
//
//                   //CHOOSE DATE
//                   Text(
//                     'Choose Date',
//                     style: TextStyle(fontSize: 20),
//                   ),
//                   SizedBox(
//                     height: 5,
//                   ),
//                   Container(
//                       width: 550,
//                       height: MediaQuery.of(context).size.height * 0.08,
//                       decoration: BoxDecoration(
//                         color: Colors.white,
//                         borderRadius: BorderRadius.circular(8),
//                         border: Border.all(
//                           color: Colors.black,
//                         ),
//                       ),
//                       child: Column(
//                           mainAxisAlignment: MainAxisAlignment.spaceAround,
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Padding(
//                                 padding:
//                                     const EdgeInsets.only(left: 10, right: 10),
//                                 child: Row(
//                                   mainAxisAlignment:
//                                       MainAxisAlignment.spaceBetween,
//                                   children: [
//                                     Text(
//                                       datePicked == null
//                                           ? 'Date Month Year'
//                                           : datePicked
//                                               .toDate()
//                                               .toString()
//                                               .substring(0, 10),
//                                       style: TextStyle(
//                                         fontFamily: 'Poppins',
//                                         color: datePicked == null
//                                             ? Color(0xffDFDFDF)
//                                             : Colors.blue,
//                                         fontSize: 13,
//                                         fontWeight: FontWeight.w600,
//                                       ),
//                                     ),
//                                     IconButton(
//                                       icon: Icon(
//                                         Icons.calendar_today_outlined,
//                                         size:
//                                             MediaQuery.of(context).size.height *
//                                                 0.04,
//                                         color: Color(0xff0054FF),
//                                       ),
//                                       onPressed: () {
//                                         showDatePicker(
//                                                 context: context,
//                                                 initialDate: selectedDate,
//                                                 locale: Locale('en', 'IN'),
//                                                 firstDate: DateTime(1901, 1),
//                                                 lastDate: DateTime(2100, 1))
//                                             .then((value) {
//                                           setState(() {
//                                             datePicked = Timestamp.fromDate(
//                                                 DateTime(
//                                                     value.year,
//                                                     value.month,
//                                                     value.day,
//                                                     0,
//                                                     0,
//                                                     0));
//
//                                             selectedDate = value;
//                                           });
//                                         });
//                                       },
//                                     )
//                                   ],
//                                 ))
//                           ])),
//                   SizedBox(
//                     height: 10,
//                   ),
//
//                   //SELECT PARTICULARS
//                   Text(
//                     'Choose Particular',
//                     style: TextStyle(fontSize: 20),
//                   ),
//                   SizedBox(
//                     height: 5,
//                   ),
//                   Container(
//                       height: MediaQuery.of(context).size.height * 0.08,
//                       width: 550,
//                       decoration: BoxDecoration(
//                         color: Colors.white,
//                         borderRadius: BorderRadius.circular(8),
//                         border: Border.all(
//                           color: Colors.black,
//                         ),
//                       ),
//                       child: CustomDropdown.search(
//                         hintText: 'Select project type',
//                         hintStyle: TextStyle(color: Colors.black),
//                         items: widget.currentHeadList,
//                         controller: selectedProjectType,
//                         // excludeSelected: false,
//                         onChanged: (text) {
//                           setState(() {});
//                         },
//                       )),
//                   SizedBox(
//                     height: 10,
//                   ),
//
//                   //AMOUNT
//                   Text(
//                     'Enter Amount',
//                     style: TextStyle(fontSize: 20),
//                   ),
//                   SizedBox(
//                     height: 5,
//                   ),
//                   Container(
//                       width: 550,
//                       height: MediaQuery.of(context).size.height * 0.08,
//                       decoration: BoxDecoration(
//                         color: Colors.white,
//                         borderRadius: BorderRadius.circular(8),
//                         border: Border.all(
//                           color: Colors.black,
//                         ),
//                       ),
//                       child: TextFormField(
//                         controller: amount,
//                         obscureText: false,
//                         decoration: InputDecoration(
//                           prefixIcon: Container(
//                             width: MediaQuery.of(context).size.width * 0.09,
//                             height: MediaQuery.of(context).size.height * 0.08,
//                             decoration: BoxDecoration(
//                               color: Color(0xffCFC3C3),
//                               border: Border.all(width: 0.001),
//                               borderRadius: BorderRadius.circular(8),
//                             ),
//                             child: Center(child: Text('₹INR')),
//                           ),
//                           labelText: '₹15000',
//                           labelStyle: FlutterFlowTheme.bodyText2.override(
//                               fontFamily: 'Montserrat',
//                               color: Colors.black,
//                               fontWeight: FontWeight.w500,
//                               fontSize: 12),
//                           hintText: 'Please Enter Amount',
//                           hintStyle: FlutterFlowTheme.bodyText2.override(
//                               fontFamily: 'Montserrat',
//                               color: Colors.black,
//                               fontWeight: FontWeight.w500,
//                               fontSize: 12),
//                           enabledBorder: UnderlineInputBorder(
//                             borderSide: BorderSide(
//                               color: Colors.transparent,
//                               width: 1,
//                             ),
//                             // borderRadius: const BorderRadius.only(
//                             //   topLeft: Radius.circular(4.0),
//                             //   topRight: Radius.circular(4.0),
//                             // ),
//                           ),
//                           focusedBorder: UnderlineInputBorder(
//                             borderSide: BorderSide(
//                               color: Colors.transparent,
//                               width: 1,
//                             ),
//                             borderRadius: const BorderRadius.only(
//                               topLeft: Radius.circular(4.0),
//                               topRight: Radius.circular(4.0),
//                             ),
//                           ),
//                         ),
//                         style: FlutterFlowTheme.bodyText2.override(
//                             fontFamily: 'Montserrat',
//                             color: Color(0xFF8B97A2),
//                             fontWeight: FontWeight.w500,
//                             fontSize: 13),
//                       )),
//                   SizedBox(
//                     height: 10,
//                   ),
//
//                   //DESCRIPTION
//                   Text(
//                     'Description',
//                     style: TextStyle(fontSize: 20),
//                   ),
//                   SizedBox(
//                     height: 5,
//                   ),
//                   Container(
//                       width: 550,
//                       height: MediaQuery.of(context).size.height * 0.08,
//                       decoration: BoxDecoration(
//                         color: Colors.white,
//                         borderRadius: BorderRadius.circular(8),
//                         border: Border.all(
//                           color: Colors.black,
//                         ),
//                       ),
//                       child: Padding(
//                         padding: const EdgeInsets.only(left: 10),
//                         child: TextFormField(
//                           controller: description,
//                           obscureText: false,
//                           decoration: InputDecoration(
//                             labelText: 'Description',
//                             labelStyle: FlutterFlowTheme.bodyText2.override(
//                                 fontFamily: 'Montserrat',
//                                 color: Colors.black,
//                                 fontWeight: FontWeight.w500,
//                                 fontSize: 12),
//                             hintText: 'Please Enter Description',
//                             hintStyle: FlutterFlowTheme.bodyText2.override(
//                                 fontFamily: 'Montserrat',
//                                 color: Colors.black,
//                                 fontWeight: FontWeight.w500,
//                                 fontSize: 12),
//                             enabledBorder: UnderlineInputBorder(
//                               borderSide: BorderSide(
//                                 color: Colors.transparent,
//                                 width: 1,
//                               ),
//                               // borderRadius: const BorderRadius.only(
//                               //   topLeft: Radius.circular(4.0),
//                               //   topRight: Radius.circular(4.0),
//                               // ),
//                             ),
//                             focusedBorder: UnderlineInputBorder(
//                               borderSide: BorderSide(
//                                 color: Colors.transparent,
//                                 width: 1,
//                               ),
//                               borderRadius: const BorderRadius.only(
//                                 topLeft: Radius.circular(4.0),
//                                 topRight: Radius.circular(4.0),
//                               ),
//                             ),
//                           ),
//                           style: FlutterFlowTheme.bodyText2.override(
//                               fontFamily: 'Montserrat',
//                               color: Color(0xFF8B97A2),
//                               fontWeight: FontWeight.w500,
//                               fontSize: 13),
//                         ),
//                       )),
//                   SizedBox(
//                     height: 10,
//                   ),
//
//                   //CASH OR BANK
//
//                   Row(
//                     children: [
//                       Container(
//                         child: a,
//                       )
//                     ],
//                   ),
//
//                   //BUTTON
//                   Padding(
//                     padding: EdgeInsetsDirectional.fromSTEB(0, 24, 0, 44),
//                     child: FFButtonWidget(
//                       onPressed: () async {
//                         final FormState form = widget.form.currentState;
//
//                         if (form.validate()) {}
//                       },
//                       text: 'Register As Customer',
//                       options: FFButtonOptions(
//                         width: 200,
//                         height: 50,
//                         color: Color(0xFF4B39EF),
//                         textStyle: FlutterFlowTheme.subtitle2.override(
//                           fontFamily: 'Lexend Deca',
//                           color: Colors.white,
//                           fontSize: 12,
//                           fontWeight: FontWeight.bold,
//                         ),
//                         elevation: 2,
//                         borderSide: BorderSide(
//                           color: Colors.transparent,
//                           width: 1,
//                         ),
//                         borderRadius: 10,
//                       ),
//                     ),
//                   ),
//                   SizedBox(
//                     height: 25,
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
