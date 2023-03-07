import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:multiple_select/Item.dart';
import 'package:multiple_select/multi_filter_select.dart';
import 'package:multiple_select/multiple_select.dart';
import '../../../auth/auth_util.dart';
import '../../../flutter_flow/flutter_flow_icon_button.dart';
import '../../../flutter_flow/flutter_flow_theme.dart';
import '../../../flutter_flow/flutter_flow_widgets.dart';
import 'package:flutter/material.dart';
import '../../../flutter_flow/upload_media.dart';
import '../../app_widget.dart';
import '../../pages/home_page/home.dart';
import '../Branch/SelectBranches.dart';
import '../users/users/addBranchUser.dart';

class EditEnquiry extends StatefulWidget {
  final String eId;

  const EditEnquiry({
    Key key,
    this.eId,
  }) : super(key: key);

  @override
  _EditEnquiryState createState() => _EditEnquiryState();
}

class _EditEnquiryState extends State<EditEnquiry> {
  TextEditingController name;
  TextEditingController email;
  TextEditingController mobile;
  TextEditingController place;
  TextEditingController additionalInfo;
  TextEditingController qualification;
  TextEditingController institute;
  TextEditingController year;
  TextEditingController branch;
  TextEditingController projectType;
  TextEditingController address;
  TextEditingController agentName;
  // TextEditingController careOfNo;

  TextEditingController workname;
  TextEditingController requirement;
  TextEditingController platform;
  TextEditingController topic;

  List projectDetails = [];

  TextEditingController domain;
  TextEditingController deliverables;

  List abc = [];

  final scaffoldKey = GlobalKey<ScaffoldState>();

  List<Item> universityList = [];

  List selectedUniversities = [];

  // Map<String,dynamic> courseNames={};
  // Map<String,dynamic> courseId={};
  Map<String, dynamic> countryNames = {};
  Map<String, dynamic> countryId = {};

  List selectedCourse = [];
  List selectedCountry = [];
  List projectDetailsList = [];

  List<MultipleSelectItem> country = [];

  List<Item> countryList = [];

  getCountry() async {
    QuerySnapshot data1 =
        await FirebaseFirestore.instance.collection("country").get();
    // int rowIndex=1;
    for (var size in data1.docs) {
      print(size.get('name'));
      countryList.add(Item.build(
        value: size.id,
        display: size.get('name'),
        content: size.get('name').toString(),
      ));
    }
    if (mounted) {
      setState(() {});
    }
  }

  // List<MultipleSelectItem> course = [];
  // List<Item> coursesList = [];
  // getCourse() async {
  //   QuerySnapshot data1 =
  //   await FirebaseFirestore.instance.collection("course").get();
  //   for (var size in data1.docs) {
  //     print(size.get('name'));
  //     coursesList.add(Item.build(
  //       value: size.id,
  //       display: size.get('name'),
  //       content: size.get('name').toString(),
  //     ));
  //
  //   }
  //   if(mounted){
  //     setState(() {
  //
  //     });
  //   }
  //
  // }

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

  bool loaded = true;

  @override
  void initState() {
    super.initState();
    // getCourse();
    getCountry();
    name = TextEditingController();
    email = TextEditingController();
    mobile = TextEditingController();
    place = TextEditingController();
    qualification = TextEditingController();
    institute = TextEditingController();
    year = TextEditingController();

    additionalInfo = TextEditingController();
    branch = TextEditingController();
    projectType = TextEditingController();

    address = TextEditingController();
    agentName = TextEditingController();
    // careOfNo = TextEditingController();
    workname = TextEditingController();
    requirement = TextEditingController();
    platform = TextEditingController();
    topic = TextEditingController();

    deliverables = TextEditingController();
    domain = TextEditingController();
  }

