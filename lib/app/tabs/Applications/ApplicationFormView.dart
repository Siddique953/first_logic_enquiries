import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:multiple_select/Item.dart';
import 'package:multiple_select/multi_filter_select.dart';
import 'package:searchfield/searchfield.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../flutter_flow/flutter_flow_drop_down.dart';
import '../../../flutter_flow/flutter_flow_theme.dart';
import '../../../flutter_flow/flutter_flow_util.dart';
import '../../../flutter_flow/flutter_flow_widgets.dart';

import 'package:flutter/material.dart';

class ApplicationFomrView extends StatefulWidget {
  final String name;
  final String eId;
  final String email;
  final String mobile;
  final String place;
  final String dob;
  final String ieltsScore;
  final String additionalInfo;
  final List educationalDetails;
  final List nameList;

  const ApplicationFomrView(
      {Key key,
      this.name,
      this.email,
      this.mobile,
      this.place,
      this.dob,
      this.ieltsScore,
      this.additionalInfo,
      this.educationalDetails,
      this.eId,
      this.nameList})
      : super(key: key);

  @override
  _ApplicationFomrViewState createState() => _ApplicationFomrViewState();
}

class _ApplicationFomrViewState extends State<ApplicationFomrView> {
  TextEditingController name;
  TextEditingController email;
  TextEditingController mobile;
  TextEditingController place;
  TextEditingController dob;
  TextEditingController additionalInfo;
  TextEditingController IELTSScore;
  TextEditingController course;
  TextEditingController country;
  TextEditingController address;
  TextEditingController fatherNo;
  TextEditingController fatherName;
  final scaffoldKey = GlobalKey<ScaffoldState>();

  String dropDownValue;

  List<String> countryList = [];
  List<String> inTakeList = [];
  List<String> courseList = [];
  List<Item> universityList = [];

  String selectedCourse = '';
  String selectedCountry = '';
  List selectedUniversities = [];

  DocumentSnapshot doc;
  Map<String, dynamic> courseNames = {};
  Map<String, dynamic> courseId = {};
  Map<String, dynamic> courseDuration = {};
  Map<String, dynamic> courseType = {};
  Map<String, dynamic> courseLink = {};
  Map<String, dynamic> countryNames = {};
  Map<String, dynamic> countryId = {};
  Map<String, dynamic> universityNameById = {};
  Map<String, dynamic> universityName = {};

