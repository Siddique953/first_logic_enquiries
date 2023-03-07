import 'dart:math';

import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:multiple_select/Item.dart';
import 'package:multiple_select/multi_filter_select.dart';
import '../../../auth/auth_util.dart';
import '../../../flutter_flow/flutter_flow_drop_down.dart';
import '../../../flutter_flow/flutter_flow_theme.dart';
import '../../../flutter_flow/flutter_flow_util.dart';
import '../../../flutter_flow/flutter_flow_widgets.dart';
import 'package:flutter/material.dart';
import '../../../flutter_flow/upload_media.dart';
import '../../app_widget.dart';
import '../../pages/home_page/home.dart';
import '../users/users/addBranchUser.dart';

class RegistrationFormWidget extends StatefulWidget {
  final String name;
  final String careOf;
  final String careOfNo;
  final String eId;
  final String email;
  final String mobile;
  final String place;
  final String dob;
  final String additionalInfo;
  final List projectDetails;
  final List nameList;
  final String selectedBranch;
  final List courses;

  const RegistrationFormWidget({
    Key key,
    this.name,
    this.email,
    this.mobile,
    this.place,
    this.dob,
    this.additionalInfo,
    this.eId,
    this.nameList,
    this.careOf,
    this.careOfNo,
    this.selectedBranch,
    this.courses,
    this.projectDetails,
  }) : super(key: key);

  @override
  _RegistrationFormWidgetState createState() => _RegistrationFormWidgetState();
}

class _RegistrationFormWidgetState extends State<RegistrationFormWidget> {
  TextEditingController firstName;
  TextEditingController lastName;
  TextEditingController email;
  TextEditingController mobile;
  TextEditingController place;
  TextEditingController dob;
  TextEditingController additionalInfo;
  TextEditingController branch;
  TextEditingController country;
  TextEditingController careOf;
  TextEditingController careOfNo;

  TextEditingController address;
  TextEditingController projectTopic;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  String dropDownValue;

  List<String> countryList = [];
  List<String> inTakeList = [];
  List courseList = [];
  List<Item> universityList = [];

  List selectedCourse = [];
  String selectedCountry;
  List selectedUniversities = [];

  Map<String, dynamic> courseNames = {};
  // Map<String,dynamic> courseId={};
  Map<String, dynamic> countryNames = {};
  Map<String, dynamic> countryId = {};
  Map<String, dynamic> universityNameById = {};
  Map<String, dynamic> universityName = {};

  //  getCourse() async {
  //   QuerySnapshot data1 =
  //   await FirebaseFirestore.instance.collection("course").get();
  //   for (var doc in data1.docs) {
  //
  //     courseList.add(Item.build(
  //       value: doc.id,
  //       display: doc.get('name'),
  //       content: doc.get('name').toString(),
  //     ));
  //     courseNames[doc.get('name')]=doc.id;
  //     courseId[doc.id]=doc.get('name');
  //
  //   }
  //   if(mounted){
  //     setState(() {
  //     });
  //   }
  // }
  getCountry() async {
    QuerySnapshot data1 =
        await FirebaseFirestore.instance.collection("country").get();
    for (var doc in data1.docs) {
      countryList.add(doc.get('name'));
      countryNames[doc.get('name')] = doc.id;
      countryId[doc.id] = doc.get('name');
    }
    if (mounted) {
      setState(() {});
    }
  }

  getUniversity() async {
    QuerySnapshot data1 =
        await FirebaseFirestore.instance.collection("university").get();
    // int rowIndex=1;
    for (var size in data1.docs) {
      print(size.get('name'));
      universityNameById[size.get('name')] = size.get('courses');
      universityName[size.id] = size.get('name');

      universityList.add(Item.build(
        value: size.id,
        display: size.get('name'),
        content: size.get('name').toString(),
      ));
    }
  }

  setSearchParam(String caseNumber) {
    List<String> caseSearchList = List<String>();
    String temp = "";

    List<String> nameSplits = caseNumber.split(" ");
    for (int i = 0; i < nameSplits.length; i++) {
      String name = "";

      for (int k = i; k < nameSplits.length; k++) {
        name = name + nameSplits[k] + " ";
      }
      temp = "";

      for (int j = 0; j < name.length; j++) {
        temp = temp + name[j];
        caseSearchList.add(temp.toUpperCase());
      }
    }
    return caseSearchList;
  }