  DocumentSnapshot data;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Color(0xFF383838)),
        automaticallyImplyLeading: true,
        title: Text(
          'Edit Details',
          style: FlutterFlowTheme.title2.override(
            fontFamily: 'Lexend Deca',
            color: Color(0xFF090F13),
            fontSize: 22,
            fontWeight: FontWeight.w600,
          ),
        ),
        actions: [],
        centerTitle: true,
        elevation: 5,
      ),
      backgroundColor: Color(0xFFECF0F5),
      body: StreamBuilder<DocumentSnapshot>(
          stream: FirebaseFirestore.instance
              .collection('enquiries')
              .doc(widget.eId)
              .snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            data = snapshot.data;

            if (snapshot.data.exists) {
              name.text = data.get('name');
              place.text = data.get('place');
              mobile.text = data.get('mobile');
              email.text = data.get('email');
              additionalInfo.text = data.get('additionalInfo');
              agentName.text = data.get('agentId') == ''
                  ? ''
                  : agentDataById[data.get('agentId')]['name'];
              // careOfNo.text = data.get('careOfNo');
              topic.text = data.get('projectTopic');

              projectDetails = data.get('projectDetails');

              if (loaded == true) {
                loaded = false;
                projectType.text = data.get('projectType');
              }

              // if(selectedCourse.length==0){
              //   selectedCourse=data.get('courses').toList();
              //
              // }
              if (selectedCountry.length == 0) {
                selectedCountry = data.get('countries').toList();
              }
            }

            return Padding(
              padding: EdgeInsetsDirectional.fromSTEB(16, 8, 16, 16),
              child: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
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
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Material(
                                      color: Colors.transparent,
                                      elevation: 3,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      child: Container(
                                        width: 950,
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(12),
                                        ),
                                        child: Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  20, 10, 0, 20),
                                          child: Column(
                                            mainAxisSize: MainAxisSize.max,
                                            children: [
                                              Text(
                                                'Enquiry Details',
                                                style: FlutterFlowTheme
                                                    .bodyText2
                                                    .override(
                                                  fontFamily: 'Montserrat',
                                                  color: Color(0xFF8B97A2),
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              Padding(
                                                padding: EdgeInsetsDirectional
                                                    .fromSTEB(5, 10, 30, 5),
                                                child: Row(
                                                  children: [
                                                    Expanded(
                                                      child: Container(
                                                        width: 350,
                                                        height: 60,
                                                        decoration:
                                                            BoxDecoration(
                                                          color: Colors.white,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(8),
                                                          border: Border.all(
                                                            color: Color(
                                                                0xFFE6E6E6),
                                                          ),
                                                        ),
                                                        child: Padding(
                                                          padding: EdgeInsets
                                                              .fromLTRB(
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
                                                                      fontSize:
                                                                          12),
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
                                                                      fontSize:
                                                                          12),
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
                                                                    fontSize:
                                                                        13),
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
                                                        decoration:
                                                            BoxDecoration(
                                                          color: Colors.white,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(8),
                                                          border: Border.all(
                                                            color: Color(
                                                                0xFF8B97A2),
                                                          ),
                                                        ),
                                                        child: Padding(
                                                          padding: EdgeInsets
                                                              .fromLTRB(
                                                                  16, 0, 0, 0),
                                                          child: TextFormField(
                                                            controller: place,
                                                            obscureText: false,
                                                            decoration:
                                                                InputDecoration(
                                                              labelText:
                                                                  'Place',
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
                                                                      fontSize:
                                                                          12),
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
                                                                      fontSize:
                                                                          12),
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
                                                                    fontSize:
                                                                        12),
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
                                                        decoration:
                                                            BoxDecoration(
                                                          color: Colors.white,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(8),
                                                          border: Border.all(
                                                            color: Color(
                                                                0xFFE6E6E6),
                                                          ),
                                                        ),
                                                        child: Padding(
                                                          padding: EdgeInsets
                                                              .fromLTRB(
                                                                  16, 0, 0, 0),
                                                          child: TextFormField(
                                                            controller: mobile,
                                                            obscureText: false,
                                                            decoration:
                                                                InputDecoration(
                                                              labelText:
                                                                  'Mobile',
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
                                                                      fontSize:
                                                                          12),
                                                              hintText:
                                                                  'Please Enter Mobile No',
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
                                                                      fontSize:
                                                                          12),
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
                                                                    fontSize:
                                                                        12),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Padding(
                                                padding: EdgeInsetsDirectional
                                                    .fromSTEB(5, 10, 30, 5),
                                                child: Row(
                                                  children: [
                                                    Expanded(
                                                      child: Container(
                                                        width: 350,
                                                        height: 60,
                                                        decoration:
                                                            BoxDecoration(
                                                          color: Colors.white,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(8),
                                                          border: Border.all(
                                                            color: Color(
                                                                0xFFE6E6E6),
                                                          ),
                                                        ),
                                                        child: Padding(
                                                          padding: EdgeInsets
                                                              .fromLTRB(
                                                                  16, 0, 0, 0),
                                                          child: TextFormField(
                                                            controller: email,
                                                            obscureText: false,
                                                            decoration:
                                                                InputDecoration(
                                                              labelText:
                                                                  'Email',
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
                                                                      fontSize:
                                                                          12),
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
                                                                      fontSize:
                                                                          12),
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
                                                                    fontSize:
                                                                        13),
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
                                                        decoration:
                                                            BoxDecoration(
                                                          color: Colors.white,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(8),
                                                          border: Border.all(
                                                            color: Color(
                                                                0xFFE6E6E6),
                                                          ),
                                                        ),
                                                        child: Padding(
                                                          padding: EdgeInsets
                                                              .fromLTRB(
                                                                  16, 0, 0, 0),
                                                          child: TextFormField(
                                                            controller:
                                                                agentName,
                                                            obscureText: false,
                                                            decoration:
                                                                InputDecoration(
                                                              labelText: 'C/0',
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
                                                                      fontSize:
                                                                          12),
                                                              hintText:
                                                                  'Please Enter C/O Name',
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
                                                                      fontSize:
                                                                          12),
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
                                                                    fontSize:
                                                                        12),
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
                                                    //     decoration:
                                                    //         BoxDecoration(
                                                    //       color: Colors.white,
                                                    //       borderRadius:
                                                    //           BorderRadius
                                                    //               .circular(8),
                                                    //       border: Border.all(
                                                    //         color: Color(
                                                    //             0xFFE6E6E6),
                                                    //       ),
                                                    //     ),
                                                    //     child: Padding(
                                                    //       padding: EdgeInsets
                                                    //           .fromLTRB(
                                                    //               16, 0, 0, 0),
                                                    //       child: TextFormField(
                                                    //         controller:
                                                    //             careOfNo,
                                                    //         obscureText: false,
                                                    //         decoration:
                                                    //             InputDecoration(
                                                    //           labelText:
                                                    //               'C/0 Employee ID',
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
                                                    //                   fontSize:
                                                    //                       12),
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
                                                    //                   fontSize:
                                                    //                       12),
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
                                                    //               topLeft: Radius
                                                    //                   .circular(
                                                    //                       4.0),
                                                    //               topRight: Radius
                                                    //                   .circular(
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
                                                    //               topLeft: Radius
                                                    //                   .circular(
                                                    //                       4.0),
                                                    //               topRight: Radius
                                                    //                   .circular(
                                                    //                       4.0),
                                                    //             ),
                                                    //           ),
                                                    //         ),
                                                    //         style: FlutterFlowTheme
                                                    //             .bodyText2
                                                    //             .override(
                                                    //                 fontFamily:
                                                    //                     'Montserrat',
                                                    //                 color: Colors
                                                    //                     .black,
                                                    //                 fontWeight:
                                                    //                     FontWeight
                                                    //                         .w500,
                                                    //                 fontSize:
                                                    //                     13),
                                                    //       ),
                                                    //     ),
                                                    //   ),
                                                    // ),
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
                                    Material(
                                      color: Colors.transparent,
                                      elevation: 3,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      child: Container(
                                        width: 950,
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(12),
                                        ),
                                        child: Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  20, 10, 0, 20),
                                          child: Column(
                                            mainAxisSize: MainAxisSize.max,
                                            children: [
                                              Padding(
                                                  padding: EdgeInsetsDirectional
                                                      .fromSTEB(30, 5, 30, 20),
                                                  child: Text(
                                                    'Project Details',
                                                    style: FlutterFlowTheme
                                                        .bodyText2
                                                        .override(
                                                            fontFamily:
                                                                'Montserrat',
                                                            color: Color(
                                                                0xFF8B97A2),
                                                            fontWeight:
                                                                FontWeight.w500,
                                                            fontSize: 17),
                                                  )),
                                              SizedBox(
                                                width: 30,
                                              ),

                                              //TOPIC&NAME
                                              Padding(
                                                padding: EdgeInsetsDirectional
                                                    .fromSTEB(30, 5, 30, 5),
                                                child: Row(
                                                  children: [
                                                    Expanded(
                                                      child: Container(
                                                        width: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .width *
                                                            0.1,
                                                        decoration:
                                                            BoxDecoration(
                                                          color: Colors.white,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(8),
                                                          border: Border.all(
                                                            color: Colors.black,
                                                          ),
                                                        ),
                                                        child: CustomDropdown
                                                            .search(
                                                          hintText:
                                                              'Select Project Type',
                                                          items:
                                                              projectTypeList,
                                                          controller:
                                                              projectType,
                                                          // excludeSelected: false,
                                                          onChanged: (text) {
                                                            setState(() {});
                                                          },
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
                                                        decoration:
                                                            BoxDecoration(
                                                          color: Colors.white,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(8),
                                                          border: Border.all(
                                                            color: Color(
                                                                0xFFE6E6E6),
                                                          ),
                                                        ),
                                                        child: Padding(
                                                          padding: EdgeInsets
                                                              .fromLTRB(
                                                                  16, 0, 0, 0),
                                                          child: TextFormField(
                                                            controller: topic,
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
                                                                      fontSize:
                                                                          12),
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
                                                                      fontSize:
                                                                          12),
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
                                                                    fontSize:
                                                                        12),
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
                                              SizedBox(
                                                width: 30,
                                              ),

                                              //workDetail
                                              Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Row(
                                                    children: [
                                                      Expanded(
                                                        child: Container(
                                                          width: 350,
                                                          height: 60,
                                                          decoration:
                                                              BoxDecoration(
                                                            color: Colors.white,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        8),
                                                            border: Border.all(
                                                              color: Color(
                                                                  0xFFE6E6E6),
                                                            ),
                                                          ),
                                                          child: Padding(
                                                            padding: EdgeInsets
                                                                .fromLTRB(16, 0,
                                                                    0, 0),
                                                            child:
                                                                CustomDropdown
                                                                    .search(
                                                              hintText:
                                                                  'Select domain',
                                                              hintStyle: TextStyle(
                                                                  color: Colors
                                                                      .black),
                                                              items:
                                                                  listOfDomain,
                                                              controller:
                                                                  domain,
                                                              // excludeSelected: false,
                                                              onChanged:
                                                                  (text) {
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
                                                          decoration:
                                                              BoxDecoration(
                                                            color: Colors.white,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        8),
                                                            border: Border.all(
                                                              color: Color(
                                                                  0xFFE6E6E6),
                                                            ),
                                                          ),
                                                          child: Padding(
                                                            padding: EdgeInsets
                                                                .fromLTRB(16, 0,
                                                                    0, 0),
                                                            child:
                                                                TextFormField(
                                                              controller:
                                                                  deliverables,
                                                              obscureText:
                                                                  false,
                                                              decoration:
                                                                  InputDecoration(
                                                                labelText:
                                                                    'Deliverables',
                                                                labelStyle: FlutterFlowTheme.bodyText2.override(
                                                                    fontFamily:
                                                                        'Montserrat',
                                                                    color: Colors
                                                                        .black,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w500,
                                                                    fontSize:
                                                                        12),
                                                                hintText:
                                                                    'Please Enter Deliverable',
                                                                hintStyle: FlutterFlowTheme.bodyText2.override(
                                                                    fontFamily:
                                                                        'Montserrat',
                                                                    color: Colors
                                                                        .black,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w500,
                                                                    fontSize:
                                                                        12),
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
                                                                      fontSize:
                                                                          12),
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
                                                          decoration:
                                                              BoxDecoration(
                                                            color: Colors.white,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        8),
                                                            border: Border.all(
                                                              color: Color(
                                                                  0xFFE6E6E6),
                                                            ),
                                                          ),
                                                          child: Padding(
                                                            padding: EdgeInsets
                                                                .fromLTRB(16, 0,
                                                                    0, 0),
                                                            child:
                                                                CustomDropdown
                                                                    .search(
                                                              hintText:
                                                                  'Select Platform',
                                                              hintStyle: TextStyle(
                                                                  color: Colors
                                                                      .black),
                                                              items: platforms,
                                                              controller:
                                                                  platform,
                                                              // excludeSelected: false,
                                                              onChanged:
                                                                  (text) {
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
                                                          if (domain.text !=
                                                                  '' &&
                                                              deliverables
                                                                      .text !=
                                                                  '' &&
                                                              platform.text !=
                                                                  '') {
                                                            projectDetails.add({
                                                              'domain':
                                                                  domain.text,
                                                              'deliverable':
                                                                  deliverables
                                                                      .text,
                                                              'platform':
                                                                  platform.text,
                                                            });
                                                            if (mounted) {
                                                              setState(() {});
                                                            }
                                                            print(
                                                                projectDetails);

                                                            domain.text = '';
                                                            deliverables.text =
                                                                '';
                                                            platform.text = '';
                                                          } else {
                                                            domain.text == ''
                                                                ? showUploadMessage(
                                                                    context,
                                                                    'Please Enter Domain')
                                                                : deliverables
                                                                            .text ==
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
                                                        options:
                                                            FFButtonOptions(
                                                          width: 80,
                                                          height: 40,
                                                          color:
                                                              Color(0xff0054FF),
                                                          textStyle:
                                                              FlutterFlowTheme
                                                                  .subtitle2
                                                                  .override(
                                                            fontFamily:
                                                                'Lexend Deca',
                                                            color: Colors.white,
                                                            fontSize: 13,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                          ),
                                                          elevation: 2,
                                                          borderSide:
                                                              BorderSide(
                                                            color: Colors
                                                                .transparent,
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
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.9,
                                                child:
                                                    projectDetails.length == 0
                                                        ? Center(
                                                            child: Text(
                                                            'No Details Added',
                                                            style: FlutterFlowTheme
                                                                .bodyText2
                                                                .override(
                                                                    fontFamily:
                                                                        'Montserrat',
                                                                    color: Color(
                                                                        0xFF8B97A2),
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    fontSize:
                                                                        13),
                                                          ))
                                                        : DataTable(
                                                            horizontalMargin:
                                                                12,
                                                            columns: [
                                                              DataColumn(
                                                                label: Text(
                                                                  "Sl No",
                                                                  style: TextStyle(
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold,
                                                                      fontSize:
                                                                          12),
                                                                ),
                                                              ),
                                                              DataColumn(
                                                                label: Text(
                                                                    "Domain",
                                                                    style: TextStyle(
                                                                        fontWeight:
                                                                            FontWeight
                                                                                .bold,
                                                                        fontSize:
                                                                            12)),
                                                              ),
                                                              DataColumn(
                                                                label: Text(
                                                                    "Requirement",
                                                                    style: TextStyle(
                                                                        fontWeight:
                                                                            FontWeight
                                                                                .bold,
                                                                        fontSize:
                                                                            12)),
                                                              ),
                                                              DataColumn(
                                                                label: Text(
                                                                    "Quotation Amount",
                                                                    style: TextStyle(
                                                                        fontWeight:
                                                                            FontWeight
                                                                                .bold,
                                                                        fontSize:
                                                                            12)),
                                                              ),
                                                              DataColumn(
                                                                label: Text("",
                                                                    style: TextStyle(
                                                                        fontWeight:
                                                                            FontWeight.bold)),
                                                              ),
                                                            ],
                                                            rows: List.generate(
                                                              projectDetails
                                                                  .length,
                                                              (index) {
                                                                final history =
                                                                    projectDetails[
                                                                        index];

                                                                return DataRow(
                                                                  color: index
                                                                          .isOdd
                                                                      ? MaterialStateProperty.all(Colors
                                                                          .blueGrey
                                                                          .shade50
                                                                          .withOpacity(
                                                                              0.7))
                                                                      : MaterialStateProperty.all(Colors
                                                                          .blueGrey
                                                                          .shade50),
                                                                  cells: [
                                                                    DataCell(Text(
                                                                        (index +
                                                                                1)
                                                                            .toString(),
                                                                        style: TextStyle(
                                                                            fontWeight:
                                                                                FontWeight.bold,
                                                                            fontSize: 12))),
                                                                    DataCell(Text(
                                                                        history[
                                                                            'domain'],
                                                                        style: TextStyle(
                                                                            fontWeight:
                                                                                FontWeight.bold,
                                                                            fontSize: 12))),
                                                                    DataCell(Text(
                                                                        history[
                                                                            'deliverable'],
                                                                        style: TextStyle(
                                                                            fontWeight:
                                                                                FontWeight.bold,
                                                                            fontSize: 12))),
                                                                    DataCell(Text(
                                                                        history[
                                                                            'platform'],
                                                                        style: TextStyle(
                                                                            fontWeight:
                                                                                FontWeight.bold,
                                                                            fontSize: 12))),
                                                                    DataCell(
                                                                      Row(
                                                                        children: [
                                                                          // Generated code for this Button Widget...
                                                                          FlutterFlowIconButton(
                                                                            borderColor:
                                                                                Colors.transparent,
                                                                            borderRadius:
                                                                                30,
                                                                            borderWidth:
                                                                                1,
                                                                            buttonSize:
                                                                                50,
                                                                            icon:
                                                                                Icon(
                                                                              Icons.delete,
                                                                              color: Color(0xFFEE0000),
                                                                              size: 25,
                                                                            ),
                                                                            onPressed:
                                                                                () async {
                                                                              bool pressed = await alert(context, 'Do you want Delete');

                                                                              if (pressed) {
                                                                                projectDetailsList.removeAt(index);

                                                                                FirebaseFirestore.instance.collection('enquiry').doc(widget.eId).update({
                                                                                  'projectDetails': projectDetailsList,
                                                                                });
                                                                                showUploadMessage(context, 'Details Deleted...');
                                                                                setState(() {});
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

                                              //additional
                                              Padding(
                                                padding: EdgeInsetsDirectional
                                                    .fromSTEB(5, 10, 30, 5),
                                                child: Row(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Expanded(
                                                      child: Container(
                                                        width: 440,
                                                        decoration:
                                                            BoxDecoration(
                                                          color: Colors.white,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(8),
                                                          border: Border.all(
                                                            color: Color(
                                                                0xFFE6E6E6),
                                                          ),
                                                        ),
                                                        child: Padding(
                                                          padding: EdgeInsets
                                                              .fromLTRB(
                                                                  16, 0, 0, 0),
                                                          child: TextFormField(
                                                            controller:
                                                                additionalInfo,
                                                            obscureText: false,
                                                            maxLines: 4,
                                                            decoration:
                                                                InputDecoration(
                                                              labelText:
                                                                  'Additional Info',
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
                                                                      fontSize:
                                                                          12),
                                                              hintText:
                                                                  'Please Enter Additional Information',
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
                                                                      fontSize:
                                                                          12),
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
                                                                    fontSize:
                                                                        13),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      width: 10,
                                                    )
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
                                                      // FirebaseFirestore.instance
                                                      //     .collection('settings')
                                                      //     .doc(currentbranchId)
                                                      //     .update({
                                                      //   'enquiryId': FieldValue.increment(1),
                                                      //
                                                      // });

                                                      if (name.text != '' &&
                                                          mobile.text != '') {
                                                        bool proceed = await alert(
                                                            context,
                                                            'You want to Update this Enquiry?');

                                                        if (proceed) {
                                                          data.reference
                                                              .update({
                                                            'name': name.text,
                                                            'place': place.text,
                                                            'mobile':
                                                                mobile.text,
                                                            'email': email.text,
                                                            'additionalInfo':
                                                                additionalInfo
                                                                        .text ??
                                                                    "",
                                                            'projectDetails':
                                                                projectDetails,
                                                            'projectType':
                                                                projectType
                                                                    .text,
                                                            'countries':
                                                                selectedCountry,
                                                            'userId':
                                                                currentUserUid,
                                                            'branch':
                                                                currentbranchName,
                                                            'branchId':
                                                                currentBranchId,
                                                            'userEmail':
                                                                currentUserEmail,
                                                            'search':
                                                                setSearchParam(
                                                                    mobile
                                                                        .text),
                                                            'check': false,
                                                            'agentId':
                                                                agentIdByNumber[
                                                                        agentName
                                                                            .text] ??
                                                                    '',
                                                            // 'careOfNo':
                                                            //     careOfNo.text ??
                                                            //         '',
                                                            'projectTopic':
                                                                topic.text,
                                                            'photo': '',
                                                            'paymentDetails':
                                                                [],
                                                            // 'projectDetails':projectDetailsList,
                                                            'whatsAppNo': '',
                                                            'companyName': '',
                                                            'companyAddress':
                                                                '',
                                                          });
                                                          Navigator.pop(
                                                              context);
                                                          showUploadMessage(
                                                              context,
                                                              'Enquiry edited Successfully...');

                                                          setState(() {});
                                                        } else {
                                                          name.text == ''
                                                              ? showUploadMessage(
                                                                  context,
                                                                  'Please Enter Name')
                                                              : showUploadMessage(
                                                                  context,
                                                                  'Please Enter Mobile Number');
                                                        }
                                                      }
                                                    },
                                                    text: 'Update',
                                                    options: FFButtonOptions(
                                                      width: 150,
                                                      height: 50,
                                                      color: Color(0xff0054FF),
                                                      textStyle:
                                                          FlutterFlowTheme
                                                              .subtitle2
                                                              .override(
                                                        fontFamily:
                                                            'Montserrat',
                                                        color: Colors.white,
                                                        fontSize: 15,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                      ),
                                                      elevation: 2,
                                                      borderSide: BorderSide(
                                                        color:
                                                            Colors.transparent,
                                                        width: 2,
                                                      ),
                                                      borderRadius: 8,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Padding(
                                                padding: EdgeInsets.symmetric(
                                                    vertical: 10.0,
                                                    horizontal: 0.0),
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
            );
          }),
    );
  }
}
