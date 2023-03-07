import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:multiple_select/Item.dart';
import '../../../auth/auth_util.dart';
import '../../../flutter_flow/flutter_flow_drop_down.dart';
import '../../../flutter_flow/flutter_flow_theme.dart';
import '../../../flutter_flow/flutter_flow_util.dart';
import '../../../flutter_flow/flutter_flow_widgets.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../flutter_flow/upload_media.dart';
import '../../app_widget.dart';
import '../Branch/SelectBranches.dart';

class ApplicationForm extends StatefulWidget {
  final String name;
  final String university;
  final String countryId;
  final String courseId;
  final String id;
  final String email;
  final String mobile;
  final String place;
  final String dob;
  final String ieltsScore;
  final String address;
  final String fatherName;
  final String fatherNo;
  final int application;
  final List educationalDetails;
  final List nameList;

  const ApplicationForm(
      {Key key,
      this.name,
      this.email,
      this.mobile,
      this.place,
      this.dob,
      this.ieltsScore,
      this.address,
      this.educationalDetails,
      this.id,
      this.nameList,
      this.university,
      this.fatherName,
      this.fatherNo,
      this.application,
      this.countryId,
      this.courseId})
      : super(key: key);

  @override
  _ApplicationFormState createState() => _ApplicationFormState();
}

class _ApplicationFormState extends State<ApplicationForm> {
  TextEditingController name;
  String title = 'Mr';
  TextEditingController email;
  TextEditingController mobile;
  TextEditingController place;
  TextEditingController dob;
  TextEditingController Correspondence;
  TextEditingController IELTSScore;
  TextEditingController course;
  TextEditingController country;
  TextEditingController address;
  TextEditingController fatherNo;
  TextEditingController fatherName;
  TextEditingController postCode;
  TextEditingController passportNo;
  TextEditingController passportIssueDate;
  TextEditingController passportPlaceofIssue;
  TextEditingController passportExpDate;
  TextEditingController passportSurName;
  TextEditingController passportGivenName;
  TextEditingController passportPlaceofBirth;
  TextEditingController nationality;
  final scaffoldKey = GlobalKey<ScaffoldState>();

  String dropDownValue;
  bool gender = false;

  List<String> countryList = [];
  List<String> inTakeList = [];
  List<String> courseList = [];
  List<Item> universityList = [];

  String selectedCourse = '';
  String selectedCountry = '';
  List selectedUniversities = [];

