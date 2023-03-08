import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';
import 'package:searchfield/searchfield.dart';
import '../../../auth/auth_util.dart';
import '../../../flutter_flow/flutter_flow_icon_button.dart';
import '../../../flutter_flow/flutter_flow_theme.dart';
import '../../../flutter_flow/flutter_flow_widgets.dart';
import '../../../flutter_flow/upload_media.dart';
import '../../app_widget.dart';
import '../../pages/home_page/home.dart';
import 'editProjects.dart';

class AddEnquiryWidget extends StatefulWidget {
  const AddEnquiryWidget({Key key}) : super(key: key);

  @override
  _AddEnquiryWidgetState createState() => _AddEnquiryWidgetState();
}

class _AddEnquiryWidgetState extends State<AddEnquiryWidget> {
  String uploadedFileUrl1 = '';
  String dropDownValue;
  String uploadedFileUrl2;
  TextEditingController name;
  TextEditingController place;
  TextEditingController mobile;
  TextEditingController email;
  TextEditingController description;
  TextEditingController domain;
  TextEditingController deliverables;
  TextEditingController platform;
  TextEditingController agentName;
  TextEditingController branch;
  TextEditingController selectedProjectType;
  TextEditingController projectName;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  List selectedCourse = [];

  List selectedCountry = [];

  List projectDetails = [];
  List<Map<String, dynamic>> projectList = [];

  String customerId = '';

