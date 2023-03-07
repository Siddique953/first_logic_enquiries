import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../../../auth/auth_util.dart';
import '../../../flutter_flow/flutter_flow_icon_button.dart';
import '../../../flutter_flow/flutter_flow_theme.dart';
import '../../../flutter_flow/flutter_flow_widgets.dart';
import '../../../flutter_flow/upload_media.dart';
import '../../app_widget.dart';
import '../../pages/home_page/components/side_menu.dart';
import '../../pages/home_page/home.dart';
import 'customer_SinglePage.dart';

class CreateProject extends StatefulWidget {
  final String id;
  const CreateProject({Key key, this.id}) : super(key: key);

  @override
  State<CreateProject> createState() => _CreateProjectState();
}

class _CreateProjectState extends State<CreateProject> {
  TextEditingController selectedProjectType;
  TextEditingController projectName;
  TextEditingController domain;
  TextEditingController deliverables;
  TextEditingController platform;
  TextEditingController additionalInfo;
  TextEditingController careOfNo;
  String selectedCountry;

  List projectDetails = [];

  Timestamp datePicked;
  DateTime selectedDate = DateTime.now();

  @override
  void initState() {
    super.initState();
    selectedProjectType = TextEditingController();
    projectName = TextEditingController();
    domain = TextEditingController();
    deliverables = TextEditingController();
    platform = TextEditingController();
    additionalInfo = TextEditingController();
    careOfNo = TextEditingController();
    print('////////////');
    print(widget.id);
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Center(child: Text('Create New Project')),
      content: Container(
        width: MediaQuery.of(context).size.width * 0.8,
        color: Colors.transparent,
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 25,
              ),

              //PROJECT DESC
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(30, 5, 30, 5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    InkWell(
                      onTap: () {
                        showDatePicker(
                                context: context,
                                initialDate: selectedDate,
                                locale: Locale('en', 'IN'),
                                firstDate: DateTime(1901, 1),
                                lastDate: DateTime(2100, 1))
                            .then((value) {
                          setState(() {
                            datePicked = Timestamp.fromDate(DateTime(
                                value.year, value.month, value.day, 0, 0, 0));

                            selectedDate = value;
                          });
                        });
                      },
                      child: Container(
                          width: MediaQuery.of(context).size.width * 0.1,
                          height: 40,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(
                              color: Colors.black,
                            ),
                          ),
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                    padding: const EdgeInsets.only(left: 10),
                                    child: Text(
                                      datePicked == null
                                          ? 'Choose Project Date'
                                          : datePicked
                                              .toDate()
                                              .toString()
                                              .substring(0, 10),
                                      style: TextStyle(
                                        fontFamily: 'Poppins',
                                        color: Colors.blue,
                                        fontSize: 13,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ))
                              ])),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Container(
                      width: 400,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                          color: Colors.black,
                        ),
                      ),
                      child: CustomDropdown.search(
                        hintText: 'Select project type',
                        hintStyle: TextStyle(color: Colors.black),
                        items: projectTypeList,
                        controller: selectedProjectType,
                        // excludeSelected: false,
                        onChanged: (text) {
                          setState(() {});
                        },
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
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                            color: Color(0xFFE6E6E6),
                          ),
                        ),
                        child: Padding(
                          padding: EdgeInsets.fromLTRB(16, 0, 0, 0),
                          child: TextFormField(
                            controller: projectName,
                            obscureText: false,
                            decoration: InputDecoration(
                              labelText: 'Project Name',
                              labelStyle: FlutterFlowTheme.bodyText2.override(
                                  fontFamily: 'Montserrat',
                                  color: Colors.black,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 12),
                              hintText: 'Please Enter Project Name',
                              hintStyle: FlutterFlowTheme.bodyText2.override(
                                  fontFamily: 'Montserrat',
                                  color: Colors.black,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 12),
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
                                color: Color(0xFF8B97A2),
                                fontWeight: FontWeight.w500,
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

              //ADD requirements
              Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(30, 5, 30, 5),
                  child: Row(
                    children: [
                      Expanded(
                        child: Container(
                          width: 350,
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
                            child: CustomDropdown.search(
                              hintText: 'Select domain',
                              hintStyle: TextStyle(color: Colors.black),
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
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(
                              color: Color(0xFFE6E6E6),
                            ),
                          ),
                          child: Padding(
                            padding: EdgeInsets.fromLTRB(16, 0, 0, 0),
                            child: TextFormField(
                              controller: deliverables,
                              obscureText: false,
                              decoration: InputDecoration(
                                labelText: 'Deliverables',
                                labelStyle: FlutterFlowTheme.bodyText2.override(
                                    fontFamily: 'Montserrat',
                                    color: Colors.black,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 12),
                                hintText: 'Please Enter Deliverable',
                                hintStyle: FlutterFlowTheme.bodyText2.override(
                                    fontFamily: 'Montserrat',
                                    color: Colors.black,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 12),
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
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(
                              color: Color(0xFFE6E6E6),
                            ),
                          ),
                          child: Padding(
                            padding: EdgeInsets.fromLTRB(16, 0, 0, 0),
                            child: CustomDropdown.search(
                              hintText: 'Select Platform',
                              hintStyle: TextStyle(color: Colors.black),
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
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(0, 0, 8, 0),
                        child: FFButtonWidget(
                          onPressed: () {
                            if (domain.text != '' &&
                                deliverables.text != '' &&
                                platform.text != '') {
                              projectDetails.add({
                                'domain': domain.text,
                                'deliverable': deliverables.text,
                                'platform': platform.text,
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
                                      context, 'Please Enter Domain')
                                  : deliverables.text == ''
                                      ? showUploadMessage(
                                          context, 'Please Enter Deliverable')
                                      : showUploadMessage(
                                          context, 'Please Enter Platform');
                            }
                          },
                          text: 'Add',
                          options: FFButtonOptions(
                            width: 80,
                            height: 40,
                            color: Color(0xff0054FF),
                            textStyle: FlutterFlowTheme.subtitle2.override(
                              fontFamily: 'Lexend Deca',
                              color: Colors.white,
                              fontSize: 13,
                              fontWeight: FontWeight.bold,
                            ),
                            elevation: 2,
                            borderSide: BorderSide(
                              color: Colors.transparent,
                              width: 1,
                            ),
                            borderRadius: 50,
                          ),
                        ),
                      )
                    ],
                  )),

              //REQUIREMENTS TABLE
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(30, 5, 30, 5),
                child: SizedBox(
                  width: double.infinity,
                  child: projectDetails.length == 0
                      ? Center(
                          child: Text(
                          'No Details Added...',
                          style: FlutterFlowTheme.bodyText2.override(
                              fontFamily: 'Montserrat',
                              color: Color(0xFF8B97A2),
                              fontWeight: FontWeight.bold,
                              fontSize: 13),
                        ))
                      : DataTable(
                          horizontalMargin: 12,
                          columns: [
                            DataColumn(
                              label: Text(
                                "Sl No",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 12),
                              ),
                            ),
                            DataColumn(
                              label: Text("Domain",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12)),
                            ),
                            DataColumn(
                              label: Text("Deliverable",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12)),
                            ),
                            DataColumn(
                              label: Text("PlatForm",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12)),
                            ),
                            DataColumn(
                              label: Text("",
                                  style:
                                      TextStyle(fontWeight: FontWeight.bold)),
                            ),
                          ],
                          rows: List.generate(
                            projectDetails.length,
                            (index) {
                              final history = projectDetails[index];

                              return DataRow(
                                color: index.isOdd
                                    ? MaterialStateProperty.all(Colors
                                        .blueGrey.shade50
                                        .withOpacity(0.7))
                                    : MaterialStateProperty.all(
                                        Colors.blueGrey.shade50),
                                cells: [
                                  DataCell(Text((index + 1).toString(),
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 12))),
                                  DataCell(Text(history['domain'],
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 12))),
                                  DataCell(Text(history['deliverable'],
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 12))),
                                  DataCell(Text(history['platform'],
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 12))),
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
                                            bool pressed = await alert(
                                                context, 'Do you want Delete');

                                            if (pressed) {
                                              projectDetails.removeAt(index);

                                              showUploadMessage(context,
                                                  'Details Deleted...');
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
              ),

              //PROJECT DESCRIPTION
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(30, 5, 30, 5),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Container(
                        width: 440,
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
                            controller: additionalInfo,
                            obscureText: false,
                            maxLines: 4,
                            decoration: InputDecoration(
                              labelText: 'Description',
                              labelStyle: FlutterFlowTheme.bodyText2.override(
                                  fontFamily: 'Montserrat',
                                  color: Colors.black,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 12),
                              hintText:
                                  'Enter Short description about the project',
                              hintStyle: FlutterFlowTheme.bodyText2.override(
                                  fontFamily: 'Montserrat',
                                  color: Colors.black,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 12),
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
                                color: Color(0xFF8B97A2),
                                fontWeight: FontWeight.w500,
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

              //ADD BUTTON
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(0, 24, 0, 44),
                child: FFButtonWidget(
                  onPressed: () async {
                    if (selectedProjectType.text != '' &&
                        projectName.text != '') {
                      bool pressed =
                          await alert(context, 'Create New Project...');
                      if (pressed) {
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
                          'customerId': 'C' +
                              currentbranchShortName +
                              projectNo.toString(),
                          'userId': currentUserUid,
                          'branchId': currentBranchId,
                        });

                        FirebaseFirestore.instance
                            .collection('projects')
                            .doc('P' +
                                currentbranchShortName +
                                projectNo.toString())
                            .set({
                          'date': datePicked == null
                              ? DateTime.now()
                              : datePicked.toDate(),
                          'status': 'Pending',
                          'branchId': currentBranchId,
                          'branch': currentbranchName,
                          'userId': currentUserUid,
                          'currentStatus': 'Registered',
                          'nextStatus': 'Document Collection',
                          'statusList': FieldValue.arrayUnion(statusList),
                          'description': additionalInfo.text,
                          'projectTopic': '',
                          'projectType': selectedProjectType.text,
                          'projectDetails': projectDetails,
                          'paymentDetails': [],
                          'projectCost': 0.00,
                          'totalPaid': 0.00,
                          'projectName': projectName.text,
                          'companyName': '',
                          'companyAddress': '',
                          'customerID': widget.id,
                          'projectId': 'P' +
                              currentbranchShortName +
                              projectNo.toString()
                        });
                        FirebaseFirestore.instance
                            .collection('customer')
                            .doc(widget.id)
                            .update({'projects': FieldValue.increment(1)});
                        showUploadMessage(context, 'New Project Created...');

                        subTabView = false;
                        Navigator.pop(context);
                      }
                    } else {
                      selectedProjectType.text == ''
                          ? showUploadMessage(
                              context, 'Please Select Project Type')
                          : showUploadMessage(
                              context, 'Please Enter Project Name ');
                    }
                  },
                  text: 'Create',
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
              SizedBox(
                height: 25,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
