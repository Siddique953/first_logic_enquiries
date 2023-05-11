// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:fl_erp/app/tabs/Applications/application_view.dart';
// import 'package:lottie/lottie.dart';
//
// import '../../../flutter_flow/flutter_flow_theme.dart';
// import '../../../flutter_flow/flutter_flow_widgets.dart';
// import 'ApplicationSubmittedDetailsView.dart';
// import 'application_view1.dart';
// class ApplicationHistoryDetails extends StatefulWidget {
//   const ApplicationHistoryDetails({Key key}) : super(key: key);
//
//   @override
//   State<ApplicationHistoryDetails> createState() => _ApplicationHistoryDetailsState();
// }
//
// class _ApplicationHistoryDetailsState extends State<ApplicationHistoryDetails> {
//   TextEditingController search;
//   final scaffoldKey = GlobalKey<ScaffoldState>();
//   List<DropdownMenuItem> listofcategory;
//   List<DropdownMenuItem> listofSubcategory;
//   String selectedCategory = '';
//   String selectedSubCategory = '';
//
//
//   String selectedCategoryId = "";
//   List<DropdownMenuItem> categoryTemp = [];
//
//   int pendingApplication=0;
//
//   Timestamp thisYear;
//   bool _loadingButton1 = false;
//   Timestamp thisMonth;
//
//   int thisMonthApplication=0;
//   int thisYearApplication=0;
//
//   @override
//   void initState() {
//     super.initState();
//     DateTime today=DateTime.now();
//
//     thisYear =Timestamp.fromDate(DateTime(today.year,4,1,0,0,0));
//
//     thisMonth =Timestamp.fromDate(DateTime(today.year,today.month,0,0));
//     search = TextEditingController();
//
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       key: scaffoldKey,
//       backgroundColor: Colors.white,
//       body: SafeArea(
//         child: Column(
//           mainAxisSize: MainAxisSize.max,
//           children: [
//             Padding(
//               padding: const EdgeInsets.only(left: 25,top: 30),
//               child: Row(
//                 children: [
//                   Text('Application Submitted List',style: FlutterFlowTheme.title2.override(
//
//                     fontFamily: 'Lexend Deca',
//                     color: Color(0xFF090F13),
//                     fontSize: 20,
//                     fontWeight: FontWeight.w600,
//                   )),
//                 ],
//               ),
//             ),
//             // Row(
//             //   children: [
//             //     Padding(
//             //       padding: EdgeInsetsDirectional.fromSTEB(30, 20, 30, 12),
//             //       child: InkWell(
//             //         onTap: (){
//             //
//             //           // Navigator.push(context, MaterialPageRoute(builder: (context)=>VisaSubmittedList()));
//             //
//             //         },
//             //         child: Container(
//             //           width: MediaQuery.of(context).size.width*.3,
//             //           height: MediaQuery.of(context).size.height*.16,
//             //           decoration: BoxDecoration(
//             //             color: Color(0xFF4B39EF),
//             //             borderRadius: BorderRadius.circular(8),
//             //           ),
//             //           child: Padding(
//             //             padding: EdgeInsetsDirectional.fromSTEB(30, 12, 30, 12),
//             //             child: Column(
//             //               mainAxisSize: MainAxisSize.max,
//             //               mainAxisAlignment: MainAxisAlignment.center,
//             //               crossAxisAlignment: CrossAxisAlignment.center,
//             //               children: [
//             //                 Padding(
//             //                   padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 20),
//             //                   child: Row(
//             //                     mainAxisSize: MainAxisSize.max,
//             //                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             //                     children: [
//             //                       Text(
//             //                         'Pending',
//             //                         style: FlutterFlowTheme.bodyText2.override(
//             //                           fontFamily: 'Lexend Deca',
//             //                           color: Colors.white,
//             //                           fontSize:  MediaQuery.of(context).size.width*0.012,
//             //
//             //                           fontWeight: FontWeight.bold,
//             //                         ),
//             //                       ),
//             //                       Icon(
//             //                         Icons.arrow_forward_ios_rounded,
//             //                         color: Colors.white,
//             //                         size:  MediaQuery.of(context).size.width*0.016,
//             //                       ),
//             //                     ],
//             //                   ),
//             //                 ),
//             //                 Text(
//             //                   pendingApplication.toString(),
//             //                   style: FlutterFlowTheme.title1.override(
//             //                     fontFamily: 'Lexend Deca',
//             //                     color: Colors.white,
//             //                     fontSize:  MediaQuery.of(context).size.width*0.018,
//             //                     fontWeight: FontWeight.bold,
//             //                   ),
//             //                 ),
//             //               ],
//             //             ),
//             //           ),
//             //         ),
//             //       ),
//             //     ),
//             //     Padding(
//             //       padding: EdgeInsetsDirectional.fromSTEB(30, 20, 30, 12),
//             //       child: InkWell(
//             //         onTap: (){
//             //
//             //           // Navigator.push(context, MaterialPageRoute(builder: (context)=>VisaSubmittedList()));
//             //
//             //         },
//             //         child: Container(
//             //           width: MediaQuery.of(context).size.width*.3,
//             //           height: MediaQuery.of(context).size.height*.16,
//             //           decoration: BoxDecoration(
//             //             color: Color(0xFF4B39EF),
//             //             borderRadius: BorderRadius.circular(8),
//             //           ),
//             //           child: Padding(
//             //             padding: EdgeInsetsDirectional.fromSTEB(30, 12, 30, 12),
//             //             child: Column(
//             //               mainAxisSize: MainAxisSize.max,
//             //               mainAxisAlignment: MainAxisAlignment.center,
//             //               crossAxisAlignment: CrossAxisAlignment.center,
//             //               children: [
//             //                 Padding(
//             //                   padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 20),
//             //                   child: Row(
//             //                     mainAxisSize: MainAxisSize.max,
//             //                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             //                     children: [
//             //                       Text(
//             //                         'Submitted',
//             //                         style: FlutterFlowTheme.bodyText2.override(
//             //                           fontFamily: 'Lexend Deca',
//             //                           color: Colors.white,
//             //                           fontSize:  MediaQuery.of(context).size.width*0.012,
//             //                           fontWeight: FontWeight.bold,
//             //                         ),
//             //                       ),
//             //                       Icon(
//             //                         Icons.arrow_forward_ios_rounded,
//             //                         color: Colors.white,
//             //                         size:  MediaQuery.of(context).size.width*0.016,
//             //                       ),
//             //                     ],
//             //                   ),
//             //                 ),
//             //                 Row(
//             //                   mainAxisAlignment: MainAxisAlignment.spaceAround,
//             //                   children: [
//             //                     SizedBox(width: 15,),
//             //
//             //                     Column(
//             //                       children: [
//             //                         Text(
//             //                           'This Month',
//             //                           style: FlutterFlowTheme.title1.override(
//             //                             fontFamily: 'Lexend Deca',
//             //                             color: Colors.white,
//             //                             fontSize:  MediaQuery.of(context).size.width*0.008,
//             //                             fontWeight: FontWeight.w600,
//             //                           ),
//             //                         ),
//             //                         SizedBox(height: 10,),
//             //                         Text(
//             //                           thisMonthApplication.toString(),
//             //                           style: FlutterFlowTheme.title1.override(
//             //                             fontFamily: 'Lexend Deca',
//             //                             color: Colors.white,
//             //                             fontSize:  MediaQuery.of(context).size.width*0.015,
//             //                             fontWeight: FontWeight.w600,
//             //                           ),
//             //                         ),
//             //                       ],
//             //                     ),
//             //                     Column(
//             //                       children: [
//             //                         Text(
//             //                           'This Year',
//             //                           style: FlutterFlowTheme.title1.override(
//             //                             fontFamily: 'Lexend Deca',
//             //                             color: Colors.white,
//             //                             fontSize:  MediaQuery.of(context).size.width*0.008,
//             //                             fontWeight: FontWeight.w600,
//             //                           ),
//             //                         ),
//             //                         SizedBox(height: 10,),
//             //
//             //                         Text(
//             //                           thisYearApplication.toString(),
//             //                           style: FlutterFlowTheme.title1.override(
//             //                             fontFamily: 'Lexend Deca',
//             //                             color: Colors.white,
//             //                             fontSize:  MediaQuery.of(context).size.width*0.015,
//             //                             fontWeight: FontWeight.w600,
//             //                           ),
//             //                         ),
//             //                       ],
//             //                     ),
//             //                     SizedBox(width: 15,),
//             //
//             //                   ],
//             //                 ),
//             //               ],
//             //             ),
//             //           ),
//             //         ),
//             //       ),
//             //     ),
//             //   ],
//             // ),
//             Row(
//               mainAxisSize: MainAxisSize.max,
//               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//               children: [
//                 Padding(
//                   padding: EdgeInsetsDirectional.fromSTEB(0, 20, 0, 20),
//                   child: Container(
//                     width: 600,
//                     decoration: BoxDecoration(
//                       color: Colors.white,
//                       boxShadow: [
//                         BoxShadow(
//                           blurRadius: 3,
//                           color: Color(0x39000000),
//                           offset: Offset(0, 1),
//                         )
//                       ],
//                       borderRadius: BorderRadius.circular(12),
//                     ),
//                     child: Padding(
//                       padding: EdgeInsetsDirectional.fromSTEB(4, 4, 0, 4),
//                       child: Row(
//                         mainAxisSize: MainAxisSize.max,
//                         children: [
//                           Expanded(
//                             child: Padding(
//                               padding: EdgeInsetsDirectional.fromSTEB(4, 0, 4, 0),
//                               child: TextFormField(
//                                 controller: search,
//                                 obscureText: false,
//                                 onChanged: (text){
//                                   setState(() {
//
//                                   });
//                                 },
//                                 decoration: InputDecoration(
//                                   labelText: 'Search ',
//                                   hintText: 'Please Enter Mobile Number',
//                                   labelStyle: FlutterFlowTheme
//                                       .bodyText2
//                                       .override(
//                                     fontFamily: 'Poppins',
//                                     color: Color(0xFF7C8791),
//                                     fontSize: 11,
//                                     fontWeight: FontWeight.bold,
//                                   ),
//                                   enabledBorder: OutlineInputBorder(
//                                     borderSide: BorderSide(
//                                       color: Color(0x00000000),
//                                       width: 2,
//                                     ),
//                                     borderRadius: BorderRadius.circular(8),
//                                   ),
//                                   focusedBorder: OutlineInputBorder(
//                                     borderSide: BorderSide(
//                                       color: Color(0x00000000),
//                                       width: 2,
//                                     ),
//                                     borderRadius: BorderRadius.circular(8),
//                                   ),
//                                   filled: true,
//                                   fillColor: Colors.white,
//                                 ),
//                                 style: FlutterFlowTheme
//                                     .bodyText1
//                                     .override(
//                                   fontFamily: 'Poppins',
//                                   color: Color(0xFF090F13),
//                                   fontSize: 11,
//                                   fontWeight: FontWeight.normal,
//                                 ),
//                               ),
//                             ),
//                           ),
//                           Padding(
//                             padding: EdgeInsetsDirectional.fromSTEB(0, 0, 8, 0),
//                             child: FFButtonWidget(
//                               onPressed: ()  {
//
//                                 search.clear();
//                                 setState(() {
//
//                                 });
//
//                               },
//                               text: 'Clear',
//                               options: FFButtonOptions(
//                                 width: 80,
//                                 height: 40,
//                                 color: Color(0xFF4B39EF),
//                                 textStyle: FlutterFlowTheme
//                                     .subtitle2
//                                     .override(
//                                   fontFamily: 'Poppins',
//                                   color: Colors.white,
//                                   fontSize: 12,
//                                   fontWeight: FontWeight.bold,
//                                 ),
//                                 elevation: 2,
//                                 borderSide: BorderSide(
//                                   color: Colors.transparent,
//                                   width: 1,
//                                 ),
//                                 borderRadius: 50,
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//             search.text==''?
//             StreamBuilder<QuerySnapshot>(
//                 stream: FirebaseFirestore.instance.collection('applicationForms')
//                     .where('status',isEqualTo: 1)
//                     .orderBy('date',descending: true)
//                     .snapshots(),
//                 builder: (context, snapshot) {
//                   if(!snapshot.hasData){
//                     return Center(child: CircularProgressIndicator(),);
//                   }
//                   var data=snapshot.data.docs;
//                   return data.length==0?Container(  color: Colors.white,
//                       child: Column(
//                         children: [
//                           Text('No Application Available',style: FlutterFlowTheme
//                               .subtitle2
//                               .override(
//                             fontFamily: 'Poppins',
//                             color: Color(0xFF7C8791),
//                             fontSize: 12,
//                             fontWeight: FontWeight.bold,
//                           ),),
//
//                           Image.asset('assets/images/noDoc.gif',height: 390,),
//                         ],
//                       )): SizedBox(
//                     width: double.infinity,
//                     child: DataTable(
//                       horizontalMargin: 10,
//                       columns: [
//                         DataColumn(
//                           label: Text("App.Id",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 11),),
//                         ),
//                         DataColumn(
//                           label: Text("S.Id",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 11),),
//                         ),
//                         DataColumn(
//                           label: Text("Name",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 11),),
//                         ),
//                         DataColumn(
//                           label: Text("Mobile",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 11),),
//                         ),
//                         DataColumn(
//                           label: Text("Email",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 11),),
//                         ),
//
//                         DataColumn(
//                           label: Text("Status",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 11),),
//                         ),
//                         DataColumn(
//                           label: Text("Action",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 11),),
//                         ),
//                       ],
//                       rows: List.generate(
//                         data.length,
//                             (index) {
//
//                           String name=data[index]['name'];
//                           String candidateId=data[index]['candidateId'];
//                           String mobile=data[index]['mobile'];
//                           String email=data[index]['email'];
//                           String phoneCode=data[index]['phoneCode'];
//
//
//                           print(data[index]['currentStatus']);
//
//
//                           return DataRow(
//                             color: index.isOdd?MaterialStateProperty.all(Colors.blueGrey.shade50.withOpacity(0.7)):MaterialStateProperty.all(Colors.blueGrey.shade50),
//
//
//                             cells: [
//                               DataCell(SelectableText(data[index].id,  style: FlutterFlowTheme.bodyText2.override(
//                                 fontFamily: 'Lexend Deca',
//                                 color: Colors.black,
//                                 fontSize: 10,
//                                 fontWeight: FontWeight.bold,
//                               ),)),
//                               DataCell(SelectableText(candidateId,  style: FlutterFlowTheme.bodyText2.override(
//                                 fontFamily: 'Lexend Deca',
//                                 color: Colors.black,
//                                 fontSize: 10,
//                                 fontWeight: FontWeight.bold,
//                               ),)),
//                               DataCell(SelectableText(name,style: FlutterFlowTheme.bodyText2.override(
//                                 fontFamily: 'Lexend Deca',
//                                 color: Colors.black,
//                                 fontSize: 10,
//                                 fontWeight: FontWeight.bold,
//                               ),)),
//                               DataCell(SelectableText(phoneCode+mobile,  style: FlutterFlowTheme.bodyText2.override(
//                                 fontFamily: 'Lexend Deca',
//                                 color: Colors.black,
//                                 fontSize: 10,
//                                 fontWeight: FontWeight.bold,
//                               ),)),
//                               DataCell(SelectableText(email,style: FlutterFlowTheme.bodyText2.override(
//                                 fontFamily: 'Lexend Deca',
//                                 color: Colors.black,
//                                 fontSize: 10,
//                                 fontWeight: FontWeight.bold,
//                               ))),
//                               DataCell(SelectableText(data[index]['currentStatus'].toString(),style: FlutterFlowTheme.bodyText2.override(
//                                 fontFamily: 'Lexend Deca',
//                                 color: Colors.black,
//                                 fontSize: 10,
//                                 fontWeight: FontWeight.bold,
//                               ))),
//                               DataCell(   Row(
//                                 children: [
//                                   FFButtonWidget(
//                                     onPressed: () {
//
//                                       Navigator.push(context, MaterialPageRoute(builder: (context)=>ApplicationSubmittedDetailsView(
//                                         id: data[index]['candidateId'],
//                                         appId: data[index].id,
//                                         status: data[index]['status'],
//
//
//                                       )));
//
//                                     },
//                                     text: 'View',
//                                     options: FFButtonOptions(
//                                       width: 80,
//                                       height: 30,
//                                       color: Colors.teal,
//                                       textStyle: FlutterFlowTheme.subtitle2.override(
//                                           fontFamily: 'Poppins',
//                                           color: Colors.white,
//                                           fontSize: 11,
//                                           fontWeight: FontWeight.bold
//
//                                       ),
//                                       borderSide: BorderSide(
//                                         color: Colors.transparent,
//                                         width: 1,
//                                       ),
//                                       borderRadius: 8,
//                                     ),
//                                   ),
//                                 ],
//                               ),),
//                               // DataCell(Text(fileInfo.size)),
//                             ],
//                           );
//                         },
//                       ),
//                     ),
//                   );
//                 }
//             ):
//             StreamBuilder<QuerySnapshot>(
//                 stream: FirebaseFirestore.instance.collection('applicationForms')
//                     .orderBy('date',descending: true)
//                     .where('status',isEqualTo: 1)
//                     .where('search',arrayContains: search.text.toUpperCase())
//                     .snapshots(),
//                 builder: (context, snapshot) {
//                   if(!snapshot.hasData){
//                     return Center(child: CircularProgressIndicator(),);
//                   }
//                   var data=snapshot.data.docs;
//                   return data.length==0?LottieBuilder.network('https://assets9.lottiefiles.com/packages/lf20_HpFqiS.json',height: 500,): SizedBox(
//                     width: double.infinity,
//                     child: DataTable(
//                       horizontalMargin: 10,
//                       columns: [
//                         DataColumn(
//                           label: Text("App.Id",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 11),),
//                         ),
//                         DataColumn(
//                           label: Text("S.Id",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 11),),
//                         ),
//                         DataColumn(
//                           label: Text("Name",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 11),),
//                         ),
//                         DataColumn(
//                           label: Text("Mobile",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 11),),
//                         ),
//                         DataColumn(
//                           label: Text("Email",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 11),),
//                         ),
//
//                         DataColumn(
//                           label: Text("Status",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 11),),
//                         ),
//                         DataColumn(
//                           label: Text("Action",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 11),),
//                         ),
//                       ],
//                       rows: List.generate(
//                         data.length,
//                             (index) {
//
//                           String name=data[index]['name'];
//                           String candidateId=data[index]['candidateId'];
//                           String mobile=data[index]['mobile'];
//                           String email=data[index]['email'];
//                           String phoneCode=data[index]['phoneCode'];
//
//
//
//
//                           return DataRow(
//                             color: index.isOdd?MaterialStateProperty.all(Colors.blueGrey.shade50.withOpacity(0.7)):MaterialStateProperty.all(Colors.blueGrey.shade50),
//
//
//                             cells: [
//                               DataCell(SelectableText(data[index].id,  style: FlutterFlowTheme.bodyText2.override(
//                                 fontFamily: 'Lexend Deca',
//                                 color: Colors.black,
//                                 fontSize: 10,
//                                 fontWeight: FontWeight.bold,
//                               ),)),
//                               DataCell(SelectableText(candidateId,  style: FlutterFlowTheme.bodyText2.override(
//                                 fontFamily: 'Lexend Deca',
//                                 color: Colors.black,
//                                 fontSize: 10,
//                                 fontWeight: FontWeight.bold,
//                               ),)),
//                               DataCell(SelectableText(name,style: FlutterFlowTheme.bodyText2.override(
//                                 fontFamily: 'Lexend Deca',
//                                 color: Colors.black,
//                                 fontSize: 10,
//                                 fontWeight: FontWeight.bold,
//                               ),)),
//                               DataCell(SelectableText(phoneCode+mobile,  style: FlutterFlowTheme.bodyText2.override(
//                                 fontFamily: 'Lexend Deca',
//                                 color: Colors.black,
//                                 fontSize: 10,
//                                 fontWeight: FontWeight.bold,
//                               ),)),
//                               DataCell(SelectableText(email,style: FlutterFlowTheme.bodyText2.override(
//                                 fontFamily: 'Lexend Deca',
//                                 color: Colors.black,
//                                 fontSize: 10,
//                                 fontWeight: FontWeight.bold,
//                               ))),
//                               DataCell(SelectableText(data[index]['currentStatus'].toString(),style: FlutterFlowTheme.bodyText2.override(
//                                 fontFamily: 'Lexend Deca',
//                                 color: Colors.black,
//                                 fontSize: 10,
//                                 fontWeight: FontWeight.bold,
//                               ))),
//                               DataCell(   Row(
//                                 children: [
//                                   FFButtonWidget(
//                                     onPressed: () {
//
//                                       Navigator.push(context, MaterialPageRoute(builder: (context)=>ApplicationSubmittedDetailsView(
//                                         id: data[index]['candidateId'],
//                                         appId: data[index].id,
//                                         status: data[index]['status'],
//
//
//                                       )));
//
//                                     },
//                                     text: 'View',
//                                     options: FFButtonOptions(
//                                       width: 80,
//                                       height: 30,
//                                       color: Colors.teal,
//                                       textStyle: FlutterFlowTheme.subtitle2.override(
//                                           fontFamily: 'Poppins',
//                                           color: Colors.white,
//                                           fontSize: 11,
//                                           fontWeight: FontWeight.bold
//
//                                       ),
//                                       borderSide: BorderSide(
//                                         color: Colors.transparent,
//                                         width: 1,
//                                       ),
//                                       borderRadius: 8,
//                                     ),
//                                   ),
//                                 ],
//                               ),),
//                               // DataCell(Text(fileInfo.size)),
//                             ],
//                           );
//                         },
//                       ),
//                     ),
//                   );
//                 }
//             ),
//
//           ],
//         ),
//       ),
//     );
//   }
// }
