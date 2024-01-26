// // //PROJECT DETAILS
// // Padding(
// //     padding: const EdgeInsets.only(
// //         top: 20, bottom: 20),
// //     child: SingleChildScrollView(
// //       physics: BouncingScrollPhysics(),
// //       child: Column(
// //         children: [
// //           //heading
// //           Row(
// //             children: [
// //               SizedBox(
// //                 width: MediaQuery.of(context)
// //                         .size
// //                         .width *
// //                     0.01,
// //               ),
// //               IconButton(
// //                 onPressed: () {
// //                   setState(() {
// //                     subTab = false;
// //                   });
// //                 },
// //                 icon: Icon(Icons
// //                     .arrow_back_ios_new_outlined),
// //               ),
// //               SizedBox(
// //                 width: MediaQuery.of(context)
// //                         .size
// //                         .width *
// //                     0.4,
// //               ),
// //               Center(
// //                 child: Text(
// //                   'Project Details',
// //                   style: FlutterFlowTheme
// //                       .bodyText2
// //                       .override(
// //                           fontFamily:
// //                               'Montserrat',
// //                           color:
// //                               Color(0xFF8B97A2),
// //                           fontWeight:
// //                               FontWeight.w500,
// //                           fontSize: 17),
// //                 ),
// //               ),
// //             ],
// //           ),
// //           SizedBox(
// //             width: 30,
// //           ),
// //
// //           Padding(
// //             padding: const EdgeInsets.all(20.0),
// //             child: Row(
// //               crossAxisAlignment:
// //                   CrossAxisAlignment.start,
// //               mainAxisAlignment:
// //                   MainAxisAlignment.center,
// //               children: [
// //                 //Enquiry Details
// //                 Expanded(
// //                   child: Material(
// //                     color: Colors.transparent,
// //                     elevation: 10,
// //                     shape: RoundedRectangleBorder(
// //                       borderRadius:
// //                           BorderRadius.circular(
// //                               20),
// //                     ),
// //                     child: Container(
// //                       decoration: BoxDecoration(
// //                         color: Colors.white,
// //                         borderRadius:
// //                             BorderRadius.circular(
// //                                 20),
// //                       ),
// //                       child: Padding(
// //                         padding: const EdgeInsets
// //                                 .fromLTRB(
// //                             0, 10, 0, 10),
// //                         child: Column(
// //                           children: [
// //                             Container(
// //                               width: MediaQuery.of(
// //                                           context)
// //                                       .size
// //                                       .width *
// //                                   0.3,
// //                               decoration:
// //                                   BoxDecoration(
// //                                 color:
// //                                     Colors.white,
// //                                 borderRadius:
// //                                     BorderRadius
// //                                         .circular(
// //                                             8),
// //                                 border:
// //                                     Border.all(
// //                                   color: Colors
// //                                       .black,
// //                                 ),
// //                               ),
// //                               child:
// //                                   CustomDropdown
// //                                       .search(
// //                                 hintText:
// //                                     'Select Project Type',
// //                                 items:
// //                                     projectTypeList,
// //                                 controller:
// //                                     projectType,
// //                                 // excludeSelected: false,
// //                                 onChanged:
// //                                     (text) {
// //                                   setState(() {});
// //                                 },
// //                               ),
// //                             ),
// //                             SizedBox(
// //                               height: 10,
// //                             ),
// //                             Container(
// //                               width: 350,
// //                               height: 60,
// //                               decoration:
// //                                   BoxDecoration(
// //                                 color:
// //                                     Colors.white,
// //                                 borderRadius:
// //                                     BorderRadius
// //                                         .circular(
// //                                             8),
// //                                 border:
// //                                     Border.all(
// //                                   color: Color(
// //                                       0xFFE6E6E6),
// //                                 ),
// //                               ),
// //                               child: Padding(
// //                                 padding:
// //                                     EdgeInsets
// //                                         .fromLTRB(
// //                                             16,
// //                                             0,
// //                                             0,
// //                                             0),
// //                                 child:
// //                                     TextFormField(
// //                                   controller:
// //                                       projectname,
// //                                   obscureText:
// //                                       false,
// //                                   decoration:
// //                                       InputDecoration(
// //                                     labelText:
// //                                         'Project Name',
// //                                     labelStyle: FlutterFlowTheme.bodyText2.override(
// //                                         fontFamily:
// //                                             'Montserrat',
// //                                         color: Colors
// //                                             .black,
// //                                         fontWeight:
// //                                             FontWeight
// //                                                 .w500,
// //                                         fontSize:
// //                                             12),
// //                                     hintText:
// //                                         'Please Enter Project Name',
// //                                     hintStyle: FlutterFlowTheme.bodyText2.override(
// //                                         fontFamily:
// //                                             'Montserrat',
// //                                         color: Colors
// //                                             .black,
// //                                         fontWeight:
// //                                             FontWeight
// //                                                 .w500,
// //                                         fontSize:
// //                                             12),
// //                                     enabledBorder:
// //                                         UnderlineInputBorder(
// //                                       borderSide:
// //                                           BorderSide(
// //                                         color: Colors
// //                                             .transparent,
// //                                         width: 1,
// //                                       ),
// //                                       borderRadius:
// //                                           const BorderRadius
// //                                               .only(
// //                                         topLeft: Radius
// //                                             .circular(
// //                                                 4.0),
// //                                         topRight:
// //                                             Radius.circular(
// //                                                 4.0),
// //                                       ),
// //                                     ),
// //                                     focusedBorder:
// //                                         UnderlineInputBorder(
// //                                       borderSide:
// //                                           BorderSide(
// //                                         color: Colors
// //                                             .transparent,
// //                                         width: 1,
// //                                       ),
// //                                       borderRadius:
// //                                           const BorderRadius
// //                                               .only(
// //                                         topLeft: Radius
// //                                             .circular(
// //                                                 4.0),
// //                                         topRight:
// //                                             Radius.circular(
// //                                                 4.0),
// //                                       ),
// //                                     ),
// //                                   ),
// //                                   style: FlutterFlowTheme.bodyText2.override(
// //                                       fontFamily:
// //                                           'Montserrat',
// //                                       color: Colors
// //                                           .black,
// //                                       fontWeight:
// //                                           FontWeight
// //                                               .w500,
// //                                       fontSize:
// //                                           13),
// //                                 ),
// //                               ),
// //                             ),
// //                             SizedBox(
// //                               height: 10,
// //                             ),
// //                             Container(
// //                               width: 350,
// //                               height: 60,
// //                               decoration:
// //                                   BoxDecoration(
// //                                 color:
// //                                     Colors.white,
// //                                 borderRadius:
// //                                     BorderRadius
// //                                         .circular(
// //                                             8),
// //                                 border:
// //                                     Border.all(
// //                                   color: Color(
// //                                       0xFFE6E6E6),
// //                                 ),
// //                               ),
// //                               child: Padding(
// //                                 padding:
// //                                     EdgeInsets
// //                                         .fromLTRB(
// //                                             16,
// //                                             0,
// //                                             0,
// //                                             0),
// //                                 child:
// //                                     TextFormField(
// //                                   controller:
// //                                       topic,
// //                                   obscureText:
// //                                       false,
// //                                   decoration:
// //                                       InputDecoration(
// //                                     labelText:
// //                                         'Project Topic',
// //                                     labelStyle: FlutterFlowTheme.bodyText2.override(
// //                                         fontFamily:
// //                                             'Montserrat',
// //                                         color: Colors
// //                                             .black,
// //                                         fontWeight:
// //                                             FontWeight
// //                                                 .w500,
// //                                         fontSize:
// //                                             12),
// //                                     hintText:
// //                                         'Please Enter Project Topic',
// //                                     hintStyle: FlutterFlowTheme.bodyText2.override(
// //                                         fontFamily:
// //                                             'Montserrat',
// //                                         color: Colors
// //                                             .black,
// //                                         fontWeight:
// //                                             FontWeight
// //                                                 .w500,
// //                                         fontSize:
// //                                             12),
// //                                     enabledBorder:
// //                                         UnderlineInputBorder(
// //                                       borderSide:
// //                                           BorderSide(
// //                                         color: Colors
// //                                             .transparent,
// //                                         width: 1,
// //                                       ),
// //                                       borderRadius:
// //                                           const BorderRadius
// //                                               .only(
// //                                         topLeft: Radius
// //                                             .circular(
// //                                                 4.0),
// //                                         topRight:
// //                                             Radius.circular(
// //                                                 4.0),
// //                                       ),
// //                                     ),
// //                                     focusedBorder:
// //                                         UnderlineInputBorder(
// //                                       borderSide:
// //                                           BorderSide(
// //                                         color: Colors
// //                                             .transparent,
// //                                         width: 1,
// //                                       ),
// //                                       borderRadius:
// //                                           const BorderRadius
// //                                               .only(
// //                                         topLeft: Radius
// //                                             .circular(
// //                                                 4.0),
// //                                         topRight:
// //                                             Radius.circular(
// //                                                 4.0),
// //                                       ),
// //                                     ),
// //                                   ),
// //                                   style: FlutterFlowTheme.bodyText2.override(
// //                                       fontFamily:
// //                                           'Montserrat',
// //                                       color: Colors
// //                                           .black,
// //                                       fontWeight:
// //                                           FontWeight
// //                                               .w500,
// //                                       fontSize:
// //                                           12),
// //                                 ),
// //                               ),
// //                             ),
// //                             SizedBox(
// //                               height: 10,
// //                             ),
// //                             Container(
// //                               width: 350,
// //                               height: 60,
// //                               decoration:
// //                                   BoxDecoration(
// //                                 color:
// //                                     Colors.white,
// //                                 borderRadius:
// //                                     BorderRadius
// //                                         .circular(
// //                                             8),
// //                                 border:
// //                                     Border.all(
// //                                   color: Color(
// //                                       0xFFE6E6E6),
// //                                 ),
// //                               ),
// //                               child: Padding(
// //                                 padding:
// //                                     EdgeInsets
// //                                         .fromLTRB(
// //                                             16,
// //                                             0,
// //                                             0,
// //                                             0),
// //                                 child:
// //                                     TextFormField(
// //                                   controller:
// //                                       projectCost,
// //                                   obscureText:
// //                                       false,
// //                                   decoration:
// //                                       InputDecoration(
// //                                     labelText:
// //                                         'Project Cost',
// //                                     labelStyle: FlutterFlowTheme.bodyText2.override(
// //                                         fontFamily:
// //                                             'Montserrat',
// //                                         color: Colors
// //                                             .black,
// //                                         fontWeight:
// //                                             FontWeight
// //                                                 .w500,
// //                                         fontSize:
// //                                             12),
// //                                     hintText:
// //                                         'Please Enter Project Cost',
// //                                     hintStyle: FlutterFlowTheme.bodyText2.override(
// //                                         fontFamily:
// //                                             'Montserrat',
// //                                         color: Colors
// //                                             .black,
// //                                         fontWeight:
// //                                             FontWeight
// //                                                 .w500,
// //                                         fontSize:
// //                                             12),
// //                                     enabledBorder:
// //                                         UnderlineInputBorder(
// //                                       borderSide:
// //                                           BorderSide(
// //                                         color: Colors
// //                                             .transparent,
// //                                         width: 1,
// //                                       ),
// //                                       borderRadius:
// //                                           const BorderRadius
// //                                               .only(
// //                                         topLeft: Radius
// //                                             .circular(
// //                                                 4.0),
// //                                         topRight:
// //                                             Radius.circular(
// //                                                 4.0),
// //                                       ),
// //                                     ),
// //                                     focusedBorder:
// //                                         UnderlineInputBorder(
// //                                       borderSide:
// //                                           BorderSide(
// //                                         color: Colors
// //                                             .transparent,
// //                                         width: 1,
// //                                       ),
// //                                       borderRadius:
// //                                           const BorderRadius
// //                                               .only(
// //                                         topLeft: Radius
// //                                             .circular(
// //                                                 4.0),
// //                                         topRight:
// //                                             Radius.circular(
// //                                                 4.0),
// //                                       ),
// //                                     ),
// //                                   ),
// //                                   style: FlutterFlowTheme.bodyText2.override(
// //                                       fontFamily:
// //                                           'Montserrat',
// //                                       color: Colors
// //                                           .black,
// //                                       fontWeight:
// //                                           FontWeight
// //                                               .w500,
// //                                       fontSize:
// //                                           12),
// //                                 ),
// //                               ),
// //                             ),
// //                             SizedBox(
// //                               height: 10,
// //                             ),
// //                             Padding(
// //                               padding:
// //                                   EdgeInsetsDirectional
// //                                       .fromSTEB(
// //                                           0,
// //                                           0,
// //                                           8,
// //                                           0),
// //                               child:
// //                                   FFButtonWidget(
// //                                 onPressed: () {
// //                                   if (projectType != '' &&
// //                                       projectname !=
// //                                           '' &&
// //                                       topic !=
// //                                           '' &&
// //                                       projectCost !=
// //                                           '') {
// //                                     FirebaseFirestore
// //                                         .instance
// //                                         .collection(
// //                                             'customer')
// //                                         .doc(widget
// //                                             .id)
// //                                         .update({
// //                                       'projectType':
// //                                           projectType
// //                                               .text,
// //                                       'projectName':
// //                                           projectname
// //                                               .text,
// //                                       'projectTopic':
// //                                           topic
// //                                               .text,
// //                                       'projectCost':
// //                                           int.tryParse(
// //                                               projectCost.text),
// //                                     });
// //                                     showUploadMessage(
// //                                         context,
// //                                         'project details addes successfully');
// //                                   } else {
// //                                     projectType.text ==
// //                                             ''
// //                                         ? showUploadMessage(
// //                                             context,
// //                                             'Please Enter Project Type')
// //                                         : projectname.text ==
// //                                                 ''
// //                                             ? showUploadMessage(
// //                                                 context,
// //                                                 'Please Enter Project Name')
// //                                             : topic.text == ''
// //                                                 ? showUploadMessage(context, 'Please Enter Project Topic')
// //                                                 : showUploadMessage(context, 'Please Enter Project Cost');
// //                                   }
// //                                 },
// //                                 text: 'Update',
// //                                 options:
// //                                     FFButtonOptions(
// //                                   width: 80,
// //                                   height: 40,
// //                                   color: Color(
// //                                       0xff0054FF),
// //                                   textStyle:
// //                                       FlutterFlowTheme
// //                                           .subtitle2
// //                                           .override(
// //                                     fontFamily:
// //                                         'Lexend Deca',
// //                                     color: Colors
// //                                         .white,
// //                                     fontSize: 13,
// //                                     fontWeight:
// //                                         FontWeight
// //                                             .bold,
// //                                   ),
// //                                   elevation: 2,
// //                                   borderSide:
// //                                       BorderSide(
// //                                     color: Colors
// //                                         .transparent,
// //                                     width: 1,
// //                                   ),
// //                                   borderRadius:
// //                                       50,
// //                                 ),
// //                               ),
// //                             )
// //                           ],
// //                         ),
// //                       ),
// //                     ),
// //                   ),
// //                 ),
// //                 SizedBox(
// //                   width: 15,
// //                 ),
// //
// //                 //FollowUp and Status
// //                 Expanded(
// //                     flex: 2,
// //                     child: Column(
// //                       children: [
// //                         Material(
// //                           color:
// //                               Colors.transparent,
// //                           elevation: 10,
// //                           shape:
// //                               RoundedRectangleBorder(
// //                             borderRadius:
// //                                 BorderRadius
// //                                     .circular(20),
// //                           ),
// //                           child: Container(
// //                             height: MediaQuery.of(
// //                                     context)
// //                                 .size
// //                                 .height,
// //                             decoration:
// //                                 BoxDecoration(
// //                               color: Colors.white,
// //                               borderRadius:
// //                                   BorderRadius
// //                                       .circular(
// //                                           20),
// //                             ),
// //                             child: Padding(
// //                               padding:
// //                                   const EdgeInsets
// //                                       .all(20.0),
// //                               child: Column(
// //                                 children: [
// //                                   //Status TextField
// //                                   Padding(
// //                                     padding: EdgeInsetsDirectional
// //                                         .fromSTEB(
// //                                             30,
// //                                             5,
// //                                             30,
// //                                             5),
// //                                     child: Row(
// //                                       children: [
// //                                         Expanded(
// //                                           child:
// //                                               Material(
// //                                             color:
// //                                                 Colors.transparent,
// //                                             elevation:
// //                                                 10,
// //                                             shape:
// //                                                 RoundedRectangleBorder(
// //                                               borderRadius:
// //                                                   BorderRadius.circular(15),
// //                                             ),
// //                                             child:
// //                                                 Container(
// //                                               width:
// //                                                   350,
// //                                               height:
// //                                                   60,
// //                                               decoration:
// //                                                   BoxDecoration(
// //                                                 color: Colors.white,
// //                                                 borderRadius: BorderRadius.circular(8),
// //                                                 border: Border.all(
// //                                                   color: Color(0xFFE6E6E6),
// //                                                 ),
// //                                               ),
// //                                               child:
// //                                                   Padding(
// //                                                 padding: EdgeInsets.fromLTRB(16, 0, 0, 0),
// //                                                 child: CustomDropdown.search(
// //                                                   hintText: 'Select domain',
// //                                                   hintStyle: TextStyle(color: Colors.black),
// //                                                   items: domain,
// //                                                   controller: Domain,
// //                                                   // excludeSelected: false,
// //                                                   onChanged: (text) {
// //                                                     setState(() {});
// //                                                   },
// //                                                 ),
// //                                               ),
// //                                             ),
// //                                           ),
// //                                         ),
// //                                         SizedBox(
// //                                           width:
// //                                               10,
// //                                         ),
// //                                         Expanded(
// //                                           child:
// //                                               Material(
// //                                             color:
// //                                                 Colors.transparent,
// //                                             elevation:
// //                                                 10,
// //                                             shape:
// //                                                 RoundedRectangleBorder(
// //                                               borderRadius:
// //                                                   BorderRadius.circular(15),
// //                                             ),
// //                                             child:
// //                                                 Container(
// //                                               width:
// //                                                   350,
// //                                               height:
// //                                                   60,
// //                                               decoration:
// //                                                   BoxDecoration(
// //                                                 color: Colors.white,
// //                                                 borderRadius: BorderRadius.circular(8),
// //                                                 border: Border.all(
// //                                                   color: Color(0xFFE6E6E6),
// //                                                 ),
// //                                               ),
// //                                               child:
// //                                                   Padding(
// //                                                 padding: EdgeInsets.fromLTRB(16, 0, 0, 0),
// //                                                 child: TextFormField(
// //                                                   controller: platform,
// //                                                   obscureText: false,
// //                                                   decoration: InputDecoration(
// //                                                     labelText: 'Deliverables',
// //                                                     labelStyle: FlutterFlowTheme.bodyText2.override(fontFamily: 'Montserrat', color: Colors.black, fontWeight: FontWeight.w500, fontSize: 12),
// //                                                     hintText: 'Please Enter Deliverable',
// //                                                     hintStyle: FlutterFlowTheme.bodyText2.override(fontFamily: 'Montserrat', color: Colors.black, fontWeight: FontWeight.w500, fontSize: 12),
// //                                                     enabledBorder: UnderlineInputBorder(
// //                                                       borderSide: BorderSide(
// //                                                         color: Colors.transparent,
// //                                                         width: 1,
// //                                                       ),
// //                                                       borderRadius: const BorderRadius.only(
// //                                                         topLeft: Radius.circular(4.0),
// //                                                         topRight: Radius.circular(4.0),
// //                                                       ),
// //                                                     ),
// //                                                     focusedBorder: UnderlineInputBorder(
// //                                                       borderSide: BorderSide(
// //                                                         color: Colors.transparent,
// //                                                         width: 1,
// //                                                       ),
// //                                                       borderRadius: const BorderRadius.only(
// //                                                         topLeft: Radius.circular(4.0),
// //                                                         topRight: Radius.circular(4.0),
// //                                                       ),
// //                                                     ),
// //                                                   ),
// //                                                   style: FlutterFlowTheme.bodyText2.override(fontFamily: 'Montserrat', color: Colors.black, fontWeight: FontWeight.w500, fontSize: 12),
// //                                                 ),
// //                                               ),
// //                                             ),
// //                                           ),
// //                                         ),
// //                                         SizedBox(
// //                                           width:
// //                                               10,
// //                                         ),
// //                                         Expanded(
// //                                           child:
// //                                               Material(
// //                                             color:
// //                                                 Colors.transparent,
// //                                             elevation:
// //                                                 10,
// //                                             shape:
// //                                                 RoundedRectangleBorder(
// //                                               borderRadius:
// //                                                   BorderRadius.circular(15),
// //                                             ),
// //                                             child:
// //                                                 Container(
// //                                               width:
// //                                                   350,
// //                                               height:
// //                                                   60,
// //                                               decoration:
// //                                                   BoxDecoration(
// //                                                 color: Colors.white,
// //                                                 borderRadius: BorderRadius.circular(8),
// //                                                 border: Border.all(
// //                                                   color: Color(0xFFE6E6E6),
// //                                                 ),
// //                                               ),
// //                                               child:
// //                                                   Padding(
// //                                                 padding: EdgeInsets.fromLTRB(16, 0, 0, 0),
// //                                                 child: TextFormField(
// //                                                   controller: platform,
// //                                                   obscureText: false,
// //                                                   decoration: InputDecoration(
// //                                                     labelText: 'Platform',
// //                                                     labelStyle: FlutterFlowTheme.bodyText2.override(fontFamily: 'Montserrat', color: Colors.black, fontWeight: FontWeight.w500, fontSize: 12),
// //                                                     hintText: 'Please Enter Platform',
// //                                                     hintStyle: FlutterFlowTheme.bodyText2.override(fontFamily: 'Montserrat', color: Colors.black, fontWeight: FontWeight.w500, fontSize: 12),
// //                                                     enabledBorder: UnderlineInputBorder(
// //                                                       borderSide: BorderSide(
// //                                                         color: Colors.transparent,
// //                                                         width: 1,
// //                                                       ),
// //                                                       borderRadius: const BorderRadius.only(
// //                                                         topLeft: Radius.circular(4.0),
// //                                                         topRight: Radius.circular(4.0),
// //                                                       ),
// //                                                     ),
// //                                                     focusedBorder: UnderlineInputBorder(
// //                                                       borderSide: BorderSide(
// //                                                         color: Colors.transparent,
// //                                                         width: 1,
// //                                                       ),
// //                                                       borderRadius: const BorderRadius.only(
// //                                                         topLeft: Radius.circular(4.0),
// //                                                         topRight: Radius.circular(4.0),
// //                                                       ),
// //                                                     ),
// //                                                   ),
// //                                                   style: FlutterFlowTheme.bodyText2.override(fontFamily: 'Montserrat', color: Colors.black, fontWeight: FontWeight.w500, fontSize: 12),
// //                                                 ),
// //                                               ),
// //                                             ),
// //                                           ),
// //                                         ),
// //                                         SizedBox(
// //                                           width:
// //                                               10,
// //                                         ),
// //                                         Padding(
// //                                           padding: EdgeInsetsDirectional.fromSTEB(
// //                                               0,
// //                                               0,
// //                                               8,
// //                                               0),
// //                                           child:
// //                                               FFButtonWidget(
// //                                             onPressed:
// //                                                 () {
// //                                               if (Domain.text != '' &&
// //                                                   deliverable.text != '' &&
// //                                                   platform.text != '') {
// //                                                 List abc = [];
// //                                                 abc.add({
// //                                                   'domain': Domain.text,
// //                                                   'deliverable': deliverable.text,
// //                                                   'platform': platform.text,
// //                                                 });
// //                                                 
// //                                                 FirebaseFirestore.instance.collection('customer').doc(widget.id).update({
// //                                                   'projectDetails': FieldValue.arrayUnion(abc),
// //                                                 });
// //                                                 showUploadMessage(context, 'Project details added successfully');
// //
// //                                                 Domain.text = '';
// //                                                 deliverable.text = '';
// //                                                 platform.text = '';
// //                                               } else {
// //                                                 Domain.text == ''
// //                                                     ? showUploadMessage(context, 'Please Enter Domain')
// //                                                     : deliverable.text == ''
// //                                                         ? showUploadMessage(context, 'Please Enter Deliverable')
// //                                                         : showUploadMessage(context, 'Please Enter Platform');
// //                                               }
// //                                             },
// //                                             text:
// //                                                 'Add',
// //                                             options:
// //                                                 FFButtonOptions(
// //                                               width:
// //                                                   80,
// //                                               height:
// //                                                   40,
// //                                               color:
// //                                                   Color(0xff0054FF),
// //                                               textStyle:
// //                                                   FlutterFlowTheme.subtitle2.override(
// //                                                 fontFamily: 'Lexend Deca',
// //                                                 color: Colors.white,
// //                                                 fontSize: 13,
// //                                                 fontWeight: FontWeight.bold,
// //                                               ),
// //                                               elevation:
// //                                                   2,
// //                                               borderSide:
// //                                                   BorderSide(
// //                                                 color: Colors.transparent,
// //                                                 width: 1,
// //                                               ),
// //                                               borderRadius:
// //                                                   50,
// //                                             ),
// //                                           ),
// //                                         )
// //                                       ],
// //                                     ),
// //                                   ),
// //                                   SizedBox(
// //                                     width: MediaQuery.of(
// //                                                 context)
// //                                             .size
// //                                             .width *
// //                                         0.9,
// //                                     child: project
// //                                                 .length ==
// //                                             0
// //                                         ? Center(
// //                                             child:
// //                                                 Text(
// //                                             'No Details Added yet',
// //                                             style: FlutterFlowTheme.bodyText2.override(
// //                                                 fontFamily: 'Montserrat',
// //                                                 color: Color(0xFF8B97A2),
// //                                                 fontWeight: FontWeight.bold,
// //                                                 fontSize: 13),
// //                                           ))
// //                                         : DataTable(
// //                                             horizontalMargin:
// //                                                 12,
// //                                             columns: [
// //                                               DataColumn(
// //                                                 label: Text(
// //                                                   "Sl No",
// //                                                   style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
// //                                                 ),
// //                                               ),
// //                                               DataColumn(
// //                                                 label: Text("Domain", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
// //                                               ),
// //                                               DataColumn(
// //                                                 label: Text("Deliverables", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
// //                                               ),
// //                                               DataColumn(
// //                                                 label: Text("Platform", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
// //                                               ),
// //                                               DataColumn(
// //                                                 label: Text("", style: TextStyle(fontWeight: FontWeight.bold)),
// //                                               ),
// //                                             ],
// //                                             rows:
// //                                                 List.generate(
// //                                               project.length,
// //                                               (index) {
// //                                                 final data = project[index];
// //
// //                                                 return DataRow(
// //                                                   color: index.isOdd ? MaterialStateProperty.all(Colors.blueGrey.shade50.withOpacity(0.7)) : MaterialStateProperty.all(Colors.blueGrey.shade50),
// //                                                   cells: [
// //                                                     DataCell(Text((index + 1).toString(), style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12))),
// //                                                     DataCell(Text(data['name'], style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12))),
// //                                                     DataCell(Text(data['requirement'] ?? '', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12))),
// //                                                     DataCell(Text(data['platform'], style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12))),
// //                                                     DataCell(
// //                                                       Row(
// //                                                         children: [
// //                                                           // Generated code for this Button Widget...
// //                                                           FlutterFlowIconButton(
// //                                                             borderColor: Colors.transparent,
// //                                                             borderRadius: 30,
// //                                                             borderWidth: 1,
// //                                                             buttonSize: 50,
// //                                                             icon: Icon(
// //                                                               Icons.delete,
// //                                                               color: Color(0xFFEE0000),
// //                                                               size: 25,
// //                                                             ),
// //                                                             onPressed: () async {
// //                                                               bool pressed = await alert(context, 'Do you want Delete');
// //
// //                                                               if (pressed) {
// //                                                                 project.removeAt(index);
// //
// //                                                                 FirebaseFirestore.instance.collection('customer').doc(widget.id).update({
// //                                                                   'projectDetails': project,
// //                                                                 });
// //
// //                                                                 showUploadMessage(context, 'Details Deleted...');
// //                                                                 setState(() {});
// //                                                               }
// //                                                             },
// //                                                           ),
// //                                                         ],
// //                                                       ),
// //                                                     ),
// //                                                   ],
// //                                                 );
// //                                               },
// //                                             ),
// //                                           ),
// //                                   ),
// //                                   SizedBox(
// //                                     height: MediaQuery.of(
// //                                                 context)
// //                                             .size
// //                                             .height *
// //                                         0.010,
// //                                   ),
// //                                 ],
// //                               ),
// //                             ),
// //                           ),
// //                         )
// //                       ],
// //                     ))
// //               ],
// //             ),
// //           ),
// //         ],
// //       ),
// //     ),
// //   )
//
//

//
// InkWell(
// onTap: () async {
// selectFileToDownload(
// customerDocument
//     .keys
//     .elementAt(
// index),
// 'update',
// context);
// },
// child: Container(
// height: 70,
// width: 180,
// decoration:
// BoxDecoration(
// // color: Color(0xff0054FF),
// borderRadius:
// BorderRadius.circular(
// 15)),
// child: Center(
// child: Text(
// 'Edit',
// style:
// TextStyle(
// fontWeight:
// FontWeight
//     .bold,
// color: Colors
//     .blue,
// fontSize: 16,
// ),
// ),
// ),
// ),
// ),
// InkWell(
// onTap: () async {
// await downloadUrl(
// customerDocument
//     .values
//     .elementAt(
// index)[0]
// .toString());
// },
// child: Container(
// height: 40,
// width: 70,
// child: Center(
// child: Icon(
// Icons.download,
// size: 25,
// color:
// Colors.teal,
// )),
// ),
// )