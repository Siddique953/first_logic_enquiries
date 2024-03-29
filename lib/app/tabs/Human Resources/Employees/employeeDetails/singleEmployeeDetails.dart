import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:searchfield/searchfield.dart';

import '../../../../../flutter_flow/flutter_flow_theme.dart';
import '../../../../../flutter_flow/flutter_flow_util.dart';
import '../../../../../flutter_flow/upload_media.dart';
import '../../../../app_widget.dart';
import '../../../../models/Employee/EmployeeModel.dart';
import '../../../../pages/home_page/home.dart';
import '../Employee_List/employeeList.dart';

class SingleEmployeeDetails extends StatefulWidget {
  final TabController _tabController;
  const SingleEmployeeDetails({
    Key? key,
    required TabController tabController,
  })  : _tabController = tabController,
        super(key: key);

  @override
  State<SingleEmployeeDetails> createState() => _SingleEmployeeDetailsState();
}

class _SingleEmployeeDetailsState extends State<SingleEmployeeDetails> {
  RegExp phnValidation = RegExp(r'^[0-9]{10}$');
  RegExp numberValidation = RegExp(r'^[0-9]+$');

  PlatformFile? pickFile;
  UploadTask? uploadTask;
  String profile = '';

  //MANDATORY INFORMATION
  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController dateOfJoining = TextEditingController();
  DateTime? joinedDate;

  //OPTIONAL INFORMATION
  TextEditingController dateOfBirth = TextEditingController();
  DateTime? dob;
  String gender = '';

  //WORK

  TextEditingController dept = TextEditingController();
  TextEditingController subDept = TextEditingController();
  List<String> subDepartments = [''];
  TextEditingController designation = TextEditingController();
  TextEditingController reportingManager = TextEditingController();
  TextEditingController teamLead = TextEditingController();
  TextEditingController empType = TextEditingController();
  TextEditingController pan = TextEditingController();
  TextEditingController probationPeriod = TextEditingController(text: '0');
  int probation = 0;

  //SALARY DETAILS
  TextEditingController ctc = TextEditingController();
  TextEditingController holderName = TextEditingController();
  TextEditingController bankName = TextEditingController();
  TextEditingController city = TextEditingController();
  TextEditingController ifsc = TextEditingController();
  TextEditingController branchName = TextEditingController();
  TextEditingController accountNumber = TextEditingController();
  TextEditingController confirmAccountNumber = TextEditingController();

  /// SEND MAIL

  TextEditingController subject = TextEditingController();
  TextEditingController bodyOfMail = TextEditingController();
  List attachments = [];

  DateTime? createdDate;

  double width = 0;
  double height = 0;

  int tabIndex = 0;

  bool preRegistered = false;
  bool cancelHover = false;
  bool submitHover = false;

  String mError = '';
  String oError = '';

  EmployeeModel? employeeDetails;

  getEmployee() {
    FirebaseFirestore.instance
        .collection('employees')
        .doc(employeeId)
        .snapshots()
        .listen((event) {
      employeeDetails = EmployeeModel.fromJson(event.data()!);

      name.text = employeeDetails!.name!;
      email.text = employeeDetails!.email!;
      phone.text = employeeDetails!.phone!;
      pan.text = employeeDetails!.pan??'';
      dateOfJoining.text =
          dateTimeFormat('dd-MM-yyyy', employeeDetails!.joinedDate!);
      joinedDate = employeeDetails!.joinedDate!;
      dateOfBirth.text = dateTimeFormat('dd-MM-yyyy', employeeDetails!.dob!);
      dob = employeeDetails!.dob!;
      createdDate = employeeDetails!.createdDate!;
      gender = employeeDetails!.gender!;
      dept.text = employeeDetails!.dept!;
      profile = employeeDetails!.profile!;

      if (dept.text == 'Human Resource (HR)') {
        subDepartments = [
          'Training & Development',
          'Recruitment',
          'Payroll',
          'Office Management',
        ];
      } else if (dept.text == 'Leadership') {
        subDepartments = [
          'Strategy & Planning',
          'Quality Control',
        ];
      } else if (dept.text == 'Operations') {
        subDepartments = [
          'Strategy & Planning',
          'Quality Control',
          'Product Design',
        ];
      } else if (dept.text == 'Sales & Marketing') {
        subDepartments = [
          'Sales',
          'Advertising & Media',
          'Sales Promotion',
          'Market Research',
          'Public Relations',
        ];
      } else if (dept.text == 'IT') {
        subDepartments = [
          'Planning',
          'Application Development',
          'Web Development',
          'Application Management',
          'Business Intelligence',
          'IT Management & Administration',
          'IT Security',
          'Network Administration',
          'User Support & Services',
        ];
      } else if (dept.text == 'Accounts & Finance') {
        subDepartments = [
          'Accounting Department',
          'Cost Accounts Department',
          'Audit Department',
          'Financial Planning & Budgeting Department',
          'Cash Department',
          'Credit Department',
        ];
      } else {
        subDepartments = [
          'Market Research',
          'Innovations',
          'Quality Control',
          'Product Research & Development',
          'Cash Department',
          'Credit Department',
        ];
      }

      subDept.text = employeeDetails!.subDept??'';
      designation.text = employeeDetails!.designation??'';
      reportingManager.text =
          empDataById[employeeDetails!.reportingManager ?? ''] == null
              ? ''
              : empDataById[employeeDetails!.reportingManager ?? '']!.name!;

      try {
        teamLead.text = empDataById[employeeDetails!.teamLead ?? ''] == null
            ? ''
            : empDataById[employeeDetails!.teamLead ?? '']!.name!;
      } catch (e) {
        teamLead.text = '';
      }

      // employeeDetails.reportingManager;
      empType.text = employeeDetails!.empType??'';
      probationPeriod.text = employeeDetails!.probation!.toString();
      probation = employeeDetails!.probation??0;
      ctc.text = employeeDetails!.ctc??'';
      holderName.text = employeeDetails!.accountHolderName??'';
      bankName.text = employeeDetails!.bankName??'';
      city.text = employeeDetails!.city!;
      ifsc.text = employeeDetails!.ifsc!;
      branchName.text = employeeDetails!.branchName!;
      accountNumber.text = employeeDetails!.accountNumber!;
      confirmAccountNumber.text = employeeDetails!.accountNumber!;

      if (mounted) {
        setState(() {});
      }
    });
  }

  bool mandatoryDataReadOnly= true;
  bool personalDataReadOnly= true;
  getEditPermission() async {
    final doc = await FirebaseFirestore.instance.collection('settings')
        .doc(currentBranchId)
        .get();

    mandatoryDataReadOnly = doc['editEmployeeMandatoryInfo']==false;
    personalDataReadOnly = doc['editEmployeePersonalInfo']==false;



    if(mounted) {
      setState(() {});
    }
  }

  List<SearchFieldListItem<String>> empNamesLocal=[];

