import 'package:cached_network_image/cached_network_image.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:multiple_select/Item.dart';
import '../../../auth/auth_util.dart';
import '../../../backend/backend.dart';
import '../../../backend/firebase_storage/storage.dart';
import '../../../flutter_flow/flutter_flow_drop_down.dart';
import '../../../flutter_flow/flutter_flow_icon_button.dart';
import '../../../flutter_flow/flutter_flow_theme.dart';
import '../../../flutter_flow/flutter_flow_widgets.dart';

import 'package:flutter/material.dart';

import '../../../flutter_flow/upload_media.dart';
import '../../app_widget.dart';
import '../Branch/SelectBranches.dart';
import '../University/CheckCriteria.dart';
import 'ApplicationForm.dart';

class CandidateDetails extends StatefulWidget {
  final String id;

  const CandidateDetails({Key key, this.id}) : super(key: key);

  @override
  _CandidateDetailsState createState() => _CandidateDetailsState();
}

class _CandidateDetailsState extends State<CandidateDetails> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  DocumentSnapshot data;

  List educationalDetails = [];
  List<Item> countryList = [];
  List<Item> courseList = [];
  List courses = [];
  List university = [];
  List countries = [];
  String currentStatus;
  String nextStatus;
  String passport = '';
  String aadhar = '';
  String profilePic = '';
  String consolidate = '';
  String cas = '';
  String ieltsCertificate = '';
  bool checkboxListTileValue = false;
  bool language = false;
  bool interview = false;
  bool others = false;
  bool academic = false;
  bool financial = false;
  bool leadzverification = false;
  bool offerLetter = false;
  bool unverification = false;

  bool medicalDocument = false;
  bool aats = false;
  bool financialDocument = false;
  bool tuitionFeePayment = false;
  bool online = false;
  bool casBool = false;
  TextEditingController other;

  String bankStatements = '';
  String medicalCheckUp = '';
  String financialDocumentUpload = '';
  String tuationFee = '';
  String otherDocument = '';
  var value;
  TextEditingController comments;
  Timestamp datePicked1;
  Timestamp datePicked2;
  DateTime selectedDate1 = DateTime.now();
  DateTime selectedDate2 = DateTime.now();

  bool load = false;
  bool table = true;

  PlatformFile pickFile;
  UploadTask uploadTask;

  Map<String, dynamic> courseNames = {};
  Map<String, dynamic> universityNames = {};
  Map<String, dynamic> countryIdByUniversityId = {};
  Map<String, dynamic> universityCourse = {};
  Map<String, dynamic> countryNames = {};
  Map<String, dynamic> countryId = {};
  Map<String, dynamic> courseById = {};
  Map<String, dynamic> courseId = {};
  Map<String, dynamic> documents = {};
  String course = '';
  String country = '';
  String newStatus = '';

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

  getCountry() async {
    QuerySnapshot data1 =
        await FirebaseFirestore.instance.collection("country").get();
    for (var doc in data1.docs) {
      countryNames[doc.get('name')] = doc.id;
      countryId[doc.id] = doc.get('name');

      countryList.add(Item.build(
          value: doc.id, display: doc.get('name'), content: doc.get('name')));
    }
    setState(() {});
  }

  getCourse() async {
    QuerySnapshot data1 =
        await FirebaseFirestore.instance.collection("course").get();
    for (DocumentSnapshot doc in data1.docs) {
      courseNames[doc.get('name')] = doc.id;
      courseById[doc.id] = doc.get('name');
      courseId[doc.id] = doc.get('name');

      courseList.add(Item.build(
          value: doc.id, display: doc.get('name'), content: doc.get('name')));
    }
    setState(() {});
  }

  getUniversity() async {
    QuerySnapshot data1 =
        await FirebaseFirestore.instance.collection("university").get();
    for (var doc in data1.docs) {
      universityNames[doc.id] = doc.get('name');
      countryIdByUniversityId[doc.id] = doc.get('country');
      print(universityCourse);
    }
    setState(() {});
  }

  Future selectFile(String name) async {
    final result = await FilePicker.platform.pickFiles();
    if (result == null) return;

    pickFile = result.files.first;
    final fileBytes = result.files.first.bytes;

    showUploadMessage(context, 'Uploading...', showLoading: true);

    uploadFileToFireBase(name, fileBytes);
    setState(() {});
  }

  Future uploadFileToFireBase(String name, fileBytes) async {
    // final path='file/${pickFile.name}';
    // final file=File(pickFile.path);

    // final ref=FirebaseStorage.instance.ref().child(path);
    // uploadTask = ref.putFile(file);
    uploadTask = FirebaseStorage.instance
        .ref('uploads/${pickFile.name}')
        .putData(fileBytes);

    final snapshot = await uploadTask.whenComplete(() {});

    final urlDownlod = await snapshot.ref.getDownloadURL();

    passport = urlDownlod;

    data.reference.update({
      'documents.$name': urlDownlod,
    });

    showUploadMessage(context, '$name Uploaded Successfully...');

    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    comments = TextEditingController();
    other = TextEditingController();
    getCountry();
    getCourse();
    getUniversity();
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
      body: courseNames.length == 0
          ? Container(
              color: Colors.white,
              child: Center(
                child: Image.asset('assets/images/loading.gif'),
              ))
          : StreamBuilder<DocumentSnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('candidates')
                  .doc(widget.id)
                  .snapshots(),
              builder: (context, snapshot) {
                print(widget.id);
                if (!snapshot.hasData) {
                  return Container(
                      color: Colors.white,
                      child: Center(
                        child: Image.asset('assets/images/loading.gif'),
                      ));
                }
                data = snapshot.data;
                if (snapshot.data.exists) {
                  educationalDetails = snapshot.data.get('educationalDetails');
                  if (load == false) {
                    load = true;
                    currentStatus = snapshot.data.get('currentStatus');
                    nextStatus = snapshot.data.get('nextStatus');

                    print(currentStatus);
                  }
                  university = snapshot.data.get('university');

                  profilePic = snapshot.data.get('image');
                  documents = snapshot.data.get('documents');

                  // if (courses.length == 0) {
                  //   courses = snapshot.data.get('courses').toList();
                  // }
                  // if (countries.length == 0) {
                  //   countries = snapshot.data.get('countries').toList();
                  // }
                }
                return !data.exists
                    ? Center(
                        child: Text('Loading...'),
                      )
                    : Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Row(
                          children: [
                            Expanded(
                              child: Material(
                                color: Colors.transparent,
                                elevation: 10,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Container(
                                  height: MediaQuery.of(context).size.height,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: SingleChildScrollView(
                                    physics: BouncingScrollPhysics(),
                                    child: Column(
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            Container(
                                                width: 150,
                                                height: 100,
                                                clipBehavior: Clip.antiAlias,
                                                decoration: BoxDecoration(
                                                  shape: BoxShape.circle,
                                                ),
                                                child: CachedNetworkImage(
                                                  imageUrl: profilePic == ''
                                                      ? 'https://cdn1.iconfinder.com/data/icons/ecommerce-gradient/512/ECommerce_Website_App_Online_Shop_Gradient_greenish_lineart_Modern_profile_photo_person_contact_account_buyer_seller-512.png'
                                                      : profilePic,
                                                )),
                                          ],
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
                                                'Father Name : ' +
                                                    data['fatherName'],
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
                                                'Father Mobile : ' +
                                                    data['fatherNumber'],
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
                                          padding: const EdgeInsets.all(8.0),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              Text(
                                                'Status: ' +
                                                    data['currentStatus'],
                                                style: FlutterFlowTheme.title3
                                                    .override(
                                                  fontFamily: 'Poppins',
                                                  color: Color(0xFF090F13),
                                                  fontSize: 13,
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
                                                'IELTS Score : ' +
                                                    data.get('ieltsScore'),
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
                                                  0, 5, 0, 0),
                                          child: Column(
                                            children: [
                                              Text(
                                                'Registered on : ' +
                                                    data['date']
                                                        .toDate()
                                                        .toString()
                                                        .substring(0, 16),
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
                                                      'Educational Details',
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
                                                              'Qualification',
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
                                                              'Mark',
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
                                                              'Year',
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
                                                              educationalDetails
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
                                                                    educationalDetails[
                                                                            index]
                                                                        [
                                                                        'qualification'],
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
                                                                    educationalDetails[
                                                                            index]
                                                                        [
                                                                        'marks'],
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
                                                                    educationalDetails[
                                                                            index]
                                                                        [
                                                                        'year'],
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
                                          children: [
                                            Column(
                                              mainAxisSize: MainAxisSize.max,
                                              children: [
                                                Row(
                                                  mainAxisSize:
                                                      MainAxisSize.max,
                                                  children: [
                                                    Padding(
                                                      padding:
                                                          EdgeInsetsDirectional
                                                              .fromSTEB(24, 12,
                                                                  0, 12),
                                                      child: Text(
                                                        'University Course',
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
                                              ],
                                            ),
                                            Column(
                                                mainAxisSize: MainAxisSize.max,
                                                children: List.generate(
                                                    university.length, (index) {
                                                  print(university);
                                                  return Row(
                                                    mainAxisSize:
                                                        MainAxisSize.max,
                                                    children: [
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(8.0),
                                                        child: Text(
                                                          '${index + 1} -  ${universityNames[university[index]['name']]} - ${courseById[university[index]['course']]} ',
                                                          style:
                                                              FlutterFlowTheme
                                                                  .bodyText1
                                                                  .override(
                                                            fontFamily:
                                                                'Lexend Deca',
                                                            color: Color(
                                                                0xFF090F13),
                                                            fontSize: 15,
                                                            fontWeight:
                                                                FontWeight.w600,
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  );
                                                })),
                                          ],
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(10.0),
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
                                                    List unId = [];
                                                    bool pressed = await alert(
                                                        context, 'Update List');

                                                    if (pressed) {
                                                      unId = await Navigator.push(
                                                          context,
                                                          MaterialPageRoute(
                                                              builder: (context) =>
                                                                  UniversityListWidget()));
                                                    }
                                                    if (unId.length != 0) {
                                                      print(unId);

                                                      snapshot.data.reference
                                                          .update({
                                                        'university': unId,
                                                      });
                                                    }
                                                  },
                                                  child: Container(
                                                    height: 100,
                                                    constraints: BoxConstraints(
                                                      maxHeight: 50,
                                                    ),
                                                    decoration: BoxDecoration(
                                                      color: Color(0xFF4B39EF),
                                                      boxShadow: [
                                                        BoxShadow(
                                                          blurRadius: 4,
                                                          color:
                                                              Color(0x32171717),
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
                                                            Icons
                                                                .playlist_add_check,
                                                            color: Colors.white,
                                                            size: 20,
                                                          ),
                                                          Padding(
                                                            padding:
                                                                EdgeInsetsDirectional
                                                                    .fromSTEB(
                                                                        8,
                                                                        0,
                                                                        8,
                                                                        0),
                                                            child: Text(
                                                              'Update Eligibility Criteria',
                                                              style:
                                                                  FlutterFlowTheme
                                                                      .bodyText1
                                                                      .override(
                                                                fontFamily:
                                                                    'Lexend Deca',
                                                                color: Colors
                                                                    .white,
                                                                fontSize: 12,
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
                                            ],
                                          ),
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
                            Expanded(
                                flex: 3,
                                child: Material(
                                  color: Colors.transparent,
                                  elevation: 10,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Container(
                                    height: MediaQuery.of(context).size.height,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(20.0),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          // Generated code for this Container Widget...

                                          // Generated code for this Container Widget...

                                          Material(
                                            color: Colors.transparent,
                                            elevation: 10,
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(15),
                                            ),
                                            child: Container(
                                              width: double.infinity,
                                              decoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius:
                                                    BorderRadius.circular(16),
                                              ),
                                              alignment:
                                                  AlignmentDirectional(0, 0),
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(10.0),
                                                child: Column(
                                                  children: [
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              8.0),
                                                      child: Row(
                                                        mainAxisSize:
                                                            MainAxisSize.max,
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .start,
                                                        children: [
                                                          Expanded(
                                                            child: Text(
                                                              'Current Status',
                                                              style:
                                                                  FlutterFlowTheme
                                                                      .bodyText1
                                                                      .override(
                                                                fontFamily:
                                                                    'Lexend Deca',
                                                                color: Color(
                                                                    0xFF262D34),
                                                                fontSize: 13,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                              ),
                                                            ),
                                                          ),
                                                          Expanded(
                                                            child: Text(
                                                              'Next',
                                                              style:
                                                                  FlutterFlowTheme
                                                                      .bodyText1
                                                                      .override(
                                                                fontFamily:
                                                                    'Lexend Deca',
                                                                color: Color(
                                                                    0xFF262D34),
                                                                fontSize: 13,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                              ),
                                                            ),
                                                          ),
                                                          Expanded(
                                                              child: SizedBox(
                                                            width: 100,
                                                          )),
                                                        ],
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              8.0),
                                                      child: Row(
                                                        mainAxisSize:
                                                            MainAxisSize.max,
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .start,
                                                        children: [
                                                          SizedBox(
                                                            width: 10,
                                                          ),
                                                          Expanded(
                                                            child:
                                                                FlutterFlowDropDown(
                                                              initialOption:
                                                                  currentStatus ??
                                                                      'Registered',
                                                              options: [
                                                                'Registered',
                                                                'Document Collected',
                                                                'Application Submitted',
                                                                'Verification Completed',
                                                                'Offer Letter Received',
                                                                'Conditions FullFilled',
                                                                'UnCond.Offer Letter Received',
                                                                'CAS Shield Submitted',
                                                                'CAS Received',
                                                                'VISA Application Submitted',
                                                                'Pending Documents Submitted (VISA)',
                                                                'VISA Received',
                                                                'VISA Rejected',
                                                                'Online Enrollment Completed',
                                                                'Traveling Assistance Provided',
                                                                'Accommodation Provided',
                                                                // 'Commission Received',
                                                                'FeedBack Received',
                                                              ].toList(),
                                                              onChanged: (val) {
                                                                if (val ==
                                                                    'Document Collected') {
                                                                  newStatus =
                                                                      'Application Submission';
                                                                  setState(
                                                                      () {});
                                                                }
                                                                setState(() {
                                                                  currentStatus =
                                                                      val;
                                                                });
                                                              },
                                                              width: 180,
                                                              height: 50,
                                                              textStyle:
                                                                  FlutterFlowTheme
                                                                      .bodyText1
                                                                      .override(
                                                                fontFamily:
                                                                    'Poppins',
                                                                color: Colors
                                                                    .black,
                                                              ),
                                                              hintText:
                                                                  'Please select...',
                                                              fillColor:
                                                                  Colors.white,
                                                              elevation: 0,
                                                              borderColor:
                                                                  Colors.black,
                                                              borderWidth: 0,
                                                              borderRadius: 0,
                                                              margin:
                                                                  EdgeInsetsDirectional
                                                                      .fromSTEB(
                                                                          12,
                                                                          4,
                                                                          12,
                                                                          4),
                                                              hidesUnderline:
                                                                  true,
                                                            ),
                                                          ),
                                                          SizedBox(
                                                            width: 20,
                                                          ),
                                                          Expanded(
                                                            child:
                                                                FlutterFlowDropDown(
                                                              initialOption:
                                                                  nextStatus ??
                                                                      'Document Collection',
                                                              options: [
                                                                'Document Collection',
                                                                'Application Submission',
                                                                'Verification Process',
                                                                'Waiting for Offer Letter',
                                                                'Waiting for UnCond.Offer Letter',
                                                                'FullFill The Conditions',
                                                                'CAS Processing',
                                                                'Waiting for CAS',
                                                                'VISA Filing',
                                                                'Waiting for VISA Response',
                                                                'Resubmission',
                                                                'Online Enrollment',
                                                                'Traveling Assistance',
                                                                'Accommodation Arrangements',
                                                                'Waiting for FeedBack',
                                                                'Completed Thank you',
                                                              ].toList(),
                                                              onChanged: (val) =>
                                                                  setState(() =>
                                                                      nextStatus =
                                                                          val),
                                                              width: 180,
                                                              height: 50,
                                                              textStyle:
                                                                  FlutterFlowTheme
                                                                      .bodyText1
                                                                      .override(
                                                                fontFamily:
                                                                    'Poppins',
                                                                color: Colors
                                                                    .black,
                                                              ),
                                                              hintText:
                                                                  'Please select...',
                                                              fillColor:
                                                                  Colors.white,
                                                              elevation: 0,
                                                              borderColor:
                                                                  Colors.black,
                                                              borderWidth: 0,
                                                              borderRadius: 0,
                                                              margin:
                                                                  EdgeInsetsDirectional
                                                                      .fromSTEB(
                                                                          12,
                                                                          4,
                                                                          12,
                                                                          4),
                                                              hidesUnderline:
                                                                  true,
                                                            ),
                                                          ),
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
                                                                    comments,
                                                                obscureText:
                                                                    false,
                                                                decoration:
                                                                    InputDecoration(
                                                                  labelText:
                                                                      'Comments...',
                                                                  hintText:
                                                                      'Please Enter Comments...',
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
                                                                      width: 0,
                                                                    ),
                                                                    borderRadius:
                                                                        BorderRadius
                                                                            .circular(8),
                                                                  ),
                                                                  focusedBorder:
                                                                      OutlineInputBorder(
                                                                    borderSide:
                                                                        BorderSide(
                                                                      color: Color(
                                                                          0x00000000),
                                                                      width: 0,
                                                                    ),
                                                                    borderRadius:
                                                                        BorderRadius
                                                                            .circular(8),
                                                                  ),
                                                                ),
                                                                style: FlutterFlowTheme
                                                                    .bodyText1
                                                                    .override(
                                                                  fontFamily:
                                                                      'Lexend Deca',
                                                                  color: Color(
                                                                      0xFF262D34),
                                                                  fontSize: 14,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .normal,
                                                                ),
                                                              ),
                                                            ),
                                                          ),
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
                                                                if (currentStatus ==
                                                                        'SOP Processed' &&
                                                                    checkboxListTileValue ==
                                                                        false) {
                                                                  showUploadMessage(
                                                                      context,
                                                                      'SOP Not Prepared Yet...');
                                                                } else if (currentStatus ==
                                                                        'Verification Completed' &&
                                                                    leadzverification ==
                                                                        false) {
                                                                  showUploadMessage(
                                                                      context,
                                                                      'Verification Not Completed...');
                                                                } else if (currentStatus ==
                                                                        'Conditions FullFilled' &&
                                                                    (language == false ||
                                                                        academic ==
                                                                            false ||
                                                                        financial ==
                                                                            false ||
                                                                        interview ==
                                                                            false)) {
                                                                  showUploadMessage(
                                                                      context,
                                                                      'Conditions Not FullFilled...');
                                                                } else if (currentStatus ==
                                                                        'CAS Shield Submitted' &&
                                                                    (medicalDocument == false ||
                                                                        financialDocument ==
                                                                            false ||
                                                                        tuitionFeePayment ==
                                                                            false)) {
                                                                  showUploadMessage(
                                                                      context,
                                                                      'CAS Processing Not Completed or Documents are not Uploaded...');
                                                                } else if (currentStatus ==
                                                                        'CAS Received' &&
                                                                    (casBool ==
                                                                        false)) {
                                                                  showUploadMessage(
                                                                      context,
                                                                      'CAS Documents are not Uploaded...');
                                                                } else {
                                                                  bool pressed =
                                                                      await alert(
                                                                          context,
                                                                          'Update This Status...');

                                                                  if (pressed) {
                                                                    print(
                                                                        currentStatus);
                                                                    print(
                                                                        nextStatus);
                                                                    FirebaseFirestore
                                                                        .instance
                                                                        .collection(
                                                                            'status')
                                                                        .add({
                                                                      'date': DateTime
                                                                          .now(),
                                                                      'next':
                                                                          nextStatus,
                                                                      'status':
                                                                          currentStatus,
                                                                      'eId':
                                                                          widget
                                                                              .id,
                                                                      'userId':
                                                                          currentUserUid,
                                                                      'comments':
                                                                          comments
                                                                              .text,
                                                                    }).then((value) {
                                                                      if (currentStatus ==
                                                                          'Verification Completed') {
                                                                        snapshot
                                                                            .data
                                                                            .reference
                                                                            .update({
                                                                          'currentStatus':
                                                                              currentStatus,
                                                                          'nextStatus':
                                                                              nextStatus,
                                                                          'comment':
                                                                              comments.text,
                                                                          'leadzVerification':
                                                                              leadzverification,
                                                                          'universityVerification':
                                                                              unverification,
                                                                        });
                                                                      } else if (currentStatus ==
                                                                          'Conditions FullFilled') {
                                                                        snapshot
                                                                            .data
                                                                            .reference
                                                                            .update({
                                                                          'currentStatus':
                                                                              currentStatus,
                                                                          'nextStatus':
                                                                              nextStatus,
                                                                          'comment':
                                                                              comments.text,
                                                                          'language':
                                                                              language,
                                                                          'academic':
                                                                              academic,
                                                                          'financial':
                                                                              financial,
                                                                          'interview':
                                                                              interview,
                                                                        });
                                                                      } else if (currentStatus ==
                                                                          'CAS Received') {
                                                                        snapshot
                                                                            .data
                                                                            .reference
                                                                            .update({
                                                                          'currentStatus':
                                                                              currentStatus,
                                                                          'nextStatus':
                                                                              nextStatus,
                                                                          'comment':
                                                                              comments.text,
                                                                        });
                                                                        FirebaseFirestore
                                                                            .instance
                                                                            .collection('visa')
                                                                            .add({
                                                                          'date':
                                                                              DateTime.now(),
                                                                          'status':
                                                                              0,
                                                                          'candidateId':
                                                                              widget.id,
                                                                          'userId':
                                                                              currentUserUid,
                                                                          'userEmail':
                                                                              currentUserEmail,
                                                                          'branchId':
                                                                              currentBranchId,
                                                                          'search':
                                                                              setSearchParam(data.get('mobile'))
                                                                        });
                                                                      } else if (currentStatus ==
                                                                          'Conditions Not FullFilled') {
                                                                        snapshot
                                                                            .data
                                                                            .reference
                                                                            .update({
                                                                          'currentStatus':
                                                                              currentStatus,
                                                                          'nextStatus':
                                                                              nextStatus,
                                                                          'comment':
                                                                              comments.text,
                                                                          'paymentOnline':
                                                                              online,
                                                                        });
                                                                      } else if (currentStatus ==
                                                                          'FeedBack Received') {
                                                                        snapshot
                                                                            .data
                                                                            .reference
                                                                            .update({
                                                                          'currentStatus':
                                                                              currentStatus,
                                                                          'nextStatus':
                                                                              nextStatus,
                                                                          'comment':
                                                                              comments.text,
                                                                          'status':
                                                                              1,
                                                                        });
                                                                      } else {
                                                                        snapshot
                                                                            .data
                                                                            .reference
                                                                            .update({
                                                                          'currentStatus':
                                                                              currentStatus,
                                                                          'nextStatus':
                                                                              nextStatus,
                                                                          'comment':
                                                                              comments.text,
                                                                        });
                                                                      }

                                                                      table =
                                                                          true;
                                                                    });

                                                                    showUploadMessage(
                                                                        context,
                                                                        'Status Updated...');
                                                                    setState(
                                                                        () {
                                                                      comments.text =
                                                                          '';
                                                                    });
                                                                  }
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
                                                                borderRadius:
                                                                    50,
                                                              ),
                                                            ),
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
                                            height: 15,
                                          ),
                                          Row(
                                            children: [
                                              table == true
                                                  ? Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              8.0),
                                                      child: InkWell(
                                                        onTap: () {
                                                          setState(() {
                                                            table = false;
                                                          });
                                                        },
                                                        child: Text(
                                                          'Status Hide',
                                                          style: FlutterFlowTheme
                                                              .bodyText1
                                                              .override(
                                                                  fontFamily:
                                                                      'Poppins',
                                                                  color: Colors
                                                                      .blue,
                                                                  fontSize: 13,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600),
                                                        ),
                                                      ),
                                                    )
                                                  : Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              8.0),
                                                      child: InkWell(
                                                        onTap: () {
                                                          table = true;
                                                          setState(() {});
                                                        },
                                                        child: Text(
                                                          'Status View',
                                                          style: FlutterFlowTheme
                                                              .bodyText1
                                                              .override(
                                                                  fontFamily:
                                                                      'Poppins',
                                                                  color: Colors
                                                                      .blue,
                                                                  fontSize: 13,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600),
                                                        ),
                                                      ),
                                                    ),
                                            ],
                                          ),

                                          table == true
                                              ? Expanded(
                                                  child: StreamBuilder<
                                                          QuerySnapshot>(
                                                      stream: FirebaseFirestore
                                                          .instance
                                                          .collection('status')
                                                          .where('eId',
                                                              isEqualTo:
                                                                  widget.id)
                                                          .orderBy('date',
                                                              descending: true)
                                                          .snapshots(),
                                                      builder:
                                                          (context, snapshot) {
                                                        if (!snapshot.hasData) {
                                                          return Center(
                                                            child:
                                                                CircularProgressIndicator(),
                                                          );
                                                        }
                                                        value =
                                                            snapshot.data.docs;

                                                        return value.length == 0
                                                            ? Container(
                                                                child: Center(
                                                                  child: Image
                                                                      .asset(
                                                                          'assets/images/93794-office-illustration.gif'),
                                                                ),
                                                              )
                                                            : SizedBox(
                                                                width: double
                                                                    .infinity,
                                                                child:
                                                                    SingleChildScrollView(
                                                                  physics:
                                                                      BouncingScrollPhysics(),
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
                                                                            child:
                                                                                Text("Date", style: TextStyle(fontWeight: FontWeight.bold)),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                      DataColumn(
                                                                        label:
                                                                            Container(
                                                                          child:
                                                                              Center(
                                                                            child:
                                                                                Text("Status", style: TextStyle(fontWeight: FontWeight.bold)),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                      DataColumn(
                                                                        label:
                                                                            Center(
                                                                          child: Text(
                                                                              "Next",
                                                                              style: TextStyle(fontWeight: FontWeight.bold)),
                                                                        ),
                                                                      ),
                                                                      DataColumn(
                                                                        label:
                                                                            Center(
                                                                          child: Text(
                                                                              "Comments",
                                                                              style: TextStyle(fontWeight: FontWeight.bold)),
                                                                        ),
                                                                      ),
                                                                    ],
                                                                    rows: List
                                                                        .generate(
                                                                      value
                                                                          .length,
                                                                      (index) {
                                                                        newStatus =
                                                                            value[0]['status'];
                                                                        print('1 ' +
                                                                            newStatus);
                                                                        print('2 ' +
                                                                            value[0]['status']);

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
                                                                                  fontSize: 12,
                                                                                  fontWeight: FontWeight.bold,
                                                                                ),
                                                                              ),
                                                                            ),

                                                                            DataCell(
                                                                              Text(
                                                                                value[index]['next'],
                                                                                textAlign: TextAlign.end,
                                                                                style: FlutterFlowTheme.bodyText2.override(
                                                                                  fontFamily: 'Lexend Deca',
                                                                                  color: Colors.black,
                                                                                  fontSize: 12,
                                                                                  fontWeight: FontWeight.bold,
                                                                                ),
                                                                              ),
                                                                            ),
                                                                            DataCell(
                                                                              Text(
                                                                                value[index]['comments'],
                                                                                textAlign: TextAlign.end,
                                                                                style: FlutterFlowTheme.bodyText2.override(
                                                                                  fontFamily: 'Lexend Deca',
                                                                                  color: Colors.black,
                                                                                  fontSize: 12,
                                                                                  fontWeight: FontWeight.bold,
                                                                                ),
                                                                              ),
                                                                            ),
                                                                            // DataCell(Text(fileInfo.size)),
                                                                          ],
                                                                        );
                                                                      },
                                                                    ),
                                                                  ),
                                                                ),
                                                              );
                                                      }),
                                                )
                                              : Container(),

                                          // Generated code for this Container Widget...
                                          newStatus != '' && table == false
                                              ? Material(
                                                  color: Colors.transparent,
                                                  elevation: 10,
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            15),
                                                  ),
                                                  child: Container(
                                                    width: double.infinity,
                                                    decoration: BoxDecoration(
                                                      color: Colors.white,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              16),
                                                    ),
                                                    alignment:
                                                        AlignmentDirectional(
                                                            0, 0),
                                                    child: Padding(
                                                        padding:
                                                            EdgeInsetsDirectional.fromSTEB(
                                                                15, 15, 15, 15),
                                                        child: value[0]['status'] == 'Registered'
                                                            ? SingleChildScrollView(
                                                                child: Column(
                                                                  mainAxisSize:
                                                                      MainAxisSize
                                                                          .max,
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .center,
                                                                  children: [
                                                                    Row(
                                                                      mainAxisSize:
                                                                          MainAxisSize
                                                                              .max,
                                                                      children: [
                                                                        Text(
                                                                          'Please Upload Following Documents',
                                                                          style: FlutterFlowTheme.bodyText1.override(
                                                                              fontFamily: 'Poppins',
                                                                              color: Colors.black,
                                                                              fontWeight: FontWeight.bold),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                    Row(
                                                                      crossAxisAlignment:
                                                                          CrossAxisAlignment
                                                                              .start,
                                                                      children: [
                                                                        Expanded(
                                                                          child:
                                                                              Column(
                                                                            crossAxisAlignment:
                                                                                CrossAxisAlignment.start,
                                                                            children: [
                                                                              SizedBox(
                                                                                height: 5,
                                                                              ),
                                                                              Row(
                                                                                children: [
                                                                                  Expanded(
                                                                                    child: Text(
                                                                                      'Profile Photo',
                                                                                      style: FlutterFlowTheme.bodyText1.override(fontFamily: 'Poppins', color: Colors.black, fontSize: 15, fontWeight: FontWeight.w500),
                                                                                    ),
                                                                                  ),
                                                                                  FFButtonWidget(
                                                                                    onPressed: () async {
                                                                                      final selectedMedia = await selectMedia(
                                                                                        maxWidth: 1080.00,
                                                                                        maxHeight: 1320.00,
                                                                                      );
                                                                                      if (selectedMedia != null && validateFileFormat(selectedMedia.storagePath, context)) {
                                                                                        showUploadMessage(context, 'Uploading file...', showLoading: true);
                                                                                        final downloadUrl = await uploadData(selectedMedia.storagePath, selectedMedia.bytes);

                                                                                        snapshot.data.reference.update({
                                                                                          'image': downloadUrl,
                                                                                        });
                                                                                        ScaffoldMessenger.of(context).hideCurrentSnackBar();
                                                                                        if (downloadUrl != null) {
                                                                                          setState(() => profilePic = downloadUrl);
                                                                                          showUploadMessage(context, 'Success!');
                                                                                        } else {
                                                                                          showUploadMessage(context, 'Failed to upload media');
                                                                                        }
                                                                                      }
                                                                                    },
                                                                                    text: profilePic == '' ? 'Upload' : 'Change',
                                                                                    options: FFButtonOptions(
                                                                                      width: 100,
                                                                                      height: 40,
                                                                                      color: profilePic == '' ? Color(0xFF4B39EF) : Colors.teal,
                                                                                      textStyle: FlutterFlowTheme.subtitle2.override(
                                                                                        fontFamily: 'Lexend Deca',
                                                                                        color: Colors.white,
                                                                                        fontSize: 16,
                                                                                        fontWeight: FontWeight.normal,
                                                                                      ),
                                                                                      elevation: 2,
                                                                                      borderSide: BorderSide(
                                                                                        color: Colors.transparent,
                                                                                        width: 1,
                                                                                      ),
                                                                                      borderRadius: 50,
                                                                                    ),
                                                                                  ),
                                                                                ],
                                                                              ),
                                                                              SizedBox(
                                                                                height: 5,
                                                                              ),
                                                                              Row(
                                                                                children: [
                                                                                  Expanded(
                                                                                    child: Text(
                                                                                      '10TH',
                                                                                      style: FlutterFlowTheme.bodyText1.override(fontFamily: 'Poppins', color: Colors.black, fontSize: 15, fontWeight: FontWeight.w500),
                                                                                    ),
                                                                                  ),
                                                                                  FFButtonWidget(
                                                                                    onPressed: () async {
                                                                                      selectFile('SSLC');
                                                                                    },
                                                                                    text: documents['SSLC'] == null ? 'Upload' : 'Change',
                                                                                    options: FFButtonOptions(
                                                                                      width: 100,
                                                                                      height: 40,
                                                                                      color: documents['SSLC'] == null ? Color(0xFF4B39EF) : Colors.teal,
                                                                                      textStyle: FlutterFlowTheme.subtitle2.override(
                                                                                        fontFamily: 'Lexend Deca',
                                                                                        color: Colors.white,
                                                                                        fontSize: 16,
                                                                                        fontWeight: FontWeight.normal,
                                                                                      ),
                                                                                      elevation: 2,
                                                                                      borderSide: BorderSide(
                                                                                        color: Colors.transparent,
                                                                                        width: 1,
                                                                                      ),
                                                                                      borderRadius: 50,
                                                                                    ),
                                                                                  ),
                                                                                ],
                                                                              ),
                                                                              SizedBox(
                                                                                height: 5,
                                                                              ),
                                                                              Row(
                                                                                children: [
                                                                                  Expanded(
                                                                                    child: Text(
                                                                                      '12TH',
                                                                                      style: FlutterFlowTheme.bodyText1.override(fontFamily: 'Poppins', color: Colors.black, fontSize: 15, fontWeight: FontWeight.w500),
                                                                                    ),
                                                                                  ),
                                                                                  FFButtonWidget(
                                                                                    onPressed: () async {
                                                                                      selectFile('PLUSTWO');
                                                                                    },
                                                                                    text: documents['PLUSTWO'] == null ? 'Upload' : 'Change',
                                                                                    options: FFButtonOptions(
                                                                                      width: 100,
                                                                                      height: 40,
                                                                                      color: documents['PLUSTWO'] == null ? Color(0xFF4B39EF) : Colors.teal,
                                                                                      textStyle: FlutterFlowTheme.subtitle2.override(
                                                                                        fontFamily: 'Lexend Deca',
                                                                                        color: Colors.white,
                                                                                        fontSize: 16,
                                                                                        fontWeight: FontWeight.normal,
                                                                                      ),
                                                                                      elevation: 2,
                                                                                      borderSide: BorderSide(
                                                                                        color: Colors.transparent,
                                                                                        width: 1,
                                                                                      ),
                                                                                      borderRadius: 50,
                                                                                    ),
                                                                                  ),
                                                                                ],
                                                                              ),
                                                                              SizedBox(
                                                                                height: 5,
                                                                              ),
                                                                              Row(
                                                                                children: [
                                                                                  Expanded(
                                                                                    child: Text(
                                                                                      'UG Certificate',
                                                                                      style: FlutterFlowTheme.bodyText1.override(fontFamily: 'Poppins', color: Colors.black, fontSize: 15, fontWeight: FontWeight.w500),
                                                                                    ),
                                                                                  ),
                                                                                  FFButtonWidget(
                                                                                    onPressed: () async {
                                                                                      selectFile('UG Certificate');
                                                                                    },
                                                                                    text: documents['UG Certificate'] == null ? 'Upload' : 'Change',
                                                                                    options: FFButtonOptions(
                                                                                      width: 100,
                                                                                      height: 40,
                                                                                      color: documents['UG Certificate'] == null ? Color(0xFF4B39EF) : Colors.teal,
                                                                                      textStyle: FlutterFlowTheme.subtitle2.override(
                                                                                        fontFamily: 'Lexend Deca',
                                                                                        color: Colors.white,
                                                                                        fontSize: 16,
                                                                                        fontWeight: FontWeight.normal,
                                                                                      ),
                                                                                      elevation: 2,
                                                                                      borderSide: BorderSide(
                                                                                        color: Colors.transparent,
                                                                                        width: 1,
                                                                                      ),
                                                                                      borderRadius: 50,
                                                                                    ),
                                                                                  ),
                                                                                ],
                                                                              ),
                                                                              SizedBox(
                                                                                height: 5,
                                                                              ),
                                                                              Row(
                                                                                children: [
                                                                                  Expanded(
                                                                                    child: Text(
                                                                                      'Consolidate',
                                                                                      style: FlutterFlowTheme.bodyText1.override(fontFamily: 'Poppins', color: Colors.black, fontSize: 15, fontWeight: FontWeight.w500),
                                                                                    ),
                                                                                  ),
                                                                                  FFButtonWidget(
                                                                                    onPressed: () async {
                                                                                      selectFile('Consolidate');
                                                                                    },
                                                                                    text: documents['Consolidate'] == null ? 'Upload' : 'Change',
                                                                                    options: FFButtonOptions(
                                                                                      width: 100,
                                                                                      height: 40,
                                                                                      color: documents['Consolidate'] == null ? Color(0xFF4B39EF) : Colors.teal,
                                                                                      textStyle: FlutterFlowTheme.subtitle2.override(
                                                                                        fontFamily: 'Lexend Deca',
                                                                                        color: Colors.white,
                                                                                        fontSize: 16,
                                                                                        fontWeight: FontWeight.normal,
                                                                                      ),
                                                                                      elevation: 2,
                                                                                      borderSide: BorderSide(
                                                                                        color: Colors.transparent,
                                                                                        width: 1,
                                                                                      ),
                                                                                      borderRadius: 50,
                                                                                    ),
                                                                                  ),
                                                                                ],
                                                                              ),
                                                                              SizedBox(
                                                                                height: 5,
                                                                              ),
                                                                              Row(
                                                                                children: [
                                                                                  Expanded(
                                                                                    child: Text(
                                                                                      'UG Individual Mark List',
                                                                                      style: FlutterFlowTheme.bodyText1.override(fontFamily: 'Poppins', color: Colors.black, fontSize: 15, fontWeight: FontWeight.w500),
                                                                                    ),
                                                                                  ),
                                                                                  FFButtonWidget(
                                                                                    onPressed: () async {
                                                                                      selectFile('UG Mark List');
                                                                                    },
                                                                                    text: documents['UG Mark List'] == null ? 'Upload' : 'Change',
                                                                                    options: FFButtonOptions(
                                                                                      width: 100,
                                                                                      height: 40,
                                                                                      color: documents['UG Mark List'] == null ? Color(0xFF4B39EF) : Colors.teal,
                                                                                      textStyle: FlutterFlowTheme.subtitle2.override(
                                                                                        fontFamily: 'Lexend Deca',
                                                                                        color: Colors.white,
                                                                                        fontSize: 16,
                                                                                        fontWeight: FontWeight.normal,
                                                                                      ),
                                                                                      elevation: 2,
                                                                                      borderSide: BorderSide(
                                                                                        color: Colors.transparent,
                                                                                        width: 1,
                                                                                      ),
                                                                                      borderRadius: 50,
                                                                                    ),
                                                                                  ),
                                                                                ],
                                                                              ),
                                                                              SizedBox(
                                                                                height: 5,
                                                                              ),
                                                                              Row(
                                                                                children: [
                                                                                  Expanded(
                                                                                    child: Text(
                                                                                      'Medium of Instruction ( MOI )',
                                                                                      style: FlutterFlowTheme.bodyText1.override(fontFamily: 'Poppins', color: Colors.black, fontSize: 15, fontWeight: FontWeight.w500),
                                                                                    ),
                                                                                  ),
                                                                                  FFButtonWidget(
                                                                                    onPressed: () async {
                                                                                      selectFile('MOI');
                                                                                    },
                                                                                    text: documents['MOI'] == null ? 'Upload' : 'Change',
                                                                                    options: FFButtonOptions(
                                                                                      width: 100,
                                                                                      height: 40,
                                                                                      color: documents['MOI'] == null ? Color(0xFF4B39EF) : Colors.teal,
                                                                                      textStyle: FlutterFlowTheme.subtitle2.override(
                                                                                        fontFamily: 'Lexend Deca',
                                                                                        color: Colors.white,
                                                                                        fontSize: 16,
                                                                                        fontWeight: FontWeight.normal,
                                                                                      ),
                                                                                      elevation: 2,
                                                                                      borderSide: BorderSide(
                                                                                        color: Colors.transparent,
                                                                                        width: 1,
                                                                                      ),
                                                                                      borderRadius: 50,
                                                                                    ),
                                                                                  ),
                                                                                ],
                                                                              ),
                                                                              SizedBox(
                                                                                height: 5,
                                                                              ),
                                                                              Row(
                                                                                children: [
                                                                                  Expanded(
                                                                                    child: Text(
                                                                                      'Academic LOR 1',
                                                                                      style: FlutterFlowTheme.bodyText1.override(fontFamily: 'Poppins', color: Colors.black, fontSize: 15, fontWeight: FontWeight.w500),
                                                                                    ),
                                                                                  ),
                                                                                  FFButtonWidget(
                                                                                    onPressed: () async {
                                                                                      selectFile('Academic LOR 1');
                                                                                    },
                                                                                    text: documents['Academic LOR 1'] == null ? 'Upload' : 'Change',
                                                                                    options: FFButtonOptions(
                                                                                      width: 100,
                                                                                      height: 40,
                                                                                      color: documents['Academic LOR 1'] == null ? Color(0xFF4B39EF) : Colors.teal,
                                                                                      textStyle: FlutterFlowTheme.subtitle2.override(
                                                                                        fontFamily: 'Lexend Deca',
                                                                                        color: Colors.white,
                                                                                        fontSize: 16,
                                                                                        fontWeight: FontWeight.normal,
                                                                                      ),
                                                                                      elevation: 2,
                                                                                      borderSide: BorderSide(
                                                                                        color: Colors.transparent,
                                                                                        width: 1,
                                                                                      ),
                                                                                      borderRadius: 50,
                                                                                    ),
                                                                                  ),
                                                                                ],
                                                                              ),
                                                                              SizedBox(
                                                                                height: 5,
                                                                              ),
                                                                              Row(
                                                                                children: [
                                                                                  Expanded(
                                                                                    child: Text(
                                                                                      'Academic LOR 2',
                                                                                      style: FlutterFlowTheme.bodyText1.override(fontFamily: 'Poppins', color: Colors.black, fontSize: 15, fontWeight: FontWeight.w500),
                                                                                    ),
                                                                                  ),
                                                                                  FFButtonWidget(
                                                                                    onPressed: () async {
                                                                                      selectFile('Academic LOR 2');
                                                                                    },
                                                                                    text: documents['Academic LOR 2'] == null ? 'Upload' : 'Change',
                                                                                    options: FFButtonOptions(
                                                                                      width: 100,
                                                                                      height: 40,
                                                                                      color: documents['Academic LOR 2'] == null ? Color(0xFF4B39EF) : Colors.teal,
                                                                                      textStyle: FlutterFlowTheme.subtitle2.override(
                                                                                        fontFamily: 'Lexend Deca',
                                                                                        color: Colors.white,
                                                                                        fontSize: 16,
                                                                                        fontWeight: FontWeight.normal,
                                                                                      ),
                                                                                      elevation: 2,
                                                                                      borderSide: BorderSide(
                                                                                        color: Colors.transparent,
                                                                                        width: 1,
                                                                                      ),
                                                                                      borderRadius: 50,
                                                                                    ),
                                                                                  ),
                                                                                ],
                                                                              ),
                                                                            ],
                                                                          ),
                                                                        ),
                                                                        SizedBox(
                                                                          width:
                                                                              20,
                                                                        ),
                                                                        Expanded(
                                                                          child:
                                                                              Column(
                                                                            crossAxisAlignment:
                                                                                CrossAxisAlignment.start,
                                                                            children: [
                                                                              SizedBox(
                                                                                height: 5,
                                                                              ),
                                                                              Row(
                                                                                children: [
                                                                                  Expanded(
                                                                                    child: Text(
                                                                                      'Professional LOR 1',
                                                                                      style: FlutterFlowTheme.bodyText1.override(fontFamily: 'Poppins', color: Colors.black, fontSize: 15, fontWeight: FontWeight.w500),
                                                                                    ),
                                                                                  ),
                                                                                  FFButtonWidget(
                                                                                    onPressed: () async {
                                                                                      selectFile('Professional LOR 1');
                                                                                    },
                                                                                    text: documents['Professional LOR 1'] == null ? 'Upload' : 'Change',
                                                                                    options: FFButtonOptions(
                                                                                      width: 100,
                                                                                      height: 40,
                                                                                      color: documents['Professional LOR 1'] == null ? Color(0xFF4B39EF) : Colors.teal,
                                                                                      textStyle: FlutterFlowTheme.subtitle2.override(
                                                                                        fontFamily: 'Lexend Deca',
                                                                                        color: Colors.white,
                                                                                        fontSize: 16,
                                                                                        fontWeight: FontWeight.normal,
                                                                                      ),
                                                                                      elevation: 2,
                                                                                      borderSide: BorderSide(
                                                                                        color: Colors.transparent,
                                                                                        width: 1,
                                                                                      ),
                                                                                      borderRadius: 50,
                                                                                    ),
                                                                                  ),
                                                                                ],
                                                                              ),
                                                                              SizedBox(
                                                                                height: 5,
                                                                              ),
                                                                              Row(
                                                                                children: [
                                                                                  Expanded(
                                                                                    child: Text(
                                                                                      'State of Purpose',
                                                                                      style: FlutterFlowTheme.bodyText1.override(fontFamily: 'Poppins', color: Colors.black, fontSize: 15, fontWeight: FontWeight.w500),
                                                                                    ),
                                                                                  ),
                                                                                  FFButtonWidget(
                                                                                    onPressed: () async {
                                                                                      selectFile('SOP');
                                                                                    },
                                                                                    text: documents['SOP'] == null ? 'Upload' : 'Change',
                                                                                    options: FFButtonOptions(
                                                                                      width: 100,
                                                                                      height: 40,
                                                                                      color: documents['SOP'] == null ? Color(0xFF4B39EF) : Colors.teal,
                                                                                      textStyle: FlutterFlowTheme.subtitle2.override(
                                                                                        fontFamily: 'Lexend Deca',
                                                                                        color: Colors.white,
                                                                                        fontSize: 16,
                                                                                        fontWeight: FontWeight.normal,
                                                                                      ),
                                                                                      elevation: 2,
                                                                                      borderSide: BorderSide(
                                                                                        color: Colors.transparent,
                                                                                        width: 1,
                                                                                      ),
                                                                                      borderRadius: 50,
                                                                                    ),
                                                                                  ),
                                                                                ],
                                                                              ),
                                                                              SizedBox(
                                                                                height: 5,
                                                                              ),
                                                                              Row(
                                                                                children: [
                                                                                  Expanded(
                                                                                    child: Text(
                                                                                      'Experience Certificate',
                                                                                      style: FlutterFlowTheme.bodyText1.override(fontFamily: 'Poppins', color: Colors.black, fontSize: 15, fontWeight: FontWeight.w500),
                                                                                    ),
                                                                                  ),
                                                                                  FFButtonWidget(
                                                                                    onPressed: () async {
                                                                                      selectFile('Experience');
                                                                                    },
                                                                                    text: documents['Experience'] == null ? 'Upload' : 'Change',
                                                                                    options: FFButtonOptions(
                                                                                      width: 100,
                                                                                      height: 40,
                                                                                      color: documents['Experience'] == null ? Color(0xFF4B39EF) : Colors.teal,
                                                                                      textStyle: FlutterFlowTheme.subtitle2.override(
                                                                                        fontFamily: 'Lexend Deca',
                                                                                        color: Colors.white,
                                                                                        fontSize: 16,
                                                                                        fontWeight: FontWeight.normal,
                                                                                      ),
                                                                                      elevation: 2,
                                                                                      borderSide: BorderSide(
                                                                                        color: Colors.transparent,
                                                                                        width: 1,
                                                                                      ),
                                                                                      borderRadius: 50,
                                                                                    ),
                                                                                  ),
                                                                                ],
                                                                              ),
                                                                              SizedBox(
                                                                                height: 5,
                                                                              ),
                                                                              Row(
                                                                                children: [
                                                                                  Expanded(
                                                                                    child: Text(
                                                                                      'IELTS Score Card',
                                                                                      style: FlutterFlowTheme.bodyText1.override(fontFamily: 'Poppins', color: Colors.black, fontSize: 15, fontWeight: FontWeight.w500),
                                                                                    ),
                                                                                  ),
                                                                                  FFButtonWidget(
                                                                                    onPressed: () async {
                                                                                      selectFile('IELTS Score Card');
                                                                                    },
                                                                                    text: documents['IELTS Score Card'] == null ? 'Upload' : 'Change',
                                                                                    options: FFButtonOptions(
                                                                                      width: 100,
                                                                                      height: 40,
                                                                                      color: documents['IELTS Score Card'] == null ? Color(0xFF4B39EF) : Colors.teal,
                                                                                      textStyle: FlutterFlowTheme.subtitle2.override(
                                                                                        fontFamily: 'Lexend Deca',
                                                                                        color: Colors.white,
                                                                                        fontSize: 16,
                                                                                        fontWeight: FontWeight.normal,
                                                                                      ),
                                                                                      elevation: 2,
                                                                                      borderSide: BorderSide(
                                                                                        color: Colors.transparent,
                                                                                        width: 1,
                                                                                      ),
                                                                                      borderRadius: 50,
                                                                                    ),
                                                                                  ),
                                                                                ],
                                                                              ),
                                                                              SizedBox(
                                                                                height: 5,
                                                                              ),
                                                                              Row(
                                                                                children: [
                                                                                  Expanded(
                                                                                    child: Text(
                                                                                      'PassPort',
                                                                                      style: FlutterFlowTheme.bodyText1.override(fontFamily: 'Poppins', color: Colors.black, fontSize: 15, fontWeight: FontWeight.w500),
                                                                                    ),
                                                                                  ),
                                                                                  FFButtonWidget(
                                                                                    onPressed: () async {
                                                                                      selectFile('PassPort');
                                                                                    },
                                                                                    text: documents['PassPort'] == null ? 'Upload' : 'Change',
                                                                                    options: FFButtonOptions(
                                                                                      width: 100,
                                                                                      height: 40,
                                                                                      color: documents['PassPort'] == null ? Color(0xFF4B39EF) : Colors.teal,
                                                                                      textStyle: FlutterFlowTheme.subtitle2.override(
                                                                                        fontFamily: 'Lexend Deca',
                                                                                        color: Colors.white,
                                                                                        fontSize: 16,
                                                                                        fontWeight: FontWeight.normal,
                                                                                      ),
                                                                                      elevation: 2,
                                                                                      borderSide: BorderSide(
                                                                                        color: Colors.transparent,
                                                                                        width: 1,
                                                                                      ),
                                                                                      borderRadius: 50,
                                                                                    ),
                                                                                  ),
                                                                                ],
                                                                              ),
                                                                              SizedBox(
                                                                                height: 5,
                                                                              ),
                                                                              Row(
                                                                                children: [
                                                                                  Expanded(
                                                                                    child: Text(
                                                                                      'CV',
                                                                                      style: FlutterFlowTheme.bodyText1.override(fontFamily: 'Poppins', color: Colors.black, fontSize: 15, fontWeight: FontWeight.w500),
                                                                                    ),
                                                                                  ),
                                                                                  FFButtonWidget(
                                                                                    onPressed: () async {
                                                                                      selectFile('CV');
                                                                                    },
                                                                                    text: documents['CV'] == null ? 'Upload' : 'Change',
                                                                                    options: FFButtonOptions(
                                                                                      width: 100,
                                                                                      height: 40,
                                                                                      color: documents['CV'] == null ? Color(0xFF4B39EF) : Colors.teal,
                                                                                      textStyle: FlutterFlowTheme.subtitle2.override(
                                                                                        fontFamily: 'Lexend Deca',
                                                                                        color: Colors.white,
                                                                                        fontSize: 16,
                                                                                        fontWeight: FontWeight.normal,
                                                                                      ),
                                                                                      elevation: 2,
                                                                                      borderSide: BorderSide(
                                                                                        color: Colors.transparent,
                                                                                        width: 1,
                                                                                      ),
                                                                                      borderRadius: 50,
                                                                                    ),
                                                                                  ),
                                                                                ],
                                                                              ),
                                                                              SizedBox(
                                                                                height: 5,
                                                                              ),
                                                                              Row(
                                                                                children: [
                                                                                  Expanded(
                                                                                    child: Text(
                                                                                      'Aadhar',
                                                                                      style: FlutterFlowTheme.bodyText1.override(fontFamily: 'Poppins', color: Colors.black, fontSize: 15, fontWeight: FontWeight.w500),
                                                                                    ),
                                                                                  ),
                                                                                  FFButtonWidget(
                                                                                    onPressed: () async {
                                                                                      selectFile('Aadhar');
                                                                                    },
                                                                                    text: documents['Aadhar'] == null ? 'Upload' : 'Change',
                                                                                    options: FFButtonOptions(
                                                                                      width: 100,
                                                                                      height: 40,
                                                                                      color: documents['Aadhar'] == null ? Color(0xFF4B39EF) : Colors.teal,
                                                                                      textStyle: FlutterFlowTheme.subtitle2.override(
                                                                                        fontFamily: 'Lexend Deca',
                                                                                        color: Colors.white,
                                                                                        fontSize: 16,
                                                                                        fontWeight: FontWeight.normal,
                                                                                      ),
                                                                                      elevation: 2,
                                                                                      borderSide: BorderSide(
                                                                                        color: Colors.transparent,
                                                                                        width: 1,
                                                                                      ),
                                                                                      borderRadius: 50,
                                                                                    ),
                                                                                  ),
                                                                                ],
                                                                              ),
                                                                              SizedBox(
                                                                                height: 5,
                                                                              ),
                                                                              Row(
                                                                                children: [
                                                                                  Expanded(
                                                                                    child: Text(
                                                                                      'Other 1',
                                                                                      style: FlutterFlowTheme.bodyText1.override(fontFamily: 'Poppins', color: Colors.black, fontSize: 15, fontWeight: FontWeight.w500),
                                                                                    ),
                                                                                  ),
                                                                                  FFButtonWidget(
                                                                                    onPressed: () async {
                                                                                      selectFile('Other 1');
                                                                                    },
                                                                                    text: documents['Other 1'] == null ? 'Upload' : 'Change',
                                                                                    options: FFButtonOptions(
                                                                                      width: 100,
                                                                                      height: 40,
                                                                                      color: documents['Other 1'] == null ? Color(0xFF4B39EF) : Colors.teal,
                                                                                      textStyle: FlutterFlowTheme.subtitle2.override(
                                                                                        fontFamily: 'Lexend Deca',
                                                                                        color: Colors.white,
                                                                                        fontSize: 16,
                                                                                        fontWeight: FontWeight.normal,
                                                                                      ),
                                                                                      elevation: 2,
                                                                                      borderSide: BorderSide(
                                                                                        color: Colors.transparent,
                                                                                        width: 1,
                                                                                      ),
                                                                                      borderRadius: 50,
                                                                                    ),
                                                                                  ),
                                                                                ],
                                                                              ),
                                                                              SizedBox(
                                                                                height: 5,
                                                                              ),
                                                                              Row(
                                                                                children: [
                                                                                  Expanded(
                                                                                    child: Text(
                                                                                      'Other 1',
                                                                                      style: FlutterFlowTheme.bodyText1.override(fontFamily: 'Poppins', color: Colors.black, fontSize: 15, fontWeight: FontWeight.w500),
                                                                                    ),
                                                                                  ),
                                                                                  FFButtonWidget(
                                                                                    onPressed: () async {
                                                                                      selectFile('Other 1');
                                                                                    },
                                                                                    text: documents['Other 1'] == null ? 'Upload' : 'Change',
                                                                                    options: FFButtonOptions(
                                                                                      width: 100,
                                                                                      height: 40,
                                                                                      color: documents['Other 1'] == null ? Color(0xFF4B39EF) : Colors.teal,
                                                                                      textStyle: FlutterFlowTheme.subtitle2.override(
                                                                                        fontFamily: 'Lexend Deca',
                                                                                        color: Colors.white,
                                                                                        fontSize: 16,
                                                                                        fontWeight: FontWeight.normal,
                                                                                      ),
                                                                                      elevation: 2,
                                                                                      borderSide: BorderSide(
                                                                                        color: Colors.transparent,
                                                                                        width: 1,
                                                                                      ),
                                                                                      borderRadius: 50,
                                                                                    ),
                                                                                  ),
                                                                                ],
                                                                              ),
                                                                            ],
                                                                          ),
                                                                        ),
                                                                      ],
                                                                    )
                                                                  ],
                                                                ),
                                                              )
                                                            : value[0]['status'] == 'Document Collected'
                                                                ? Column(
                                                                    mainAxisSize:
                                                                        MainAxisSize
                                                                            .max,
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .center,
                                                                    children: [
                                                                      // Generated code for this Row Widget...
                                                                      Row(
                                                                          mainAxisSize: MainAxisSize
                                                                              .max,
                                                                          mainAxisAlignment: MainAxisAlignment
                                                                              .spaceEvenly,
                                                                          children: List.generate(
                                                                              university.length,
                                                                              (index) {
                                                                            return Column(
                                                                              mainAxisSize: MainAxisSize.max,
                                                                              children: [
                                                                                Text(
                                                                                  universityNames[university[index]['name']],
                                                                                  style: FlutterFlowTheme.subtitle2.override(
                                                                                    fontFamily: 'Lexend Deca',
                                                                                    color: Colors.black,
                                                                                    fontSize: 13,
                                                                                    fontWeight: FontWeight.w600,
                                                                                  ),
                                                                                ),
                                                                                Container(
                                                                                  width: 100,
                                                                                  height: 100,
                                                                                  decoration: BoxDecoration(
                                                                                    color: Color(0xFFEEEEEE),
                                                                                    borderRadius: BorderRadius.circular(15),
                                                                                  ),
                                                                                  child: FlutterFlowIconButton(
                                                                                    borderColor: Colors.transparent,
                                                                                    borderRadius: 30,
                                                                                    borderWidth: 1,
                                                                                    buttonSize: 60,
                                                                                    icon: FaIcon(
                                                                                      FontAwesomeIcons.wpforms,
                                                                                      color: Colors.black,
                                                                                      size: 30,
                                                                                    ),
                                                                                    onPressed: () async {
                                                                                      print(index + 1);

                                                                                      bool pressed = await alert(context, 'Do you want to Proceed?');

                                                                                      if (pressed) {
                                                                                        Navigator.push(
                                                                                            context,
                                                                                            MaterialPageRoute(
                                                                                                builder: (context) => ApplicationForm(
                                                                                                      university: universityNames[university[index]['name']],
                                                                                                      name: data.get('name'),
                                                                                                      countryId: countryIdByUniversityId[university[index]['name']],
                                                                                                      courseId: university[index]['course'],
                                                                                                      ieltsScore: data.get('ieltsScore'),
                                                                                                      place: data.get('place'),
                                                                                                      email: data.get('email'),
                                                                                                      mobile: data.get('mobile'),
                                                                                                      address: data.get('address'),
                                                                                                      fatherName: data.get('fatherName'),
                                                                                                      fatherNo: data.get('fatherNumber'),
                                                                                                      id: data.id,
                                                                                                      application: index + 1,
                                                                                                    )));
                                                                                      }
                                                                                    },
                                                                                  ),
                                                                                ),
                                                                              ],
                                                                            );
                                                                          }))
                                                                    ],
                                                                  )
                                                                : value[0]['status'] == 'Application Submitted'
                                                                    ? Column(
                                                                        mainAxisSize:
                                                                            MainAxisSize.max,
                                                                        mainAxisAlignment:
                                                                            MainAxisAlignment.center,
                                                                        children: [
                                                                          // Generated code for this Row Widget...
                                                                          Row(
                                                                            children: [
                                                                              Expanded(
                                                                                child: Theme(
                                                                                  data: ThemeData(
                                                                                    checkboxTheme: CheckboxThemeData(
                                                                                      shape: RoundedRectangleBorder(
                                                                                        borderRadius: BorderRadius.circular(25),
                                                                                      ),
                                                                                    ),
                                                                                    unselectedWidgetColor: Color(0xFF95A1AC),
                                                                                  ),
                                                                                  child: CheckboxListTile(
                                                                                    value: leadzverification ??= true,
                                                                                    onChanged: (newValue) => setState(() => leadzverification = newValue),
                                                                                    title: Text(
                                                                                      'Leadz',
                                                                                      style: FlutterFlowTheme.title3,
                                                                                    ),
                                                                                    tileColor: Color(0xFFF5F5F5),
                                                                                    activeColor: FlutterFlowTheme.primaryColor,
                                                                                    dense: false,
                                                                                    controlAffinity: ListTileControlAffinity.trailing,
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                              Expanded(
                                                                                child: Theme(
                                                                                  data: ThemeData(
                                                                                    checkboxTheme: CheckboxThemeData(
                                                                                      shape: RoundedRectangleBorder(
                                                                                        borderRadius: BorderRadius.circular(25),
                                                                                      ),
                                                                                    ),
                                                                                    unselectedWidgetColor: Color(0xFF95A1AC),
                                                                                  ),
                                                                                  child: CheckboxListTile(
                                                                                    value: unverification ??= true,
                                                                                    onChanged: (newValue) => setState(() => unverification = newValue),
                                                                                    title: Text(
                                                                                      'University',
                                                                                      style: FlutterFlowTheme.title3,
                                                                                    ),
                                                                                    tileColor: Color(0xFFF5F5F5),
                                                                                    activeColor: FlutterFlowTheme.primaryColor,
                                                                                    dense: false,
                                                                                    controlAffinity: ListTileControlAffinity.trailing,
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                            ],
                                                                          )
                                                                        ],
                                                                      )
                                                                    : value[0]['status'] == 'Verification Completed'
                                                                        ? Column(
                                                                            mainAxisSize:
                                                                                MainAxisSize.max,
                                                                            mainAxisAlignment:
                                                                                MainAxisAlignment.center,
                                                                            children: [
                                                                              // Generated code for this Row Widget...
                                                                              Row(
                                                                                children: [
                                                                                  Expanded(
                                                                                    child: SwitchListTile(
                                                                                      value: offerLetter ??= true,
                                                                                      onChanged: (newValue) {
                                                                                        offerLetter = newValue;

                                                                                        if (newValue == true) {
                                                                                          comments.text = 'Unconditional';
                                                                                        } else {
                                                                                          comments.text = 'Conditional';
                                                                                        }
                                                                                        setState(() {});
                                                                                      },
                                                                                      title: Text(
                                                                                        offerLetter == false ? 'Conditional' : 'Unconditional',
                                                                                        style: FlutterFlowTheme.title3.override(
                                                                                          fontFamily: 'Poppins',
                                                                                          fontSize: 18,
                                                                                          fontWeight: FontWeight.w500,
                                                                                        ),
                                                                                      ),
                                                                                      tileColor: Color(0xFFF5F5F5),
                                                                                      dense: true,
                                                                                      controlAffinity: ListTileControlAffinity.trailing,
                                                                                    ),
                                                                                  )
                                                                                ],
                                                                              ),
                                                                            ],
                                                                          )
                                                                        : value[0]['status'] == 'Offer Letter Received'
                                                                            ? Column(
                                                                                mainAxisSize: MainAxisSize.max,
                                                                                mainAxisAlignment: MainAxisAlignment.center,
                                                                                children: [
                                                                                  // Generated code for this Row Widget...
                                                                                  value[0]['comments'] == 'Conditional'
                                                                                      ? Row(
                                                                                          children: [
                                                                                            Text(
                                                                                              'Conditional',
                                                                                              style: FlutterFlowTheme.title3.override(
                                                                                                fontFamily: 'Poppins',
                                                                                                fontSize: 15,
                                                                                                fontWeight: FontWeight.w600,
                                                                                              ),
                                                                                            ),
                                                                                          ],
                                                                                        )
                                                                                      : Row(
                                                                                          children: [
                                                                                            Text(
                                                                                              'UnConditional',
                                                                                              style: FlutterFlowTheme.title3.override(
                                                                                                fontFamily: 'Poppins',
                                                                                                fontSize: 16,
                                                                                                fontWeight: FontWeight.w600,
                                                                                              ),
                                                                                            ),
                                                                                          ],
                                                                                        ),
                                                                                  value[0]['comments'] == 'Conditional'
                                                                                      ? Column(
                                                                                          children: [
                                                                                            Row(
                                                                                              children: [
                                                                                                Expanded(
                                                                                                  child: Theme(
                                                                                                    data: ThemeData(
                                                                                                      checkboxTheme: CheckboxThemeData(
                                                                                                        shape: RoundedRectangleBorder(
                                                                                                          borderRadius: BorderRadius.circular(25),
                                                                                                        ),
                                                                                                      ),
                                                                                                      unselectedWidgetColor: Color(0xFF95A1AC),
                                                                                                    ),
                                                                                                    child: CheckboxListTile(
                                                                                                      value: language ??= true,
                                                                                                      onChanged: (newValue) => setState(() => language = newValue),
                                                                                                      title: Text(
                                                                                                        'Language',
                                                                                                        style: FlutterFlowTheme.title3.override(
                                                                                                          fontFamily: 'Poppins',
                                                                                                          fontSize: 18,
                                                                                                          fontWeight: FontWeight.w500,
                                                                                                        ),
                                                                                                      ),
                                                                                                      tileColor: Color(0xFFF5F5F5),
                                                                                                      activeColor: FlutterFlowTheme.primaryColor,
                                                                                                      dense: true,
                                                                                                      controlAffinity: ListTileControlAffinity.trailing,
                                                                                                    ),
                                                                                                  ),
                                                                                                ),
                                                                                                FFButtonWidget(
                                                                                                  onPressed: () async {
                                                                                                    selectFile('language');
                                                                                                  },
                                                                                                  text: documents['language'] == null ? 'Upload' : 'Change',
                                                                                                  options: FFButtonOptions(
                                                                                                    width: 100,
                                                                                                    height: 40,
                                                                                                    color: documents['language'] == null ? Color(0xFF4B39EF) : Colors.teal,
                                                                                                    textStyle: FlutterFlowTheme.subtitle2.override(
                                                                                                      fontFamily: 'Lexend Deca',
                                                                                                      color: Colors.white,
                                                                                                      fontSize: 16,
                                                                                                      fontWeight: FontWeight.normal,
                                                                                                    ),
                                                                                                    elevation: 2,
                                                                                                    borderSide: BorderSide(
                                                                                                      color: Colors.transparent,
                                                                                                      width: 1,
                                                                                                    ),
                                                                                                    borderRadius: 50,
                                                                                                  ),
                                                                                                ),
                                                                                              ],
                                                                                            ),
                                                                                            Row(
                                                                                              children: [
                                                                                                Expanded(
                                                                                                  child: Theme(
                                                                                                    data: ThemeData(
                                                                                                      checkboxTheme: CheckboxThemeData(
                                                                                                        shape: RoundedRectangleBorder(
                                                                                                          borderRadius: BorderRadius.circular(25),
                                                                                                        ),
                                                                                                      ),
                                                                                                      unselectedWidgetColor: Color(0xFF95A1AC),
                                                                                                    ),
                                                                                                    child: CheckboxListTile(
                                                                                                      value: academic ??= true,
                                                                                                      onChanged: (newValue) => setState(() => academic = newValue),
                                                                                                      title: Text(
                                                                                                        'Academic',
                                                                                                        style: FlutterFlowTheme.title3.override(
                                                                                                          fontFamily: 'Poppins',
                                                                                                          fontSize: 18,
                                                                                                          fontWeight: FontWeight.w500,
                                                                                                        ),
                                                                                                      ),
                                                                                                      tileColor: Color(0xFFF5F5F5),
                                                                                                      activeColor: FlutterFlowTheme.primaryColor,
                                                                                                      dense: true,
                                                                                                      controlAffinity: ListTileControlAffinity.trailing,
                                                                                                    ),
                                                                                                  ),
                                                                                                ),
                                                                                                FFButtonWidget(
                                                                                                  onPressed: () async {
                                                                                                    selectFile('academic');
                                                                                                  },
                                                                                                  text: documents['academic'] == null ? 'Upload' : 'Change',
                                                                                                  options: FFButtonOptions(
                                                                                                    width: 100,
                                                                                                    height: 40,
                                                                                                    color: documents['academic'] == null ? Color(0xFF4B39EF) : Colors.teal,
                                                                                                    textStyle: FlutterFlowTheme.subtitle2.override(
                                                                                                      fontFamily: 'Lexend Deca',
                                                                                                      color: Colors.white,
                                                                                                      fontSize: 16,
                                                                                                      fontWeight: FontWeight.normal,
                                                                                                    ),
                                                                                                    elevation: 2,
                                                                                                    borderSide: BorderSide(
                                                                                                      color: Colors.transparent,
                                                                                                      width: 1,
                                                                                                    ),
                                                                                                    borderRadius: 50,
                                                                                                  ),
                                                                                                ),
                                                                                              ],
                                                                                            ),
                                                                                          ],
                                                                                        )
                                                                                      : Container(),

                                                                                  Row(
                                                                                    children: [
                                                                                      Expanded(
                                                                                        child: Theme(
                                                                                          data: ThemeData(
                                                                                            checkboxTheme: CheckboxThemeData(
                                                                                              shape: RoundedRectangleBorder(
                                                                                                borderRadius: BorderRadius.circular(25),
                                                                                              ),
                                                                                            ),
                                                                                            unselectedWidgetColor: Color(0xFF95A1AC),
                                                                                          ),
                                                                                          child: CheckboxListTile(
                                                                                            value: financial ??= true,
                                                                                            onChanged: (newValue) => setState(() => financial = newValue),
                                                                                            title: Text(
                                                                                              'Financial',
                                                                                              style: FlutterFlowTheme.title3.override(
                                                                                                fontFamily: 'Poppins',
                                                                                                fontSize: 18,
                                                                                                fontWeight: FontWeight.w500,
                                                                                              ),
                                                                                            ),
                                                                                            tileColor: Color(0xFFF5F5F5),
                                                                                            activeColor: FlutterFlowTheme.primaryColor,
                                                                                            dense: true,
                                                                                            controlAffinity: ListTileControlAffinity.trailing,
                                                                                          ),
                                                                                        ),
                                                                                      ),
                                                                                      FFButtonWidget(
                                                                                        onPressed: () async {
                                                                                          selectFile('financial');
                                                                                        },
                                                                                        text: documents['financial'] == null ? 'Upload' : 'Change',
                                                                                        options: FFButtonOptions(
                                                                                          width: 100,
                                                                                          height: 40,
                                                                                          color: documents['financial'] == null ? Color(0xFF4B39EF) : Colors.teal,
                                                                                          textStyle: FlutterFlowTheme.subtitle2.override(
                                                                                            fontFamily: 'Lexend Deca',
                                                                                            color: Colors.white,
                                                                                            fontSize: 16,
                                                                                            fontWeight: FontWeight.normal,
                                                                                          ),
                                                                                          elevation: 2,
                                                                                          borderSide: BorderSide(
                                                                                            color: Colors.transparent,
                                                                                            width: 1,
                                                                                          ),
                                                                                          borderRadius: 50,
                                                                                        ),
                                                                                      ),
                                                                                    ],
                                                                                  ),
                                                                                  Row(
                                                                                    children: [
                                                                                      Expanded(
                                                                                        child: Theme(
                                                                                          data: ThemeData(
                                                                                            checkboxTheme: CheckboxThemeData(
                                                                                              shape: RoundedRectangleBorder(
                                                                                                borderRadius: BorderRadius.circular(25),
                                                                                              ),
                                                                                            ),
                                                                                            unselectedWidgetColor: Color(0xFF95A1AC),
                                                                                          ),
                                                                                          child: CheckboxListTile(
                                                                                            value: interview ??= true,
                                                                                            onChanged: (newValue) => setState(() => interview = newValue),
                                                                                            title: Text(
                                                                                              'InterView',
                                                                                              style: FlutterFlowTheme.title3.override(
                                                                                                fontFamily: 'Poppins',
                                                                                                fontSize: 18,
                                                                                                fontWeight: FontWeight.w500,
                                                                                              ),
                                                                                            ),
                                                                                            tileColor: Color(0xFFF5F5F5),
                                                                                            activeColor: FlutterFlowTheme.primaryColor,
                                                                                            dense: true,
                                                                                            controlAffinity: ListTileControlAffinity.trailing,
                                                                                          ),
                                                                                        ),
                                                                                      ),
                                                                                      FFButtonWidget(
                                                                                        onPressed: () async {
                                                                                          selectFile('interView');
                                                                                        },
                                                                                        text: documents['interView'] == null ? 'Upload' : 'Change',
                                                                                        options: FFButtonOptions(
                                                                                          width: 100,
                                                                                          height: 40,
                                                                                          color: documents['interView'] == null ? Color(0xFF4B39EF) : Colors.teal,
                                                                                          textStyle: FlutterFlowTheme.subtitle2.override(
                                                                                            fontFamily: 'Lexend Deca',
                                                                                            color: Colors.white,
                                                                                            fontSize: 16,
                                                                                            fontWeight: FontWeight.normal,
                                                                                          ),
                                                                                          elevation: 2,
                                                                                          borderSide: BorderSide(
                                                                                            color: Colors.transparent,
                                                                                            width: 1,
                                                                                          ),
                                                                                          borderRadius: 50,
                                                                                        ),
                                                                                      ),
                                                                                    ],
                                                                                  ),
                                                                                ],
                                                                              )
                                                                            : value[0]['status'] == 'UnCond.Offer Letter Received'
                                                                                ? Column(
                                                                                    mainAxisSize: MainAxisSize.max,
                                                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                                                    children: [
                                                                                      Row(
                                                                                        children: [
                                                                                          Text(
                                                                                            'Mode of Payment',
                                                                                            style: FlutterFlowTheme.title3.override(
                                                                                              fontFamily: 'Poppins',
                                                                                              fontSize: 16,
                                                                                              fontWeight: FontWeight.w600,
                                                                                            ),
                                                                                          ),
                                                                                        ],
                                                                                      ),
                                                                                      Row(
                                                                                        children: [
                                                                                          Expanded(
                                                                                            child: Theme(
                                                                                              data: ThemeData(
                                                                                                checkboxTheme: CheckboxThemeData(
                                                                                                  shape: RoundedRectangleBorder(
                                                                                                    borderRadius: BorderRadius.circular(25),
                                                                                                  ),
                                                                                                ),
                                                                                                unselectedWidgetColor: Color(0xFF95A1AC),
                                                                                              ),
                                                                                              child: CheckboxListTile(
                                                                                                value: medicalDocument ??= true,
                                                                                                onChanged: (newValue) => setState(() => medicalDocument = newValue),
                                                                                                title: Row(
                                                                                                  children: [
                                                                                                    Text(
                                                                                                      'Medical Check Up',
                                                                                                      style: FlutterFlowTheme.title3.override(
                                                                                                        fontFamily: 'Poppins',
                                                                                                        fontSize: 18,
                                                                                                        fontWeight: FontWeight.w500,
                                                                                                      ),
                                                                                                    ),
                                                                                                    Expanded(
                                                                                                        child: SizedBox(
                                                                                                      width: 50,
                                                                                                    )),
                                                                                                    FFButtonWidget(
                                                                                                      onPressed: () async {
                                                                                                        selectFile('Medical Check Up');
                                                                                                      },
                                                                                                      text: documents['Medical Check Up'] == null ? 'Upload' : 'Change',
                                                                                                      options: FFButtonOptions(
                                                                                                        width: 100,
                                                                                                        height: 40,
                                                                                                        color: documents['Medical Check Up'] == null ? Color(0xFF4B39EF) : Colors.teal,
                                                                                                        textStyle: FlutterFlowTheme.subtitle2.override(
                                                                                                          fontFamily: 'Lexend Deca',
                                                                                                          color: Colors.white,
                                                                                                          fontSize: 16,
                                                                                                          fontWeight: FontWeight.normal,
                                                                                                        ),
                                                                                                        elevation: 2,
                                                                                                        borderSide: BorderSide(
                                                                                                          color: Colors.transparent,
                                                                                                          width: 1,
                                                                                                        ),
                                                                                                        borderRadius: 50,
                                                                                                      ),
                                                                                                    ),
                                                                                                  ],
                                                                                                ),
                                                                                                tileColor: Color(0xFFF5F5F5),
                                                                                                activeColor: FlutterFlowTheme.primaryColor,
                                                                                                dense: true,
                                                                                                controlAffinity: ListTileControlAffinity.trailing,
                                                                                              ),
                                                                                            ),
                                                                                          ),
                                                                                        ],
                                                                                      ),
                                                                                      Row(
                                                                                        children: [
                                                                                          Expanded(
                                                                                            child: Theme(
                                                                                              data: ThemeData(
                                                                                                checkboxTheme: CheckboxThemeData(
                                                                                                  shape: RoundedRectangleBorder(
                                                                                                    borderRadius: BorderRadius.circular(25),
                                                                                                  ),
                                                                                                ),
                                                                                                unselectedWidgetColor: Color(0xFF95A1AC),
                                                                                              ),
                                                                                              child: CheckboxListTile(
                                                                                                value: aats ??= true,
                                                                                                onChanged: (newValue) => setState(() => aats = newValue),
                                                                                                title: Row(
                                                                                                  children: [
                                                                                                    Text(
                                                                                                      'ATAS (if Required)',
                                                                                                      style: FlutterFlowTheme.title3.override(
                                                                                                        fontFamily: 'Poppins',
                                                                                                        fontSize: 18,
                                                                                                        fontWeight: FontWeight.w500,
                                                                                                      ),
                                                                                                    ),
                                                                                                    Expanded(
                                                                                                        child: SizedBox(
                                                                                                      width: 50,
                                                                                                    )),
                                                                                                    FFButtonWidget(
                                                                                                      onPressed: () async {
                                                                                                        selectFile('ATAS');
                                                                                                      },
                                                                                                      text: documents['ATAS'] == null ? 'Upload' : 'Change',
                                                                                                      options: FFButtonOptions(
                                                                                                        width: 100,
                                                                                                        height: 40,
                                                                                                        color: documents['ATAS'] == null ? Color(0xFF4B39EF) : Colors.teal,
                                                                                                        textStyle: FlutterFlowTheme.subtitle2.override(
                                                                                                          fontFamily: 'Lexend Deca',
                                                                                                          color: Colors.white,
                                                                                                          fontSize: 16,
                                                                                                          fontWeight: FontWeight.normal,
                                                                                                        ),
                                                                                                        elevation: 2,
                                                                                                        borderSide: BorderSide(
                                                                                                          color: Colors.transparent,
                                                                                                          width: 1,
                                                                                                        ),
                                                                                                        borderRadius: 50,
                                                                                                      ),
                                                                                                    ),
                                                                                                  ],
                                                                                                ),
                                                                                                tileColor: Color(0xFFF5F5F5),
                                                                                                activeColor: FlutterFlowTheme.primaryColor,
                                                                                                dense: true,
                                                                                                controlAffinity: ListTileControlAffinity.trailing,
                                                                                              ),
                                                                                            ),
                                                                                          ),
                                                                                        ],
                                                                                      ),
                                                                                      Row(
                                                                                        children: [
                                                                                          Expanded(
                                                                                            child: Theme(
                                                                                              data: ThemeData(
                                                                                                checkboxTheme: CheckboxThemeData(
                                                                                                  shape: RoundedRectangleBorder(
                                                                                                    borderRadius: BorderRadius.circular(25),
                                                                                                  ),
                                                                                                ),
                                                                                                unselectedWidgetColor: Color(0xFF95A1AC),
                                                                                              ),
                                                                                              child: CheckboxListTile(
                                                                                                value: financialDocument ??= true,
                                                                                                onChanged: (newValue) => setState(() => financialDocument = newValue),
                                                                                                title: Row(
                                                                                                  children: [
                                                                                                    Text(
                                                                                                      'Financial',
                                                                                                      style: FlutterFlowTheme.title3.override(
                                                                                                        fontFamily: 'Poppins',
                                                                                                        fontSize: 18,
                                                                                                        fontWeight: FontWeight.w500,
                                                                                                      ),
                                                                                                    ),
                                                                                                    Expanded(
                                                                                                        child: SizedBox(
                                                                                                      width: 50,
                                                                                                    )),
                                                                                                    FFButtonWidget(
                                                                                                      onPressed: () async {
                                                                                                        selectFile('Financial');
                                                                                                      },
                                                                                                      text: documents['Financial'] == null ? 'Upload' : 'Change',
                                                                                                      options: FFButtonOptions(
                                                                                                        width: 100,
                                                                                                        height: 40,
                                                                                                        color: documents['Financial'] == null ? Color(0xFF4B39EF) : Colors.teal,
                                                                                                        textStyle: FlutterFlowTheme.subtitle2.override(
                                                                                                          fontFamily: 'Lexend Deca',
                                                                                                          color: Colors.white,
                                                                                                          fontSize: 16,
                                                                                                          fontWeight: FontWeight.normal,
                                                                                                        ),
                                                                                                        elevation: 2,
                                                                                                        borderSide: BorderSide(
                                                                                                          color: Colors.transparent,
                                                                                                          width: 1,
                                                                                                        ),
                                                                                                        borderRadius: 50,
                                                                                                      ),
                                                                                                    ),
                                                                                                  ],
                                                                                                ),
                                                                                                tileColor: Color(0xFFF5F5F5),
                                                                                                activeColor: FlutterFlowTheme.primaryColor,
                                                                                                dense: true,
                                                                                                controlAffinity: ListTileControlAffinity.trailing,
                                                                                              ),
                                                                                            ),
                                                                                          ),
                                                                                        ],
                                                                                      ),
                                                                                      Row(
                                                                                        children: [
                                                                                          Expanded(
                                                                                            child: Theme(
                                                                                              data: ThemeData(
                                                                                                checkboxTheme: CheckboxThemeData(
                                                                                                  shape: RoundedRectangleBorder(
                                                                                                    borderRadius: BorderRadius.circular(25),
                                                                                                  ),
                                                                                                ),
                                                                                                unselectedWidgetColor: Color(0xFF95A1AC),
                                                                                              ),
                                                                                              child: CheckboxListTile(
                                                                                                value: tuitionFeePayment ??= true,
                                                                                                onChanged: (newValue) => setState(() => tuitionFeePayment = newValue),
                                                                                                title: Row(
                                                                                                  children: [
                                                                                                    Text(
                                                                                                      'Tuition Fee Payment',
                                                                                                      style: FlutterFlowTheme.title3.override(
                                                                                                        fontFamily: 'Poppins',
                                                                                                        fontSize: 18,
                                                                                                        fontWeight: FontWeight.w500,
                                                                                                      ),
                                                                                                    ),
                                                                                                    Expanded(
                                                                                                        child: SizedBox(
                                                                                                      width: 50,
                                                                                                    )),
                                                                                                    FFButtonWidget(
                                                                                                      onPressed: () async {
                                                                                                        selectFile('tuitionFee');
                                                                                                      },
                                                                                                      text: documents['tuitionFee'] == null ? 'Upload' : 'Change',
                                                                                                      options: FFButtonOptions(
                                                                                                        width: 100,
                                                                                                        height: 40,
                                                                                                        color: documents['tuitionFee'] == null ? Color(0xFF4B39EF) : Colors.teal,
                                                                                                        textStyle: FlutterFlowTheme.subtitle2.override(
                                                                                                          fontFamily: 'Lexend Deca',
                                                                                                          color: Colors.white,
                                                                                                          fontSize: 16,
                                                                                                          fontWeight: FontWeight.normal,
                                                                                                        ),
                                                                                                        elevation: 2,
                                                                                                        borderSide: BorderSide(
                                                                                                          color: Colors.transparent,
                                                                                                          width: 1,
                                                                                                        ),
                                                                                                        borderRadius: 50,
                                                                                                      ),
                                                                                                    ),
                                                                                                  ],
                                                                                                ),
                                                                                                tileColor: Color(0xFFF5F5F5),
                                                                                                activeColor: FlutterFlowTheme.primaryColor,
                                                                                                dense: true,
                                                                                                controlAffinity: ListTileControlAffinity.trailing,
                                                                                              ),
                                                                                            ),
                                                                                          ),
                                                                                        ],
                                                                                      ),
                                                                                      Row(
                                                                                        children: [
                                                                                          Expanded(
                                                                                            child: Theme(
                                                                                              data: ThemeData(
                                                                                                checkboxTheme: CheckboxThemeData(
                                                                                                  shape: RoundedRectangleBorder(
                                                                                                    borderRadius: BorderRadius.circular(25),
                                                                                                  ),
                                                                                                ),
                                                                                                unselectedWidgetColor: Color(0xFF95A1AC),
                                                                                              ),
                                                                                              child: CheckboxListTile(
                                                                                                value: others ??= true,
                                                                                                onChanged: (newValue) => setState(() => others = newValue),
                                                                                                title: Row(
                                                                                                  children: [
                                                                                                    Text(
                                                                                                      'Other',
                                                                                                      style: FlutterFlowTheme.title3.override(
                                                                                                        fontFamily: 'Poppins',
                                                                                                        fontSize: 18,
                                                                                                        fontWeight: FontWeight.w500,
                                                                                                      ),
                                                                                                    ),
                                                                                                    Expanded(
                                                                                                        child: SizedBox(
                                                                                                      width: 50,
                                                                                                    )),
                                                                                                    FFButtonWidget(
                                                                                                      onPressed: () async {
                                                                                                        selectFile('other');
                                                                                                      },
                                                                                                      text: documents['other'] == null ? 'Upload' : 'Change',
                                                                                                      options: FFButtonOptions(
                                                                                                        width: 100,
                                                                                                        height: 40,
                                                                                                        color: documents['other'] == null ? Color(0xFF4B39EF) : Colors.teal,
                                                                                                        textStyle: FlutterFlowTheme.subtitle2.override(
                                                                                                          fontFamily: 'Lexend Deca',
                                                                                                          color: Colors.white,
                                                                                                          fontSize: 16,
                                                                                                          fontWeight: FontWeight.normal,
                                                                                                        ),
                                                                                                        elevation: 2,
                                                                                                        borderSide: BorderSide(
                                                                                                          color: Colors.transparent,
                                                                                                          width: 1,
                                                                                                        ),
                                                                                                        borderRadius: 50,
                                                                                                      ),
                                                                                                    ),
                                                                                                  ],
                                                                                                ),
                                                                                                tileColor: Color(0xFFF5F5F5),
                                                                                                activeColor: FlutterFlowTheme.primaryColor,
                                                                                                dense: true,
                                                                                                controlAffinity: ListTileControlAffinity.trailing,
                                                                                              ),
                                                                                            ),
                                                                                          ),
                                                                                        ],
                                                                                      ),
                                                                                      Row(
                                                                                        children: [
                                                                                          Expanded(
                                                                                            child: Theme(
                                                                                              data: ThemeData(
                                                                                                checkboxTheme: CheckboxThemeData(
                                                                                                  shape: RoundedRectangleBorder(
                                                                                                    borderRadius: BorderRadius.circular(25),
                                                                                                  ),
                                                                                                ),
                                                                                                unselectedWidgetColor: Color(0xFF95A1AC),
                                                                                              ),
                                                                                              child: CheckboxListTile(
                                                                                                value: false,
                                                                                                // onChanged: (newValue) => setState(() => others = newValue),
                                                                                                title: Row(
                                                                                                  children: [
                                                                                                    Text(
                                                                                                      'One and Same',
                                                                                                      style: FlutterFlowTheme.title3.override(
                                                                                                        fontFamily: 'Poppins',
                                                                                                        fontSize: 18,
                                                                                                        fontWeight: FontWeight.w500,
                                                                                                      ),
                                                                                                    ),
                                                                                                    Expanded(
                                                                                                        child: SizedBox(
                                                                                                      width: 50,
                                                                                                    )),
                                                                                                    FFButtonWidget(
                                                                                                      onPressed: () async {
                                                                                                        selectFile('oneandSame');
                                                                                                      },
                                                                                                      text: documents['oneandSame'] == null ? 'Upload' : 'Change',
                                                                                                      options: FFButtonOptions(
                                                                                                        width: 100,
                                                                                                        height: 40,
                                                                                                        color: documents['oneandSame'] == null ? Color(0xFF4B39EF) : Colors.teal,
                                                                                                        textStyle: FlutterFlowTheme.subtitle2.override(
                                                                                                          fontFamily: 'Lexend Deca',
                                                                                                          color: Colors.white,
                                                                                                          fontSize: 16,
                                                                                                          fontWeight: FontWeight.normal,
                                                                                                        ),
                                                                                                        elevation: 2,
                                                                                                        borderSide: BorderSide(
                                                                                                          color: Colors.transparent,
                                                                                                          width: 1,
                                                                                                        ),
                                                                                                        borderRadius: 50,
                                                                                                      ),
                                                                                                    ),
                                                                                                  ],
                                                                                                ),
                                                                                                tileColor: Color(0xFFF5F5F5),
                                                                                                activeColor: FlutterFlowTheme.primaryColor,
                                                                                                dense: true,
                                                                                                controlAffinity: ListTileControlAffinity.trailing,
                                                                                              ),
                                                                                            ),
                                                                                          ),
                                                                                        ],
                                                                                      ),
                                                                                    ],
                                                                                  )
                                                                                : value[0]['status'] == 'CAS Shield Submitted'
                                                                                    ? Column(
                                                                                        mainAxisSize: MainAxisSize.max,
                                                                                        mainAxisAlignment: MainAxisAlignment.center,
                                                                                        children: [
                                                                                          Row(
                                                                                            children: [
                                                                                              Text(
                                                                                                'Upload CAS',
                                                                                                style: FlutterFlowTheme.title3.override(
                                                                                                  fontFamily: 'Poppins',
                                                                                                  fontSize: 16,
                                                                                                  fontWeight: FontWeight.w600,
                                                                                                ),
                                                                                              ),
                                                                                            ],
                                                                                          ),
                                                                                          Row(
                                                                                            children: [
                                                                                              Expanded(
                                                                                                child: Theme(
                                                                                                  data: ThemeData(
                                                                                                    checkboxTheme: CheckboxThemeData(
                                                                                                      shape: RoundedRectangleBorder(
                                                                                                        borderRadius: BorderRadius.circular(25),
                                                                                                      ),
                                                                                                    ),
                                                                                                    unselectedWidgetColor: Color(0xFF95A1AC),
                                                                                                  ),
                                                                                                  child: CheckboxListTile(
                                                                                                    value: casBool ??= true,
                                                                                                    onChanged: (newValue) => setState(() => casBool = newValue),
                                                                                                    title: Row(
                                                                                                      children: [
                                                                                                        Text(
                                                                                                          'CAS',
                                                                                                          style: FlutterFlowTheme.title3.override(
                                                                                                            fontFamily: 'Poppins',
                                                                                                            fontSize: 18,
                                                                                                            fontWeight: FontWeight.w500,
                                                                                                          ),
                                                                                                        ),
                                                                                                        Expanded(
                                                                                                            child: SizedBox(
                                                                                                          width: 50,
                                                                                                        )),
                                                                                                        FFButtonWidget(
                                                                                                          onPressed: () async {
                                                                                                            selectFile('CAS');
                                                                                                          },
                                                                                                          text: documents['CAS'] == null ? 'Upload' : 'Change',
                                                                                                          options: FFButtonOptions(
                                                                                                            width: 100,
                                                                                                            height: 40,
                                                                                                            color: documents['CAS'] == null ? Color(0xFF4B39EF) : Colors.teal,
                                                                                                            textStyle: FlutterFlowTheme.subtitle2.override(
                                                                                                              fontFamily: 'Lexend Deca',
                                                                                                              color: Colors.white,
                                                                                                              fontSize: 16,
                                                                                                              fontWeight: FontWeight.normal,
                                                                                                            ),
                                                                                                            elevation: 2,
                                                                                                            borderSide: BorderSide(
                                                                                                              color: Colors.transparent,
                                                                                                              width: 1,
                                                                                                            ),
                                                                                                            borderRadius: 50,
                                                                                                          ),
                                                                                                        ),
                                                                                                      ],
                                                                                                    ),
                                                                                                    tileColor: Color(0xFFF5F5F5),
                                                                                                    activeColor: FlutterFlowTheme.primaryColor,
                                                                                                    dense: true,
                                                                                                    controlAffinity: ListTileControlAffinity.trailing,
                                                                                                  ),
                                                                                                ),
                                                                                              ),
                                                                                            ],
                                                                                          ),
                                                                                        ],
                                                                                      )
                                                                                    : Container()),
                                                  ),
                                                )
                                              : Container()
                                        ],
                                      ),
                                    ),
                                  ),
                                ))
                          ],
                        ),
                      );
              }),
    );
  }
}