  Map<String, dynamic> courseNames = {};
  Map<String, dynamic> courseId = {};
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
    address = TextEditingController(text: widget.address);
    IELTSScore = TextEditingController(text: widget.ieltsScore);
    Correspondence = TextEditingController(text: widget.address);
    course = TextEditingController();
    country = TextEditingController();
    address = TextEditingController(text: widget.address);
    fatherNo = TextEditingController(text: widget.fatherNo);
    fatherName = TextEditingController(text: widget.fatherName);
    postCode = TextEditingController();
    passportIssueDate = TextEditingController();
    passportExpDate = TextEditingController();
    passportGivenName = TextEditingController();
    passportNo = TextEditingController();
    passportPlaceofIssue = TextEditingController();
    passportSurName = TextEditingController();
    passportPlaceofBirth = TextEditingController();
    nationality = TextEditingController(text: 'INDIAN');
  }

  int _radioSelected = 1;
  String _radioVal;

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
      body: (inTakeList.length == 0 &&
              universityNameById.length == 0 &&
              courseId.length == 0)
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Padding(
              padding: EdgeInsetsDirectional.fromSTEB(16, 8, 16, 16),
              child: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text('Customers Details',
                          style: FlutterFlowTheme.title2.override(
                            fontFamily: 'Lexend Deca',
                            color: Color(0xFF090F13),
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                          )),
                    ),
                    // Generated code for this DropDown Widget...
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(10, 5, 10, 5),
                      child: Row(
                        children: [
                          FlutterFlowDropDown(
                            initialOption: title ?? 'Mr',
                            options: ['Mr', 'Mrs', 'Miss', 'Ms'].toList(),
                            onChanged: (val) => setState(() => title = val),
                            width: 180,
                            height: 50,
                            textStyle: FlutterFlowTheme.bodyText1.override(
                              fontFamily: 'Poppins',
                              color: Colors.black,
                            ),
                            hintText: 'Please select Title...',
                            fillColor: Colors.white,
                            elevation: 2,
                            borderColor: Colors.black,
                            borderWidth: 0,
                            borderRadius: 0,
                            margin:
                                EdgeInsetsDirectional.fromSTEB(12, 4, 12, 4),
                            hidesUnderline: true,
                          ),
                          SizedBox(
                            width: 60,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text('Male',
                                  style: FlutterFlowTheme.title2.override(
                                    fontFamily: 'Lexend Deca',
                                    color: Color(0xFF090F13),
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600,
                                  )),
                              Radio(
                                value: 1,
                                groupValue: _radioSelected,
                                activeColor: Colors.blue,
                                onChanged: (value) {
                                  setState(() {
                                    _radioSelected = value;
                                    _radioVal = 'Male';
                                  });
                                },
                              ),
                              Text('Female',
                                  style: FlutterFlowTheme.title2.override(
                                    fontFamily: 'Lexend Deca',
                                    color: Color(0xFF090F13),
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600,
                                  )),
                              Radio(
                                value: 2,
                                groupValue: _radioSelected,
                                activeColor: Colors.pink,
                                onChanged: (value) {
                                  setState(() {
                                    _radioSelected = value;
                                    _radioVal = 'Female';
                                  });
                                },
                              )
                            ],
                          ),
                          SizedBox(
                            width: 30,
                          ),
                          Expanded(
                            child: Row(
                              children: [
                                Expanded(
                                  child: TextFormField(
                                    controller: name,
                                    obscureText: false,
                                    decoration: InputDecoration(
                                      isDense: true,
                                      labelText: 'Name',
                                      hintText: 'Please Enter Name',
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Colors.black,
                                          width: 1,
                                        ),
                                        borderRadius: const BorderRadius.only(
                                          topLeft: Radius.circular(4.0),
                                          topRight: Radius.circular(4.0),
                                        ),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Colors.black,
                                          width: 1,
                                        ),
                                        borderRadius: const BorderRadius.only(
                                          topLeft: Radius.circular(4.0),
                                          topRight: Radius.circular(4.0),
                                        ),
                                      ),
                                    ),
                                    style: FlutterFlowTheme.bodyText1,
                                  ),
                                ),
                                SizedBox(
                                  width: 30,
                                ),
                                Expanded(
                                  child: TextFormField(
                                    controller: dob,
                                    obscureText: false,
                                    decoration: InputDecoration(
                                      isDense: true,
                                      labelText: 'DOB',
                                      hintText: 'Please Enter Dob',
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Colors.black,
                                          width: 1,
                                        ),
                                        borderRadius: const BorderRadius.only(
                                          topLeft: Radius.circular(4.0),
                                          topRight: Radius.circular(4.0),
                                        ),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Colors.black,
                                          width: 1,
                                        ),
                                        borderRadius: const BorderRadius.only(
                                          topLeft: Radius.circular(4.0),
                                          topRight: Radius.circular(4.0),
                                        ),
                                      ),
                                    ),
                                    style: FlutterFlowTheme.bodyText1,
                                  ),
                                ),
                                SizedBox(
                                  width: 30,
                                ),
                                Expanded(
                                  child: TextFormField(
                                    controller: mobile,
                                    obscureText: false,
                                    decoration: InputDecoration(
                                      isDense: true,
                                      labelText: 'Mobile',
                                      hintText: 'Please Enter Mobile',
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Colors.black,
                                          width: 1,
                                        ),
                                        borderRadius: const BorderRadius.only(
                                          topLeft: Radius.circular(4.0),
                                          topRight: Radius.circular(4.0),
                                        ),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Colors.black,
                                          width: 1,
                                        ),
                                        borderRadius: const BorderRadius.only(
                                          topLeft: Radius.circular(4.0),
                                          topRight: Radius.circular(4.0),
                                        ),
                                      ),
                                    ),
                                    style: FlutterFlowTheme.bodyText1,
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),

                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(10, 5, 10, 5),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Expanded(
                            child: TextFormField(
                              controller: postCode,
                              obscureText: false,
                              decoration: InputDecoration(
                                isDense: true,
                                labelText: 'PostCode',
                                hintText: 'Please Enter PostCode',
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.black,
                                    width: 1,
                                  ),
                                  borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(4.0),
                                    topRight: Radius.circular(4.0),
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.black,
                                    width: 1,
                                  ),
                                  borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(4.0),
                                    topRight: Radius.circular(4.0),
                                  ),
                                ),
                              ),
                              style: FlutterFlowTheme.bodyText1,
                            ),
                          ),
                          SizedBox(
                            width: 30,
                          ),
                          Expanded(
                            child: TextFormField(
                              controller: place,
                              obscureText: false,
                              decoration: InputDecoration(
                                isDense: true,
                                labelText: 'Place',
                                hintText: 'Please Enter Place',
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.black,
                                    width: 1,
                                  ),
                                  borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(4.0),
                                    topRight: Radius.circular(4.0),
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.black,
                                    width: 1,
                                  ),
                                  borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(4.0),
                                    topRight: Radius.circular(4.0),
                                  ),
                                ),
                              ),
                              style: FlutterFlowTheme.bodyText1,
                            ),
                          ),
                          SizedBox(
                            width: 30,
                          ),
                          Expanded(
                            child: TextFormField(
                              controller: email,
                              obscureText: false,
                              decoration: InputDecoration(
                                isDense: true,
                                labelText: 'Email',
                                hintText: 'Please Enter Email',
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.black,
                                    width: 1,
                                  ),
                                  borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(4.0),
                                    topRight: Radius.circular(4.0),
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.black,
                                    width: 1,
                                  ),
                                  borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(4.0),
                                    topRight: Radius.circular(4.0),
                                  ),
                                ),
                              ),
                              style: FlutterFlowTheme.bodyText1,
                            ),
                          ),
                          SizedBox(
                            width: 30,
                          ),
                          Expanded(
                            child: TextFormField(
                              controller: IELTSScore,
                              obscureText: false,
                              decoration: InputDecoration(
                                isDense: true,
                                labelText: 'IELTS Score',
                                hintText: 'Please Enter IELTS Score',
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.black,
                                    width: 1,
                                  ),
                                  borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(4.0),
                                    topRight: Radius.circular(4.0),
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.black,
                                    width: 1,
                                  ),
                                  borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(4.0),
                                    topRight: Radius.circular(4.0),
                                  ),
                                ),
                              ),
                              style: FlutterFlowTheme.bodyText1,
                            ),
                          ),
                        ],
                      ),
                    ),

                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(10, 5, 10, 5),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Expanded(
                            child: TextFormField(
                              controller: Correspondence,
                              obscureText: false,
                              maxLines: 4,
                              decoration: InputDecoration(
                                isDense: true,
                                labelText: 'Correspondence Address',
                                hintText: 'Please Enter Correspondence Address',
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.black,
                                    width: 1,
                                  ),
                                  borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(4.0),
                                    topRight: Radius.circular(4.0),
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.black,
                                    width: 1,
                                  ),
                                  borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(4.0),
                                    topRight: Radius.circular(4.0),
                                  ),
                                ),
                              ),
                              style: FlutterFlowTheme.bodyText1,
                            ),
                          ),
                          SizedBox(
                            width: 30,
                          ),
                          Expanded(
                            child: TextFormField(
                              controller: address,
                              obscureText: false,
                              maxLines: 4,
                              decoration: InputDecoration(
                                isDense: true,
                                labelText:
                                    'Permanent/Home address (if different)',
                                hintText: 'Please Enter Permanent/Home address',
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.black,
                                    width: 1,
                                  ),
                                  borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(4.0),
                                    topRight: Radius.circular(4.0),
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.black,
                                    width: 1,
                                  ),
                                  borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(4.0),
                                    topRight: Radius.circular(4.0),
                                  ),
                                ),
                              ),
                              style: FlutterFlowTheme.bodyText1,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text('PassPort Details',
                          style: FlutterFlowTheme.title2.override(
                            fontFamily: 'Lexend Deca',
                            color: Color(0xFF090F13),
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                          )),
                    ),
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(10, 5, 10, 5),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Expanded(
                            child: TextFormField(
                              controller: passportNo,
                              obscureText: false,
                              decoration: InputDecoration(
                                isDense: true,
                                labelText: 'Passport No',
                                hintText: 'Please Enter Passport No',
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.black,
                                    width: 1,
                                  ),
                                  borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(4.0),
                                    topRight: Radius.circular(4.0),
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.black,
                                    width: 1,
                                  ),
                                  borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(4.0),
                                    topRight: Radius.circular(4.0),
                                  ),
                                ),
                              ),
                              style: FlutterFlowTheme.bodyText1,
                            ),
                          ),
                          SizedBox(
                            width: 30,
                          ),
                          Expanded(
                            child: TextFormField(
                              controller: passportSurName,
                              obscureText: false,
                              decoration: InputDecoration(
                                isDense: true,
                                labelText: 'SurName',
                                hintText: 'Please Enter SurName',
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.black,
                                    width: 1,
                                  ),
                                  borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(4.0),
                                    topRight: Radius.circular(4.0),
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.black,
                                    width: 1,
                                  ),
                                  borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(4.0),
                                    topRight: Radius.circular(4.0),
                                  ),
                                ),
                              ),
                              style: FlutterFlowTheme.bodyText1,
                            ),
                          ),
                          SizedBox(
                            width: 30,
                          ),
                          Expanded(
                            child: TextFormField(
                              controller: passportGivenName,
                              obscureText: false,
                              decoration: InputDecoration(
                                isDense: true,
                                labelText: 'GivenName',
                                hintText: 'Please Enter GivenName',
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.black,
                                    width: 1,
                                  ),
                                  borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(4.0),
                                    topRight: Radius.circular(4.0),
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.black,
                                    width: 1,
                                  ),
                                  borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(4.0),
                                    topRight: Radius.circular(4.0),
                                  ),
                                ),
                              ),
                              style: FlutterFlowTheme.bodyText1,
                            ),
                          ),
                          SizedBox(
                            width: 30,
                          ),
                          Expanded(
                            child: TextFormField(
                              controller: passportPlaceofIssue,
                              obscureText: false,
                              decoration: InputDecoration(
                                isDense: true,
                                labelText: 'Place of Birth',
                                hintText: 'Please Enter Place of Birth',
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.black,
                                    width: 1,
                                  ),
                                  borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(4.0),
                                    topRight: Radius.circular(4.0),
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.black,
                                    width: 1,
                                  ),
                                  borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(4.0),
                                    topRight: Radius.circular(4.0),
                                  ),
                                ),
                              ),
                              style: FlutterFlowTheme.bodyText1,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(10, 5, 10, 5),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Expanded(
                            child: TextFormField(
                              controller: passportIssueDate,
                              obscureText: false,
                              decoration: InputDecoration(
                                isDense: true,
                                labelText: 'Date of Issued',
                                hintText: 'Please Enter Passport Issued Date',
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.black,
                                    width: 1,
                                  ),
                                  borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(4.0),
                                    topRight: Radius.circular(4.0),
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.black,
                                    width: 1,
                                  ),
                                  borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(4.0),
                                    topRight: Radius.circular(4.0),
                                  ),
                                ),
                              ),
                              style: FlutterFlowTheme.bodyText1,
                            ),
                          ),
                          SizedBox(
                            width: 30,
                          ),
                          Expanded(
                            child: TextFormField(
                              controller: passportExpDate,
                              obscureText: false,
                              decoration: InputDecoration(
                                isDense: true,
                                labelText: 'Date of Expiry',
                                hintText: 'Please Enter Date',
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.black,
                                    width: 1,
                                  ),
                                  borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(4.0),
                                    topRight: Radius.circular(4.0),
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.black,
                                    width: 1,
                                  ),
                                  borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(4.0),
                                    topRight: Radius.circular(4.0),
                                  ),
                                ),
                              ),
                              style: FlutterFlowTheme.bodyText1,
                            ),
                          ),
                          SizedBox(
                            width: 30,
                          ),
                          Expanded(
                            child: TextFormField(
                              controller: passportPlaceofIssue,
                              obscureText: false,
                              decoration: InputDecoration(
                                isDense: true,
                                labelText: 'Place of Issue',
                                hintText: 'Please Enter Place of Issue',
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.black,
                                    width: 1,
                                  ),
                                  borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(4.0),
                                    topRight: Radius.circular(4.0),
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.black,
                                    width: 1,
                                  ),
                                  borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(4.0),
                                    topRight: Radius.circular(4.0),
                                  ),
                                ),
                              ),
                              style: FlutterFlowTheme.bodyText1,
                            ),
                          ),
                          SizedBox(
                            width: 30,
                          ),
                          Expanded(
                            child: TextFormField(
                              controller: nationality,
                              obscureText: false,
                              decoration: InputDecoration(
                                isDense: true,
                                labelText: 'Nationality',
                                hintText: 'Please Enter Nationality',
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.black,
                                    width: 1,
                                  ),
                                  borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(4.0),
                                    topRight: Radius.circular(4.0),
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.black,
                                    width: 1,
                                  ),
                                  borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(4.0),
                                    topRight: Radius.circular(4.0),
                                  ),
                                ),
                              ),
                              style: FlutterFlowTheme.bodyText1,
                            ),
                          ),
                        ],
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text('Parent Details',
                          style: FlutterFlowTheme.title2.override(
                            fontFamily: 'Lexend Deca',
                            color: Color(0xFF090F13),
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                          )),
                    ),
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(10, 5, 10, 5),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Expanded(
                            child: TextFormField(
                              controller: fatherName,
                              obscureText: false,
                              decoration: InputDecoration(
                                isDense: true,
                                labelText: 'Parent Name',
                                hintText: 'Please Enter Father Name',
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.black,
                                    width: 1,
                                  ),
                                  borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(4.0),
                                    topRight: Radius.circular(4.0),
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.black,
                                    width: 1,
                                  ),
                                  borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(4.0),
                                    topRight: Radius.circular(4.0),
                                  ),
                                ),
                              ),
                              style: FlutterFlowTheme.bodyText1,
                            ),
                          ),
                          SizedBox(
                            width: 30,
                          ),
                          Expanded(
                            child: TextFormField(
                              controller: fatherNo,
                              obscureText: false,
                              decoration: InputDecoration(
                                isDense: true,
                                labelText: 'Mobile Number',
                                hintText: 'Please Enter Mobile Number',
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.black,
                                    width: 1,
                                  ),
                                  borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(4.0),
                                    topRight: Radius.circular(4.0),
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.black,
                                    width: 1,
                                  ),
                                  borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(4.0),
                                    topRight: Radius.circular(4.0),
                                  ),
                                ),
                              ),
                              style: FlutterFlowTheme.bodyText1,
                            ),
                          ),
                          SizedBox(
                            width: 30,
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text('InTake',
                          style: FlutterFlowTheme.title2.override(
                            fontFamily: 'Lexend Deca',
                            color: Color(0xFF090F13),
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                          )),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: FlutterFlowDropDown(
                        initialOption: dropDownValue ?? inTakeList[0],
                        options: inTakeList,
                        onChanged: (val) => setState(() => dropDownValue = val),
                        width: 250,
                        height: 50,
                        textStyle: FlutterFlowTheme.bodyText1.override(
                          fontFamily: 'Poppins',
                          color: Colors.black,
                        ),
                        hintText: 'Please select InTake',
                        icon: FaIcon(
                          FontAwesomeIcons.calendar,
                        ),
                        fillColor: Colors.white,
                        elevation: 2,
                        borderColor: Colors.black,
                        borderWidth: 0,
                        borderRadius: 0,
                        margin: EdgeInsetsDirectional.fromSTEB(10, 4, 12, 4),
                        hidesUnderline: true,
                      ),
                    ),

                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(0, 24, 0, 44),
                      child: FFButtonWidget(
                        onPressed: () async {
                          if (name.text != '' &&
                              place.text != '' &&
                              mobile.text != '' &&
                              email.text != '' &&
                              dob.text != '' &&
                              IELTSScore.text != '' &&
                              address.text != '' &&
                              fatherNo.text != '' &&
                              fatherName.text != '') {
                            bool pressed =
                                await alert(context, 'Submit Application...');
                            if (pressed) {
                              DocumentSnapshot doc = await FirebaseFirestore
                                  .instance
                                  .collection('settings')
                                  .doc(currentBranchId)
                                  .get();
                              FirebaseFirestore.instance
                                  .collection('settings')
                                  .doc(currentBranchId)
                                  .update({
                                'applicationId': FieldValue.increment(1),
                              });
                              int applicationId = doc.get('applicationId');
                              applicationId++;

                              FirebaseFirestore.instance
                                  .collection('applicationForms')
                                  .doc('A' +
                                      currentbranchShortName +
                                      applicationId.toString())
                                  .set({
                                'candidateId': widget.id,
                                'countryId': widget.countryId,
                                'courseId': widget.courseId,
                                'status': 0,
                                'date': DateTime.now(),
                                'title': title,
                                'gender': _radioVal,
                                'name': name.text,
                                'dob': dob.text,
                                'mobile': mobile.text,
                                'postCode': postCode.text,
                                'place': place.text,
                                'email': email.text,
                                'ieltsScore': IELTSScore.text,
                                'Correspondence': Correspondence.text,
                                'address': address.text,
                                'university': widget.university,
                                'fatherName': fatherName.text,
                                'fatherNumber': fatherNo.text,
                                'branchId': currentBranchId,
                                'userId': currentUserUid,
                                'passPort': {
                                  'passPortNo': passportNo.text,
                                  'surName': passportSurName.text,
                                  'givenName': passportGivenName.text,
                                  'placeOfBirth': passportPlaceofBirth.text,
                                  'dateOfIssued': passportIssueDate.text,
                                  'dateOfExpiry': passportExpDate.text,
                                  'placeOfIssue': passportPlaceofIssue.text,
                                  'nationality': nationality.text,
                                },
                                'search': setSearchParam(mobile.text),
                                'inTake': dropDownValue,
                              }).then((value) {
                                if (widget.application == 1) {
                                  FirebaseFirestore.instance
                                      .collection('candidates')
                                      .doc(widget.id)
                                      .update({
                                    'currentStatus': 'Application Submitted',
                                    'nextStatus': 'Verification Process',
                                    'application1': true,
                                  });
                                } else if (widget.application == 2) {
                                  FirebaseFirestore.instance
                                      .collection('candidates')
                                      .doc(widget.id)
                                      .update({
                                    'currentStatus': 'Application Submitted',
                                    'nextStatus': 'Verification Process',
                                    'application2': true,
                                  });
                                } else {
                                  FirebaseFirestore.instance
                                      .collection('candidates')
                                      .doc(widget.id)
                                      .update({
                                    'currentStatus': 'Application Submitted',
                                    'nextStatus': 'Verification Process',
                                    'application3': true,
                                  });
                                }
                              });
                              showUploadMessage(
                                  context, 'Application Submitted...');

                              Navigator.pop(context);
                              Navigator.pop(context);
                            }
                          } else {
                            name.text == ''
                                ? showUploadMessage(
                                    context, 'Please Enter Name')
                                : place.text == ''
                                    ? showUploadMessage(
                                        context, 'Please Enter Place')
                                    : mobile.text == ''
                                        ? showUploadMessage(context,
                                            'Please Enter Mobile Number')
                                        : email.text == ''
                                            ? showUploadMessage(
                                                context, 'Please Enter Email')
                                            : dob.text == ''
                                                ? showUploadMessage(
                                                    context, 'Please Enter dob')
                                                : IELTSScore.text == ''
                                                    ? showUploadMessage(context,
                                                        'Please Enter IELTS Score')
                                                    : fatherName.text == ''
                                                        ? showUploadMessage(
                                                            context,
                                                            'Please Enter Father Name')
                                                        : showUploadMessage(
                                                            context,
                                                            'Please Enter Father No');
                          }
                        },
                        text: 'Submit Application',
                        options: FFButtonOptions(
                          width: 350,
                          height: 60,
                          color: Colors.teal,
                          textStyle: FlutterFlowTheme.subtitle2.override(
                            fontFamily: 'Lexend Deca',
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.normal,
                          ),
                          elevation: 2,
                          borderSide: BorderSide(
                            color: Colors.transparent,
                            width: 1,
                          ),
                          borderRadius: 30,
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