  getCourse() async {
    QuerySnapshot data1 =
        await FirebaseFirestore.instance.collection("course").get();
    for (var doc in data1.docs) {
      courseList.add(doc.get('name'));
      courseNames[doc.get('name')] = doc.id;
      courseId[doc.id] = doc.get('name');
      courseDuration[doc.id] = doc.get('duration');
      courseType[doc.id] = doc.get('type');
      courseLink[doc.id] = doc.get('link');
    }
    if (mounted) {
      setState(() {});
    }
  }

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
    getCourse();
    getCountry();
    getUniversity();
    getInTakes();
    name = TextEditingController(text: widget.name);
    email = TextEditingController(text: widget.email);
    mobile = TextEditingController(text: widget.mobile);
    place = TextEditingController(text: widget.place);
    dob = TextEditingController(text: widget.dob);
    additionalInfo = TextEditingController(text: widget.additionalInfo);
    IELTSScore = TextEditingController(text: widget.ieltsScore);
    course = TextEditingController();
    country = TextEditingController();
    address = TextEditingController();
    fatherNo = TextEditingController();
    fatherName = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Color(0xFF383838)),
        automaticallyImplyLeading: true,
        title: Text(
          'Application Form',
          style: FlutterFlowTheme.title2.override(
            fontFamily: 'Lexend Deca',
            color: Color(0xFF090F13),
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
        actions: [],
        centerTitle: true,
        elevation: 5,
      ),
      backgroundColor: Colors.white,
      body: (universityNameById.length == 0 && courseId.length == 0)
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Padding(
              padding: EdgeInsetsDirectional.fromSTEB(16, 8, 16, 16),
              child: StreamBuilder<DocumentSnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection('applicationForms')
                      .doc(widget.eId)
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    doc = snapshot.data;
                    return SingleChildScrollView(
                      physics: BouncingScrollPhysics(),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Column(
                                  children: [
                                    Row(
                                      children: [
                                        Text('Customers Details',
                                            style: FlutterFlowTheme.title2
                                                .override(
                                              fontFamily: 'Lexend Deca',
                                              color: Color(0xFF090F13),
                                              fontSize: 20,
                                              fontWeight: FontWeight.w600,
                                            )),
                                      ],
                                    ),
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  10, 5, 10, 5),
                                          child: Row(
                                            mainAxisSize: MainAxisSize.max,
                                            children: [
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text('Title ',
                                                      style: FlutterFlowTheme
                                                          .title2
                                                          .override(
                                                        fontFamily:
                                                            'Lexend Deca',
                                                        color:
                                                            Color(0xFF090F13),
                                                        fontSize: 15,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                      )),
                                                  SizedBox(
                                                    height: 5,
                                                  ),
                                                  Text('Name  ',
                                                      style: FlutterFlowTheme
                                                          .title2
                                                          .override(
                                                        fontFamily:
                                                            'Lexend Deca',
                                                        color:
                                                            Color(0xFF090F13),
                                                        fontSize: 15,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                      )),
                                                  SizedBox(
                                                    height: 5,
                                                  ),
                                                  Text('Mobile  ',
                                                      style: FlutterFlowTheme
                                                          .title2
                                                          .override(
                                                        fontFamily:
                                                            'Lexend Deca',
                                                        color:
                                                            Color(0xFF090F13),
                                                        fontSize: 15,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                      )),
                                                  SizedBox(
                                                    height: 5,
                                                  ),
                                                  Text('DOB  ',
                                                      style: FlutterFlowTheme
                                                          .title2
                                                          .override(
                                                        fontFamily:
                                                            'Lexend Deca',
                                                        color:
                                                            Color(0xFF090F13),
                                                        fontSize: 15,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                      )),
                                                  SizedBox(
                                                    height: 5,
                                                  ),
                                                  Text('Place  ',
                                                      style: FlutterFlowTheme
                                                          .title2
                                                          .override(
                                                        fontFamily:
                                                            'Lexend Deca',
                                                        color:
                                                            Color(0xFF090F13),
                                                        fontSize: 15,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                      )),
                                                  SizedBox(
                                                    height: 5,
                                                  ),
                                                  Text('Gender  ',
                                                      style: FlutterFlowTheme
                                                          .title2
                                                          .override(
                                                        fontFamily:
                                                            'Lexend Deca',
                                                        color:
                                                            Color(0xFF090F13),
                                                        fontSize: 15,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                      )),
                                                  SizedBox(
                                                    height: 5,
                                                  ),
                                                  Text('IELTS  ',
                                                      style: FlutterFlowTheme
                                                          .title2
                                                          .override(
                                                        fontFamily:
                                                            'Lexend Deca',
                                                        color:
                                                            Color(0xFF090F13),
                                                        fontSize: 15,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                      )),
                                                  SizedBox(
                                                    height: 5,
                                                  ),
                                                ],
                                              ),
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(' : ',
                                                      style: FlutterFlowTheme
                                                          .title2
                                                          .override(
                                                        fontFamily:
                                                            'Lexend Deca',
                                                        color:
                                                            Color(0xFF090F13),
                                                        fontSize: 15,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                      )),
                                                  SizedBox(
                                                    height: 5,
                                                  ),
                                                  Text(' : ',
                                                      style: FlutterFlowTheme
                                                          .title2
                                                          .override(
                                                        fontFamily:
                                                            'Lexend Deca',
                                                        color:
                                                            Color(0xFF090F13),
                                                        fontSize: 15,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                      )),
                                                  SizedBox(
                                                    height: 5,
                                                  ),
                                                  Text(' : ',
                                                      style: FlutterFlowTheme
                                                          .title2
                                                          .override(
                                                        fontFamily:
                                                            'Lexend Deca',
                                                        color:
                                                            Color(0xFF090F13),
                                                        fontSize: 15,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                      )),
                                                  SizedBox(
                                                    height: 5,
                                                  ),
                                                  Text(' : ',
                                                      style: FlutterFlowTheme
                                                          .title2
                                                          .override(
                                                        fontFamily:
                                                            'Lexend Deca',
                                                        color:
                                                            Color(0xFF090F13),
                                                        fontSize: 15,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                      )),
                                                  SizedBox(
                                                    height: 5,
                                                  ),
                                                  Text(' : ',
                                                      style: FlutterFlowTheme
                                                          .title2
                                                          .override(
                                                        fontFamily:
                                                            'Lexend Deca',
                                                        color:
                                                            Color(0xFF090F13),
                                                        fontSize: 15,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                      )),
                                                  SizedBox(
                                                    height: 5,
                                                  ),
                                                  Text(' : ',
                                                      style: FlutterFlowTheme
                                                          .title2
                                                          .override(
                                                        fontFamily:
                                                            'Lexend Deca',
                                                        color:
                                                            Color(0xFF090F13),
                                                        fontSize: 15,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                      )),
                                                  SizedBox(
                                                    height: 5,
                                                  ),
                                                  Text(' : ',
                                                      style: FlutterFlowTheme
                                                          .title2
                                                          .override(
                                                        fontFamily:
                                                            'Lexend Deca',
                                                        color:
                                                            Color(0xFF090F13),
                                                        fontSize: 15,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                      )),
                                                  SizedBox(
                                                    height: 5,
                                                  ),
                                                ],
                                              ),
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  SelectableText(
                                                      doc.get('title'),
                                                      style: FlutterFlowTheme
                                                          .title2
                                                          .override(
                                                        fontFamily:
                                                            'Lexend Deca',
                                                        color:
                                                            Color(0xFF090F13),
                                                        fontSize: 15,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                      )),
                                                  SizedBox(
                                                    height: 5,
                                                  ),
                                                  SelectableText(
                                                      doc.get('name'),
                                                      style: FlutterFlowTheme
                                                          .title2
                                                          .override(
                                                        fontFamily:
                                                            'Lexend Deca',
                                                        color:
                                                            Color(0xFF090F13),
                                                        fontSize: 15,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                      )),
                                                  SizedBox(
                                                    height: 5,
                                                  ),
                                                  SelectableText(
                                                      doc.get('mobile'),
                                                      style: FlutterFlowTheme
                                                          .title2
                                                          .override(
                                                        fontFamily:
                                                            'Lexend Deca',
                                                        color:
                                                            Color(0xFF090F13),
                                                        fontSize: 15,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                      )),
                                                  SizedBox(
                                                    height: 5,
                                                  ),
                                                  SelectableText(doc.get('dob'),
                                                      style: FlutterFlowTheme
                                                          .title2
                                                          .override(
                                                        fontFamily:
                                                            'Lexend Deca',
                                                        color:
                                                            Color(0xFF090F13),
                                                        fontSize: 15,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                      )),
                                                  SizedBox(
                                                    height: 5,
                                                  ),
                                                  SelectableText(
                                                      doc.get('place'),
                                                      style: FlutterFlowTheme
                                                          .title2
                                                          .override(
                                                        fontFamily:
                                                            'Lexend Deca',
                                                        color:
                                                            Color(0xFF090F13),
                                                        fontSize: 15,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                      )),
                                                  SizedBox(
                                                    height: 5,
                                                  ),
                                                  SelectableText(
                                                      doc.get('gender'),
                                                      style: FlutterFlowTheme
                                                          .title2
                                                          .override(
                                                        fontFamily:
                                                            'Lexend Deca',
                                                        color:
                                                            Color(0xFF090F13),
                                                        fontSize: 15,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                      )),
                                                  SizedBox(
                                                    height: 5,
                                                  ),
                                                  SelectableText(
                                                      doc.get('ieltsScore'),
                                                      style: FlutterFlowTheme
                                                          .title2
                                                          .override(
                                                        fontFamily:
                                                            'Lexend Deca',
                                                        color:
                                                            Color(0xFF090F13),
                                                        fontSize: 15,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                      )),
                                                  SizedBox(
                                                    height: 5,
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  10, 5, 10, 5),
                                          child: Row(
                                            mainAxisSize: MainAxisSize.max,
                                            children: [
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text('PostCode ',
                                                      style: FlutterFlowTheme
                                                          .title2
                                                          .override(
                                                        fontFamily:
                                                            'Lexend Deca',
                                                        color:
                                                            Color(0xFF090F13),
                                                        fontSize: 15,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                      )),
                                                  SizedBox(
                                                    height: 5,
                                                  ),
                                                  Text('Address ',
                                                      style: FlutterFlowTheme
                                                          .title2
                                                          .override(
                                                        fontFamily:
                                                            'Lexend Deca',
                                                        color:
                                                            Color(0xFF090F13),
                                                        fontSize: 15,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                      )),
                                                  SizedBox(
                                                    height: 5,
                                                  ),
                                                  Text('Correspondence  ',
                                                      style: FlutterFlowTheme
                                                          .title2
                                                          .override(
                                                        fontFamily:
                                                            'Lexend Deca',
                                                        color:
                                                            Color(0xFF090F13),
                                                        fontSize: 15,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                      )),
                                                  SizedBox(
                                                    height: 5,
                                                  ),
                                                  Text('Parent Name  ',
                                                      style: FlutterFlowTheme
                                                          .title2
                                                          .override(
                                                        fontFamily:
                                                            'Lexend Deca',
                                                        color:
                                                            Color(0xFF090F13),
                                                        fontSize: 15,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                      )),
                                                  SizedBox(
                                                    height: 5,
                                                  ),
                                                  Text('Parent Mobile Number',
                                                      style: FlutterFlowTheme
                                                          .title2
                                                          .override(
                                                        fontFamily:
                                                            'Lexend Deca',
                                                        color:
                                                            Color(0xFF090F13),
                                                        fontSize: 15,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                      )),
                                                  SizedBox(
                                                    height: 5,
                                                  ),
                                                  Text('Intake',
                                                      style: FlutterFlowTheme
                                                          .title2
                                                          .override(
                                                        fontFamily:
                                                            'Lexend Deca',
                                                        color:
                                                            Color(0xFF090F13),
                                                        fontSize: 15,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                      )),
                                                  SizedBox(
                                                    height: 5,
                                                  ),
                                                  Text('Date of Issue',
                                                      style: FlutterFlowTheme
                                                          .title2
                                                          .override(
                                                        fontFamily:
                                                            'Lexend Deca',
                                                        color:
                                                            Color(0xFF090F13),
                                                        fontSize: 15,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                      )),
                                                  SizedBox(
                                                    height: 5,
                                                  ),
                                                ],
                                              ),
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(' : ',
                                                      style: FlutterFlowTheme
                                                          .title2
                                                          .override(
                                                        fontFamily:
                                                            'Lexend Deca',
                                                        color:
                                                            Color(0xFF090F13),
                                                        fontSize: 15,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                      )),
                                                  SizedBox(
                                                    height: 5,
                                                  ),
                                                  Text(' : ',
                                                      style: FlutterFlowTheme
                                                          .title2
                                                          .override(
                                                        fontFamily:
                                                            'Lexend Deca',
                                                        color:
                                                            Color(0xFF090F13),
                                                        fontSize: 15,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                      )),
                                                  SizedBox(
                                                    height: 5,
                                                  ),
                                                  Text(' : ',
                                                      style: FlutterFlowTheme
                                                          .title2
                                                          .override(
                                                        fontFamily:
                                                            'Lexend Deca',
                                                        color:
                                                            Color(0xFF090F13),
                                                        fontSize: 15,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                      )),
                                                  SizedBox(
                                                    height: 5,
                                                  ),
                                                  Text(' : ',
                                                      style: FlutterFlowTheme
                                                          .title2
                                                          .override(
                                                        fontFamily:
                                                            'Lexend Deca',
                                                        color:
                                                            Color(0xFF090F13),
                                                        fontSize: 15,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                      )),
                                                  SizedBox(
                                                    height: 5,
                                                  ),
                                                  Text(' : ',
                                                      style: FlutterFlowTheme
                                                          .title2
                                                          .override(
                                                        fontFamily:
                                                            'Lexend Deca',
                                                        color:
                                                            Color(0xFF090F13),
                                                        fontSize: 15,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                      )),
                                                  SizedBox(
                                                    height: 5,
                                                  ),
                                                  Text(' : ',
                                                      style: FlutterFlowTheme
                                                          .title2
                                                          .override(
                                                        fontFamily:
                                                            'Lexend Deca',
                                                        color:
                                                            Color(0xFF090F13),
                                                        fontSize: 15,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                      )),
                                                  SizedBox(
                                                    height: 5,
                                                  ),
                                                  Text(' : ',
                                                      style: FlutterFlowTheme
                                                          .title2
                                                          .override(
                                                        fontFamily:
                                                            'Lexend Deca',
                                                        color:
                                                            Color(0xFF090F13),
                                                        fontSize: 15,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                      )),
                                                  SizedBox(
                                                    height: 5,
                                                  ),
                                                ],
                                              ),
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  SelectableText(
                                                      doc.get('postCode'),
                                                      style: FlutterFlowTheme
                                                          .title2
                                                          .override(
                                                        fontFamily:
                                                            'Lexend Deca',
                                                        color:
                                                            Color(0xFF090F13),
                                                        fontSize: 15,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                      )),
                                                  SizedBox(
                                                    height: 5,
                                                  ),
                                                  SelectableText(
                                                      doc.get('address'),
                                                      style: FlutterFlowTheme
                                                          .title2
                                                          .override(
                                                        fontFamily:
                                                            'Lexend Deca',
                                                        color:
                                                            Color(0xFF090F13),
                                                        fontSize: 15,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                      )),
                                                  SizedBox(
                                                    height: 5,
                                                  ),
                                                  SelectableText(
                                                      doc.get('Correspondence'),
                                                      style: FlutterFlowTheme
                                                          .title2
                                                          .override(
                                                        fontFamily:
                                                            'Lexend Deca',
                                                        color:
                                                            Color(0xFF090F13),
                                                        fontSize: 15,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                      )),
                                                  SizedBox(
                                                    height: 5,
                                                  ),
                                                  SelectableText(
                                                      doc.get('fatherName'),
                                                      style: FlutterFlowTheme
                                                          .title2
                                                          .override(
                                                        fontFamily:
                                                            'Lexend Deca',
                                                        color:
                                                            Color(0xFF090F13),
                                                        fontSize: 15,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                      )),
                                                  SizedBox(
                                                    height: 5,
                                                  ),
                                                  SelectableText(
                                                      doc.get('fatherNumber'),
                                                      style: FlutterFlowTheme
                                                          .title2
                                                          .override(
                                                        fontFamily:
                                                            'Lexend Deca',
                                                        color:
                                                            Color(0xFF090F13),
                                                        fontSize: 15,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                      )),
                                                  SizedBox(
                                                    height: 5,
                                                  ),
                                                  SelectableText(
                                                      doc.get('inTake'),
                                                      style: FlutterFlowTheme
                                                          .title2
                                                          .override(
                                                        fontFamily:
                                                            'Lexend Deca',
                                                        color:
                                                            Color(0xFF090F13),
                                                        fontSize: 15,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                      )),
                                                  SizedBox(
                                                    height: 5,
                                                  ),
                                                  SelectableText(
                                                      dateTimeFormat(
                                                          'yMMM',
                                                          doc
                                                              .get('date')
                                                              .toDate()),
                                                      style: FlutterFlowTheme
                                                          .title2
                                                          .override(
                                                        fontFamily:
                                                            'Lexend Deca',
                                                        color:
                                                            Color(0xFF090F13),
                                                        fontSize: 15,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                      )),
                                                  SizedBox(
                                                    height: 5,
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  width: 50,
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text('Passport Details',
                                            style: FlutterFlowTheme.title2
                                                .override(
                                              fontFamily: 'Lexend Deca',
                                              color: Color(0xFF090F13),
                                              fontSize: 20,
                                              fontWeight: FontWeight.w600,
                                            )),
                                      ],
                                    ),
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  10, 5, 10, 5),
                                          child: Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisSize: MainAxisSize.max,
                                            children: [
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text('Passport No ',
                                                      style: FlutterFlowTheme
                                                          .title2
                                                          .override(
                                                        fontFamily:
                                                            'Lexend Deca',
                                                        color:
                                                            Color(0xFF090F13),
                                                        fontSize: 15,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                      )),
                                                  SizedBox(
                                                    height: 5,
                                                  ),
                                                  Text('Surname  ',
                                                      style: FlutterFlowTheme
                                                          .title2
                                                          .override(
                                                        fontFamily:
                                                            'Lexend Deca',
                                                        color:
                                                            Color(0xFF090F13),
                                                        fontSize: 15,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                      )),
                                                  SizedBox(
                                                    height: 5,
                                                  ),
                                                  Text('Given Name  ',
                                                      style: FlutterFlowTheme
                                                          .title2
                                                          .override(
                                                        fontFamily:
                                                            'Lexend Deca',
                                                        color:
                                                            Color(0xFF090F13),
                                                        fontSize: 15,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                      )),
                                                  SizedBox(
                                                    height: 5,
                                                  ),
                                                  Text('Nationality  ',
                                                      style: FlutterFlowTheme
                                                          .title2
                                                          .override(
                                                        fontFamily:
                                                            'Lexend Deca',
                                                        color:
                                                            Color(0xFF090F13),
                                                        fontSize: 15,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                      )),
                                                  SizedBox(
                                                    height: 5,
                                                  ),
                                                  Text('Place of Birth  ',
                                                      style: FlutterFlowTheme
                                                          .title2
                                                          .override(
                                                        fontFamily:
                                                            'Lexend Deca',
                                                        color:
                                                            Color(0xFF090F13),
                                                        fontSize: 15,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                      )),
                                                  SizedBox(
                                                    height: 5,
                                                  ),
                                                ],
                                              ),
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(' : ',
                                                      style: FlutterFlowTheme
                                                          .title2
                                                          .override(
                                                        fontFamily:
                                                            'Lexend Deca',
                                                        color:
                                                            Color(0xFF090F13),
                                                        fontSize: 15,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                      )),
                                                  SizedBox(
                                                    height: 5,
                                                  ),
                                                  Text(' : ',
                                                      style: FlutterFlowTheme
                                                          .title2
                                                          .override(
                                                        fontFamily:
                                                            'Lexend Deca',
                                                        color:
                                                            Color(0xFF090F13),
                                                        fontSize: 15,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                      )),
                                                  SizedBox(
                                                    height: 5,
                                                  ),
                                                  Text(' : ',
                                                      style: FlutterFlowTheme
                                                          .title2
                                                          .override(
                                                        fontFamily:
                                                            'Lexend Deca',
                                                        color:
                                                            Color(0xFF090F13),
                                                        fontSize: 15,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                      )),
                                                  SizedBox(
                                                    height: 5,
                                                  ),
                                                  Text(' : ',
                                                      style: FlutterFlowTheme
                                                          .title2
                                                          .override(
                                                        fontFamily:
                                                            'Lexend Deca',
                                                        color:
                                                            Color(0xFF090F13),
                                                        fontSize: 15,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                      )),
                                                  SizedBox(
                                                    height: 5,
                                                  ),
                                                  Text(' : ',
                                                      style: FlutterFlowTheme
                                                          .title2
                                                          .override(
                                                        fontFamily:
                                                            'Lexend Deca',
                                                        color:
                                                            Color(0xFF090F13),
                                                        fontSize: 15,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                      )),
                                                  SizedBox(
                                                    height: 5,
                                                  ),
                                                ],
                                              ),
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  SelectableText(
                                                      doc.get(
                                                          'passPort.passPortNo'),
                                                      style: FlutterFlowTheme
                                                          .title2
                                                          .override(
                                                        fontFamily:
                                                            'Lexend Deca',
                                                        color:
                                                            Color(0xFF090F13),
                                                        fontSize: 15,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                      )),
                                                  SizedBox(
                                                    height: 5,
                                                  ),
                                                  SelectableText(
                                                      doc.get(
                                                          'passPort.givenName'),
                                                      style: FlutterFlowTheme
                                                          .title2
                                                          .override(
                                                        fontFamily:
                                                            'Lexend Deca',
                                                        color:
                                                            Color(0xFF090F13),
                                                        fontSize: 15,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                      )),
                                                  SizedBox(
                                                    height: 5,
                                                  ),
                                                  SelectableText(
                                                      doc.get(
                                                          'passPort.surName'),
                                                      style: FlutterFlowTheme
                                                          .title2
                                                          .override(
                                                        fontFamily:
                                                            'Lexend Deca',
                                                        color:
                                                            Color(0xFF090F13),
                                                        fontSize: 15,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                      )),
                                                  SizedBox(
                                                    height: 5,
                                                  ),
                                                  SelectableText(
                                                      doc.get(
                                                          'passPort.nationality'),
                                                      style: FlutterFlowTheme
                                                          .title2
                                                          .override(
                                                        fontFamily:
                                                            'Lexend Deca',
                                                        color:
                                                            Color(0xFF090F13),
                                                        fontSize: 15,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                      )),
                                                  SizedBox(
                                                    height: 5,
                                                  ),
                                                  SelectableText(
                                                      doc.get(
                                                          'passPort.placeOfBirth'),
                                                      style: FlutterFlowTheme
                                                          .title2
                                                          .override(
                                                        fontFamily:
                                                            'Lexend Deca',
                                                        color:
                                                            Color(0xFF090F13),
                                                        fontSize: 15,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                      )),
                                                  SizedBox(
                                                    height: 5,
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  10, 5, 10, 5),
                                          child: Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisSize: MainAxisSize.max,
                                            children: [
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text('Date of Issued ',
                                                      style: FlutterFlowTheme
                                                          .title2
                                                          .override(
                                                        fontFamily:
                                                            'Lexend Deca',
                                                        color:
                                                            Color(0xFF090F13),
                                                        fontSize: 15,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                      )),
                                                  SizedBox(
                                                    height: 5,
                                                  ),
                                                  Text('Place of Issued',
                                                      style: FlutterFlowTheme
                                                          .title2
                                                          .override(
                                                        fontFamily:
                                                            'Lexend Deca',
                                                        color:
                                                            Color(0xFF090F13),
                                                        fontSize: 15,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                      )),
                                                  SizedBox(
                                                    height: 5,
                                                  ),
                                                  Text('Date of Expiry  ',
                                                      style: FlutterFlowTheme
                                                          .title2
                                                          .override(
                                                        fontFamily:
                                                            'Lexend Deca',
                                                        color:
                                                            Color(0xFF090F13),
                                                        fontSize: 15,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                      )),
                                                  SizedBox(
                                                    height: 5,
                                                  ),
                                                ],
                                              ),
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(' : ',
                                                      style: FlutterFlowTheme
                                                          .title2
                                                          .override(
                                                        fontFamily:
                                                            'Lexend Deca',
                                                        color:
                                                            Color(0xFF090F13),
                                                        fontSize: 15,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                      )),
                                                  SizedBox(
                                                    height: 5,
                                                  ),
                                                  Text(' : ',
                                                      style: FlutterFlowTheme
                                                          .title2
                                                          .override(
                                                        fontFamily:
                                                            'Lexend Deca',
                                                        color:
                                                            Color(0xFF090F13),
                                                        fontSize: 15,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                      )),
                                                  SizedBox(
                                                    height: 5,
                                                  ),
                                                  Text(' : ',
                                                      style: FlutterFlowTheme
                                                          .title2
                                                          .override(
                                                        fontFamily:
                                                            'Lexend Deca',
                                                        color:
                                                            Color(0xFF090F13),
                                                        fontSize: 15,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                      )),
                                                  SizedBox(
                                                    height: 5,
                                                  ),
                                                ],
                                              ),
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  SelectableText(
                                                      doc.get(
                                                          'passPort.dateOfIssued'),
                                                      style: FlutterFlowTheme
                                                          .title2
                                                          .override(
                                                        fontFamily:
                                                            'Lexend Deca',
                                                        color:
                                                            Color(0xFF090F13),
                                                        fontSize: 15,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                      )),
                                                  SizedBox(
                                                    height: 5,
                                                  ),
                                                  SelectableText(
                                                      doc.get(
                                                          'passPort.placeOfIssue'),
                                                      style: FlutterFlowTheme
                                                          .title2
                                                          .override(
                                                        fontFamily:
                                                            'Lexend Deca',
                                                        color:
                                                            Color(0xFF090F13),
                                                        fontSize: 15,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                      )),
                                                  SizedBox(
                                                    height: 5,
                                                  ),
                                                  SelectableText(
                                                      doc.get(
                                                          'passPort.dateOfExpiry'),
                                                      style: FlutterFlowTheme
                                                          .title2
                                                          .override(
                                                        fontFamily:
                                                            'Lexend Deca',
                                                        color:
                                                            Color(0xFF090F13),
                                                        fontSize: 15,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                      )),
                                                  SizedBox(
                                                    height: 5,
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Text('University Details',
                                            style: FlutterFlowTheme.title2
                                                .override(
                                              fontFamily: 'Lexend Deca',
                                              color: Color(0xFF090F13),
                                              fontSize: 20,
                                              fontWeight: FontWeight.w600,
                                            )),
                                      ],
                                    ),
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  10, 5, 10, 5),
                                          child: Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisSize: MainAxisSize.max,
                                            children: [
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text('University Name ',
                                                      style: FlutterFlowTheme
                                                          .title2
                                                          .override(
                                                        fontFamily:
                                                            'Lexend Deca',
                                                        color:
                                                            Color(0xFF090F13),
                                                        fontSize: 15,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                      )),
                                                  SizedBox(
                                                    height: 5,
                                                  ),
                                                  Text('Country  ',
                                                      style: FlutterFlowTheme
                                                          .title2
                                                          .override(
                                                        fontFamily:
                                                            'Lexend Deca',
                                                        color:
                                                            Color(0xFF090F13),
                                                        fontSize: 15,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                      )),
                                                  SizedBox(
                                                    height: 5,
                                                  ),
                                                  Text('Course  ',
                                                      style: FlutterFlowTheme
                                                          .title2
                                                          .override(
                                                        fontFamily:
                                                            'Lexend Deca',
                                                        color:
                                                            Color(0xFF090F13),
                                                        fontSize: 15,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                      )),
                                                  SizedBox(
                                                    height: 5,
                                                  ),
                                                  Text('Duration  ',
                                                      style: FlutterFlowTheme
                                                          .title2
                                                          .override(
                                                        fontFamily:
                                                            'Lexend Deca',
                                                        color:
                                                            Color(0xFF090F13),
                                                        fontSize: 15,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                      )),
                                                  SizedBox(
                                                    height: 5,
                                                  ),
                                                  Text('Type  ',
                                                      style: FlutterFlowTheme
                                                          .title2
                                                          .override(
                                                        fontFamily:
                                                            'Lexend Deca',
                                                        color:
                                                            Color(0xFF090F13),
                                                        fontSize: 15,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                      )),
                                                  SizedBox(
                                                    height: 5,
                                                  ),
                                                ],
                                              ),
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(' : ',
                                                      style: FlutterFlowTheme
                                                          .title2
                                                          .override(
                                                        fontFamily:
                                                            'Lexend Deca',
                                                        color:
                                                            Color(0xFF090F13),
                                                        fontSize: 15,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                      )),
                                                  SizedBox(
                                                    height: 5,
                                                  ),
                                                  Text(' : ',
                                                      style: FlutterFlowTheme
                                                          .title2
                                                          .override(
                                                        fontFamily:
                                                            'Lexend Deca',
                                                        color:
                                                            Color(0xFF090F13),
                                                        fontSize: 15,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                      )),
                                                  SizedBox(
                                                    height: 5,
                                                  ),
                                                  Text(' : ',
                                                      style: FlutterFlowTheme
                                                          .title2
                                                          .override(
                                                        fontFamily:
                                                            'Lexend Deca',
                                                        color:
                                                            Color(0xFF090F13),
                                                        fontSize: 15,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                      )),
                                                  SizedBox(
                                                    height: 5,
                                                  ),
                                                  Text(' : ',
                                                      style: FlutterFlowTheme
                                                          .title2
                                                          .override(
                                                        fontFamily:
                                                            'Lexend Deca',
                                                        color:
                                                            Color(0xFF090F13),
                                                        fontSize: 15,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                      )),
                                                  SizedBox(
                                                    height: 5,
                                                  ),
                                                  Text(' : ',
                                                      style: FlutterFlowTheme
                                                          .title2
                                                          .override(
                                                        fontFamily:
                                                            'Lexend Deca',
                                                        color:
                                                            Color(0xFF090F13),
                                                        fontSize: 15,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                      )),
                                                  SizedBox(
                                                    height: 5,
                                                  ),
                                                ],
                                              ),
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  SelectableText(
                                                      doc.get('university'),
                                                      style: FlutterFlowTheme
                                                          .title2
                                                          .override(
                                                        fontFamily:
                                                            'Lexend Deca',
                                                        color:
                                                            Color(0xFF090F13),
                                                        fontSize: 15,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                      )),
                                                  SizedBox(
                                                    height: 5,
                                                  ),
                                                  SelectableText(
                                                      countryId[
                                                          doc.get('countryId')],
                                                      style: FlutterFlowTheme
                                                          .title2
                                                          .override(
                                                        fontFamily:
                                                            'Lexend Deca',
                                                        color:
                                                            Color(0xFF090F13),
                                                        fontSize: 15,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                      )),
                                                  SizedBox(
                                                    height: 5,
                                                  ),
                                                  SelectableText(
                                                      courseId[
                                                          doc.get('courseId')],
                                                      style: FlutterFlowTheme
                                                          .title2
                                                          .override(
                                                        fontFamily:
                                                            'Lexend Deca',
                                                        color:
                                                            Color(0xFF090F13),
                                                        fontSize: 15,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                      )),
                                                  SizedBox(
                                                    height: 5,
                                                  ),
                                                  SelectableText(
                                                      courseDuration[
                                                          doc.get('courseId')],
                                                      style: FlutterFlowTheme
                                                          .title2
                                                          .override(
                                                        fontFamily:
                                                            'Lexend Deca',
                                                        color:
                                                            Color(0xFF090F13),
                                                        fontSize: 15,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                      )),
                                                  SizedBox(
                                                    height: 5,
                                                  ),
                                                  Row(
                                                    children: [
                                                      SelectableText(
                                                          courseType[doc
                                                              .get('courseId')],
                                                          style:
                                                              FlutterFlowTheme
                                                                  .title2
                                                                  .override(
                                                            fontFamily:
                                                                'Lexend Deca',
                                                            color: Color(
                                                                0xFF090F13),
                                                            fontSize: 15,
                                                            fontWeight:
                                                                FontWeight.w600,
                                                          )),
                                                      SizedBox(
                                                        width: 15,
                                                      ),
                                                      GestureDetector(
                                                        child: Text(
                                                            "Course Link",
                                                            style: TextStyle(
                                                                fontSize: 17,
                                                                decoration:
                                                                    TextDecoration
                                                                        .underline,
                                                                color: Colors
                                                                    .blue)),
                                                        onTap: () async {
                                                          String url =
                                                              courseLink[doc.get(
                                                                  'courseId')];
                                                          if (await canLaunch(
                                                              url)) launch(url);
                                                        },
                                                      ),
                                                    ],
                                                  ),
                                                  SizedBox(
                                                    height: 5,
                                                  ),
                                                  SizedBox(
                                                    height: 5,
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  }),
            ),
    );
  }
}