  @override
  void initState() {

    getEditPermission();

    empNames.forEach((element) {
      empNamesLocal.add(
          SearchFieldListItem(element,)
      );
    });


    super.initState();
    getEmployee();
  }

  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            setState(() {
              widget._tabController.animateTo(6);
            });
          },
          icon: Icon(Icons.arrow_back_ios),
        ),
        title: Text(
          name.text == ''
              ? 'ONBOARDING NEW EMPLOYEE'
              : '${name.text.toUpperCase()}',
          style: TextStyle(color: Colors.white, fontSize: width * 0.02),
        ),
        elevation: 0,
        centerTitle: false,
        backgroundColor: Color(0xff231F20),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(20.0),
          child: Padding(
            padding: const EdgeInsets.only(left: 50),
            child: Container(
              height: 30.0,
              alignment: Alignment.center,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // SizedBox(
                  //   width: 15,
                  // ),

                  Row(
                    children: [
                      // SizedBox(
                      //   width: 15,
                      // ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          InkWell(
                            onTap: () {
                              tabIndex = 0;
                              setState(() {});
                            },
                            child: Text(
                              'Mandatory Info',
                              style: TextStyle(
                                color: tabIndex == 0
                                    ? Colors.white
                                    : Colors.grey,
                              ),
                            ),
                          ),
                          Spacer(),
                          tabIndex == 0
                              ? Container(
                                  width: 90,
                                  height: 5,
                                  color: Colors.white,
                                )
                              : SizedBox(),
                          Spacer(),
                        ],
                      ),
                      SizedBox(
                        width: 15,
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          InkWell(
                            onTap: () {
                              /*PRE REGISTERED TRUE*/
                              if (preRegistered) {
                                if (name.text != '' &&
                                    phone.text != '' &&
                                    email.text != '' &&
                                    joinedDate != null) {
                                  tabIndex = 1;
                                  setState(() {});
                                } else {
                                  name.text == ''
                                      ? mError =
                                          '* You Must Provide Employee Name'
                                      : phone.text == ''
                                          ? mError =
                                              '* You Must Provide Employee Phone Number'
                                          : email.text == ''
                                              ? mError =
                                                  '* You Must Provide Employee Official Email ID'
                                              : mError =
                                                  '* You Must Choose Joined Date';
                                  setState(() {});
                                }
                              } /*PRE REGISTERED FALSE*/ else {
                                if (name.text != '' &&
                                    phone.text != '' &&
                                    email.text != '') {
                                  tabIndex = 1;
                                  setState(() {});
                                } else {
                                  name.text == ''
                                      ? mError =
                                          '* You Must Provide Employee Name'
                                      : phone.text == ''
                                          ? mError =
                                              '* You Must Provide Employee Phone Number'
                                          :
                                          // email.text == ''
                                          //     ?
                                          mError =
                                              '* You Must Provide Employee Official Email ID';
                                  //     : mError =
                                  // 'You Must Choose Joined Date';
                                  setState(() {});
                                }
                              }
                            },
                            child: Text(
                              'Optional Info',
                              style: TextStyle(
                                color: tabIndex == 1
                                    ? Colors.white
                                    : Colors.grey,
                              ),
                            ),
                          ),
                          Spacer(),
                          tabIndex == 1
                              ? Container(
                                  width: 90,
                                  height: 5,
                                  color: Colors.white,
                                )
                              : SizedBox(),
                          Spacer(),
                        ],
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          InkWell(
                            onTap: () {
                              tabIndex = 2;
                              setState(() {});
                            },
                            child: Text(
                              'Mail',
                              style: TextStyle(
                                color: tabIndex == 2
                                    ? Colors.white
                                    : Colors.grey,
                              ),
                            ),
                          ),
                          Spacer(),
                          tabIndex == 2
                              ? Container(
                                  width: 90,
                                  height: 5,
                                  color: Colors.white,
                                )
                              : SizedBox(),
                          Spacer(),
                        ],
                      ),
                      SizedBox(
                        width: 30,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      body: employeeDetails == null
          ? Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Column(
                children: [
                  Center(
                    child: tabIndex == 0
                        ? Padding(
                            padding: EdgeInsets.only(
                                top: height * 0.2, bottom: height * 0.2),
                            child: Material(
                              elevation: 10,
                              child: Container(
                                width: width / 2,
                                height: height / 2,
                                color: Colors.white,
                                child: Padding(
                                  padding: EdgeInsets.all(width * 0.01),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text('MANDATORY INFO '),
                                          Row(children: [
                                            Text('PRE-ONBOARDING '),
                                            SizedBox(
                                              width: 15,
                                            ),
                                            CupertinoSwitch(
                                                activeColor: Colors.blue,
                                                thumbColor: Colors.white,
                                                value: preRegistered,
                                                onChanged: ((s) {
                                                  preRegistered = s;
                                                  setState(() {});
                                                }))
                                          ]),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Divider(
                                        height: 2,
                                        color: Colors.grey,
                                        thickness: 2,
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Expanded(
                                            child: Container(
                                              height: 60,
                                              child: Padding(
                                                padding: EdgeInsets.fromLTRB(
                                                    16, 0, 0, 0),
                                                child: TextFormField(
                                                  controller: name,
                                                  obscureText: false,
                                                  readOnly: mandatoryDataReadOnly,
                                                  onChanged: (v) {
                                                    mError = '';
                                                    setState(() {});
                                                  },
                                                  decoration: InputDecoration(
                                                    labelText: 'Full Name',
                                                    labelStyle: FlutterFlowTheme
                                                        .bodyText2
                                                        .override(
                                                            fontFamily:
                                                                'Montserrat',
                                                            color: Colors.black,
                                                            fontWeight:
                                                                FontWeight.w500,
                                                            fontSize: 15),

                                                    // hintText: 'Please Enter Name',
                                                    // hintStyle: FlutterFlowTheme.bodyText2.override(
                                                    //     fontFamily: 'Montserrat',
                                                    //     color: Colors.black,
                                                    //     fontWeight: FontWeight.w500,
                                                    //     fontSize: 12),
                                                    enabledBorder:
                                                        UnderlineInputBorder(
                                                      borderSide: BorderSide(
                                                        color: Colors.grey,
                                                        width: 2,
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
                                                      borderSide: BorderSide(
                                                        color: Colors.blue,
                                                        width: 2,
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
                                                          color: Colors.black,
                                                          fontWeight:
                                                              FontWeight.w500,
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
                                              height: 50,
                                              child: Padding(
                                                padding: EdgeInsets.fromLTRB(
                                                    16, 0, 0, 0),
                                                child: TextFormField(
                                                  controller: email,
                                                  obscureText: false,
                                                  readOnly: mandatoryDataReadOnly,
                                                  onChanged: (v) {
                                                    mError = '';
                                                    setState(() {});
                                                  },
                                                  decoration: InputDecoration(
                                                    labelText:
                                                        'Official Email Id',
                                                    labelStyle: FlutterFlowTheme
                                                        .bodyText2
                                                        .override(
                                                            fontFamily:
                                                                'Montserrat',
                                                            color: Colors.black,
                                                            fontWeight:
                                                                FontWeight.w500,
                                                            fontSize: 15),

                                                    // hintText: 'Please Enter Name',
                                                    // hintStyle: FlutterFlowTheme.bodyText2.override(
                                                    //     fontFamily: 'Montserrat',
                                                    //     color: Colors.black,
                                                    //     fontWeight: FontWeight.w500,
                                                    //     fontSize: 12),
                                                    enabledBorder:
                                                        UnderlineInputBorder(
                                                      borderSide: BorderSide(
                                                        color: Colors.grey,
                                                        width: 2,
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
                                                      borderSide: BorderSide(
                                                        color: Colors.blue,
                                                        width: 2,
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
                                                          color: Colors.black,
                                                          fontWeight:
                                                              FontWeight.w500,
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
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Expanded(
                                            child: Container(
                                              height: 60,
                                              child: Padding(
                                                padding: EdgeInsets.fromLTRB(
                                                    16, 0, 0, 0),
                                                child: TextFormField(
                                                  controller: phone,
                                                  obscureText: false,
                                                  readOnly: mandatoryDataReadOnly,
                                                  onChanged: (v) {
                                                    mError = '';
                                                    setState(() {});
                                                  },
                                                  autovalidateMode:
                                                      AutovalidateMode
                                                          .onUserInteraction,
                                                  validator: (v) {
                                                    if (!phnValidation
                                                        .hasMatch(v!)) {
                                                      return "Enter valid Phone Number";
                                                    } else {
                                                      return null;
                                                    }
                                                  },
                                                  decoration: InputDecoration(
                                                    labelText: 'Phone Number',
                                                    labelStyle: FlutterFlowTheme
                                                        .bodyText2
                                                        .override(
                                                            fontFamily:
                                                                'Montserrat',
                                                            color: Colors.black,
                                                            fontWeight:
                                                                FontWeight.w500,
                                                            fontSize: 15),

                                                    // hintText: 'Please Enter Name',
                                                    // hintStyle: FlutterFlowTheme.bodyText2.override(
                                                    //     fontFamily: 'Montserrat',
                                                    //     color: Colors.black,
                                                    //     fontWeight: FontWeight.w500,
                                                    //     fontSize: 12),
                                                    enabledBorder:
                                                        UnderlineInputBorder(
                                                      borderSide: BorderSide(
                                                        color: Colors.grey,
                                                        width: 2,
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
                                                      borderSide: BorderSide(
                                                        color: Colors.blue,
                                                        width: 2,
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
                                                          color: Colors.black,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          fontSize: 13),
                                                ),
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          preRegistered
                                              ? Expanded(
                                                  child: Container(
                                                    height: 50,
                                                    child: Padding(
                                                      padding:
                                                          EdgeInsets.fromLTRB(
                                                              16, 0, 0, 0),
                                                      child: TextFormField(
                                                        controller:
                                                            dateOfJoining,
                                                        obscureText: false,
                                                        readOnly: personalDataReadOnly,
                                                        onTap: () {
                                                          showDatePicker(
                                                                  context:
                                                                      context,
                                                                  initialDate:
                                                                      DateTime
                                                                          .now(),
                                                                  locale: Locale(
                                                                      'en',
                                                                      'IN'),
                                                                  firstDate: DateTime(
                                                                      DateTime.now()
                                                                              .year -
                                                                          100,
                                                                      1,
                                                                      1),
                                                                  lastDate: DateTime(
                                                                      DateTime.now()
                                                                              .year +
                                                                          100,
                                                                      12,
                                                                      31,
                                                                      23,
                                                                      59,
                                                                      59))
                                                              .then((value) {
                                                                if (value != null) {
                                                              setState(() {
                                                                joinedDate =
                                                                    value;
                                                                dateOfJoining
                                                                    .text = dateTimeFormat(
                                                                        'dd-MM-yyyy',
                                                                        value)
                                                                    .toString();
                                                              });
                                                            }
                                                          });
                                                        },
                                                        onChanged: (v) {
                                                          if (dateOfJoining
                                                                  .text ==
                                                              '') {
                                                            joinedDate = null;
                                                            mError = '';
                                                            setState(() {});
                                                          }
                                                        },
                                                        decoration:
                                                            InputDecoration(
                                                          labelText:
                                                              'Date Of Joining',
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
                                                                  fontSize: 15),

                                                          // hintText: 'Please Enter Name',
                                                          // hintStyle: FlutterFlowTheme.bodyText2.override(
                                                          //     fontFamily: 'Montserrat',
                                                          //     color: Colors.black,
                                                          //     fontWeight: FontWeight.w500,
                                                          //     fontSize: 12),
                                                          enabledBorder:
                                                              UnderlineInputBorder(
                                                            borderSide:
                                                                BorderSide(
                                                              color:
                                                                  Colors.grey,
                                                              width: 2,
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
                                                              color:
                                                                  Colors.blue,
                                                              width: 2,
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
                                                                fontSize: 13),
                                                      ),
                                                    ),
                                                  ),
                                                )
                                              : Spacer(),
                                          SizedBox(
                                            width: 10,
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 40,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Container(
                                            width: 130,
                                            height: 100,
                                            child: Image.network(
                                              'https://chart.googleapis.com/chart?chs=150x150&cht=qr&chl=$employeeId',
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                          Text(
                                            '$mError',
                                            style: TextStyle(color: Colors.red),
                                          ),
                                          Row(
                                            children: [
                                              GestureDetector(
                                                onTap: () async {
                                                  if (employeeDetails!.delete!) {
                                                    bool pressed = await alert(
                                                        context,
                                                        'Do you want to Add this Employee');

                                                    if (pressed) {
                                                      FirebaseFirestore.instance
                                                          .collection(
                                                              'employees')
                                                          .doc(employeeId)
                                                          .update({
                                                        'delete': false,
                                                      });
                                                      widget._tabController
                                                          .animateTo(6);
                                                    }
                                                  } else {
                                                    bool pressed = await alert(
                                                        context,
                                                        'Do you want to Delete this Employee');

                                                    if (pressed) {
                                                      FirebaseFirestore.instance
                                                          .collection(
                                                              'employees')
                                                          .doc(employeeId)
                                                          .update({
                                                        'delete': true,
                                                      });
                                                      widget._tabController
                                                          .animateTo(6);
                                                    }
                                                  }
                                                },
                                                child: MouseRegion(
                                                  cursor:
                                                      SystemMouseCursors.click,
                                                  onEnter: (v) {
                                                    cancelHover = true;
                                                    setState(() {});
                                                  },
                                                  onExit: (v) {
                                                    cancelHover = false;
                                                    setState(() {});
                                                  },
                                                  child: Material(
                                                    color: Colors.transparent,
                                                    elevation:
                                                        cancelHover ? 10 : 0,
                                                    child: Container(
                                                      width: 100,
                                                      height: 30,
                                                      color: Colors.white,
                                                      child: Center(
                                                        child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          children:
                                                              employeeDetails!
                                                                      .delete!
                                                                  ? [
                                                                      Text(
                                                                          '+ Add'),
                                                                    ]
                                                                  : [
                                                                      Icon(
                                                                        Icons
                                                                            .delete_outline_sharp,
                                                                        color: Colors
                                                                            .black,
                                                                      ),
                                                                      SizedBox(
                                                                        width:
                                                                            10,
                                                                      ),
                                                                      Text(
                                                                          'Delete'),
                                                                    ],
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              SizedBox(
                                                width: 20,
                                              ),
                                              GestureDetector(
                                                onTap: () {
                                                  /*PRE REGISTERED TRUE*/
                                                  if (preRegistered) {
                                                    if (name.text != '' &&
                                                        phone.text != '' &&
                                                        email.text != '' &&
                                                        joinedDate != null) {
                                                      tabIndex = 1;
                                                      setState(() {});
                                                    } else {
                                                      name.text == ''
                                                          ? mError =
                                                              '* You Must Provide Employee Name'
                                                          : phone.text == ''
                                                              ? mError =
                                                                  '* You Must Provide Employee Phone Number'
                                                              : email.text == ''
                                                                  ? mError =
                                                                      '* You Must Provide Employee Official Email ID'
                                                                  : mError =
                                                                      '* You Must Choose Joined Date';
                                                      setState(() {});
                                                    }
                                                  } /*PRE REGISTERED FALSE*/ else {
                                                    if (name.text != '' &&
                                                        phone.text != '' &&
                                                        email.text != '') {
                                                      tabIndex = 1;
                                                      setState(() {});
                                                    } else {
                                                      name.text == ''
                                                          ? mError =
                                                              '* You Must Provide Employee Name'
                                                          : phone.text == ''
                                                              ? mError =
                                                                  '* You Must Provide Employee Phone Number'
                                                              :
                                                              // email.text == ''
                                                              //     ?
                                                              mError =
                                                                  '* You Must Provide Employee Official Email ID';
                                                      //     : mError =
                                                      // 'You Must Choose Joined Date';
                                                      setState(() {});
                                                    }
                                                  }
                                                },
                                                child: MouseRegion(
                                                  cursor:
                                                      SystemMouseCursors.click,
                                                  onEnter: (v) {
                                                    submitHover = true;
                                                    setState(() {});
                                                  },
                                                  onExit: (v) {
                                                    submitHover = false;
                                                    setState(() {});
                                                  },
                                                  child: Material(
                                                    color: Colors.transparent,
                                                    elevation:
                                                        submitHover ? 10 : 0,
                                                    child: Container(
                                                      width: 100,
                                                      height: 30,
                                                      color: Colors.blueAccent,
                                                      child: Center(
                                                        child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          children: [
                                                            Text('NEXT'),
                                                            SizedBox(
                                                              width: 10,
                                                            ),
                                                            Icon(Icons
                                                                .arrow_forward_outlined),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          )
                        : tabIndex == 1
                            ? Padding(
                                padding: EdgeInsets.only(
                                    top: height * 0.2, bottom: height * 0.2),
                                child: Material(
                                  elevation: 10,
                                  child: Container(
                                    width: width * 0.6,
                                    // height: height * 0.75,
                                    color: Colors.white,
                                    child: Padding(
                                      padding: EdgeInsets.all(width * 0.01),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding:
                                                EdgeInsets.all(width * 0.01),
                                            child: Text('PERSONAL'),
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Expanded(
                                                child: Container(
                                                  height: 50,
                                                  child: Padding(
                                                    padding:
                                                        EdgeInsets.fromLTRB(
                                                            16, 0, 0, 0),
                                                    child: TextFormField(
                                                      controller: dateOfBirth,
                                                      obscureText: false,
                                                      readOnly: personalDataReadOnly,
                                                      onTap: () {
                                                        showDatePicker(
                                                                context:
                                                                    context,
                                                                initialDate:
                                                                    DateTime
                                                                        .now(),
                                                                locale: Locale(
                                                                    'en', 'IN'),
                                                                firstDate: DateTime(
                                                                    DateTime.now()
                                                                            .year -
                                                                        100,
                                                                    1,
                                                                    1),
                                                                lastDate: DateTime(
                                                                    DateTime.now()
                                                                            .year +
                                                                        100,
                                                                    12,
                                                                    31,
                                                                    23,
                                                                    59,
                                                                    59))
                                                            .then((value) {
                                                          if(value != null){
                                                            setState(() {
                                                              dob = value;
                                                              dateOfBirth.text =
                                                                  dateTimeFormat(
                                                                          'dd-MM-yyyy',
                                                                          value)
                                                                      .toString();
                                                            });
                                                          }
                                                        });
                                                      },
                                                      onChanged: (v) {
                                                        oError = '';
                                                        if (dateOfJoining
                                                                .text ==
                                                            '') {
                                                          dob = null;
                                                          setState(() {});
                                                        }
                                                        setState(() {});
                                                      },
                                                      decoration:
                                                          InputDecoration(
                                                        suffixIcon: Icon(
                                                          Icons
                                                              .calendar_today_outlined,
                                                          color: Colors.blue,
                                                        ),
                                                        labelText:
                                                            'Date Of Birth',
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
                                                                fontSize: 15),

                                                        // hintText: 'Please Enter Name',
                                                        // hintStyle: FlutterFlowTheme.bodyText2.override(
                                                        //     fontFamily: 'Montserrat',
                                                        //     color: Colors.black,
                                                        //     fontWeight: FontWeight.w500,
                                                        //     fontSize: 12),
                                                        enabledBorder:
                                                            UnderlineInputBorder(
                                                          borderSide:
                                                              BorderSide(
                                                            color: Colors.grey,
                                                            width: 2,
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
                                                            color: Colors.blue,
                                                            width: 2,
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
                                                              color:
                                                                  Colors.black,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                              fontSize: 13),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              SizedBox(
                                                width: 15,
                                              ),
                                              Expanded(
                                                child: Container(
                                                  height: 56,
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Text(
                                                        'Select Gender',
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            color:
                                                                Colors.black),
                                                      ),
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          InkWell(
                                                            onTap: () {
                                                              gender = 'Male';
                                                              oError = '';
                                                              setState(() {});
                                                            },
                                                            child: Container(
                                                              child: Column(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .spaceBetween,
                                                                children: [
                                                                  Row(
                                                                    children: [
                                                                      Icon(
                                                                        Icons
                                                                            .male,
                                                                        color: gender ==
                                                                                'Male'
                                                                            ? Colors.blue
                                                                            : Colors.black,
                                                                      ),
                                                                      Text(
                                                                        'Male',
                                                                        style:
                                                                            TextStyle(
                                                                          color: gender == 'Male'
                                                                              ? Colors.blue
                                                                              : Colors.black,
                                                                        ),
                                                                      )
                                                                    ],
                                                                  ),
                                                                  Divider(
                                                                    thickness:
                                                                        5,
                                                                    height: 5,
                                                                    color: gender ==
                                                                            'Male'
                                                                        ? Colors
                                                                            .blue
                                                                        : Colors
                                                                            .black,
                                                                  )
                                                                ],
                                                              ),
                                                            ),
                                                          ),
                                                          SizedBox(
                                                            width: 10,
                                                          ),
                                                          InkWell(
                                                            onTap: () {
                                                              gender = 'Female';
                                                              oError = '';
                                                              setState(() {});
                                                            },
                                                            child: Container(
                                                              child: Column(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .spaceBetween,
                                                                children: [
                                                                  Row(
                                                                    children: [
                                                                      Icon(
                                                                        Icons
                                                                            .male,
                                                                        color: gender ==
                                                                                'Female'
                                                                            ? Colors.blue
                                                                            : Colors.black,
                                                                      ),
                                                                      Text(
                                                                        'Female',
                                                                        style:
                                                                            TextStyle(
                                                                          color: gender == 'Female'
                                                                              ? Colors.blue
                                                                              : Colors.black,
                                                                        ),
                                                                      )
                                                                    ],
                                                                  ),
                                                                  Divider(
                                                                    thickness:
                                                                        5,
                                                                    height: 5,
                                                                    color: gender ==
                                                                            'Female'
                                                                        ? Colors
                                                                            .blue
                                                                        : Colors
                                                                            .black,
                                                                  )
                                                                ],
                                                              ),
                                                            ),
                                                          ),
                                                          SizedBox(
                                                            width: 10,
                                                          ),
                                                          InkWell(
                                                            onTap: () {
                                                              gender = 'Others';
                                                              oError = '';
                                                              setState(() {});
                                                            },
                                                            child: Container(
                                                              child: Column(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .spaceBetween,
                                                                children: [
                                                                  Row(
                                                                    children: [
                                                                      Icon(
                                                                        Icons
                                                                            .male,
                                                                        color: gender ==
                                                                                'Others'
                                                                            ? Colors.blue
                                                                            : Colors.black,
                                                                      ),
                                                                      Text(
                                                                        'Others',
                                                                        style:
                                                                            TextStyle(
                                                                          color: gender == 'Others'
                                                                              ? Colors.blue
                                                                              : Colors.black,
                                                                        ),
                                                                      )
                                                                    ],
                                                                  ),
                                                                  Divider(
                                                                    thickness:
                                                                        5,
                                                                    height: 5,
                                                                    color: gender ==
                                                                            'Others'
                                                                        ? Colors
                                                                            .blue
                                                                        : Colors
                                                                            .black,
                                                                  )
                                                                ],
                                                              ),
                                                            ),
                                                          ),
                                                          SizedBox(
                                                            width: 10,
                                                          ),
                                                        ],
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              ),
                                              SizedBox(
                                                width: 100,
                                              ),
                                              InkWell(
                                                onTap: () {
                                                  selectFileToUpload(
                                                      context, 'profile');
                                                },
                                                child: profile == ''
                                                    ? CircleAvatar(
                                                        radius: 25,
                                                        backgroundColor:
                                                            Colors.blueGrey,
                                                      )
                                                    : CircleAvatar(
                                                        radius: 25,
                                                        backgroundImage:
                                                            NetworkImage(
                                                                profile),
                                                        backgroundColor:
                                                            Colors.blueGrey,
                                                      ),
                                              )
                                            ],
                                          ),
                                          SizedBox(
                                            height: 30,
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Expanded(
                                                child: Container(
                                                  height: 50,
                                                  child: Padding(
                                                    padding:
                                                        EdgeInsets.fromLTRB(
                                                            16, 0, 0, 0),
                                                    child: TextFormField(
                                                      controller: pan,
                                                      readOnly: personalDataReadOnly,
                                                      obscureText: false,
                                                      decoration:
                                                          InputDecoration(
                                                        labelText: 'PAN Number',
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
                                                                fontSize: 15),

                                                        // hintText: 'Please Enter Name',
                                                        // hintStyle: FlutterFlowTheme.bodyText2.override(
                                                        //     fontFamily: 'Montserrat',
                                                        //     color: Colors.black,
                                                        //     fontWeight: FontWeight.w500,
                                                        //     fontSize: 12),
                                                        enabledBorder:
                                                            UnderlineInputBorder(
                                                          borderSide:
                                                              BorderSide(
                                                            color: Colors.grey,
                                                            width: 2,
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
                                                            color: Colors.blue,
                                                            width: 2,
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
                                                              color:
                                                                  Colors.black,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                              fontSize: 13),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              SizedBox(
                                                width: 15,
                                              ),
                                              Expanded(
                                                child: Container(
                                                  height: 56,
                                                ),
                                              ),
                                              SizedBox(
                                                width: 100,
                                              ),
                                              Expanded(
                                                child: Container(
                                                  height: 56,
                                                ),
                                              ),
                                            ],
                                          ),
                                          SizedBox(
                                            height: 30,
                                          ),
                                          Padding(
                                            padding:
                                                EdgeInsets.all(width * 0.01),
                                            child: Divider(
                                              height: 1,
                                              color: Colors.grey,
                                              thickness: 1,
                                            ),
                                          ),
                                          SizedBox(
                                            height: 20,
                                          ),
                                          Padding(
                                            padding:
                                                EdgeInsets.all(width * 0.01),
                                            child: Text('WORK'),
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Expanded(
                                                child: Container(
                                                  height: 60,
                                                  child: Padding(
                                                    padding:
                                                        EdgeInsets.fromLTRB(
                                                            16, 0, 0, 0),
                                                    child: Column(
                                                      children: [
                                                        CustomDropdown.search(
                                                          hintText:
                                                              'Department',
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
                                                                  fontSize: 15),
                                                          items: [
                                                            'Leadership',
                                                            'Human Resource (HR)',
                                                            'Operations',
                                                            'Sales & Marketing',
                                                            'IT',
                                                            'Accounts & Finance',
                                                            'R & D',
                                                          ],
                                                          controller: dept,
                                                          excludeSelected: true,
                                                          onChanged: (text) {
                                                            subDept.text = '';
                                                            oError = '';
                                                            if (dept.text ==
                                                                'Human Resource (HR)') {
                                                              subDepartments = [
                                                                'Training & Development',
                                                                'Recruitment',
                                                                'Payroll',
                                                                'Office Management',
                                                              ];
                                                              setState(() {});
                                                            } else if (dept
                                                                    .text ==
                                                                'Operations') {
                                                              subDepartments = [
                                                                'Strategy & Planning',
                                                                'Quality Control',
                                                                'Product Design',
                                                              ];
                                                              setState(() {});
                                                            } else if (dept
                                                                    .text ==
                                                                'Sales & Marketing') {
                                                              subDepartments = [
                                                                'Sales',
                                                                'Advertising & Media',
                                                                'Sales Promotion',
                                                                'Market Research',
                                                                'Public Relations',
                                                              ];
                                                              setState(() {});
                                                            } else if (dept
                                                                    .text ==
                                                                'IT') {
                                                              subDepartments = [
                                                                'Planning',
                                                                'Application Development',
                                                                'Web Development',
                                                                'Application Management',
                                                                'Business Intelligence',
                                                                'IT Management & Administration',
                                                                'IT Security',
                                                                'Network Administration',
                                                                'User Support & Services',
                                                              ];
                                                              setState(() {});
                                                            } else if (dept
                                                                    .text ==
                                                                'Accounts & Finance') {
                                                              subDepartments = [
                                                                'Accounting Department',
                                                                'Cost Accounts Department',
                                                                'Audit Department',
                                                                'Financial Planning & Budgeting Department',
                                                                'Cash Department',
                                                                'Credit Department',
                                                              ];
                                                              setState(() {});
                                                            } else {
                                                              subDepartments = [
                                                                'Market Research',
                                                                'Innovations',
                                                                'Quality Control',
                                                                'Product Research & Development',
                                                                'Cash Department',
                                                                'Credit Department',
                                                              ];

                                                              setState(() {});
                                                            }
                                                          },
                                                        ),
                                                        Divider(
                                                          color: Colors.grey,
                                                          thickness: 2,
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              SizedBox(
                                                width: 10,
                                              ),
                                              Expanded(
                                                child: Container(
                                                  height: 60,
                                                  child: Padding(
                                                    padding:
                                                        EdgeInsets.fromLTRB(
                                                            16, 0, 0, 0),
                                                    child: Column(
                                                      children: [
                                                        CustomDropdown.search(
                                                          hintText:
                                                              'Sub Department',
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
                                                                  fontSize: 15),
                                                          items: subDepartments,
                                                          controller: subDept,
                                                          excludeSelected: true,
                                                          onChanged: (text) {
                                                            subDept.text = text;
                                                            oError = '';
                                                            setState(() {});
                                                          },
                                                        ),
                                                        Divider(
                                                          color: Colors.grey,
                                                          thickness: 2,
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              SizedBox(
                                                width: 10,
                                              ),
                                              Expanded(
                                                child: Container(
                                                  height: 60,
                                                  child: Padding(
                                                    padding:
                                                        EdgeInsets.fromLTRB(
                                                            16, 0, 0, 0),
                                                    child: TextFormField(
                                                      controller: designation,
                                                      readOnly: personalDataReadOnly,
                                                      obscureText: false,
                                                      onChanged: (str) {
                                                        oError = '';
                                                        setState(() {});
                                                      },
                                                      decoration:
                                                          InputDecoration(
                                                        labelText:
                                                            'Designation',
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
                                                                fontSize: 15),

                                                        // hintText: 'Please Enter Name',
                                                        // hintStyle: FlutterFlowTheme.bodyText2.override(
                                                        //     fontFamily: 'Montserrat',
                                                        //     color: Colors.black,
                                                        //     fontWeight: FontWeight.w500,
                                                        //     fontSize: 12),
                                                        enabledBorder:
                                                            UnderlineInputBorder(
                                                          borderSide:
                                                              BorderSide(
                                                            color: Colors.grey,
                                                            width: 2,
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
                                                            color: Colors.blue,
                                                            width: 2,
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
                                                              color:
                                                                  Colors.black,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                              fontSize: 13),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Expanded(
                                                child: Container(
                                                  height: 60,
                                                  child: Padding(
                                                    padding:
                                                        EdgeInsets.fromLTRB(
                                                            16, 0, 0, 0),
                                                    child: SearchField(
                                                      suggestions: empNamesLocal,
                                                      controller:
                                                          reportingManager,
                                                      searchStyle: TextStyle(
                                                        fontSize: 18,
                                                        color: Colors.black
                                                            .withOpacity(0.8),
                                                      ),
                                                      searchInputDecoration:
                                                          InputDecoration(
                                                        labelText:
                                                            'Reporting Manager',
                                                        labelStyle:
                                                            FlutterFlowTheme
                                                                .bodyText2
                                                                .override(
                                                          fontFamily:
                                                              'Montserrat',
                                                          color: Colors.black,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          fontSize: 12,
                                                        ),
                                                        enabledBorder:
                                                            UnderlineInputBorder(
                                                          borderSide:
                                                              BorderSide(
                                                            color: Colors.grey,
                                                            width: 2,
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
                                                            color: Colors.blue,
                                                            width: 2,
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
                                                      onSuggestionTap: (x) {
                                                        reportingManager.text =
                                                            x.searchKey;
                                                        oError = '';

                                                        setState(() {
                                                        });
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
                                                  height: 60,
                                                  child: Padding(
                                                    padding:
                                                        EdgeInsets.fromLTRB(
                                                            16, 0, 0, 0),
                                                    child: SearchField(
                                                      suggestions: empNamesLocal,
                                                      controller: teamLead,
                                                      searchStyle: TextStyle(
                                                        fontSize: 18,
                                                        color: Colors.black
                                                            .withOpacity(0.8),
                                                      ),
                                                      searchInputDecoration:
                                                          InputDecoration(
                                                        labelText:
                                                            'Team Leader',
                                                        labelStyle:
                                                            FlutterFlowTheme
                                                                .bodyText2
                                                                .override(
                                                          fontFamily:
                                                              'Montserrat',
                                                          color: Colors.black,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          fontSize: 12,
                                                        ),
                                                        enabledBorder:
                                                            UnderlineInputBorder(
                                                          borderSide:
                                                              BorderSide(
                                                            color: Colors.grey,
                                                            width: 2,
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
                                                            color: Colors.blue,
                                                            width: 2,
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
                                                      onSuggestionTap: (x) {
                                                        teamLead.text = x.searchKey;
                                                        oError = '';

                                                        setState(() {
                                                        });
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
                                                  height: 60,
                                                  child: Padding(
                                                    padding:
                                                        EdgeInsets.fromLTRB(
                                                            16, 0, 0, 0),
                                                    child: Column(
                                                      children: [
                                                        CustomDropdown(
                                                          hintText:
                                                              'Employee Type',
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
                                                                  fontSize: 15),
                                                          items: [
                                                            'Full Time',
                                                            'Part Time',
                                                            'Temporary',
                                                            'Intern',
                                                            'Seasonal',
                                                          ],
                                                          controller: empType,
                                                          excludeSelected: true,
                                                          onChanged: (text) {
                                                            empType.text = text;

                                                            setState(() {});
                                                          },
                                                        ),
                                                        Divider(
                                                          color: Colors.grey,
                                                          thickness: 2,
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Expanded(
                                                child: Container(
                                                  height: 50,
                                                  child: Padding(
                                                    padding:
                                                        EdgeInsets.fromLTRB(
                                                            16, 0, 0, 0),
                                                    child: TextFormField(
                                                      controller:
                                                          probationPeriod,
                                                      readOnly: personalDataReadOnly,
                                                      obscureText: false,
                                                      autovalidateMode:
                                                          AutovalidateMode
                                                              .onUserInteraction,
                                                      validator: (v) {
                                                        if (!numberValidation
                                                            .hasMatch(v!)) {
                                                          return "Insert Only Number";
                                                        } else {
                                                          return null;
                                                        }
                                                      },
                                                      onChanged: (str) {
                                                        oError = '';
                                                        try {
                                                          probation =
                                                              int.tryParse(
                                                                  probationPeriod
                                                                      .text)!;
                                                        } catch (err) {
                                                          showSnackbar(context,
                                                              'Input is not in a correct format');
                                                        }
                                                        setState(() {});
                                                      },
                                                      decoration:
                                                          InputDecoration(
                                                        suffixIcon: Column(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          children: [
                                                            InkWell(
                                                                onTap: () {
                                                                  try {
                                                                    probation =
                                                                        int.tryParse(
                                                                            probationPeriod.text)!;
                                                                    probation++;
                                                                    probationPeriod
                                                                            .text =
                                                                        probation
                                                                            .toString();
                                                                  } catch (err) {
                                                                    showSnackbar(
                                                                        context,
                                                                        'Input is not in a correct format');
                                                                  }
                                                                },
                                                                child: Icon(
                                                                  Icons
                                                                      .keyboard_arrow_up_outlined,
                                                                  color: Colors
                                                                      .black,
                                                                  size: 20,
                                                                )),
                                                            InkWell(
                                                                onTap: () {
                                                                  try {
                                                                    probation =
                                                                        int.tryParse(
                                                                            probationPeriod.text)!;
                                                                    probation--;
                                                                    probationPeriod
                                                                            .text =
                                                                        probation
                                                                            .toString();
                                                                  } catch (err) {
                                                                    showSnackbar(
                                                                        context,
                                                                        'Input is not in a correct format');
                                                                  }
                                                                },
                                                                child: Icon(
                                                                  Icons
                                                                      .keyboard_arrow_down_outlined,
                                                                  color: Colors
                                                                      .black,
                                                                  size: 20,
                                                                ))
                                                          ],
                                                        ),

                                                        labelText:
                                                            'Probation Period',
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
                                                                fontSize: 15),

                                                        // hintText: 'Please Enter Name',
                                                        // hintStyle: FlutterFlowTheme.bodyText2.override(
                                                        //     fontFamily: 'Montserrat',
                                                        //     color: Colors.black,
                                                        //     fontWeight: FontWeight.w500,
                                                        //     fontSize: 12),
                                                        enabledBorder:
                                                            UnderlineInputBorder(
                                                          borderSide:
                                                              BorderSide(
                                                            color: Colors.grey,
                                                            width: 2,
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
                                                            color: Colors.blue,
                                                            width: 2,
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
                                                              color:
                                                                  Colors.black,
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
                                              !preRegistered
                                                  ? Expanded(
                                                      child: Container(
                                                        height: 50,
                                                        child: Padding(
                                                          padding: EdgeInsets
                                                              .fromLTRB(
                                                                  16, 0, 0, 0),
                                                          child: TextFormField(
                                                            controller:
                                                                dateOfJoining,
                                                            readOnly: personalDataReadOnly,
                                                            obscureText: false,
                                                            onTap: () {
                                                              showDatePicker(
                                                                      context:
                                                                          context,
                                                                      initialDate:
                                                                          DateTime
                                                                              .now(),
                                                                      locale: Locale(
                                                                          'en',
                                                                          'IN'),
                                                                      firstDate: DateTime(
                                                                          DateTime.now().year -
                                                                              100,
                                                                          1,
                                                                          1),
                                                                      lastDate: DateTime(
                                                                          DateTime.now().year +
                                                                              100,
                                                                          12,
                                                                          31,
                                                                          23,
                                                                          59,
                                                                          59))
                                                                  .then(
                                                                      (value) {
                                                                setState(() {
                                                                  joinedDate =
                                                                      value;
                                                                  dateOfJoining
                                                                      .text = dateTimeFormat(
                                                                          'dd-MM-yyyy',
                                                                          value!)
                                                                      .toString();
                                                                });
                                                              });
                                                            },
                                                            onChanged: (v) {
                                                              if (dateOfJoining
                                                                      .text ==
                                                                  '') {
                                                                joinedDate =
                                                                    null;
                                                              }
                                                              oError = '';
                                                              setState(() {});
                                                            },
                                                            decoration:
                                                                InputDecoration(
                                                              labelText:
                                                                  'Date Of Joining',
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
                                                                          15),

                                                              // hintText: 'Please Enter Name',
                                                              // hintStyle: FlutterFlowTheme.bodyText2.override(
                                                              //     fontFamily: 'Montserrat',
                                                              //     color: Colors.black,
                                                              //     fontWeight: FontWeight.w500,
                                                              //     fontSize: 12),
                                                              enabledBorder:
                                                                  UnderlineInputBorder(
                                                                borderSide:
                                                                    BorderSide(
                                                                  color: Colors
                                                                      .grey,
                                                                  width: 2,
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
                                                                      .blue,
                                                                  width: 2,
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
                                                    )
                                                  : Spacer(),
                                              SizedBox(
                                                width: 10,
                                              ),
                                              Expanded(
                                                child: Container(
                                                  height: 60,
                                                ),
                                              ),
                                            ],
                                          ),
                                          SizedBox(
                                            height: 30,
                                          ),
                                          Padding(
                                            padding:
                                                EdgeInsets.all(width * 0.01),
                                            child: Divider(
                                              height: 1,
                                              color: Colors.grey,
                                              thickness: 1,
                                            ),
                                          ),
                                          SizedBox(
                                            height: 20,
                                          ),
                                          Padding(
                                            padding:
                                                EdgeInsets.all(width * 0.01),
                                            child: Text('SALARY DETAILS'),
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Expanded(
                                                child: Container(
                                                  height: 60,
                                                  child: Padding(
                                                    padding:
                                                        EdgeInsets.fromLTRB(
                                                            16, 0, 0, 0),
                                                    child: TextFormField(
                                                      controller: ctc,
                                                      obscureText: false,
                                                      readOnly: personalDataReadOnly,
                                                      onChanged: (str) {
                                                        oError = '';
                                                        setState(() {});
                                                      },
                                                      autovalidateMode:
                                                          AutovalidateMode
                                                              .onUserInteraction,
                                                      validator: (v) {
                                                        if (!numberValidation
                                                            .hasMatch(v!)) {
                                                          return "Insert Only Number";
                                                        } else {
                                                          return null;
                                                        }
                                                      },
                                                      decoration:
                                                          InputDecoration(
                                                        labelText: 'CTC',
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
                                                                fontSize: 15),

                                                        // hintText: 'Please Enter Name',
                                                        // hintStyle: FlutterFlowTheme.bodyText2.override(
                                                        //     fontFamily: 'Montserrat',
                                                        //     color: Colors.black,
                                                        //     fontWeight: FontWeight.w500,
                                                        //     fontSize: 12),
                                                        enabledBorder:
                                                            UnderlineInputBorder(
                                                          borderSide:
                                                              BorderSide(
                                                            color: Colors.grey,
                                                            width: 2,
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
                                                            color: Colors.blue,
                                                            width: 2,
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
                                                              color:
                                                                  Colors.black,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                              fontSize: 13),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Expanded(
                                                child: Container(
                                                  height: 60,
                                                  child: Padding(
                                                    padding:
                                                        EdgeInsets.fromLTRB(
                                                            16, 0, 0, 0),
                                                    child: TextFormField(
                                                      controller: holderName,
                                                      readOnly: personalDataReadOnly,
                                                      obscureText: false,
                                                      onChanged: (str) {
                                                        oError = '';
                                                        setState(() {});
                                                      },
                                                      decoration:
                                                          InputDecoration(
                                                        labelText:
                                                            "Account Holder's Name",
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
                                                                fontSize: 15),

                                                        // hintText: 'Please Enter Name',
                                                        // hintStyle: FlutterFlowTheme.bodyText2.override(
                                                        //     fontFamily: 'Montserrat',
                                                        //     color: Colors.black,
                                                        //     fontWeight: FontWeight.w500,
                                                        //     fontSize: 12),
                                                        enabledBorder:
                                                            UnderlineInputBorder(
                                                          borderSide:
                                                              BorderSide(
                                                            color: Colors.grey,
                                                            width: 2,
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
                                                            color: Colors.blue,
                                                            width: 2,
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
                                                              color:
                                                                  Colors.black,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                              fontSize: 13),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Expanded(
                                                child: Container(
                                                  height: 60,
                                                  child: Padding(
                                                    padding:
                                                        EdgeInsets.fromLTRB(
                                                            16, 0, 0, 0),
                                                    child: TextFormField(
                                                      controller: bankName,
                                                      readOnly: personalDataReadOnly,
                                                      obscureText: false,
                                                      onChanged: (str) {
                                                        oError = '';
                                                        setState(() {});
                                                      },
                                                      decoration:
                                                          InputDecoration(
                                                        labelText: 'Bank Name',
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
                                                                fontSize: 15),

                                                        // hintText: 'Please Enter Name',
                                                        // hintStyle: FlutterFlowTheme.bodyText2.override(
                                                        //     fontFamily: 'Montserrat',
                                                        //     color: Colors.black,
                                                        //     fontWeight: FontWeight.w500,
                                                        //     fontSize: 12),
                                                        enabledBorder:
                                                            UnderlineInputBorder(
                                                          borderSide:
                                                              BorderSide(
                                                            color: Colors.grey,
                                                            width: 2,
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
                                                            color: Colors.blue,
                                                            width: 2,
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
                                                              color:
                                                                  Colors.black,
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
                                                  height: 60,
                                                  child: Padding(
                                                    padding:
                                                        EdgeInsets.fromLTRB(
                                                            16, 0, 0, 0),
                                                    child: TextFormField(
                                                      controller: city,
                                                      readOnly: personalDataReadOnly,
                                                      obscureText: false,
                                                      onChanged: (str) {
                                                        oError = '';
                                                        setState(() {});
                                                      },
                                                      decoration:
                                                          InputDecoration(
                                                        labelText: 'City',
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
                                                                fontSize: 15),

                                                        // hintText: 'Please Enter Name',
                                                        // hintStyle: FlutterFlowTheme.bodyText2.override(
                                                        //     fontFamily: 'Montserrat',
                                                        //     color: Colors.black,
                                                        //     fontWeight: FontWeight.w500,
                                                        //     fontSize: 12),
                                                        enabledBorder:
                                                            UnderlineInputBorder(
                                                          borderSide:
                                                              BorderSide(
                                                            color: Colors.grey,
                                                            width: 2,
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
                                                            color: Colors.blue,
                                                            width: 2,
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
                                                              color:
                                                                  Colors.black,
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
                                                  height: 60,
                                                  child: Padding(
                                                    padding:
                                                        EdgeInsets.fromLTRB(
                                                            16, 0, 0, 0),
                                                    child: TextFormField(
                                                      controller: ifsc,
                                                      readOnly: personalDataReadOnly,
                                                      textCapitalization:
                                                          TextCapitalization
                                                              .characters,
                                                      // inputFormatters: [UpperCaseTextFormatter()],
                                                      onChanged: ((val) {
                                                        ifsc.value =
                                                            TextEditingValue(
                                                                text: val
                                                                    .toUpperCase(),
                                                                selection: ifsc
                                                                    .selection);
                                                        oError = '';
                                                        setState(() {});
                                                        //   
                                                        //   ifsc.text = val.toUpperCase();
                                                        //   // setState(() {});
                                                      }),
                                                      obscureText: false,
                                                      decoration:
                                                          InputDecoration(
                                                        labelText: 'IFSC',
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
                                                                fontSize: 15),

                                                        // hintText: 'Please Enter Name',
                                                        // hintStyle: FlutterFlowTheme.bodyText2.override(
                                                        //     fontFamily: 'Montserrat',
                                                        //     color: Colors.black,
                                                        //     fontWeight: FontWeight.w500,
                                                        //     fontSize: 12),
                                                        enabledBorder:
                                                            UnderlineInputBorder(
                                                          borderSide:
                                                              BorderSide(
                                                            color: Colors.grey,
                                                            width: 2,
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
                                                            color: Colors.blue,
                                                            width: 2,
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
                                                              color:
                                                                  Colors.black,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                              fontSize: 13),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Expanded(
                                                child: Container(
                                                  height: 60,
                                                  child: Padding(
                                                    padding:
                                                        EdgeInsets.fromLTRB(
                                                            16, 0, 0, 0),
                                                    child: TextFormField(
                                                      controller: branchName,
                                                      readOnly: personalDataReadOnly,
                                                      obscureText: false,
                                                      onChanged: (str) {
                                                        oError = '';
                                                        setState(() {});
                                                      },
                                                      decoration:
                                                          InputDecoration(
                                                        labelText:
                                                            'Branch Name',
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
                                                                fontSize: 15),

                                                        // hintText: 'Please Enter Name',
                                                        // hintStyle: FlutterFlowTheme.bodyText2.override(
                                                        //     fontFamily: 'Montserrat',
                                                        //     color: Colors.black,
                                                        //     fontWeight: FontWeight.w500,
                                                        //     fontSize: 12),
                                                        enabledBorder:
                                                            UnderlineInputBorder(
                                                          borderSide:
                                                              BorderSide(
                                                            color: Colors.grey,
                                                            width: 2,
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
                                                            color: Colors.blue,
                                                            width: 2,
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
                                                              color:
                                                                  Colors.black,
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
                                                  height: 60,
                                                  child: Padding(
                                                    padding:
                                                        EdgeInsets.fromLTRB(
                                                            16, 0, 0, 0),
                                                    child: TextFormField(
                                                      controller: accountNumber,
                                                      readOnly: personalDataReadOnly,
                                                      obscureText: false,
                                                      onChanged: (str) {
                                                        oError = '';
                                                        setState(() {});
                                                      },
                                                      decoration:
                                                          InputDecoration(
                                                        labelText:
                                                            'Account Number',
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
                                                                fontSize: 15),

                                                        // hintText: 'Please Enter Name',
                                                        // hintStyle: FlutterFlowTheme.bodyText2.override(
                                                        //     fontFamily: 'Montserrat',
                                                        //     color: Colors.black,
                                                        //     fontWeight: FontWeight.w500,
                                                        //     fontSize: 12),
                                                        enabledBorder:
                                                            UnderlineInputBorder(
                                                          borderSide:
                                                              BorderSide(
                                                            color: Colors.grey,
                                                            width: 2,
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
                                                            color: Colors.blue,
                                                            width: 2,
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
                                                              color:
                                                                  Colors.black,
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
                                                  height: 60,
                                                  child: Padding(
                                                    padding:
                                                        EdgeInsets.fromLTRB(
                                                            16, 0, 0, 0),
                                                    child: TextFormField(
                                                      controller:
                                                          confirmAccountNumber,
                                                      readOnly: personalDataReadOnly,
                                                      obscureText: false,
                                                      onChanged: (str) {
                                                        oError = '';
                                                        setState(() {});
                                                      },
                                                      decoration:
                                                          InputDecoration(
                                                        labelText:
                                                            'Confirm Account Number',
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
                                                                fontSize: 15),

                                                        // hintText: 'Please Enter Name',
                                                        // hintStyle: FlutterFlowTheme.bodyText2.override(
                                                        //     fontFamily: 'Montserrat',
                                                        //     color: Colors.black,
                                                        //     fontWeight: FontWeight.w500,
                                                        //     fontSize: 12),
                                                        enabledBorder:
                                                            UnderlineInputBorder(
                                                          borderSide:
                                                              BorderSide(
                                                            color: Colors.grey,
                                                            width: 2,
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
                                                            color: Colors.blue,
                                                            width: 2,
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
                                                              color:
                                                                  Colors.black,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                              fontSize: 13),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                          SizedBox(
                                            height: 40,
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                '$oError',
                                                style: TextStyle(
                                                    color: Colors.red),
                                              ),
                                              Row(
                                                children: [
                                                  GestureDetector(
                                                    onTap: () {
                                                      tabIndex = 0;
                                                      setState(() {});
                                                    },
                                                    child: MouseRegion(
                                                      cursor: SystemMouseCursors
                                                          .click,
                                                      onEnter: (v) {
                                                        cancelHover = true;
                                                        setState(() {});
                                                      },
                                                      onExit: (v) {
                                                        cancelHover = false;
                                                        setState(() {});
                                                      },
                                                      child: Material(
                                                        color:
                                                            Colors.transparent,
                                                        elevation: cancelHover
                                                            ? 10
                                                            : 0,
                                                        child: Container(
                                                          width: 100,
                                                          height: 30,
                                                          color: Colors.white,
                                                          child: Center(
                                                            child: Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .center,
                                                              children: [
                                                                Icon(Icons
                                                                    .arrow_back_outlined),
                                                                SizedBox(
                                                                  width: 10,
                                                                ),
                                                                Text('BACK'),
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    width: 20,
                                                  ),
                                                  GestureDetector(
                                                    onTap: () {
                                                      if (dob != null &&
                                                          gender != '' &&
                                                          dept.text != '' &&
                                                          subDept.text != '' &&
                                                          designation.text !=
                                                              '' &&
                                                          reportingManager.text !=
                                                              '' &&
                                                          // teamLead.text != '' &&
                                                          empType.text != '' &&
                                                          joinedDate != null &&
                                                          ctc.text != '' &&
                                                          holderName.text !=
                                                              '' &&
                                                          bankName.text != '' &&
                                                          city.text != '' &&
                                                          ifsc.text != '' &&
                                                          branchName.text !=
                                                              '' &&
                                                          accountNumber.text !=
                                                              '' &&
                                                          (confirmAccountNumber
                                                                  .text ==
                                                              accountNumber
                                                                  .text)) {
                                                        final data = EmployeeModel(
                                                            name: name.text
                                                                .toUpperCase(),
                                                            phone: phone.text,
                                                            email: email.text,
                                                            gender: gender,
                                                            dob: dob,
                                                            accountHolderName:
                                                                holderName.text,
                                                            accountNumber:
                                                                accountNumber
                                                                    .text,
                                                            bankName:
                                                                bankName.text,
                                                            branchName:
                                                                branchName.text,
                                                            city: city.text,
                                                            ctc: ctc.text,
                                                            dept: dept.text,
                                                            designation:
                                                                designation
                                                                    .text,
                                                            empType:
                                                                empType.text,

                                                            ifsc: ifsc.text,
                                                            joinedDate:
                                                                joinedDate,
                                                            probation:
                                                                probation,
                                                            reportingManager:
                                                                empIdByName[
                                                                    reportingManager
                                                                        .text],
                                                            teamLead: empIdByName[
                                                                teamLead.text],
                                                            profile: profile,
                                                            subDept:
                                                                subDept.text,
                                                            delete: false,
                                                            empId: employeeId,
                                                            createdDate:
                                                                createdDate,
                                                            pan: pan.text);

                                                        FirebaseFirestore
                                                            .instance
                                                            .collection(
                                                                'employees')
                                                            .doc(employeeId)
                                                            .update(
                                                                data.toJson())
                                                            .then((value) {
                                                          setState(() {
                                                            widget
                                                                ._tabController
                                                                .animateTo(6);
                                                            showSnackbar(
                                                                context,
                                                                'Employee Details Updated.');
                                                          });
                                                        });
                                                      } else {
                                                        dob == null
                                                            ? oError =
                                                                '* Must Choose Date Of Birth '
                                                            : gender == ''
                                                                ? oError =
                                                                    '* Must Choose a Gender'
                                                                : dept.text ==
                                                                        ''
                                                                    ? oError =
                                                                        '* Must Choose a Department'
                                                                    : subDept.text ==
                                                                            ''
                                                                        ? oError =
                                                                            '* Must Choose a Sub Department'
                                                                        : designation.text ==
                                                                                ''
                                                                            ? oError =
                                                                                '* Must Provide Employee Designation'
                                                                            : reportingManager.text == ''
                                                                                ? oError = '* Must Provide a Reporting Manager'
                                                                                :
                                                                                // :teamLead
                                                                                //         .text ==
                                                                                //     ''
                                                                                // ? oError =
                                                                                //     '* Must Provide a Team Lead Name'
                                                                                // :
                                                                                empType.text == ''
                                                                                    ? oError = '* Must Choose a Employee Type'
                                                                                    : joinedDate == null
                                                                                        ? oError = '* Must Choose Employee Joined Date'
                                                                                        : ctc.text == ''
                                                                                            ? oError = '* Must Provide a Cost To Company'
                                                                                            : holderName.text == ''
                                                                                                ? oError = '* Must Provide  Account Holder Name'
                                                                                                : bankName.text == ''
                                                                                                    ? oError = '* Must Provide Bank Name'
                                                                                                    : city.text == ''
                                                                                                        ? oError = '* Must Provide  City of Bank'
                                                                                                        : ifsc.text == ''
                                                                                                            ? oError = '* Must Provide  IFSC Code'
                                                                                                            : branchName.text == ''
                                                                                                                ? oError = '* Must Provide  Bank Branch Name'
                                                                                                                : accountNumber.text == ''
                                                                                                                    ? oError = '* Must Provide  Account Number'
                                                                                                                    : oError = '* Confirm Account Number is same as Account Number';
                                                      }
                                                    },
                                                    child: MouseRegion(
                                                      cursor: SystemMouseCursors
                                                          .click,
                                                      onEnter: (v) {
                                                        submitHover = true;
                                                        setState(() {});
                                                      },
                                                      onExit: (v) {
                                                        submitHover = false;
                                                        setState(() {});
                                                      },
                                                      child: Material(
                                                        color:
                                                            Colors.transparent,
                                                        elevation: submitHover
                                                            ? 10
                                                            : 0,
                                                        child: Container(
                                                          width: 100,
                                                          height: 30,
                                                          color:
                                                              Colors.blueAccent,
                                                          child: Center(
                                                            child: Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .center,
                                                              children: [
                                                                Icon(
                                                                  Icons.done,
                                                                  color: Colors
                                                                      .white,
                                                                ),
                                                                SizedBox(
                                                                  width: 10,
                                                                ),
                                                                Text(
                                                                  'SAVE',
                                                                  style:
                                                                      TextStyle(
                                                                    color: Colors
                                                                        .white,
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              )
                            : Padding(
                                padding: EdgeInsets.only(
                                    top: height * 0.2, bottom: height * 0.2),
                                child: Material(
                                  elevation: 10,
                                  child: Container(
                                    width: width * 0.6,
                                    // height: height * 0.75,
                                    color: Colors.white,
                                    child: Padding(
                                      padding: EdgeInsets.all(width * 0.01),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding:
                                                EdgeInsets.all(width * 0.005),
                                            child: Text('Compose Mail',
                                              style:TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold
                                              ),),
                                          ),

                                          /// MAIL SUBJECT
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
                                                        color:
                                                            Color(0xFFE6E6E6),
                                                      ),
                                                    ),
                                                    child: Padding(
                                                      padding:
                                                          EdgeInsets.fromLTRB(
                                                              16, 0, 0, 0),
                                                      child: TextFormField(
                                                        controller: subject,
                                                        readOnly: personalDataReadOnly,
                                                        obscureText: false,
                                                        decoration:
                                                            InputDecoration(
                                                          labelText: 'Subject',
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
                                                              'Please Enter Mail Subject',
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
                                              ],
                                            ),
                                          ),

                                          ///MAIL BODY
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
                                                    height: 450,
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
                                                        controller: bodyOfMail,
                                                        obscureText: false,
                                                        maxLines: 100,
                                                        textAlign: TextAlign.start,

                                                        decoration:
                                                            InputDecoration(
                                                          labelText:
                                                              'Body',
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
                                                              'Enter Body of your E-Mail',
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
                                            padding: const EdgeInsets.all(8.0),
                                            child: GridView.builder(
                                              shrinkWrap: true,
                                              itemCount: attachments.length+1,
                                              gridDelegate:
                                                  SliverGridDelegateWithFixedCrossAxisCount(
                                                crossAxisCount: 5,
                                                // childAspectRatio: 1,
                                              ),
                                              itemBuilder:
                                                  (BuildContext context,
                                                      int index) {
                                                return index ==
                                                        attachments.length
                                                    ? Padding(
                                                      padding: const EdgeInsets.all(8.0),
                                                      child: InkWell(
                                                          onTap: () {
                                                            selectFileToUpload(
                                                                context, 'mail');
                                                          },
                                                          child: Container(
                                                            height: 200,
                                                            width: 200,
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
                                                            child:
                                                                Icon(Icons.add),
                                                          ),
                                                        ),
                                                    )
                                                    : Padding(
                                                      padding: const EdgeInsets.all(8.0),
                                                      child: InkWell(
                                                        onLongPress: ()async{
                                                          bool pressed= await alert(context,'Do you want to remove this file ?');

                                                          if(pressed){
                                                            attachments.removeAt(index);
                                                            setState(() {

                                                            });
                                                          }
                                                        },
                                                        child: Container(
                                                            height: 200,
                                                            width: 200,
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
                                                            child: Column(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .spaceBetween,
                                                              children: [
                                                                Container(
                                                                  height: 160,
                                                                  width: 200,
                                                                  decoration:
                                                                      BoxDecoration(
                                                                    color: Colors
                                                                        .white,
                                                                    borderRadius:
                                                                        BorderRadius
                                                                            .circular(
                                                                                8),
                                                                    border:
                                                                        Border.all(
                                                                      color: Color(
                                                                          0xFFE6E6E6),
                                                                    ),
                                                                  ),
                                                                  child: Icon(Icons
                                                                      .file_present_outlined),
                                                                ),
                                                                Center(
                                                                  child: Text(
                                                                      attachments[
                                                                          index]['filename'],overflow: TextOverflow.fade,),
                                                                )
                                                              ],
                                                            ),
                                                          ),
                                                      ),
                                                    );
                                              },
                                            ),
                                          ),

                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            children: [

                                              Row(
                                                children: [

                                                  GestureDetector(
                                                    onTap: () {
                                                      String html = '<html>'
                                                          '<head>'
                                                          '<meta name="viewport" content="width=device-width, initial-scale=1">'
                                                          '<link href="https://fonts.googleapis.com/css2?family=Gotham:wght@400;700&display=swap" rel="stylesheet">'
                                                          '<style>'
                                                          'body {'
                                                          'font-family: "Gotham", sans-serif;'
                                                          '}'
                                                          '.header {'
                                                          'background-color: #0058ff;'
                                                          'color: #fff;'
                                                          'text-align: center;'
                                                          'padding: 10px;'
                                                          'display: flex;'
                                                          'align-items: center;'
                                                          ' }'
                                                          '.header img {'
                                                          ' margin-right: 20px;'
                                                          '}'
                                                          '.container {'
                                                          'width: 80%;'
                                                          'margin: 0 auto;'
                                                          'background-color: #f2f2f2;'
                                                          'padding: 20px;'
                                                          ' }'
                                                          'table {'
                                                          'width: 100%;'
                                                          'border-collapse: collapse;'
                                                          'margin-top: 20px;'
                                                          '}'
                                                          'th,'
                                                          'td {'
                                                          'border: 1px solid #333;'
                                                          'padding: 10px;'
                                                          '}'
                                                          'th {'
                                                          'background-color: #0058ff;'
                                                          ' color: #fff;'
                                                          '}'
                                                          '@media (max-width: 767px) {'
                                                          '.container {'
                                                          'width: 90%;'
                                                          '}'
                                                          'th,'
                                                          'td {'
                                                          'font-size: 14px;'
                                                          ' }'
                                                          ' }'
                                                          '</style>'
                                                          ' </head>'
                                                          '<body>'
                                                          '<div class="header">'
                                                          ' <img src="https://firebasestorage.googleapis.com/v0/b/first-logic-erp.appspot.com/o/webicon-01.png?alt=media&token=424afef7-b36f-47e0-aa12-ec5dd178085b" style="width:50px;height:50px;" alt="Company Logo" />'
                                                          '<h3>First Logic Meta Lab Pvt. Ltd</h3>'
                                                          '</div>'
                                                          '<div class="container">'
                                                          '<p>'+
                                                      bodyOfMail.text +
                                                          '</p>'
                                                          
                                                          '</div>'
                                                          ' </body>'
                                                          '</html>';

                                                      FirebaseFirestore.instance.collection('mail').add({
                                                        'html': html,
                                                        'status': subject.text,
                                                        'att': attachments[0],
                                                        'emailList': [employeeDetails!.email],
                                                        'date':FieldValue.serverTimestamp()
                                                      });
                                                    },
                                                    child: MouseRegion(
                                                      cursor: SystemMouseCursors
                                                          .click,
                                                      onEnter: (v) {
                                                        submitHover = true;
                                                        setState(() {});
                                                      },
                                                      onExit: (v) {
                                                        submitHover = false;
                                                        setState(() {});
                                                      },
                                                      child: Material(
                                                        color:
                                                            Colors.transparent,
                                                        elevation: submitHover
                                                            ? 10
                                                            : 0,
                                                        child: Container(
                                                          width: 120,
                                                          height: 30,
                                                          color:
                                                              Colors.blueAccent,
                                                          child: Center(
                                                            child: Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .center,
                                                              children: [
                                                                Icon(
                                                                  Icons.send,
                                                                  color: Colors
                                                                      .white,
                                                                ),
                                                                SizedBox(
                                                                  width: 10,
                                                                ),
                                                                Text(
                                                                  'SEND MAIL',
                                                                  style:
                                                                      TextStyle(
                                                                    color: Colors
                                                                        .white,
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                  ),
                ],
              ),
            ),
    );
  }

  //PICK FILE
  Future selectFileToUpload(BuildContext context, String type) async {
    final result = await FilePicker.platform.pickFiles();
    if (result == null) return;

    pickFile = result.files.first;
    String name = pickFile!.name;

    String ext = pickFile!.name.split('.').last;
    final fileBytes = result.files.first.bytes;

    showUploadMessage(context, 'Uploading...', showLoading: true);

    uploadFileToFireBase(name, fileBytes, ext, context, type);

    setState(() {});
  }

  //UPDATE DOCUMENT DATE
  Future uploadFileToFireBase(String name, fileBytes, String ext,
      BuildContext context, String type) async {
    String ref = '';
    String urlDownload = '';
    if (type == 'mail') {
      ref =
          'employees/mailDocs/Single/${employeeDetails!.empId}-${employeeDetails!.name}-$name.$ext';
    } else {
      ref =
          'profiles/employees/${employeeDetails!.empId}-${employeeDetails!.name}-$name.$ext';
    }
    uploadTask = FirebaseStorage.instance.ref(ref).putData(fileBytes);
    final snapshot = await uploadTask!.whenComplete(() {});
    urlDownload = await snapshot.ref.getDownloadURL();

    showUploadMessage(context, '$name Uploaded Successfully...');
    setState(() {
      if (type == 'mail') {
        attachments.add({
        'filename':name,
        'path':urlDownload,
        });
      } else {
        profile = urlDownload;
      }
    });
  }
}