  @override
  void initState() {
    super.initState();
    name = TextEditingController();
    place = TextEditingController();
    mobile = TextEditingController();
    description = TextEditingController();
    projectName = TextEditingController();
    domain = TextEditingController();
    deliverables = TextEditingController();
    platform = TextEditingController();
    email = TextEditingController(text: '');
    agentName = TextEditingController(text: '');
    branch = TextEditingController();
    selectedProjectType = TextEditingController();

    print(phnNumbers);
    print(customerDetailsByNumber);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: Color(0xFFECF0F5),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(20, 30, 20, 0),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Expanded(
                      child: Text(
                        'Add New Enquiry',
                        style: FlutterFlowTheme.bodyText1.override(
                          fontFamily: 'Poppins',
                          color: Colors.black,
                          fontSize: 25,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width * 0.8,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              //PERSONAL Details
                              Material(
                                color: Colors.transparent,
                                elevation: 3,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Container(
                                  // width: 950,
                                  decoration: BoxDecoration(
                                    color: Color(0xFFECF0F5),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        20, 10, 0, 20),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        SizedBox(
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.01,
                                        ),
                                        Text(
                                          'Enquiry Customer Details',
                                          style: FlutterFlowTheme.bodyText2
                                              .override(
                                            fontFamily: 'Montserrat',
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        SizedBox(
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.03,
                                        ),
                                        Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  5, 10, 30, 5),
                                          child: Row(
                                            children: [
                                              Expanded(
                                                child: Container(
                                                  width: 350,
                                                  height: 60,
                                                  decoration: BoxDecoration(
                                                    color: Colors.white,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8),
                                                    border: Border.all(
                                                      color: Color(0xFFE6E6E6),
                                                    ),
                                                  ),
                                                  child: Padding(
                                                    padding:
                                                        EdgeInsets.fromLTRB(
                                                            16, 0, 0, 0),
                                                    child: TextFormField(
                                                      controller: name,
                                                      obscureText: false,
                                                      decoration:
                                                          InputDecoration(
                                                        labelText: 'Name',
                                                        labelStyle: FlutterFlowTheme
                                                            .bodyText2
                                                            .override(
                                                                fontFamily:
                                                                    'Montserrat',
                                                                color: Colors
                                                                    .black,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500,
                                                                fontSize: 12),
                                                        hintText:
                                                            'Please Enter Name',
                                                        hintStyle: FlutterFlowTheme
                                                            .bodyText2
                                                            .override(
                                                                fontFamily:
                                                                    'Montserrat',
                                                                color: Colors
                                                                    .black,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500,
                                                                fontSize: 12),
                                                        enabledBorder:
                                                            UnderlineInputBorder(
                                                          borderSide:
                                                              BorderSide(
                                                            color: Colors
                                                                .transparent,
                                                            width: 1,
                                                          ),
                                                          borderRadius:
                                                              const BorderRadius
                                                                  .only(
                                                            topLeft:
                                                                Radius.circular(
                                                                    4.0),
                                                            topRight:
                                                                Radius.circular(
                                                                    4.0),
                                                          ),
                                                        ),
                                                        focusedBorder:
                                                            UnderlineInputBorder(
                                                          borderSide:
                                                              BorderSide(
                                                            color: Colors
                                                                .transparent,
                                                            width: 1,
                                                          ),
                                                          borderRadius:
                                                              const BorderRadius
                                                                  .only(
                                                            topLeft:
                                                                Radius.circular(
                                                                    4.0),
                                                            topRight:
                                                                Radius.circular(
                                                                    4.0),
                                                          ),
                                                        ),
                                                      ),
                                                      style: FlutterFlowTheme
                                                          .bodyText2
                                                          .override(
                                                              fontFamily:
                                                                  'Montserrat',
                                                              color: Color(
                                                                  0xFF8B97A2),
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                              fontSize: 13),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              SizedBox(
                                                width: 10,
                                              ),
                                              Expanded(
                                                child: Container(
                                                  width: 350,
                                                  height: 60,
                                                  decoration: BoxDecoration(
                                                    color: Colors.white,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8),
                                                    border: Border.all(
                                                      color: Color(0xFFE6E6E6),
                                                    ),
                                                  ),
                                                  child: Padding(
                                                    padding:
                                                        EdgeInsets.fromLTRB(
                                                            16, 0, 0, 0),
                                                    child: SearchField(
                                                      suggestions: phnNumbers,
                                                      controller: mobile,
                                                      hint:
                                                          'Please Enter Mobile Number',
                                                      searchStyle: FlutterFlowTheme
                                                          .bodyText2
                                                          .override(
                                                              fontFamily:
                                                                  'Montserrat',
                                                              color: Color(
                                                                  0xFF8B97A2),
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                              fontSize: 13),
                                                      searchInputDecoration:
                                                          InputDecoration(
                                                        labelText:
                                                            'Mobile Number',
                                                        labelStyle: FlutterFlowTheme
                                                            .bodyText2
                                                            .override(
                                                                fontFamily:
                                                                    'Montserrat',
                                                                color: Colors
                                                                    .black,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500,
                                                                fontSize: 12),
                                                        hintText:
                                                            'Please Enter Mobile Number',
                                                        hintStyle: FlutterFlowTheme
                                                            .bodyText2
                                                            .override(
                                                                fontFamily:
                                                                    'Montserrat',
                                                                color: Colors
                                                                    .black,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500,
                                                                fontSize: 12),
                                                        enabledBorder:
                                                            UnderlineInputBorder(
                                                          borderSide:
                                                              BorderSide(
                                                            color: Colors
                                                                .transparent,
                                                            width: 1,
                                                          ),
                                                          borderRadius:
                                                              const BorderRadius
                                                                  .only(
                                                            topLeft:
                                                                Radius.circular(
                                                                    4.0),
                                                            topRight:
                                                                Radius.circular(
                                                                    4.0),
                                                          ),
                                                        ),
                                                        focusedBorder:
                                                            UnderlineInputBorder(
                                                          borderSide:
                                                              BorderSide(
                                                            color: Colors
                                                                .transparent,
                                                            width: 1,
                                                          ),
                                                          borderRadius:
                                                              const BorderRadius
                                                                  .only(
                                                            topLeft:
                                                                Radius.circular(
                                                                    4.0),
                                                            topRight:
                                                                Radius.circular(
                                                                    4.0),
                                                          ),
                                                        ),
                                                      ),
                                                      onTap: (x) {
                                                        mobile.text = x;
                                                        name.text =
                                                            customerDetailsByNumber[
                                                                x]['name'];
                                                        place.text =
                                                            customerDetailsByNumber[
                                                                x]['place'];
                                                        email.text =
                                                            customerDetailsByNumber[
                                                                x]['email'];

                                                        customerId =
                                                            customerDetailsByNumber[
                                                                    x]
                                                                ['customerID'];

                                                        agentName
                                                            .text = customerDetailsByNumber[
                                                                        x]
                                                                    [
                                                                    'agentId'] ==
                                                                ''
                                                            ? ''
                                                            : agentDataById[
                                                                        customerDetailsByNumber[
                                                                                x]
                                                                            [
                                                                            'agentId']]
                                                                    [
                                                                    'mobileNumber'] ??
                                                                '';
                                                        // careOfNo.text =
                                                        //     customerDetailsByNumber[
                                                        //         x]['careOfNo'];

                                                        print(
                                                            '[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[customerId]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]');
                                                        print(customerId);
                                                      },
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              SizedBox(
                                                width: 10,
                                              ),
                                              Expanded(
                                                child: Container(
                                                  width: 350,
                                                  height: 60,
                                                  decoration: BoxDecoration(
                                                    color: Colors.white,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8),
                                                    border: Border.all(
                                                      color: Color(0xFFE6E6E6),
                                                    ),
                                                  ),
                                                  child: Padding(
                                                    padding:
                                                        EdgeInsets.fromLTRB(
                                                            16, 0, 0, 0),
                                                    child: TextFormField(
                                                      controller: email,
                                                      obscureText: false,
                                                      decoration:
                                                          InputDecoration(
                                                        labelText: 'Email',
                                                        labelStyle: FlutterFlowTheme
                                                            .bodyText2
                                                            .override(
                                                                fontFamily:
                                                                    'Montserrat',
                                                                color: Colors
                                                                    .black,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500,
                                                                fontSize: 12),
                                                        hintText:
                                                            'Please Enter Email',
                                                        hintStyle: FlutterFlowTheme
                                                            .bodyText2
                                                            .override(
                                                                fontFamily:
                                                                    'Montserrat',
                                                                color: Colors
                                                                    .black,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500,
                                                                fontSize: 12),
                                                        enabledBorder:
                                                            UnderlineInputBorder(
                                                          borderSide:
                                                              BorderSide(
                                                            color: Colors
                                                                .transparent,
                                                            width: 1,
                                                          ),
                                                          borderRadius:
                                                              const BorderRadius
                                                                  .only(
                                                            topLeft:
                                                                Radius.circular(
                                                                    4.0),
                                                            topRight:
                                                                Radius.circular(
                                                                    4.0),
                                                          ),
                                                        ),
                                                        focusedBorder:
                                                            UnderlineInputBorder(
                                                          borderSide:
                                                              BorderSide(
                                                            color: Colors
                                                                .transparent,
                                                            width: 1,
                                                          ),
                                                          borderRadius:
                                                              const BorderRadius
                                                                  .only(
                                                            topLeft:
                                                                Radius.circular(
                                                                    4.0),
                                                            topRight:
                                                                Radius.circular(
                                                                    4.0),
                                                          ),
                                                        ),
                                                      ),
                                                      style: FlutterFlowTheme
                                                          .bodyText2
                                                          .override(
                                                              fontFamily:
                                                                  'Montserrat',
                                                              color: Color(
                                                                  0xFF8B97A2),
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                              fontSize: 13),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              SizedBox(
                                                width: 10,
                                              ),
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  5, 10, 30, 5),
                                          child: Row(
                                            children: [
                                              Expanded(
                                                child: Container(
                                                  width: 350,
                                                  height: 60,
                                                  decoration: BoxDecoration(
                                                    color: Colors.white,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8),
                                                    border: Border.all(
                                                      color: Color(0xFFE6E6E6),
                                                    ),
                                                  ),
                                                  child: Padding(
                                                    padding:
                                                        EdgeInsets.fromLTRB(
                                                            16, 0, 0, 0),
                                                    child: TextFormField(
                                                      controller: place,
                                                      obscureText: false,
                                                      decoration:
                                                          InputDecoration(
                                                        labelText: 'Place',
                                                        labelStyle: FlutterFlowTheme
                                                            .bodyText2
                                                            .override(
                                                                fontFamily:
                                                                    'Montserrat',
                                                                color: Colors
                                                                    .black,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500,
                                                                fontSize: 12),
                                                        hintText:
                                                            'Please Enter Place Name',
                                                        hintStyle: FlutterFlowTheme
                                                            .bodyText2
                                                            .override(
                                                                fontFamily:
                                                                    'Montserrat',
                                                                color: Colors
                                                                    .black,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500,
                                                                fontSize: 12),
                                                        enabledBorder:
                                                            UnderlineInputBorder(
                                                          borderSide:
                                                              BorderSide(
                                                            color: Colors
                                                                .transparent,
                                                            width: 1,
                                                          ),
                                                          borderRadius:
                                                              const BorderRadius
                                                                  .only(
                                                            topLeft:
                                                                Radius.circular(
                                                                    4.0),
                                                            topRight:
                                                                Radius.circular(
                                                                    4.0),
                                                          ),
                                                        ),
                                                        focusedBorder:
                                                            UnderlineInputBorder(
                                                          borderSide:
                                                              BorderSide(
                                                            color: Colors
                                                                .transparent,
                                                            width: 1,
                                                          ),
                                                          borderRadius:
                                                              const BorderRadius
                                                                  .only(
                                                            topLeft:
                                                                Radius.circular(
                                                                    4.0),
                                                            topRight:
                                                                Radius.circular(
                                                                    4.0),
                                                          ),
                                                        ),
                                                      ),
                                                      style: FlutterFlowTheme
                                                          .bodyText2
                                                          .override(
                                                              fontFamily:
                                                                  'Montserrat',
                                                              color: Color(
                                                                  0xFF8B97A2),
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                              fontSize: 12),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              SizedBox(
                                                width: 10,
                                              ),
                                              Expanded(
                                                child: Container(
                                                  width: 350,
                                                  height: 60,
                                                  decoration: BoxDecoration(
                                                    color: Colors.white,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8),
                                                    border: Border.all(
                                                      color: Color(0xFFE6E6E6),
                                                    ),
                                                  ),
                                                  child: Padding(
                                                    padding:
                                                        EdgeInsets.fromLTRB(
                                                            16, 0, 0, 0),
                                                    child: SearchField(
                                                      suggestions:
                                                          agentNumberList,
                                                      controller: agentName,
                                                      hint:
                                                          'Please Enter Agent Name',
                                                      searchStyle: FlutterFlowTheme
                                                          .bodyText2
                                                          .override(
                                                              fontFamily:
                                                                  'Montserrat',
                                                              color: Color(
                                                                  0xFF8B97A2),
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                              fontSize: 13),
                                                      searchInputDecoration:
                                                          InputDecoration(
                                                        labelText:
                                                            'c/o Agent Number',
                                                        labelStyle: FlutterFlowTheme
                                                            .bodyText2
                                                            .override(
                                                                fontFamily:
                                                                    'Montserrat',
                                                                color: Colors
                                                                    .black,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500,
                                                                fontSize: 12),
                                                        hintText:
                                                            'Please Enter Agent Number',
                                                        hintStyle: FlutterFlowTheme
                                                            .bodyText2
                                                            .override(
                                                                fontFamily:
                                                                    'Montserrat',
                                                                color: Colors
                                                                    .black,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500,
                                                                fontSize: 12),
                                                        enabledBorder:
                                                            UnderlineInputBorder(
                                                          borderSide:
                                                              BorderSide(
                                                            color: Colors
                                                                .transparent,
                                                            width: 1,
                                                          ),
                                                          borderRadius:
                                                              const BorderRadius
                                                                  .only(
                                                            topLeft:
                                                                Radius.circular(
                                                                    4.0),
                                                            topRight:
                                                                Radius.circular(
                                                                    4.0),
                                                          ),
                                                        ),
                                                        focusedBorder:
                                                            UnderlineInputBorder(
                                                          borderSide:
                                                              BorderSide(
                                                            color: Colors
                                                                .transparent,
                                                            width: 1,
                                                          ),
                                                          borderRadius:
                                                              const BorderRadius
                                                                  .only(
                                                            topLeft:
                                                                Radius.circular(
                                                                    4.0),
                                                            topRight:
                                                                Radius.circular(
                                                                    4.0),
                                                          ),
                                                        ),
                                                      ),
                                                      onTap: (x) {
                                                        agentName.text = x;
                                                        setState(() {
                                                          print(x);
                                                        });
                                                      },
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              SizedBox(
                                                width: 10,
                                              ),
                                              Spacer(),
                                              // Expanded(
                                              //   child: Container(
                                              //     width: 350,
                                              //     height: 60,
                                              //     decoration: BoxDecoration(
                                              //       color: Colors.white,
                                              //       borderRadius:
                                              //           BorderRadius.circular(
                                              //               8),
                                              //       border: Border.all(
                                              //         color: Color(0xFFE6E6E6),
                                              //       ),
                                              //     ),
                                              //     child: Padding(
                                              //       padding:
                                              //           EdgeInsets.fromLTRB(
                                              //               16, 0, 0, 0),
                                              //       child: TextFormField(
                                              //         controller: careOfNo,
                                              //         obscureText: false,
                                              //         decoration:
                                              //             InputDecoration(
                                              //           labelText:
                                              //               'C/O Employee ID',
                                              //           labelStyle: FlutterFlowTheme
                                              //               .bodyText2
                                              //               .override(
                                              //                   fontFamily:
                                              //                       'Montserrat',
                                              //                   color: Colors
                                              //                       .black,
                                              //                   fontWeight:
                                              //                       FontWeight
                                              //                           .w500,
                                              //                   fontSize: 12),
                                              //           hintText:
                                              //               'Please Enter C/O Employee ID',
                                              //           hintStyle: FlutterFlowTheme
                                              //               .bodyText2
                                              //               .override(
                                              //                   fontFamily:
                                              //                       'Montserrat',
                                              //                   color: Colors
                                              //                       .black,
                                              //                   fontWeight:
                                              //                       FontWeight
                                              //                           .w500,
                                              //                   fontSize: 12),
                                              //           enabledBorder:
                                              //               UnderlineInputBorder(
                                              //             borderSide:
                                              //                 BorderSide(
                                              //               color: Colors
                                              //                   .transparent,
                                              //               width: 1,
                                              //             ),
                                              //             borderRadius:
                                              //                 const BorderRadius
                                              //                     .only(
                                              //               topLeft:
                                              //                   Radius.circular(
                                              //                       4.0),
                                              //               topRight:
                                              //                   Radius.circular(
                                              //                       4.0),
                                              //             ),
                                              //           ),
                                              //           focusedBorder:
                                              //               UnderlineInputBorder(
                                              //             borderSide:
                                              //                 BorderSide(
                                              //               color: Colors
                                              //                   .transparent,
                                              //               width: 1,
                                              //             ),
                                              //             borderRadius:
                                              //                 const BorderRadius
                                              //                     .only(
                                              //               topLeft:
                                              //                   Radius.circular(
                                              //                       4.0),
                                              //               topRight:
                                              //                   Radius.circular(
                                              //                       4.0),
                                              //             ),
                                              //           ),
                                              //         ),
                                              //         style: FlutterFlowTheme
                                              //             .bodyText2
                                              //             .override(
                                              //                 fontFamily:
                                              //                     'Montserrat',
                                              //                 color: Color(
                                              //                     0xFF8B97A2),
                                              //                 fontWeight:
                                              //                     FontWeight
                                              //                         .w500,
                                              //                 fontSize: 13),
                                              //       ),
                                              //     ),
                                              //   ),
                                              // ),
                                              SizedBox(
                                                width: 10,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),

                              //PROJECT DETAILS
                              Material(
                                color: Colors.transparent,
                                elevation: 3,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Container(
                                  // width: 950,
                                  decoration: BoxDecoration(
                                    color: Color(0xFFECF0F5),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        20, 10, 0, 20),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        SizedBox(
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.01,
                                        ),
                                        Text(
                                          'Project Details',
                                          style: FlutterFlowTheme.bodyText2
                                              .override(
                                            fontFamily: 'Montserrat',
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        SizedBox(
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.03,
                                        ),
                                        //type&topic
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            children: [
                                              Container(
                                                width: 400,
                                                height: 60,
                                                decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  borderRadius:
                                                      BorderRadius.circular(8),
                                                  border: Border.all(
                                                    color: Color(0xFFE6E6E6),
                                                  ),
                                                ),
                                                child: CustomDropdown.search(
                                                  hintText:
                                                      'Select project type',
                                                  hintStyle: TextStyle(
                                                      color: Colors.black),
                                                  items: projectTypeList,
                                                  controller:
                                                      selectedProjectType,
                                                  // excludeSelected: false,
                                                  onChanged: (text) {
                                                    setState(() {});
                                                  },
                                                ),
                                                // MultiFilterSelect(
                                                //   allItems: coursesList,
                                                //   initValue: selectedCourse,
                                                //   hintText: 'Preferred Course',
                                                //   selectCallback: (List selectedValue) =>
                                                //   selectedCourse = selectedValue,
                                                // )
                                              ),
                                              SizedBox(
                                                width: 10,
                                              ),
                                              Expanded(
                                                child: Container(
                                                  width: 350,
                                                  height: 60,
                                                  decoration: BoxDecoration(
                                                    color: Colors.white,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8),
                                                    border: Border.all(
                                                      color: Color(0xFFE6E6E6),
                                                    ),
                                                  ),
                                                  child: Padding(
                                                    padding:
                                                        EdgeInsets.fromLTRB(
                                                            16, 0, 0, 0),
                                                    child: TextFormField(
                                                      controller: projectName,
                                                      obscureText: false,
                                                      decoration:
                                                          InputDecoration(
                                                        labelText:
                                                            'Project Name',
                                                        labelStyle: FlutterFlowTheme
                                                            .bodyText2
                                                            .override(
                                                                fontFamily:
                                                                    'Montserrat',
                                                                color: Colors
                                                                    .black,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500,
                                                                fontSize: 12),
                                                        hintText:
                                                            'Please Enter Project Name',
                                                        hintStyle: FlutterFlowTheme
                                                            .bodyText2
                                                            .override(
                                                                fontFamily:
                                                                    'Montserrat',
                                                                color: Colors
                                                                    .black,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500,
                                                                fontSize: 12),
                                                        enabledBorder:
                                                            UnderlineInputBorder(
                                                          borderSide:
                                                              BorderSide(
                                                            color: Colors
                                                                .transparent,
                                                            width: 1,
                                                          ),
                                                          borderRadius:
                                                              const BorderRadius
                                                                  .only(
                                                            topLeft:
                                                                Radius.circular(
                                                                    4.0),
                                                            topRight:
                                                                Radius.circular(
                                                                    4.0),
                                                          ),
                                                        ),
                                                        focusedBorder:
                                                            UnderlineInputBorder(
                                                          borderSide:
                                                              BorderSide(
                                                            color: Colors
                                                                .transparent,
                                                            width: 1,
                                                          ),
                                                          borderRadius:
                                                              const BorderRadius
                                                                  .only(
                                                            topLeft:
                                                                Radius.circular(
                                                                    4.0),
                                                            topRight:
                                                                Radius.circular(
                                                                    4.0),
                                                          ),
                                                        ),
                                                      ),
                                                      style: FlutterFlowTheme
                                                          .bodyText2
                                                          .override(
                                                              fontFamily:
                                                                  'Montserrat',
                                                              color: Color(
                                                                  0xFF8B97A2),
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                              fontSize: 13),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              SizedBox(
                                                width: 10,
                                              ),
                                            ],
                                          ),
                                        ),

                                        //list&data table
                                        Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Row(
                                              children: [
                                                Expanded(
                                                  child: Container(
                                                    width: 350,
                                                    height: 60,
                                                    decoration: BoxDecoration(
                                                      color: Colors.white,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              8),
                                                      border: Border.all(
                                                        color:
                                                            Color(0xFFE6E6E6),
                                                      ),
                                                    ),
                                                    child: Padding(
                                                      padding:
                                                          EdgeInsets.fromLTRB(
                                                              16, 0, 0, 0),
                                                      child:
                                                          CustomDropdown.search(
                                                        hintText:
                                                            'Select domain',
                                                        hintStyle: TextStyle(
                                                            color:
                                                                Colors.black),
                                                        items: listOfDomain,
                                                        controller: domain,
                                                        // excludeSelected: false,
                                                        onChanged: (text) {
                                                          setState(() {});
                                                        },
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: 10,
                                                ),
                                                Expanded(
                                                  child: Container(
                                                    width: 350,
                                                    height: 60,
                                                    decoration: BoxDecoration(
                                                      color: Colors.white,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              8),
                                                      border: Border.all(
                                                        color:
                                                            Color(0xFFE6E6E6),
                                                      ),
                                                    ),
                                                    child: Padding(
                                                      padding:
                                                          EdgeInsets.fromLTRB(
                                                              16, 0, 0, 0),
                                                      child: TextFormField(
                                                        controller:
                                                            deliverables,
                                                        obscureText: false,
                                                        decoration:
                                                            InputDecoration(
                                                          labelText:
                                                              'Deliverables',
                                                          labelStyle: FlutterFlowTheme
                                                              .bodyText2
                                                              .override(
                                                                  fontFamily:
                                                                      'Montserrat',
                                                                  color: Colors
                                                                      .black,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500,
                                                                  fontSize: 12),
                                                          hintText:
                                                              'Please Enter Deliverable',
                                                          hintStyle: FlutterFlowTheme
                                                              .bodyText2
                                                              .override(
                                                                  fontFamily:
                                                                      'Montserrat',
                                                                  color: Colors
                                                                      .black,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500,
                                                                  fontSize: 12),
                                                          enabledBorder:
                                                              UnderlineInputBorder(
                                                            borderSide:
                                                                BorderSide(
                                                              color: Colors
                                                                  .transparent,
                                                              width: 1,
                                                            ),
                                                            borderRadius:
                                                                const BorderRadius
                                                                    .only(
                                                              topLeft: Radius
                                                                  .circular(
                                                                      4.0),
                                                              topRight: Radius
                                                                  .circular(
                                                                      4.0),
                                                            ),
                                                          ),
                                                          focusedBorder:
                                                              UnderlineInputBorder(
                                                            borderSide:
                                                                BorderSide(
                                                              color: Colors
                                                                  .transparent,
                                                              width: 1,
                                                            ),
                                                            borderRadius:
                                                                const BorderRadius
                                                                    .only(
                                                              topLeft: Radius
                                                                  .circular(
                                                                      4.0),
                                                              topRight: Radius
                                                                  .circular(
                                                                      4.0),
                                                            ),
                                                          ),
                                                        ),
                                                        style: FlutterFlowTheme
                                                            .bodyText2
                                                            .override(
                                                                fontFamily:
                                                                    'Montserrat',
                                                                color: Colors
                                                                    .black,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500,
                                                                fontSize: 12),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: 10,
                                                ),
                                                Expanded(
                                                  child: Container(
                                                    width: 350,
                                                    height: 60,
                                                    decoration: BoxDecoration(
                                                      color: Colors.white,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              8),
                                                      border: Border.all(
                                                        color:
                                                            Color(0xFFE6E6E6),
                                                      ),
                                                    ),
                                                    child: Padding(
                                                      padding:
                                                          EdgeInsets.fromLTRB(
                                                              16, 0, 0, 0),
                                                      child:
                                                          CustomDropdown.search(
                                                        hintText:
                                                            'Select Platform',
                                                        hintStyle: TextStyle(
                                                            color:
                                                                Colors.black),
                                                        items: platforms,
                                                        controller: platform,
                                                        // excludeSelected: false,
                                                        onChanged: (text) {
                                                          setState(() {});
                                                        },
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: 10,
                                                ),
                                                FFButtonWidget(
                                                  onPressed: () {
                                                    if (domain.text != '' &&
                                                        deliverables.text !=
                                                            '' &&
                                                        platform.text != '') {
                                                      projectDetails.add({
                                                        'domain': domain.text,
                                                        'deliverable':
                                                            deliverables.text,
                                                        'platform':
                                                            platform.text,
                                                      });
                                                      if (mounted) {
                                                        setState(() {});
                                                      }
                                                      print(projectDetails);

                                                      domain.text = '';
                                                      deliverables.text = '';
                                                      platform.text = '';
                                                    } else {
                                                      domain.text == ''
                                                          ? showUploadMessage(
                                                              context,
                                                              'Please Enter Domain')
                                                          : deliverables.text ==
                                                                  ''
                                                              ? showUploadMessage(
                                                                  context,
                                                                  'Please Enter Deliverable')
                                                              : showUploadMessage(
                                                                  context,
                                                                  'Please Enter Platform');
                                                    }
                                                  },
                                                  text: 'Add',
                                                  options: FFButtonOptions(
                                                    width: 80,
                                                    height: 40,
                                                    color: Color(0xff0054FF),
                                                    textStyle: FlutterFlowTheme
                                                        .subtitle2
                                                        .override(
                                                      fontFamily: 'Lexend Deca',
                                                      color: Colors.white,
                                                      fontSize: 13,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                    elevation: 2,
                                                    borderSide: BorderSide(
                                                      color: Colors.transparent,
                                                      width: 1,
                                                    ),
                                                    borderRadius: 50,
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: 10,
                                                ),
                                              ],
                                            )),
                                        SizedBox(
                                          width: double.infinity,
                                          child: projectDetails.length == 0
                                              ? Center(
                                                  child: Text(
                                                  'No Details Added...',
                                                  style: FlutterFlowTheme
                                                      .bodyText2
                                                      .override(
                                                          fontFamily:
                                                              'Montserrat',
                                                          color:
                                                              Color(0xFF8B97A2),
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 13),
                                                ))
                                              : DataTable(
                                                  horizontalMargin: 12,
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
                                                      label: Text("Name",
                                                          style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              fontSize: 12)),
                                                    ),
                                                    DataColumn(
                                                      label: Text("Requirement",
                                                          style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              fontSize: 12)),
                                                    ),
                                                    DataColumn(
                                                      label: Text("PlatForm",
                                                          style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              fontSize: 12)),
                                                    ),
                                                    DataColumn(
                                                      label: Text("",
                                                          style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold)),
                                                    ),
                                                  ],
                                                  rows: List.generate(
                                                    projectDetails.length,
                                                    (index) {
                                                      final data =
                                                          projectDetails[index];

                                                      return DataRow(
                                                        color: index.isOdd
                                                            ? MaterialStateProperty
                                                                .all(Colors
                                                                    .blueGrey
                                                                    .shade50
                                                                    .withOpacity(
                                                                        0.7))
                                                            : MaterialStateProperty
                                                                .all(Colors
                                                                    .blueGrey
                                                                    .shade50),
                                                        cells: [
                                                          DataCell(Text(
                                                              (index + 1)
                                                                  .toString(),
                                                              style: TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  fontSize:
                                                                      12))),
                                                          DataCell(Text(
                                                              data['domain'],
                                                              style: TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  fontSize:
                                                                      12))),
                                                          DataCell(Text(
                                                              data[
                                                                  'deliverable'],
                                                              style: TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  fontSize:
                                                                      12))),
                                                          DataCell(Text(
                                                              data['platform'],
                                                              style: TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  fontSize:
                                                                      12))),
                                                          DataCell(
                                                            Row(
                                                              children: [
                                                                // Generated code for this Button Widget...
                                                                FlutterFlowIconButton(
                                                                  borderColor:
                                                                      Colors
                                                                          .transparent,
                                                                  borderRadius:
                                                                      30,
                                                                  borderWidth:
                                                                      1,
                                                                  buttonSize:
                                                                      50,
                                                                  icon: Icon(
                                                                    Icons
                                                                        .delete,
                                                                    color: Color(
                                                                        0xFFEE0000),
                                                                    size: 25,
                                                                  ),
                                                                  onPressed:
                                                                      () async {
                                                                    bool
                                                                        pressed =
                                                                        await alert(
                                                                            context,
                                                                            'Do you want Delete');

                                                                    if (pressed) {
                                                                      projectDetails
                                                                          .removeAt(
                                                                              index);

                                                                      showUploadMessage(
                                                                          context,
                                                                          'Details Deleted...');
                                                                      setState(
                                                                          () {});
                                                                    }
                                                                  },
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                          // DataCell(Text(fileInfo.size)),
                                                        ],
                                                      );
                                                    },
                                                  ),
                                                ),
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),

                                        Padding(
                                          padding:
                                              EdgeInsetsDirectional.all(8.0),
                                          child: Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Expanded(
                                                child: Container(
                                                  width: 440,
                                                  decoration: BoxDecoration(
                                                    color: Colors.white,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8),
                                                    border: Border.all(
                                                      color: Color(0xFFE6E6E6),
                                                    ),
                                                  ),
                                                  child: Padding(
                                                    padding:
                                                        EdgeInsets.fromLTRB(
                                                            16, 0, 0, 0),
                                                    child: TextFormField(
                                                      controller: description,
                                                      obscureText: false,
                                                      maxLines: 4,
                                                      decoration:
                                                          InputDecoration(
                                                        labelText:
                                                            'Description',
                                                        labelStyle: FlutterFlowTheme
                                                            .bodyText2
                                                            .override(
                                                                fontFamily:
                                                                    'Montserrat',
                                                                color: Colors
                                                                    .black,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500,
                                                                fontSize: 12),
                                                        hintText:
                                                            'Enter Short description about the project',
                                                        hintStyle: FlutterFlowTheme
                                                            .bodyText2
                                                            .override(
                                                                fontFamily:
                                                                    'Montserrat',
                                                                color: Colors
                                                                    .black,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500,
                                                                fontSize: 12),
                                                        enabledBorder:
                                                            UnderlineInputBorder(
                                                          borderSide:
                                                              BorderSide(
                                                            color: Colors
                                                                .transparent,
                                                            width: 1,
                                                          ),
                                                          borderRadius:
                                                              const BorderRadius
                                                                  .only(
                                                            topLeft:
                                                                Radius.circular(
                                                                    4.0),
                                                            topRight:
                                                                Radius.circular(
                                                                    4.0),
                                                          ),
                                                        ),
                                                        focusedBorder:
                                                            UnderlineInputBorder(
                                                          borderSide:
                                                              BorderSide(
                                                            color: Colors
                                                                .transparent,
                                                            width: 1,
                                                          ),
                                                          borderRadius:
                                                              const BorderRadius
                                                                  .only(
                                                            topLeft:
                                                                Radius.circular(
                                                                    4.0),
                                                            topRight:
                                                                Radius.circular(
                                                                    4.0),
                                                          ),
                                                        ),
                                                      ),
                                                      style: FlutterFlowTheme
                                                          .bodyText2
                                                          .override(
                                                              fontFamily:
                                                                  'Montserrat',
                                                              color: Color(
                                                                  0xFF8B97A2),
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                              fontSize: 13),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              SizedBox(
                                                width: 10,
                                              ),
                                            ],
                                          ),
                                        ),

                                        Align(
                                          alignment: Alignment(0.95, 0),
                                          child: Padding(
                                            padding: EdgeInsets.fromLTRB(
                                                0, 16, 0, 0),
                                            child: FFButtonWidget(
                                              onPressed: () async {
                                                if (name.text != '' &&
                                                    mobile.text != '') {
                                                  if (agentName.text != '') {
                                                    if (!agentNumberList
                                                        .contains(
                                                            agentName.text)) {
                                                      return showUploadMessage(
                                                          context,
                                                          'Please add a Agent with this Number');
                                                    }
                                                  }

                                                  bool proceed = await alert(
                                                      context,
                                                      'You want to Add this Enquiry?');

                                                  if (proceed) {
                                                    DocumentSnapshot doc =
                                                        await FirebaseFirestore
                                                            .instance
                                                            .collection(
                                                                'settings')
                                                            .doc(
                                                                currentBranchId)
                                                            .get();
                                                    FirebaseFirestore.instance
                                                        .collection('settings')
                                                        .doc(currentBranchId)
                                                        .update({
                                                      'enquiryId':
                                                          FieldValue.increment(
                                                              1),
                                                    });
                                                    int enquiryId =
                                                        doc['enquiryId'];

                                                    FirebaseFirestore.instance
                                                        .collection('enquiries')
                                                        .doc('E' +
                                                            branchShortNameMap[
                                                                currentBranchId] +
                                                            enquiryId
                                                                .toString())
                                                        .set({
                                                      'status': 0,
                                                      'date': FieldValue
                                                          .serverTimestamp(),
                                                      'name': name.text,
                                                      'place': place.text,
                                                      'mobile': mobile.text,
                                                      'email': email.text,
                                                      'search': setSearchParam(
                                                          name.text +
                                                              " " +
                                                              mobile.text
                                                          // + "" +
                                                          // email.text
                                                          ),
                                                      'additionalInfo':
                                                          description.text ??
                                                              "",
                                                      'projectDetails':
                                                          projectDetails,
                                                      'projectType':
                                                          selectedProjectType
                                                              .text,
                                                      'countries':
                                                          selectedCountry,
                                                      'userId': currentUserUid,
                                                      'branch':
                                                          currentbranchName,
                                                      'branchId':
                                                          currentBranchId,
                                                      'userEmail':
                                                          currentUserEmail,
                                                      'check': false,
                                                      'converted': false,
                                                      // 'careOf':
                                                      //     agentName.text ?? '',
                                                      // 'careOfNo':
                                                      //     careOfNo.text ?? '',
                                                      'agentId':
                                                          agentIdByNumber[
                                                                  agentName
                                                                      .text] ??
                                                              '',
                                                      'enquiryId': 'E' +
                                                          branchShortNameMap[
                                                              currentBranchId] +
                                                          enquiryId.toString(),
                                                      'projectTopic':
                                                          projectName.text,
                                                      'customerId': customerId,
                                                    });
                                                    print(enquiryId.toString() +
                                                        ' %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%');
                                                    showUploadMessage(context,
                                                        'New Enquiry Added...');

                                                    setState(() {
                                                      name.text = '';
                                                      place.text = '';
                                                      email.text = '';
                                                      mobile.text = '';
                                                      description.text = '';
                                                      projectDetails = [];
                                                      branch.text = '';
                                                      selectedProjectType.text =
                                                          '';
                                                      projectName.text = '';

                                                      agentName.clear();
                                                      projectList = [];
                                                    });
                                                  }
                                                } else {
                                                  name.text == ''
                                                      ? showUploadMessage(
                                                          context,
                                                          'Please Enter Name')
                                                      : showUploadMessage(
                                                          context,
                                                          'Please Enter Phone Number');
                                                }
                                              },
                                              text: 'Add Enquiry',
                                              options: FFButtonOptions(
                                                width: 150,
                                                height: 50,
                                                color: Color(0xff0054FF),
                                                textStyle: FlutterFlowTheme
                                                    .subtitle2
                                                    .override(
                                                  fontFamily: 'Montserrat',
                                                  color: Colors.white,
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                                elevation: 2,
                                                borderSide: BorderSide(
                                                  color: Colors.transparent,
                                                  width: 2,
                                                ),
                                                borderRadius: 8,
                                              ),
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.symmetric(
                                              vertical: 10.0, horizontal: 0.0),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