  getInTakes() async {
    QuerySnapshot data1 = await FirebaseFirestore.instance
        .collection("intakes")
        .where('available', isEqualTo: true)
        .get();
    inTakeList = [];
    for (var doc in data1.docs) {
      inTakeList.add(dateTimeFormat('yMMM', doc.get('intake').toDate()));
    }
    if (mounted) {
      setState(() {});
    }
  }

  @override
  void initState() {
    super.initState();

    getCountry();
    getUniversity();
    getInTakes();
    firstName = TextEditingController(text: widget.name);
    lastName = TextEditingController(text: widget.name);
    email = TextEditingController(text: widget.email);
    mobile = TextEditingController(text: widget.mobile);
    place = TextEditingController(text: widget.place);
    dob = TextEditingController(text: widget.dob);
    additionalInfo = TextEditingController(text: widget.additionalInfo);

    branch = TextEditingController(text: widget.selectedBranch);
    careOf = TextEditingController(text: widget.careOf);
    careOfNo = TextEditingController(text: widget.careOfNo);

    address = TextEditingController();
    projectTopic = TextEditingController();

    // if(selectedCourse.length==0){
    //   selectedCourse=widget.courses;
    //
    // }
    // course.text = CourseId[courseList[0]];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        backgroundColor: Color(0xFFF1F4F8),
        iconTheme: IconThemeData(color: Color(0xFF383838)),
        automaticallyImplyLeading: true,
        title: Text(
          'Customers Registration Form',
          style: FlutterFlowTheme.title2.override(
            fontFamily: 'Lexend Deca',
            color: Color(0xFF090F13),
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
        actions: [],
        centerTitle: true,
        elevation: 0,
      ),
      backgroundColor: Color(0xFFF1F4F8),
      body: Padding(
        padding: EdgeInsetsDirectional.fromSTEB(16, 8, 16, 16),
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(30, 5, 30, 5),
                child: Row(
                  children: [
                    Expanded(
                      child: Container(
                        width: 330,
                        height: 60,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                            color: Color(0xFFE6E6E6),
                          ),
                        ),
                        child: Padding(
                          padding: EdgeInsets.fromLTRB(16, 0, 0, 0),
                          child: TextFormField(
                            controller: firstName,
                            obscureText: false,
                            decoration: InputDecoration(
                              labelText: 'First Name',
                              labelStyle: FlutterFlowTheme.bodyText2.override(
                                fontFamily: 'Montserrat',
                                color: Colors.black,
                                fontWeight: FontWeight.w500,
                              ),
                              hintText: 'Please Enter First Name',
                              hintStyle: FlutterFlowTheme.bodyText2.override(
                                fontFamily: 'Montserrat',
                                color: Colors.black,
                                fontWeight: FontWeight.w500,
                              ),
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
                              color: Colors.black,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 30,
                    ),
                    Expanded(
                      child: Container(
                        width: 330,
                        height: 60,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                            color: Color(0xFFE6E6E6),
                          ),
                        ),
                        child: Padding(
                          padding: EdgeInsets.fromLTRB(16, 0, 0, 0),
                          child: TextFormField(
                            controller: lastName,
                            obscureText: false,
                            decoration: InputDecoration(
                              labelText: 'Last Name',
                              labelStyle: FlutterFlowTheme.bodyText2.override(
                                fontFamily: 'Montserrat',
                                color: Colors.black,
                                fontWeight: FontWeight.w500,
                              ),
                              hintText: 'Please Enter Last Name',
                              hintStyle: FlutterFlowTheme.bodyText2.override(
                                fontFamily: 'Montserrat',
                                color: Colors.black,
                                fontWeight: FontWeight.w500,
                              ),
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
                              color: Colors.black,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 30,
                    ),
                    Expanded(
                      child: Container(
                        width: 330,
                        height: 60,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                            color: Color(0xFFE6E6E6),
                          ),
                        ),
                        child: Padding(
                          padding: EdgeInsets.fromLTRB(16, 0, 0, 0),
                          child: TextFormField(
                            controller: mobile,
                            obscureText: false,
                            decoration: InputDecoration(
                              labelText: 'Mobile',
                              labelStyle: FlutterFlowTheme.bodyText2.override(
                                fontFamily: 'Montserrat',
                                color: Colors.black,
                                fontWeight: FontWeight.w500,
                              ),
                              hintText: 'Please Enter Mobile',
                              hintStyle: FlutterFlowTheme.bodyText2.override(
                                fontFamily: 'Montserrat',
                                color: Colors.black,
                                fontWeight: FontWeight.w500,
                              ),
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
                              color: Colors.black,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(30, 5, 30, 5),
                child: Row(
                  children: [
                    Expanded(
                      child: Container(
                        width: 330,
                        height: 60,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                            color: Color(0xFFE6E6E6),
                          ),
                        ),
                        child: Padding(
                          padding: EdgeInsets.fromLTRB(16, 0, 0, 0),
                          child: TextFormField(
                            controller: email,
                            obscureText: false,
                            decoration: InputDecoration(
                              labelText: 'Email',
                              labelStyle: FlutterFlowTheme.bodyText2.override(
                                fontFamily: 'Montserrat',
                                color: Colors.black,
                                fontWeight: FontWeight.w500,
                              ),
                              hintText: 'Please Enter Email Address',
                              hintStyle: FlutterFlowTheme.bodyText2.override(
                                fontFamily: 'Montserrat',
                                color: Colors.black,
                                fontWeight: FontWeight.w500,
                              ),
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
                              color: Colors.black,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 30,
                    ),
                    Expanded(
                      child: Container(
                        width: 330,
                        height: 60,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                            color: Color(0xFFE6E6E6),
                          ),
                        ),
                        child: Padding(
                          padding: EdgeInsets.fromLTRB(16, 0, 0, 0),
                          child: TextFormField(
                            controller: place,
                            obscureText: false,
                            decoration: InputDecoration(
                              labelText: 'place',
                              labelStyle: FlutterFlowTheme.bodyText2.override(
                                fontFamily: 'Montserrat',
                                color: Colors.black,
                                fontWeight: FontWeight.w500,
                              ),
                              hintText: 'Please Enter place',
                              hintStyle: FlutterFlowTheme.bodyText2.override(
                                fontFamily: 'Montserrat',
                                color: Colors.black,
                                fontWeight: FontWeight.w500,
                              ),
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
                              color: Colors.black,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 30,
                    ),
                    Expanded(
                      child: Container(
                        width: 330,
                        height: 60,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                            color: Color(0xFFE6E6E6),
                          ),
                        ),
                        child: Padding(
                          padding: EdgeInsets.fromLTRB(16, 0, 0, 0),
                          child: TextFormField(
                            controller: dob,
                            obscureText: false,
                            decoration: InputDecoration(
                              labelText: 'Date of Birth',
                              labelStyle: FlutterFlowTheme.bodyText2.override(
                                fontFamily: 'Montserrat',
                                color: Colors.black,
                                fontWeight: FontWeight.w500,
                              ),
                              hintText: 'Please Enter Date of Birth',
                              hintStyle: FlutterFlowTheme.bodyText2.override(
                                fontFamily: 'Montserrat',
                                color: Colors.black,
                                fontWeight: FontWeight.w500,
                              ),
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
                              color: Colors.black,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(30, 5, 30, 5),
                child: Row(
                  children: [
                    Expanded(
                      child: Container(
                        width: 330,
                        height: 60,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                            color: Color(0xFFE6E6E6),
                          ),
                        ),
                        child: Padding(
                          padding: EdgeInsets.fromLTRB(16, 0, 0, 0),
                          child: TextFormField(
                            controller: careOf,
                            obscureText: false,
                            decoration: InputDecoration(
                              labelText: 'C/O',
                              labelStyle: FlutterFlowTheme.bodyText2.override(
                                fontFamily: 'Montserrat',
                                color: Colors.black,
                                fontWeight: FontWeight.w500,
                              ),
                              hintText: 'Please Enter Name',
                              hintStyle: FlutterFlowTheme.bodyText2.override(
                                fontFamily: 'Montserrat',
                                color: Colors.black,
                                fontWeight: FontWeight.w500,
                              ),
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
                              color: Colors.black,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 30,
                    ),
                    Expanded(
                      child: Container(
                        width: 330,
                        height: 60,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                            color: Color(0xFFE6E6E6),
                          ),
                        ),
                        child: Padding(
                          padding: EdgeInsets.fromLTRB(16, 0, 0, 0),
                          child: TextFormField(
                            controller: careOfNo,
                            obscureText: false,
                            decoration: InputDecoration(
                              labelText: 'C/O Number',
                              labelStyle: FlutterFlowTheme.bodyText2.override(
                                fontFamily: 'Montserrat',
                                color: Colors.black,
                                fontWeight: FontWeight.w500,
                              ),
                              hintText: 'Please Enter Mobile No',
                              hintStyle: FlutterFlowTheme.bodyText2.override(
                                fontFamily: 'Montserrat',
                                color: Colors.black,
                                fontWeight: FontWeight.w500,
                              ),
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
                              color: Colors.black,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                width: 30,
              ),
              SizedBox(
                width: 30,
              ),
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(30, 5, 30, 5),
                child: Row(
                  children: [
                    Expanded(
                      child: Container(
                        width: 330,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                            color: Color(0xFFE6E6E6),
                          ),
                        ),
                        child: Padding(
                          padding: EdgeInsets.fromLTRB(16, 0, 0, 0),
                          child: TextFormField(
                            maxLines: 5,
                            keyboardType: TextInputType.multiline,
                            controller: address,
                            obscureText: false,
                            decoration: InputDecoration(
                              labelText: 'address',
                              labelStyle: FlutterFlowTheme.bodyText2.override(
                                fontFamily: 'Montserrat',
                                color: Colors.black,
                                fontWeight: FontWeight.w500,
                              ),
                              hintText: 'Please Enter address',
                              hintStyle: FlutterFlowTheme.bodyText2.override(
                                fontFamily: 'Montserrat',
                                color: Colors.black,
                                fontWeight: FontWeight.w500,
                              ),
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
                              color: Colors.black,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 30,
                    ),
                    Expanded(
                      child: Container(
                        width: 330,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                            color: Color(0xFFE6E6E6),
                          ),
                        ),
                        child: Padding(
                          padding: EdgeInsets.fromLTRB(16, 0, 0, 0),
                          child: TextFormField(
                            controller: projectTopic,
                            obscureText: false,
                            decoration: InputDecoration(
                              labelText: 'pin code',
                              labelStyle: FlutterFlowTheme.bodyText2.override(
                                fontFamily: 'Montserrat',
                                color: Colors.black,
                                fontWeight: FontWeight.w500,
                              ),
                              hintText: 'Please Enter pin code',
                              hintStyle: FlutterFlowTheme.bodyText2.override(
                                fontFamily: 'Montserrat',
                                color: Colors.black,
                                fontWeight: FontWeight.w500,
                              ),
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
                              color: Colors.black,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 30,
                    ),
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.fromLTRB(16, 0, 0, 0),
                        child: Container(
                          width: 400,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(color: Color(0xFFE6E6E6)),
                          ),

                          // CustomDropdown.search(
                          //   hintText: 'Select course',
                          //   items: courses,
                          //   controller: course,
                          //   // excludeSelected: false,
                          //   onChanged: (text){
                          //     setState(() {
                          //
                          //     });
                          //
                          //   },
                          //
                          // ),

                          // MultiFilterSelect(
                          //   allItems: courseList,
                          //   initValue: selectedCourse,
                          //   hintText: 'Preferred Course',
                          //   selectCallback: (List selectedValue) =>
                          //   selectedCourse = selectedValue,
                          // )
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 30,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(0, 24, 0, 44),
                child: FFButtonWidget(
                  onPressed: () async {
                    if (firstName.text != '' &&
                        lastName.text != '' &&
                        mobile.text != '' &&
                        email.text != '' &&
                        place.text != '') {
                      bool pressed =
                          await alert(context, 'Register As Customer...');
                      if (pressed) {
                        DocumentSnapshot doc = await FirebaseFirestore.instance
                            .collection('settings')
                            .doc(currentBranchId)
                            .get();
                        FirebaseFirestore.instance
                            .collection('settings')
                            .doc(currentBranchId)
                            .update({
                          'customerId': FieldValue.increment(1),
                        });
                        int customerId = doc.get('customerId');
                        customerId++;

                        List list = [
                          {
                            'name': 'Personal Details',
                            'completed': false,
                          },
                          {
                            'name': 'Project Details',
                            'completed': false,
                          },
                          {
                            'name': 'Payment Details',
                            'completed': false,
                          },
                        ];

                        List statusList = [];

                        statusList.add({
                          'date': DateTime.now(),
                          'status': 'Registered',
                          'comments': '',
                          'link': '',
                          'customerId': 'C' +
                              currentbranchShortName +
                              customerId.toString(),
                          'userId': currentUserUid,
                          'branchId': currentBranchId,
                        });

                        FirebaseFirestore.instance
                            .collection('customer')
                            .doc('C' +
                                currentbranchShortName +
                                customerId.toString())
                            .set({
                          'enquiryId': widget.eId,
                          'form': list,
                          'image': '',
                          'date': DateTime.now(),
                          'status': 0,
                          'name': firstName.text,
                          'lastName': lastName.text,
                          'mobile': mobile.text,
                          'countryCode': 'IN',
                          'phoneCode': '+91',
                          'email': email.text,
                          'dob': dob.text,
                          'nationality': selectedCountry,
                          'place': widget.place,
                          'experience': '',
                          'travelHistory': [],
                          'educationalDetails': widget.projectDetails,
                          'ieltsScore': '',
                          'address': address.text,
                          'university': [],
                          'branchId': currentBranchId,
                          'userId': currentUserUid,
                          'currentStatus': 'Registered',
                          'nextStatus': 'Document Collection',
                          'search': setSearchParam(mobile.text),
                          'comments': '',
                          'documents': {},
                          'newDocuments': {},
                          'referenceDetails': [],
                          'inTake': '',
                          'careOf': careOf.text ?? '',
                          'careOfNo': careOfNo.text ?? '',
                          'statusList': FieldValue.arrayUnion(statusList),
                          'additionalInfo': additionalInfo.text,
                          'branch': widget.selectedBranch,
                          'projectTopic': projectTopic.text,
                          'feeDetails': [],
                          'photo': '',
                        }).then((value) {
                          FirebaseFirestore.instance.collection('status').add({
                            'date': DateTime.now(),
                            'status': 'Registered',
                            'comments': '',
                            'link': '',
                            'customerId': 'C' +
                                currentbranchShortName +
                                customerId.toString(),
                            'userId': currentUserUid,
                            'branchId': currentBranchId,
                          });

                          FirebaseFirestore.instance
                              .collection('enquiry')
                              .doc(widget.eId)
                              .update({
                            'status': 1,
                            'customerId': 'C' +
                                currentbranchShortName +
                                customerId.toString(),
                          });
                        });
                        showUploadMessage(
                            context, 'New customer Registered...');

                        Navigator.pop(context);
                        Navigator.pop(context);
                      }
                    } else {
                      firstName.text == ''
                          ? showUploadMessage(
                              context, 'Please Enter First Name')
                          : lastName.text == ''
                              ? showUploadMessage(
                                  context, 'Please Enter Last Place')
                              : mobile.text == ''
                                  ? showUploadMessage(
                                      context, 'Please Enter Mobile Number')
                                  : showUploadMessage(
                                      context, 'Please Enter Email');
                    }
                  },
                  text: 'Register As Customer',
                  options: FFButtonOptions(
                    width: 200,
                    height: 50,
                    color: Color(0xFF4B39EF),
                    textStyle: FlutterFlowTheme.subtitle2.override(
                      fontFamily: 'Lexend Deca',
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                    elevation: 2,
                    borderSide: BorderSide(
                      color: Colors.transparent,
                      width: 1,
                    ),
                    borderRadius: 10,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
