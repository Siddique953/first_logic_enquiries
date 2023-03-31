import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:multiple_select/Item.dart';
import 'package:multiple_select/multi_filter_select.dart';

import '../../../auth/auth_util.dart';
import '../../../flutter_flow/flutter_flow_icon_button.dart';
import '../../../flutter_flow/flutter_flow_theme.dart';
import '../../../flutter_flow/flutter_flow_util.dart';
import '../../../flutter_flow/flutter_flow_widgets.dart';

import 'package:flutter/material.dart';

import '../../../flutter_flow/upload_media.dart';
import '../../../main.dart';
import '../../app_widget.dart';
import '../../models/enquiry/enquiryStatus.dart';
import '../../models/enquiry/followUpModel.dart';
import 'EditEnquiry.dart';

class EnquiryDetailsWidget extends StatefulWidget {
  final String id;
  final int tab;

  const EnquiryDetailsWidget({Key key, this.id, this.tab}) : super(key: key);

  @override
  _EnquiryDetailsWidgetState createState() => _EnquiryDetailsWidgetState();
}

class _EnquiryDetailsWidgetState extends State<EnquiryDetailsWidget> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  List projectDetailList = [];
  List<Item> countryList = [];
  // List<Item> courseList = [];

  String selectedProjectType = '';
  List countries = [];
  List university = [];

  TextEditingController status;
  TextEditingController assignee;
  TextEditingController followUp;
  Timestamp datePicked1;
  Timestamp datePicked2;
  Timestamp datePicked3;
  DateTime selectedDate1 = DateTime.now();
  DateTime selectedDate2 = DateTime.now();
  DateTime selectedDate3 = DateTime.now();

  int currentTab = 1;

  bool statusLoading;
  bool followUpLoading;

  //Get Statuses of Current enquiry
  Stream<List<EnquiryStatus>> getStatusList() => FirebaseFirestore.instance
      .collection('enquiryStatus')
      .where('eId', isEqualTo: widget.id)
      .orderBy('date', descending: true)
      .snapshots()
      .map((snapshot) => snapshot.docs
          .map((doc) => EnquiryStatus.fromJson(doc.data()))
          .toList());

  //Get Statuses of Current enquiry
  Stream<List<EnquiryStatus>> getFollowUpList() => FirebaseFirestore.instance
      .collection('followUp')
      .where('eId', isEqualTo: widget.id)
      .orderBy('date', descending: true)
      .snapshots()
      .map((snapshot) => snapshot.docs
          .map((doc) => EnquiryStatus.fromJson(doc.data()))
          .toList());

  //Upload Status to FireBase
  uploadStatus(EnquiryStatus statusDetail) {
    FirebaseFirestore.instance
        .collection('enquiryStatus')
        .add(statusDetail.toJson())
        .then((doc) {
      doc.update({"dId": doc.id}).then((value) {
        showUploadMessage(context, 'SuccessFully Uploaded ');
        status.clear();
      });
    });
  }

  //Upload FollowUp to FireBase
  uploadFollowUp(FollowUpModel followUpDetail) {
    FirebaseFirestore.instance
        .collection('followUp')
        .add(followUpDetail.toJson())
        .then((value) {
      value.update({'dId': value.id});
    }).catchError((e) {
      print('@@@@@@@@@@@@');
      print(e);
    });
  }

  @override
  void initState() {
    currentTab = widget.tab ?? 1;
    super.initState();
    status = TextEditingController();
    assignee = TextEditingController();
    followUp = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    print('Build Start  !!!!!!!!!!!!!!!!!!!!');
    currentTab = widget.tab ?? 1;
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Color(0xFF383838)),
        automaticallyImplyLeading: true,
        title: Text(
          'Details',
          style: FlutterFlowTheme.title2.override(
            fontFamily: 'Poppins',
            color: Color(0xFF090F13),
            fontSize: 24,
            fontWeight: FontWeight.w500,
          ),
        ),
        actions: [],
        centerTitle: true,
        elevation: 5,
      ),
      backgroundColor: Color(0xFFF1F4F8),
      body: StreamBuilder<DocumentSnapshot>(
        stream: FirebaseFirestore.instance
            .collection('enquiries')
            .doc(widget.id)
            .snapshots(),
        builder: (context, snapshot) {
          print(snapshot);

          if (!snapshot.hasData) {
            return Container(
                color: Colors.white,
                child: Center(
                  child: Image.asset('assets/images/loading.gif'),
                ));
          }

          var data = snapshot.data;

          if (snapshot.data.exists) {
            projectDetailList = snapshot.data.get('projectDetails');
            selectedProjectType = snapshot.data.get('projectType');
          }
          return !data.exists
              ? Center(
                  child: Text('Loading... asd'),
                )
              : SingleChildScrollView(
                  physics: BouncingScrollPhysics(),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            //Enquiry Details
                            Expanded(
                              child: Material(
                                color: Colors.transparent,
                                elevation: 10,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(0, 10, 0, 10),
                                    child: Column(
                                      children: [
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(top: 10),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            children: [
                                              Material(
                                                color: Colors.transparent,
                                                elevation: 10,
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(30),
                                                ),
                                                child: InkWell(
                                                  onTap: () async {
                                                    if (data['status'] == 0) {
                                                      bool pressed =
                                                          await alert(context,
                                                              'Edit Details');

                                                      if (pressed) {
                                                        Navigator.push(
                                                            context,
                                                            MaterialPageRoute(
                                                                builder:
                                                                    (context) =>
                                                                        EditEnquiry(
                                                                          eId: data
                                                                              .id,
                                                                        )));
                                                      }
                                                    } else {
                                                      showUploadMessage(context,
                                                          'This Enquiry Already Converted to Customer...');
                                                    }
                                                  },
                                                  child: Container(
                                                    height: 100,
                                                    constraints: BoxConstraints(
                                                      maxHeight: 50,
                                                    ),
                                                    decoration: BoxDecoration(
                                                      color: Color(0xff0054FF),
                                                      boxShadow: [
                                                        BoxShadow(
                                                          blurRadius: 4,
                                                          color:
                                                              Color(0xff231F20),
                                                          offset: Offset(0, 2),
                                                        )
                                                      ],
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              30),
                                                      shape: BoxShape.rectangle,
                                                    ),
                                                    child: Padding(
                                                      padding:
                                                          EdgeInsetsDirectional
                                                              .fromSTEB(
                                                                  8, 0, 8, 0),
                                                      child: Row(
                                                        mainAxisSize:
                                                            MainAxisSize.max,
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: [
                                                          Icon(
                                                            Icons.edit,
                                                            color: Colors.white,
                                                            size: 20,
                                                          ),
                                                          Padding(
                                                            padding:
                                                                EdgeInsetsDirectional
                                                                    .fromSTEB(
                                                                        8,
                                                                        0,
                                                                        0,
                                                                        0),
                                                            child: Text(
                                                              'Edit Details',
                                                              style:
                                                                  FlutterFlowTheme
                                                                      .bodyText1
                                                                      .override(
                                                                fontFamily:
                                                                    'Lexend Deca',
                                                                color: Colors
                                                                    .white,
                                                                fontSize: 14,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .normal,
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
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
                                                  20, 8, 0, 0),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              Text(
                                                'Name : ' + data['name'],
                                                style: FlutterFlowTheme.title3
                                                    .override(
                                                  fontFamily: 'Poppins',
                                                  color: Color(0xFF090F13),
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),

                                        Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  20, 5, 0, 0),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              Text(
                                                'Mobile : ' + data['mobile'],
                                                style: FlutterFlowTheme.title3
                                                    .override(
                                                  fontFamily: 'Poppins',
                                                  color: Color(0xFF090F13),
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  20, 5, 0, 0),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              Text(
                                                'Place : ' + data['place'],
                                                style: FlutterFlowTheme.title3
                                                    .override(
                                                  fontFamily: 'Poppins',
                                                  color: Color(0xFF090F13),
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  20, 5, 0, 0),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              Text(
                                                'Email : ' + data['email'],
                                                style: FlutterFlowTheme
                                                    .bodyText2
                                                    .override(
                                                  fontFamily: 'Poppins',
                                                  color: Color(0xFF57636C),
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  20, 5, 0, 0),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              Text(
                                                'branch : ' + data['branch'],
                                                style: FlutterFlowTheme
                                                    .bodyText2
                                                    .override(
                                                  fontFamily: 'Poppins',
                                                  color: Color(0xFF57636C),
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),

                                        // Padding(
                                        //   padding:
                                        //       EdgeInsetsDirectional.fromSTEB(
                                        //           20, 5, 0, 0),
                                        //   child: Row(
                                        //     mainAxisAlignment: MainAxisAlignment.start,
                                        //     crossAxisAlignment: CrossAxisAlignment.start,
                                        //     children: [
                                        //       Text('course : ',style: FlutterFlowTheme
                                        //           .bodyText2
                                        //           .override(
                                        //         fontFamily: 'Poppins',
                                        //         color: Color(0xFF57636C),
                                        //         fontSize: 14,
                                        //         fontWeight: FontWeight.w500,
                                        //       ),),
                                        //       ProjectTypeId[selectedProjectType[0]]!=null?
                                        //       Text(
                                        //         ProjectTypeId[selectedProjectType[0]],
                                        //       style: FlutterFlowTheme
                                        //           .bodyText2
                                        //           .override(
                                        //         fontFamily: 'Poppins',
                                        //         color: Color(0xFF57636C),
                                        //         fontSize: 14,
                                        //         fontWeight: FontWeight.w500,
                                        //       ),
                                        //             )
                                        //             :Text(''),
                                        //     ],
                                        //   ),
                                        // ),

                                        // Padding(
                                        //   padding:
                                        //       EdgeInsetsDirectional.fromSTEB(
                                        //           20, 5, 0, 0),
                                        //   child: Row(
                                        //     mainAxisAlignment:
                                        //         MainAxisAlignment.start,
                                        //     children: [
                                        //       Text(
                                        //         'IELTS Score : ' +
                                        //             data.get('ieltsScore'),
                                        //         style: FlutterFlowTheme
                                        //             .bodyText2
                                        //             .override(
                                        //           fontFamily: 'Poppins',
                                        //           color: Color(0xFF57636C),
                                        //           fontSize: 14,
                                        //           fontWeight: FontWeight.w500,
                                        //         ),
                                        //       ),
                                        //     ],
                                        //   ),
                                        // ),
                                        Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  0, 5, 0, 0),
                                          child: Column(
                                            children: [
                                              Text(
                                                'Enquiry Registered on : ' +
                                                    dateTimeFormat('d-MMM-y',
                                                        data['date'].toDate()),
                                                style: FlutterFlowTheme
                                                    .bodyText2
                                                    .override(
                                                  fontFamily: 'Poppins',
                                                  color: Color(0xFF57636C),
                                                  fontSize: 17,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                              Row(
                                                mainAxisSize: MainAxisSize.max,
                                                children: [
                                                  Padding(
                                                    padding:
                                                        EdgeInsetsDirectional
                                                            .fromSTEB(
                                                                24, 12, 0, 12),
                                                    child: Text(
                                                      'Project Details',
                                                      style: FlutterFlowTheme
                                                          .bodyText1
                                                          .override(
                                                        fontFamily:
                                                            'Lexend Deca',
                                                        color:
                                                            Color(0xFF090F13),
                                                        fontSize: 14,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              Padding(
                                                padding: EdgeInsetsDirectional
                                                    .fromSTEB(20, 0, 20, 0),
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                    color: Colors.white,
                                                    boxShadow: [
                                                      BoxShadow(
                                                        blurRadius: 5,
                                                        color:
                                                            Color(0x3416202A),
                                                        offset: Offset(0, 2),
                                                      )
                                                    ],
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            12),
                                                    shape: BoxShape.rectangle,
                                                  ),
                                                  child: Padding(
                                                    padding:
                                                        EdgeInsetsDirectional
                                                            .fromSTEB(
                                                                8, 8, 8, 8),
                                                    child: Column(
                                                      children: [
                                                        Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceAround,
                                                          mainAxisSize:
                                                              MainAxisSize.max,
                                                          children: [
                                                            Text(
                                                              'Domain',
                                                              style:
                                                                  FlutterFlowTheme
                                                                      .bodyText2
                                                                      .override(
                                                                fontFamily:
                                                                    'Poppins',
                                                                color: Color(
                                                                    0xFF57636C),
                                                                fontSize: 14,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500,
                                                              ),
                                                            ),
                                                            Text(
                                                              'Requirement',
                                                              style:
                                                                  FlutterFlowTheme
                                                                      .bodyText2
                                                                      .override(
                                                                fontFamily:
                                                                    'Poppins',
                                                                color: Color(
                                                                    0xFF57636C),
                                                                fontSize: 14,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500,
                                                              ),
                                                            ),
                                                            Text(
                                                              'Quotation',
                                                              style:
                                                                  FlutterFlowTheme
                                                                      .bodyText2
                                                                      .override(
                                                                fontFamily:
                                                                    'Poppins',
                                                                color: Color(
                                                                    0xFF57636C),
                                                                fontSize: 14,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500,
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                        Column(
                                                          children: List.generate(
                                                              projectDetailList
                                                                  .length,
                                                              (index) {
                                                            return Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .spaceAround,
                                                              mainAxisSize:
                                                                  MainAxisSize
                                                                      .max,
                                                              children: [
                                                                Padding(
                                                                  padding:
                                                                      const EdgeInsets
                                                                              .all(
                                                                          8.0),
                                                                  child: Text(
                                                                    projectDetailList[index]
                                                                            [
                                                                            'domain'] ??
                                                                        '',
                                                                    style: FlutterFlowTheme
                                                                        .bodyText2
                                                                        .override(
                                                                      fontFamily:
                                                                          'Poppins',
                                                                      color: Color(
                                                                          0xFF57636C),
                                                                      fontSize:
                                                                          14,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w500,
                                                                    ),
                                                                  ),
                                                                ),
                                                                Padding(
                                                                  padding:
                                                                      const EdgeInsets
                                                                              .all(
                                                                          8.0),
                                                                  child: Text(
                                                                    projectDetailList[index]
                                                                            [
                                                                            'deliverable'] ??
                                                                        '',
                                                                    style: FlutterFlowTheme
                                                                        .bodyText2
                                                                        .override(
                                                                      fontFamily:
                                                                          'Poppins',
                                                                      color: Color(
                                                                          0xFF57636C),
                                                                      fontSize:
                                                                          14,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w500,
                                                                    ),
                                                                  ),
                                                                ),
                                                                Padding(
                                                                  padding:
                                                                      const EdgeInsets
                                                                              .all(
                                                                          8.0),
                                                                  child: Text(
                                                                    projectDetailList[index]
                                                                            [
                                                                            'platform'] ??
                                                                        '',
                                                                    style: FlutterFlowTheme
                                                                        .bodyText2
                                                                        .override(
                                                                      fontFamily:
                                                                          'Poppins',
                                                                      color: Color(
                                                                          0xFF57636C),
                                                                      fontSize:
                                                                          14,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w500,
                                                                    ),
                                                                  ),
                                                                ),
                                                              ],
                                                            );
                                                          }),
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Column(
                                          mainAxisSize: MainAxisSize.max,
                                          children: [
                                            Row(
                                              mainAxisSize: MainAxisSize.max,
                                              children: [
                                                Padding(
                                                  padding: EdgeInsetsDirectional
                                                      .fromSTEB(24, 12, 0, 12),
                                                  child: Text(
                                                    'Additional Info',
                                                    style: FlutterFlowTheme
                                                        .bodyText1
                                                        .override(
                                                      fontFamily: 'Lexend Deca',
                                                      color: Color(0xFF090F13),
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                        Column(
                                          mainAxisSize: MainAxisSize.max,
                                          children: [
                                            Padding(
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(24, 0, 0, 0),
                                              child: Row(
                                                mainAxisSize: MainAxisSize.max,
                                                children: [
                                                  Flexible(
                                                    child: Text(
                                                      data.get(
                                                          'additionalInfo'),
                                                      style: FlutterFlowTheme
                                                          .bodyText1
                                                          .override(
                                                        fontFamily:
                                                            'Lexend Deca',
                                                        color:
                                                            Color(0xFF090F13),
                                                        fontSize: 14,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            SizedBox(
                                              width: 30,
                                            ),
                                            Material(
                                              color: Colors.transparent,
                                              elevation: 10,
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(30),
                                              ),
                                              child: InkWell(
                                                onTap: () async {
                                                  print(
                                                      "[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[data['customerId']]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]");
                                                  print(data['customerId']);
                                                  if (data['status'] == 0) {
                                                    bool pressed = await alert(
                                                        context,
                                                        'Convert to Dead Enquiry?');
                                                    if (pressed) {
                                                      FirebaseFirestore.instance
                                                          .collection(
                                                              'enquiries')
                                                          .doc(data.id)
                                                          .update({
                                                        'status': 2,
                                                      });
                                                    } else {
                                                      showUploadMessage(context,
                                                          'Conversion failed.');
                                                    }
                                                  } else {
                                                    data['status'] == 1
                                                        ? showUploadMessage(
                                                            context,
                                                            'This Enquiry Already Converted to Customer...')
                                                        : showUploadMessage(
                                                            context,
                                                            'This is an Dead Enquiry...');
                                                  }
                                                },
                                                child: Container(
                                                  height: 100,
                                                  constraints: BoxConstraints(
                                                    maxHeight: 50,
                                                  ),
                                                  decoration: BoxDecoration(
                                                    color: data['status'] == 0
                                                        ? Colors.red
                                                        : Colors.red,
                                                    boxShadow: [
                                                      BoxShadow(
                                                        blurRadius: 4,
                                                        color:
                                                            Color(0xff231F20),
                                                        offset: Offset(0, 2),
                                                      )
                                                    ],
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            30),
                                                    shape: BoxShape.rectangle,
                                                  ),
                                                  child: Padding(
                                                    padding:
                                                        EdgeInsetsDirectional
                                                            .fromSTEB(
                                                                8, 0, 8, 0),
                                                    child: Row(
                                                      mainAxisSize:
                                                          MainAxisSize.max,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        Icon(
                                                          Icons.person_add,
                                                          color: Colors.white,
                                                          size: 20,
                                                        ),
                                                        Padding(
                                                          padding:
                                                              EdgeInsetsDirectional
                                                                  .fromSTEB(8,
                                                                      0, 0, 0),
                                                          child: Text(
                                                            data['status'] == 2
                                                                ? "Already a Dead One."
                                                                : 'Convert to Dead',
                                                            style:
                                                                FlutterFlowTheme
                                                                    .bodyText1
                                                                    .override(
                                                              fontFamily:
                                                                  'Lexend Deca',
                                                              color:
                                                                  Colors.white,
                                                              fontSize: 14,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .normal,
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                              width: 10,
                                            ),
                                            Material(
                                              color: Colors.transparent,
                                              elevation: 10,
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(30),
                                              ),
                                              child: InkWell(
                                                onTap: () async {
                                                  print(
                                                      "[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[data['customerId']]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]");
                                                  print(data['customerId']);
                                                  if (data['status'] == 0) {
                                                    bool pressed = await alert(
                                                        context,
                                                        'Register As Customer...');
                                                    if (pressed) {
                                                      if (data['customerId'] ==
                                                          '') {
                                                        createCustomerAndProject(
                                                            data);
                                                      } else {
                                                        addProject(data);
                                                      }
                                                    } else {
                                                      showUploadMessage(context,
                                                          'Registering as Customer failed.');
                                                    }
                                                  } else {
                                                    data['status'] == 1
                                                        ? showUploadMessage(
                                                            context,
                                                            'This Enquiry Already Converted to Customer...')
                                                        : showUploadMessage(
                                                            context,
                                                            'This is an Dead Enquiry...');
                                                  }
                                                },
                                                child: Container(
                                                  height: 100,
                                                  constraints: BoxConstraints(
                                                    maxHeight: 50,
                                                  ),
                                                  decoration: BoxDecoration(
                                                    color: data['status'] == 0
                                                        ? Color(0xff0054FF)
                                                        : Color(0xff0054FF),
                                                    boxShadow: [
                                                      BoxShadow(
                                                        blurRadius: 4,
                                                        color:
                                                            Color(0xff231F20),
                                                        offset: Offset(0, 2),
                                                      )
                                                    ],
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            30),
                                                    shape: BoxShape.rectangle,
                                                  ),
                                                  child: Padding(
                                                    padding:
                                                        EdgeInsetsDirectional
                                                            .fromSTEB(
                                                                8, 0, 8, 0),
                                                    child: Row(
                                                      mainAxisSize:
                                                          MainAxisSize.max,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        Icon(
                                                          Icons.person_add,
                                                          color: Colors.white,
                                                          size: 20,
                                                        ),
                                                        Padding(
                                                          padding:
                                                              EdgeInsetsDirectional
                                                                  .fromSTEB(8,
                                                                      0, 0, 0),
                                                          child: Text(
                                                            data['status'] == 1
                                                                ? "Already a customer."
                                                                : 'Register As Customer',
                                                            style:
                                                                FlutterFlowTheme
                                                                    .bodyText1
                                                                    .override(
                                                              fontFamily:
                                                                  'Lexend Deca',
                                                              color:
                                                                  Colors.white,
                                                              fontSize: 14,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .normal,
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                              width: 10,
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 15,
                            ),

                            //FollowUp and Status
                            Expanded(
                                flex: 2,
                                child: Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        //Status Container
                                        InkWell(
                                          onTap: () {
                                            setState(() {
                                              currentTab = 1;
                                            });
                                          },
                                          child: SizedBox(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.30,
                                            child: Padding(
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(4, 0, 4, 0),
                                              child: Material(
                                                color: Colors.transparent,
                                                elevation:
                                                    currentTab == 1 ? 10 : 0,
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(30),
                                                ),
                                                child: Container(
                                                  height: 60,
                                                  decoration: BoxDecoration(
                                                    color: currentTab == 1
                                                        ? Color(0xff231F20)
                                                        : Colors.white,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            currentTab == 1
                                                                ? 20
                                                                : 15),
                                                  ),
                                                  alignment:
                                                      AlignmentDirectional(
                                                          0, 0),
                                                  child: Center(
                                                      child: Text(
                                                    'Status',
                                                    style: TextStyle(
                                                        fontSize: 25,
                                                        color: currentTab == 1
                                                            ? Colors.white
                                                            : Colors.black,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  )),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),

                                        //FollowUp Container
                                        InkWell(
                                          onTap: () {
                                            setState(() {
                                              currentTab = 2;
                                            });
                                          },
                                          child: SizedBox(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.30,
                                            child: Padding(
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(4, 0, 4, 0),
                                              child: Material(
                                                color: Colors.transparent,
                                                elevation:
                                                    currentTab == 2 ? 10 : 0,
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(30),
                                                ),
                                                child: Container(
                                                  height: 60,
                                                  decoration: BoxDecoration(
                                                    color: currentTab == 2
                                                        ? Color(0xff231F20)
                                                        : Colors.white,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            currentTab == 2
                                                                ? 20
                                                                : 15),
                                                  ),
                                                  alignment:
                                                      AlignmentDirectional(
                                                          0, 0),
                                                  child: Center(
                                                      child: Text(
                                                    'Follow up',
                                                    style: TextStyle(
                                                        fontSize: 25,
                                                        color: currentTab == 2
                                                            ? Colors.white
                                                            : Colors.black,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  )),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.010,
                                    ),
                                    currentTab == 1
                                        ?
                                        //Status Page
                                        Material(
                                            color: Colors.transparent,
                                            elevation: 10,
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                            ),
                                            child: Container(
                                              height: MediaQuery.of(context)
                                                  .size
                                                  .height,
                                              decoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius:
                                                    BorderRadius.circular(20),
                                              ),
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(20.0),
                                                child: Column(
                                                  children: [
                                                    //Status TextField
                                                    Material(
                                                      color: Colors.transparent,
                                                      elevation: 10,
                                                      shape:
                                                          RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(15),
                                                      ),
                                                      child: Container(
                                                        width: double.infinity,
                                                        height: 60,
                                                        decoration:
                                                            BoxDecoration(
                                                          color: Colors.white,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(16),
                                                        ),
                                                        alignment:
                                                            AlignmentDirectional(
                                                                0, 0),
                                                        child: Row(
                                                          mainAxisSize:
                                                              MainAxisSize.max,
                                                          children: [
                                                            //TEXTFIELD
                                                            Expanded(
                                                              child: Padding(
                                                                padding:
                                                                    EdgeInsetsDirectional
                                                                        .fromSTEB(
                                                                            4,
                                                                            0,
                                                                            4,
                                                                            0),
                                                                child:
                                                                    TextFormField(
                                                                  controller:
                                                                      status,
                                                                  obscureText:
                                                                      false,
                                                                  decoration:
                                                                      InputDecoration(
                                                                    labelText:
                                                                        'Status...',
                                                                    hintText:
                                                                        'Please Enter Status...',
                                                                    hintStyle: FlutterFlowTheme
                                                                        .bodyText1
                                                                        .override(
                                                                      fontFamily:
                                                                          'Lexend Deca',
                                                                      color: Color(
                                                                          0xFF57636C),
                                                                      fontSize:
                                                                          14,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .normal,
                                                                    ),
                                                                    labelStyle: FlutterFlowTheme
                                                                        .bodyText1
                                                                        .override(
                                                                      fontFamily:
                                                                          'Lexend Deca',
                                                                      color: Color(
                                                                          0xFF57636C),
                                                                      fontSize:
                                                                          14,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .normal,
                                                                    ),
                                                                    enabledBorder:
                                                                        OutlineInputBorder(
                                                                      borderSide:
                                                                          BorderSide(
                                                                        color: Color(
                                                                            0x00000000),
                                                                        width:
                                                                            0,
                                                                      ),
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              8),
                                                                    ),
                                                                    focusedBorder:
                                                                        OutlineInputBorder(
                                                                      borderSide:
                                                                          BorderSide(
                                                                        color: Color(
                                                                            0x00000000),
                                                                        width:
                                                                            0,
                                                                      ),
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              8),
                                                                    ),
                                                                  ),
                                                                  style: FlutterFlowTheme
                                                                      .bodyText1
                                                                      .override(
                                                                    fontFamily:
                                                                        'Lexend Deca',
                                                                    color: Color(
                                                                        0xFF262D34),
                                                                    fontSize:
                                                                        14,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .normal,
                                                                  ),
                                                                ),
                                                              ),
                                                            ),

                                                            //DATEPICK
                                                            TextButton(
                                                                onPressed: () {
                                                                  showDatePicker(
                                                                          context:
                                                                              context,
                                                                          initialDate:
                                                                              selectedDate1,
                                                                          firstDate: DateTime(
                                                                              1901,
                                                                              1),
                                                                          lastDate: DateTime(
                                                                              2100,
                                                                              1))
                                                                      .then(
                                                                          (value) {
                                                                    setState(
                                                                        () {
                                                                      datePicked2 = Timestamp.fromDate(DateTime(
                                                                          value
                                                                              .year,
                                                                          value
                                                                              .month,
                                                                          value
                                                                              .day,
                                                                          0,
                                                                          0,
                                                                          0));

                                                                      selectedDate1 =
                                                                          value;
                                                                    });
                                                                  });
                                                                },
                                                                child: Text(
                                                                  datePicked2 ==
                                                                          null
                                                                      ? 'Choose Date'
                                                                      : datePicked2
                                                                          .toDate()
                                                                          .toString()
                                                                          .substring(
                                                                              0,
                                                                              10),
                                                                  style:
                                                                      TextStyle(
                                                                    fontFamily:
                                                                        'Poppins',
                                                                    color: Colors
                                                                        .blue,
                                                                    fontSize:
                                                                        13,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w600,
                                                                  ),
                                                                )),

                                                            //STATUS ADD BUTTON
                                                            Padding(
                                                              padding:
                                                                  EdgeInsetsDirectional
                                                                      .fromSTEB(
                                                                          0,
                                                                          0,
                                                                          8,
                                                                          0),
                                                              child:
                                                                  FFButtonWidget(
                                                                onPressed:
                                                                    () async {
                                                                  if (data[
                                                                          'status'] ==
                                                                      0) {
                                                                    if (status.text !=
                                                                            '' &&
                                                                        datePicked2 !=
                                                                            null) {
                                                                      bool pressed = await alert(
                                                                          context,
                                                                          'Update This Status...');

                                                                      if (pressed) {
                                                                        final statusDetails = EnquiryStatus(
                                                                            branch:
                                                                                currentBranchId,
                                                                            date:
                                                                                DateTime.now(),
                                                                            eId: widget.id,
                                                                            next: datePicked2.toDate(),
                                                                            status: status.text);
                                                                        uploadStatus(
                                                                            statusDetails);

                                                                        showUploadMessage(
                                                                            context,
                                                                            'Status Updated...');
                                                                        setState(
                                                                            () {
                                                                          status.text =
                                                                              '';
                                                                        });
                                                                      }
                                                                    } else {
                                                                      status.text ==
                                                                              ''
                                                                          ? showUploadMessage(
                                                                              context,
                                                                              'Please Enter Status...')
                                                                          : showUploadMessage(
                                                                              context,
                                                                              'Please Choose Date...');
                                                                    }
                                                                  } else {
                                                                    showUploadMessage(
                                                                        context,
                                                                        'This Enquiry Already Converted to Customer...');
                                                                  }
                                                                },
                                                                text: 'Update',
                                                                options:
                                                                    FFButtonOptions(
                                                                  width: 100,
                                                                  height: 40,
                                                                  color: Color(
                                                                      0xFF4B39EF),
                                                                  textStyle: FlutterFlowTheme
                                                                      .subtitle2
                                                                      .override(
                                                                    fontFamily:
                                                                        'Lexend Deca',
                                                                    color: Colors
                                                                        .white,
                                                                    fontSize:
                                                                        16,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .normal,
                                                                  ),
                                                                  elevation: 2,
                                                                  borderSide:
                                                                      BorderSide(
                                                                    color: Colors
                                                                        .transparent,
                                                                    width: 1,
                                                                  ),
                                                                  borderRadius:
                                                                      50,
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ),

                                                    SizedBox(height: 10),

                                                    //Status Table
                                                    Expanded(
                                                      child: StreamBuilder<
                                                              QuerySnapshot>(
                                                          stream: FirebaseFirestore
                                                              .instance
                                                              .collection(
                                                                  'enquiryStatus')
                                                              .where('eId',
                                                                  isEqualTo:
                                                                      widget.id)
                                                              .orderBy('date',
                                                                  descending:
                                                                      true)
                                                              .snapshots(),
                                                          builder: (context,
                                                              snapshot) {
                                                            if (!snapshot
                                                                .hasData) {
                                                              return Center(
                                                                child:
                                                                    CircularProgressIndicator(),
                                                              );
                                                            } else if (snapshot
                                                                .data
                                                                .docs
                                                                .isEmpty) {
                                                              return Center(
                                                                child: Text(
                                                                    'No data Added yet !!!'),
                                                              );
                                                            } else {
                                                              var value =
                                                                  snapshot.data
                                                                      .docs;

                                                              return SizedBox(
                                                                width: double
                                                                    .infinity,
                                                                child:
                                                                    DataTable(
                                                                  horizontalMargin:
                                                                      5,
                                                                  columns: [
                                                                    DataColumn(
                                                                      label:
                                                                          Container(
                                                                        child:
                                                                            Center(
                                                                          child: Text(
                                                                              "Date",
                                                                              style: TextStyle(fontWeight: FontWeight.bold)),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    DataColumn(
                                                                      label:
                                                                          Container(
                                                                        child:
                                                                            Center(
                                                                          child: Text(
                                                                              "Status",
                                                                              style: TextStyle(fontWeight: FontWeight.bold)),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    DataColumn(
                                                                      label:
                                                                          Center(
                                                                        child: Text(
                                                                            "Next FollowUp",
                                                                            style:
                                                                                TextStyle(fontWeight: FontWeight.bold)),
                                                                      ),
                                                                    ),
                                                                    DataColumn(
                                                                      label:
                                                                          Center(
                                                                        child: Text(
                                                                            " ",
                                                                            style:
                                                                                TextStyle(fontWeight: FontWeight.bold)),
                                                                      ),
                                                                    ),
                                                                  ],
                                                                  rows: List
                                                                      .generate(
                                                                    value
                                                                        .length,
                                                                    (index) {
                                                                      try {
                                                                        return DataRow(
                                                                          selected:
                                                                              true,
                                                                          color: index.isOdd
                                                                              ? MaterialStateProperty.all(Colors.blueGrey.shade50.withOpacity(0.7))
                                                                              : MaterialStateProperty.all(Colors.blueGrey.shade50),
                                                                          cells: [
                                                                            DataCell(
                                                                              Text(
                                                                                value[index]['date'].toDate().toString().substring(0, 16),
                                                                                textAlign: TextAlign.end,
                                                                                style: FlutterFlowTheme.bodyText2.override(
                                                                                  fontFamily: 'Lexend Deca',
                                                                                  color: Colors.black,
                                                                                  fontSize: 12,
                                                                                  fontWeight: FontWeight.w500,
                                                                                ),
                                                                              ),
                                                                            ),
                                                                            DataCell(
                                                                              Text(
                                                                                value[index]['status'],
                                                                                textAlign: TextAlign.end,
                                                                                style: FlutterFlowTheme.bodyText2.override(
                                                                                  fontFamily: 'Lexend Deca',
                                                                                  color: Colors.black,
                                                                                  fontSize: 14,
                                                                                  fontWeight: FontWeight.bold,
                                                                                ),
                                                                              ),
                                                                            ),

                                                                            DataCell(
                                                                              Text(
                                                                                value[index]['next'].toDate().toString().substring(0, 10),
                                                                                textAlign: TextAlign.end,
                                                                                style: FlutterFlowTheme.bodyText2.override(
                                                                                  fontFamily: 'Lexend Deca',
                                                                                  color: Colors.black,
                                                                                  fontSize: 12,
                                                                                  fontWeight: FontWeight.w500,
                                                                                ),
                                                                              ),
                                                                            ),
                                                                            DataCell(
                                                                              Row(
                                                                                children: [
                                                                                  // Generated code for this Button Widget...
                                                                                  FlutterFlowIconButton(
                                                                                    borderColor: Colors.transparent,
                                                                                    borderRadius: 30,
                                                                                    borderWidth: 1,
                                                                                    buttonSize: 50,
                                                                                    icon: Icon(
                                                                                      Icons.delete,
                                                                                      color: Color(0xFFEE0000),
                                                                                      size: 25,
                                                                                    ),
                                                                                    onPressed: () async {
                                                                                      bool pressed = await alert(context, 'Do you want Delete');

                                                                                      if (pressed) {
                                                                                        // value.removeAt(index);
                                                                                        FirebaseFirestore.instance.collection('enquiryStatus').doc(value[index].id).delete();

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
                                                                      } catch (err) {
                                                                        return DataRow(
                                                                          selected:
                                                                              true,
                                                                          color: index.isOdd
                                                                              ? MaterialStateProperty.all(Colors.blueGrey.shade50.withOpacity(0.7))
                                                                              : MaterialStateProperty.all(Colors.blueGrey.shade50),
                                                                          cells: [
                                                                            DataCell(
                                                                              Text(
                                                                                "",
                                                                                textAlign: TextAlign.end,
                                                                                style: FlutterFlowTheme.bodyText2.override(
                                                                                  fontFamily: 'Lexend Deca',
                                                                                  color: Colors.black,
                                                                                  fontSize: 12,
                                                                                  fontWeight: FontWeight.w500,
                                                                                ),
                                                                              ),
                                                                            ),
                                                                            DataCell(
                                                                              Text(
                                                                                "",
                                                                                textAlign: TextAlign.end,
                                                                                style: FlutterFlowTheme.bodyText2.override(
                                                                                  fontFamily: 'Lexend Deca',
                                                                                  color: Colors.black,
                                                                                  fontSize: 14,
                                                                                  fontWeight: FontWeight.bold,
                                                                                ),
                                                                              ),
                                                                            ),

                                                                            DataCell(
                                                                              Text(
                                                                                "",
                                                                                textAlign: TextAlign.end,
                                                                                style: FlutterFlowTheme.bodyText2.override(
                                                                                  fontFamily: 'Lexend Deca',
                                                                                  color: Colors.black,
                                                                                  fontSize: 12,
                                                                                  fontWeight: FontWeight.w500,
                                                                                ),
                                                                              ),
                                                                            ),
                                                                            DataCell(
                                                                              Text(""),
                                                                            ),
                                                                            // DataCell(Text(fileInfo.size)),
                                                                          ],
                                                                        );
                                                                      }
                                                                    },
                                                                  ),
                                                                ),
                                                              );
                                                            }
                                                          }),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          )
                                        :
                                        //FollowUp Page
                                        Material(
                                            color: Colors.transparent,
                                            elevation: 10,
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                            ),
                                            child: Container(
                                              height: MediaQuery.of(context)
                                                  .size
                                                  .height,
                                              decoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius:
                                                    BorderRadius.circular(20),
                                              ),
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(20.0),
                                                child: Column(
                                                  children: [
                                                    // Text Field and Buttons

                                                    Row(
                                                      mainAxisSize:
                                                          MainAxisSize.max,
                                                      children: [
                                                        //FollowUp Details TextField
                                                        Expanded(
                                                          child: Padding(
                                                            padding:
                                                                EdgeInsetsDirectional
                                                                    .fromSTEB(
                                                                        4,
                                                                        0,
                                                                        4,
                                                                        0),
                                                            child: Material(
                                                              color: Colors
                                                                  .transparent,
                                                              elevation: 10,
                                                              shape:
                                                                  RoundedRectangleBorder(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            15),
                                                              ),
                                                              child: Container(
                                                                height: 60,
                                                                decoration:
                                                                    BoxDecoration(
                                                                  color: Colors
                                                                      .white,
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              16),
                                                                ),
                                                                alignment:
                                                                    AlignmentDirectional(
                                                                        0, 0),
                                                                child:
                                                                    TextFormField(
                                                                  controller:
                                                                      followUp,
                                                                  obscureText:
                                                                      false,
                                                                  decoration:
                                                                      InputDecoration(
                                                                    labelText:
                                                                        'FollowUp',
                                                                    hintText:
                                                                        'Please Enter FollowUp...',
                                                                    hintStyle: FlutterFlowTheme
                                                                        .bodyText1
                                                                        .override(
                                                                      fontFamily:
                                                                          'Lexend Deca',
                                                                      color: Color(
                                                                          0xFF57636C),
                                                                      fontSize:
                                                                          14,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .normal,
                                                                    ),
                                                                    labelStyle: FlutterFlowTheme
                                                                        .bodyText1
                                                                        .override(
                                                                      fontFamily:
                                                                          'Lexend Deca',
                                                                      color: Color(
                                                                          0xFF57636C),
                                                                      fontSize:
                                                                          14,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .normal,
                                                                    ),
                                                                    enabledBorder:
                                                                        OutlineInputBorder(
                                                                      borderSide: BorderSide(
                                                                          color: Colors
                                                                              .white,
                                                                          width:
                                                                              0),
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              8),
                                                                    ),
                                                                    focusedBorder:
                                                                        OutlineInputBorder(
                                                                      borderSide:
                                                                          BorderSide(
                                                                        color: Colors
                                                                            .white,
                                                                        width:
                                                                            0,
                                                                      ),
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              8),
                                                                    ),
                                                                  ),
                                                                  style: FlutterFlowTheme
                                                                      .bodyText1
                                                                      .override(
                                                                    fontFamily:
                                                                        'Lexend Deca',
                                                                    color: Color(
                                                                        0xFF262D34),
                                                                    fontSize:
                                                                        14,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .normal,
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        ),

                                                        //Assignee TextField
                                                        Expanded(
                                                          child: Padding(
                                                            padding:
                                                                EdgeInsetsDirectional
                                                                    .fromSTEB(
                                                                        4,
                                                                        0,
                                                                        4,
                                                                        0),
                                                            child: Material(
                                                              color: Colors
                                                                  .transparent,
                                                              elevation: 10,
                                                              shape:
                                                                  RoundedRectangleBorder(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            15),
                                                              ),
                                                              child: Container(
                                                                height: 60,
                                                                decoration:
                                                                    BoxDecoration(
                                                                  color: Colors
                                                                      .white,
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              16),
                                                                ),
                                                                alignment:
                                                                    AlignmentDirectional(
                                                                        0, 0),
                                                                child:
                                                                    TextFormField(
                                                                  controller:
                                                                      assignee,
                                                                  obscureText:
                                                                      false,
                                                                  decoration:
                                                                      InputDecoration(
                                                                    labelText:
                                                                        'Assignee',
                                                                    hintText:
                                                                        'Please Enter Assignee Name...',
                                                                    hintStyle: FlutterFlowTheme
                                                                        .bodyText1
                                                                        .override(
                                                                      fontFamily:
                                                                          'Lexend Deca',
                                                                      color: Color(
                                                                          0xFF57636C),
                                                                      fontSize:
                                                                          14,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .normal,
                                                                    ),
                                                                    labelStyle: FlutterFlowTheme
                                                                        .bodyText1
                                                                        .override(
                                                                      fontFamily:
                                                                          'Lexend Deca',
                                                                      color: Color(
                                                                          0xFF57636C),
                                                                      fontSize:
                                                                          14,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .normal,
                                                                    ),
                                                                    enabledBorder:
                                                                        OutlineInputBorder(
                                                                      borderSide: BorderSide(
                                                                          color: Colors
                                                                              .white,
                                                                          width:
                                                                              0),
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              8),
                                                                    ),
                                                                    focusedBorder:
                                                                        OutlineInputBorder(
                                                                      borderSide:
                                                                          BorderSide(
                                                                        color: Colors
                                                                            .white,
                                                                        width:
                                                                            0,
                                                                      ),
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              8),
                                                                    ),
                                                                  ),
                                                                  style: FlutterFlowTheme
                                                                      .bodyText1
                                                                      .override(
                                                                    fontFamily:
                                                                        'Lexend Deca',
                                                                    color: Color(
                                                                        0xFF262D34),
                                                                    fontSize:
                                                                        14,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .normal,
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        ),

                                                        //DatePicker
                                                        TextButton(
                                                            onPressed: () {
                                                              showDatePicker(
                                                                      context:
                                                                          context,
                                                                      initialDate:
                                                                          selectedDate1,
                                                                      firstDate:
                                                                          DateTime(
                                                                              1901,
                                                                              1),
                                                                      lastDate:
                                                                          DateTime(
                                                                              2100,
                                                                              1))
                                                                  .then(
                                                                      (value) {
                                                                setState(() {
                                                                  datePicked3 = Timestamp.fromDate(DateTime(
                                                                      value
                                                                          .year,
                                                                      value
                                                                          .month,
                                                                      value.day,
                                                                      0,
                                                                      0,
                                                                      0));

                                                                  selectedDate1 =
                                                                      value;
                                                                });
                                                              });
                                                            },
                                                            child: Text(
                                                              datePicked3 ==
                                                                      null
                                                                  ? 'Choose Date'
                                                                  : datePicked3
                                                                      .toDate()
                                                                      .toString()
                                                                      .substring(
                                                                          0,
                                                                          10),
                                                              style: TextStyle(
                                                                fontFamily:
                                                                    'Poppins',
                                                                color:
                                                                    Colors.blue,
                                                                fontSize: 13,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600,
                                                              ),
                                                            )),

                                                        //Add Button
                                                        Padding(
                                                          padding:
                                                              EdgeInsetsDirectional
                                                                  .fromSTEB(0,
                                                                      0, 8, 0),
                                                          child: FFButtonWidget(
                                                            onPressed:
                                                                () async {
                                                              if (data[
                                                                      'status'] ==
                                                                  0) {
                                                                if (followUp.text != '' &&
                                                                    assignee.text !=
                                                                        '' &&
                                                                    datePicked3 !=
                                                                        null) {
                                                                  bool pressed =
                                                                      await alert(
                                                                          context,
                                                                          'Add FollowUp');

                                                                  if (pressed) {
                                                                    FirebaseFirestore
                                                                        .instance
                                                                        .collection(
                                                                            'followUp')
                                                                        .add({
                                                                      'date': DateTime
                                                                          .now(),
                                                                      'next':
                                                                          datePicked3,
                                                                      'followUpDetail':
                                                                          followUp
                                                                              .text,
                                                                      'eId':
                                                                          widget
                                                                              .id,
                                                                      'name': data[
                                                                          'name'],
                                                                      'workName':
                                                                          data[
                                                                              'projectTopic'],
                                                                      'email': data[
                                                                          'email'],
                                                                      'phone': data[
                                                                          'mobile'],
                                                                      'branch':
                                                                          currentBranchId,
                                                                      'assignee':
                                                                          assignee
                                                                              .text,
                                                                      'done':
                                                                          false
                                                                    }).then((value) {
                                                                      value
                                                                          .update({
                                                                        'dId':
                                                                            value.id
                                                                      });
                                                                    }).then((value) {
                                                                      showUploadMessage(
                                                                          context,
                                                                          'Status Updated...');
                                                                    });

                                                                    setState(
                                                                        () {
                                                                      assignee
                                                                          .clear();
                                                                      followUp
                                                                          .clear();
                                                                    });
                                                                  }
                                                                } else {
                                                                  status.text ==
                                                                          ''
                                                                      ? showUploadMessage(
                                                                          context,
                                                                          'Please Enter Status...')
                                                                      : assignee.text ==
                                                                              ''
                                                                          ? showUploadMessage(
                                                                              context,
                                                                              'Please Enter Assignee Name')
                                                                          : showUploadMessage(
                                                                              context,
                                                                              'Please Choose Date...');
                                                                }
                                                              } else {
                                                                showUploadMessage(
                                                                    context,
                                                                    'This Enquiry Already Converted to Customer...');
                                                              }
                                                            },
                                                            text: 'Update',
                                                            options:
                                                                FFButtonOptions(
                                                              width: 100,
                                                              height: 40,
                                                              color: Color(
                                                                  0xFF4B39EF),
                                                              textStyle:
                                                                  FlutterFlowTheme
                                                                      .subtitle2
                                                                      .override(
                                                                fontFamily:
                                                                    'Lexend Deca',
                                                                color: Colors
                                                                    .white,
                                                                fontSize: 16,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .normal,
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
                                                        ),
                                                      ],
                                                    ),

                                                    SizedBox(height: 10),
                                                    Expanded(
                                                      child: StreamBuilder<
                                                              QuerySnapshot>(
                                                          stream: FirebaseFirestore
                                                              .instance
                                                              .collection(
                                                                  'followUp')
                                                              .where('eId',
                                                                  isEqualTo:
                                                                      widget.id)
                                                              .orderBy('date',
                                                                  descending:
                                                                      true)
                                                              .snapshots(),
                                                          builder: (context,
                                                              snapshot) {
                                                            if (!snapshot
                                                                .hasData) {
                                                              return Center(
                                                                child:
                                                                    CircularProgressIndicator(),
                                                              );
                                                            } else if (snapshot
                                                                .data
                                                                .docs
                                                                .isEmpty) {
                                                              return Center(
                                                                child: Text(
                                                                    'No data Added yet !!!'),
                                                              );
                                                            } else {
                                                              var value =
                                                                  snapshot.data
                                                                      .docs;

                                                              return SizedBox(
                                                                width: double
                                                                    .infinity,
                                                                child:
                                                                    DataTable(
                                                                  horizontalMargin:
                                                                      5,
                                                                  columns: [
                                                                    DataColumn(
                                                                      label: Text(
                                                                          "Date",
                                                                          style:
                                                                              TextStyle(fontWeight: FontWeight.bold)),
                                                                    ),
                                                                    DataColumn(
                                                                      label:
                                                                          Center(
                                                                        child: Text(
                                                                            "Details",
                                                                            style:
                                                                                TextStyle(fontWeight: FontWeight.bold)),
                                                                      ),
                                                                    ),
                                                                    DataColumn(
                                                                      label:
                                                                          Flexible(
                                                                        child: Text(
                                                                            "Next FollowUp",
                                                                            style:
                                                                                TextStyle(fontWeight: FontWeight.bold)),
                                                                      ),
                                                                    ),
                                                                    DataColumn(
                                                                      label: Text(
                                                                          "Assignee",
                                                                          style:
                                                                              TextStyle(fontWeight: FontWeight.bold)),
                                                                    ),
                                                                    DataColumn(
                                                                      label: Text(
                                                                          "Status",
                                                                          style:
                                                                              TextStyle(fontWeight: FontWeight.bold)),
                                                                    ),
                                                                    DataColumn(
                                                                      label: Text(
                                                                          " ",
                                                                          style:
                                                                              TextStyle(fontWeight: FontWeight.bold)),
                                                                    ),
                                                                  ],
                                                                  rows: List
                                                                      .generate(
                                                                    value
                                                                        .length,
                                                                    (index) {
                                                                      Map dd = value[
                                                                              index]
                                                                          .data();
                                                                      print(
                                                                          '////////////////////');

                                                                      print(dd
                                                                          .keys);
                                                                      try {
                                                                        return DataRow(
                                                                          selected:
                                                                              true,
                                                                          color: index.isOdd
                                                                              ? MaterialStateProperty.all(Colors.blueGrey.shade50.withOpacity(0.7))
                                                                              : MaterialStateProperty.all(Colors.blueGrey.shade50),
                                                                          cells: [
                                                                            DataCell(
                                                                              Text(
                                                                                value[index]['date'].toDate().toString().substring(0, 10),
                                                                                textAlign: TextAlign.end,
                                                                                style: FlutterFlowTheme.bodyText2.override(
                                                                                  fontFamily: 'Lexend Deca',
                                                                                  color: Colors.black,
                                                                                  fontSize: 12,
                                                                                  fontWeight: FontWeight.w500,
                                                                                ),
                                                                              ),
                                                                            ),
                                                                            DataCell(
                                                                              Text(
                                                                                value[index]['followUpDetail'],
                                                                                textAlign: TextAlign.end,
                                                                                style: FlutterFlowTheme.bodyText2.override(
                                                                                  fontFamily: 'Lexend Deca',
                                                                                  color: Colors.black,
                                                                                  fontSize: 14,
                                                                                  fontWeight: FontWeight.bold,
                                                                                ),
                                                                              ),
                                                                            ),

                                                                            DataCell(
                                                                              Text(
                                                                                value[index]['next'].toDate().toString().substring(0, 10),
                                                                                textAlign: TextAlign.end,
                                                                                style: FlutterFlowTheme.bodyText2.override(
                                                                                  fontFamily: 'Lexend Deca',
                                                                                  color: Colors.black,
                                                                                  fontSize: 12,
                                                                                  fontWeight: FontWeight.w500,
                                                                                ),
                                                                              ),
                                                                            ),
                                                                            DataCell(
                                                                              Text(
                                                                                value[index]['assignee'],
                                                                                textAlign: TextAlign.end,
                                                                                style: FlutterFlowTheme.bodyText2.override(
                                                                                  fontFamily: 'Lexend Deca',
                                                                                  color: Colors.black,
                                                                                  fontSize: 14,
                                                                                  fontWeight: FontWeight.bold,
                                                                                ),
                                                                              ),
                                                                            ),

                                                                            DataCell(value[index]['done']
                                                                                ? Center(
                                                                                    child: Icon(
                                                                                      Icons.done,
                                                                                      size: 30,
                                                                                      color: Colors.teal,
                                                                                    ),
                                                                                  )
                                                                                : Center(
                                                                                    child: InkWell(
                                                                                      onTap: () async {
                                                                                        bool pressed = await alert(context, 'Mark as done?');

                                                                                        if (pressed) {
                                                                                          FirebaseFirestore.instance.collection('followUp').doc(value[index]['dId']).update({
                                                                                            'done': true
                                                                                          }).then((value) => showUploadMessage(context, 'FollowUp Updated'));
                                                                                        }
                                                                                      },
                                                                                      child: Icon(
                                                                                        Icons.close,
                                                                                        size: 30,
                                                                                        color: Colors.red,
                                                                                      ),
                                                                                    ),
                                                                                  )),

                                                                            DataCell(
                                                                              Row(
                                                                                children: [
                                                                                  // Generated code for this Button Widget...
                                                                                  FlutterFlowIconButton(
                                                                                    borderColor: Colors.transparent,
                                                                                    borderRadius: 30,
                                                                                    borderWidth: 1,
                                                                                    buttonSize: 50,
                                                                                    icon: Icon(
                                                                                      Icons.delete,
                                                                                      color: Color(0xFFEE0000),
                                                                                      size: 25,
                                                                                    ),
                                                                                    onPressed: () async {
                                                                                      bool pressed = await alert(context, 'Do you want Delete');

                                                                                      if (pressed) {
                                                                                        // value.removeAt(index);
                                                                                        FirebaseFirestore.instance.collection('followUp').doc(value[index].id).delete();

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
                                                                      } catch (err) {
                                                                        return DataRow(
                                                                          selected:
                                                                              true,
                                                                          color: index.isOdd
                                                                              ? MaterialStateProperty.all(Colors.blueGrey.shade50.withOpacity(0.7))
                                                                              : MaterialStateProperty.all(Colors.blueGrey.shade50),
                                                                          cells: [
                                                                            DataCell(
                                                                              Text(
                                                                                "",
                                                                                textAlign: TextAlign.end,
                                                                                style: FlutterFlowTheme.bodyText2.override(
                                                                                  fontFamily: 'Lexend Deca',
                                                                                  color: Colors.black,
                                                                                  fontSize: 12,
                                                                                  fontWeight: FontWeight.w500,
                                                                                ),
                                                                              ),
                                                                            ),
                                                                            DataCell(
                                                                              Text(
                                                                                "",
                                                                                textAlign: TextAlign.end,
                                                                                style: FlutterFlowTheme.bodyText2.override(
                                                                                  fontFamily: 'Lexend Deca',
                                                                                  color: Colors.black,
                                                                                  fontSize: 14,
                                                                                  fontWeight: FontWeight.bold,
                                                                                ),
                                                                              ),
                                                                            ),

                                                                            DataCell(
                                                                              Text(
                                                                                "",
                                                                                textAlign: TextAlign.end,
                                                                                style: FlutterFlowTheme.bodyText2.override(
                                                                                  fontFamily: 'Lexend Deca',
                                                                                  color: Colors.black,
                                                                                  fontSize: 12,
                                                                                  fontWeight: FontWeight.w500,
                                                                                ),
                                                                              ),
                                                                            ),
                                                                            DataCell(
                                                                              Text(
                                                                                "",
                                                                                textAlign: TextAlign.end,
                                                                                style: FlutterFlowTheme.bodyText2.override(
                                                                                  fontFamily: 'Lexend Deca',
                                                                                  color: Colors.black,
                                                                                  fontSize: 14,
                                                                                  fontWeight: FontWeight.bold,
                                                                                ),
                                                                              ),
                                                                            ),

                                                                            DataCell(Center(
                                                                              child: Text(''),
                                                                            )),

                                                                            DataCell(
                                                                              Text(''),
                                                                            ),
                                                                            // DataCell(Text(fileInfo.size)),
                                                                          ],
                                                                        );
                                                                      }
                                                                    },
                                                                  ),
                                                                ),
                                                              );
                                                            }
                                                          }),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          )
                                  ],
                                ))
                          ],
                        ),
                      ),
                    ],
                  ),
                );
        },
      ),
    );
  }

  addProject(DocumentSnapshot data) async {
    DocumentSnapshot doc = await FirebaseFirestore.instance
        .collection('settings')
        .doc(currentBranchId)
        .get();
    FirebaseFirestore.instance
        .collection('settings')
        .doc(currentBranchId)
        .update({
      'projects': FieldValue.increment(1),
    });
    int projectNo = doc.get('projects');

    projectNo++;

    List statusList = [];

    statusList.add({
      'date': DateTime.now(),
      'status': 'Registered',
      'comments': '',
      'link': '',
      'customerId': 'C' + currentbranchShortName + projectNo.toString(),
      'userId': currentUserUid,
      'branchId': currentBranchId,
    });

    FirebaseFirestore.instance
        .collection('projects')
        .doc('P' + currentbranchShortName + projectNo.toString())
        .set({
      'date': FieldValue.serverTimestamp(),
      'status': 'Pending',
      'branchId': currentBranchId,
      'branch': currentbranchName,
      'userId': currentUserUid,
      'currentStatus': 'Registered',
      'nextStatus': 'Document Collection',
      'statusList': FieldValue.arrayUnion(statusList),
      'description': data['additionalInfo'],
      'projectTopic': '',
      'projectType': data['projectType'],
      'projectDetails': projectDetailList,
      'paymentDetails': [],
      'projectCost': 0.00,
      'totalPaid': 0.00,
      'projectName': data['projectTopic'],
      'companyName': '',
      'companyAddress': '',
      'customerID': data['customerId'],
      'projectId': 'P' + currentbranchShortName + projectNo.toString()
    });
    FirebaseFirestore.instance
        .collection('customer')
        .doc(data['customerId'])
        .update({'projects': FieldValue.increment(1)}).then((value) {
      FirebaseFirestore.instance.collection('enquiries').doc(widget.id).update({
        'status': 1,
      });
      showUploadMessage(context, 'New Project Created...');
      Navigator.pop(context);
    });
  }

  createCustomerAndProject(DocumentSnapshot data) async {
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
    int projectNo = doc.get('projects');

    projectNo++;

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
      {
        'name': 'Documents',
        'completed': false,
      },
      {
        'name': 'Services',
        'completed': false,
      },
      {
        'name': 'Statement',
        'completed': false,
      },
    ];

    List statusList = [];

    statusList.add({
      'date': DateTime.now(),
      'status': 'Registered',
      'comments': '',
      'link': '',
      'customerId': 'C' + currentbranchShortName + customerId.toString(),
      'userId': currentUserUid,
      'branchId': currentBranchId,
    });

    FirebaseFirestore.instance
        .collection('customer')
        .doc('C' + currentbranchShortName + customerId.toString())
        .set({
      'enquiryId': data.id,
      'form': list,
      'image': '',
      'date': DateTime.now(),
      'status': 0,
      'name': data['name'],
      'mobile': data['mobile'],
      'countryCode': 'IN',
      'phoneCode': '+91',
      'email': data['email'],
      'companyEmail': '',
      'nationality': '',
      'projects': 1,
      'place': data['place'],
      'travelHistory': [],
      'projectDetails': projectDetailList,
      'ieltsScore': '',
      'address': '',
      'branchId': currentBranchId,
      'userId': currentUserUid,
      'currentStatus': 'Registered',
      'nextStatus': 'Document Collection',
      'search': setSearchParam(data['mobile']),
      'comments': '',
      'documents': {},
      'newDocuments': {},
      'referenceDetails': [],
      'inTake': '',
      'agentId': data['agentId'],
      // 'careOfNo': data['careOfNo'],
      'statusList': FieldValue.arrayUnion(statusList),
      'additionalInfo': data['additionalInfo'],
      'branch': currentbranchName,
      'projectTopic': data['projectTopic'],
      'photo': '',
      'projectType': data['projectType'],
      'paymentDetails': [],
      'projectCost': 0.00,
      'projectName': data['projectTopic'],
      'whatsAppNo': '',
      'companyName': '',
      'companyAddress': '',
      'customerID': 'C' + currentbranchShortName + customerId.toString(),
    }).then((value) {
      FirebaseFirestore.instance
          .collection('projects')
          .doc('P' + currentbranchShortName + projectNo.toString())
          .set({
        'date': FieldValue.serverTimestamp(),
        'status': 'Pending',
        'branchId': currentBranchId,
        'branch': currentbranchName,
        'userId': currentUserUid,
        'currentStatus': 'Registered',
        'nextStatus': 'Document Collection',
        'statusList': FieldValue.arrayUnion(statusList),
        'description': data['additionalInfo'],
        'projectTopic': '',
        'projectType': data['projectType'],
        'projectDetails': projectDetailList,
        'paymentDetails': [],
        'projectCost': 0.00,
        'totalPaid': 0.00,
        'projectName': data['projectTopic'],
        'companyName': '',
        'companyAddress': '',
        'customerID': 'C' + currentbranchShortName + customerId.toString(),
        'projectId': 'P' + currentbranchShortName + projectNo.toString(),
        'totalCost': 0.00,
      });
    }).then((value) {
      FirebaseFirestore.instance.collection('status').add({
        'date': DateTime.now(),
        'status': 'Registered',
        'comments': '',
        'link': '',
        'customerId': 'C' + currentbranchShortName + customerId.toString(),
        'userId': currentUserUid,
        'branchId': currentBranchId,
      });

      FirebaseFirestore.instance.collection('enquiries').doc(widget.id).update({
        'status': 1,
        'customerId': 'C' + currentbranchShortName + customerId.toString(),
      });
    });
    showUploadMessage(context, 'New customer Registered...');

    Navigator.pop(context);
  }
}
