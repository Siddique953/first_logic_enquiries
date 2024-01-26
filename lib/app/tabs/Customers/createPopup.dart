import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:searchfield/searchfield.dart';

import '../../../flutter_flow/flutter_flow_theme.dart';
import '../../../flutter_flow/flutter_flow_widgets.dart';
import '../../../flutter_flow/upload_media.dart';
import '../../app_widget.dart';
import '../../pages/home_page/home.dart';

class CreateNewPopup extends StatefulWidget {
  final GlobalKey<FormState> form;
  const CreateNewPopup({Key? key, required this.form}) : super(key: key);

  @override
  State<CreateNewPopup> createState() => _CreateNewPopupState();
}

class _CreateNewPopupState extends State<CreateNewPopup> {
  RegExp phnValidation = RegExp(r'^[0-9]{10}$');

  TextEditingController fullName = TextEditingController();
  TextEditingController mobile = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController whatsAppNo = TextEditingController();
  TextEditingController careOf = TextEditingController();
  TextEditingController careOfNo = TextEditingController();
  String selectedCountry = '';
  String countryDialCode = '';
  String countryShortName = '';
  List<SearchFieldListItem<String>> agentNumberListLocal=[];

  @override
  void initState() {
    agentNumberList.forEach((element) {
      agentNumberListLocal.add(
        SearchFieldListItem(element,)
      );
    });
    super.initState();
    fullName = TextEditingController();
    mobile = TextEditingController();
    email = TextEditingController();
    whatsAppNo = TextEditingController();
    careOf = TextEditingController();
    careOfNo = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Center(child: Text('Create New Customer')),
      content: Container(
        width: 600,
        color: Colors.transparent,
        child: Form(
          key: widget.form,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 25,
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
                            controller: fullName,
                            obscureText: false,
                            onChanged: ((v) {
                              // v = v.replaceAll(' ', '').toLowerCase();
                              // email.text = '$v@gmail.com';
                            }),
                            decoration: InputDecoration(
                              labelText: 'Name',
                              labelStyle: FlutterFlowTheme.bodyText2.override(
                                fontFamily: 'Montserrat',
                                color: Color(0xFF8B97A2),
                                fontWeight: FontWeight.w500,
                                fontSize: 12,
                              ),
                              hintText: 'Please Enter Customer Name',
                              hintStyle: FlutterFlowTheme.bodyText2.override(
                                fontFamily: 'Montserrat',
                                color: Color(0xFF8B97A2),
                                fontWeight: FontWeight.w500,
                                fontSize: 12,
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
                              color: Color(0xFF8B97A2),
                              fontWeight: FontWeight.w500,
                              fontSize: 12,
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
                        padding: EdgeInsets.fromLTRB(16, 0, 0, 0),
                        width: 100,
                        height: 60,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                            color: Color(0xFFE6E6E6),
                          ),
                        ),
                        child: IntlPhoneField(
                          controller: mobile,
                          onCountryChanged: (value) {
                            countryDialCode = value.dialCode;
                            countryShortName = value.code;
                          },
                          decoration: InputDecoration(
                            labelText: 'Phone Number',
                            labelStyle: FlutterFlowTheme.bodyText2.override(
                                fontFamily: 'Montserrat',
                                color: Color(0xFF8B97A2),
                                fontWeight: FontWeight.w500,
                                fontSize: 11),
                            hintText: 'Please Enter Phone Number',
                            hintStyle: FlutterFlowTheme.bodyText2.override(
                                fontFamily: 'Montserrat',
                                color: Color(0xFF8B97A2),
                                fontWeight: FontWeight.w500,
                                fontSize: 11),
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
                          initialCountryCode: 'IN',
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
                            controller: email,
                            obscureText: false,
                            // autovalidateMode:
                            //     AutovalidateMode.onUserInteraction,
                            // validator: (v) {
                            //   if (!v.contains('@')) {
                            //     return "Enter valid Email Address";
                            //   } else {
                            //     return null;
                            //   }
                            // },
                            decoration: InputDecoration(
                              labelText: 'Email',
                              labelStyle: FlutterFlowTheme.bodyText2.override(
                                fontFamily: 'Montserrat',
                                color: Color(0xFF8B97A2),
                                fontWeight: FontWeight.w500,
                                fontSize: 12,
                              ),
                              hintText: 'Please Enter Email Address',
                              hintStyle: FlutterFlowTheme.bodyText2.override(
                                fontFamily: 'Montserrat',
                                color: Color(0xFF8B97A2),
                                fontWeight: FontWeight.w500,
                                fontSize: 12,
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
                              color: Color(0xFF8B97A2),
                              fontWeight: FontWeight.w500,
                              fontSize: 12,
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
                            controller: whatsAppNo,
                            obscureText: false,
                            maxLength: 10,
                            // autovalidateMode:
                            //     AutovalidateMode.onUserInteraction,
                            // validator: (v) {
                            //   if (!phnValidation.hasMatch(v)) {
                            //     return "Enter valid Phone Number";
                            //   } else {
                            //     return null;
                            //   }
                            // },
                            decoration: InputDecoration(
                              labelText: 'WhatsApp No',
                              labelStyle: FlutterFlowTheme.bodyText2.override(
                                fontFamily: 'Montserrat',
                                color: Color(0xFF8B97A2),
                                fontWeight: FontWeight.w500,
                                fontSize: 12,
                              ),
                              hintText: 'Please Enter WhatsApp No',
                              hintStyle: FlutterFlowTheme.bodyText2.override(
                                fontFamily: 'Montserrat',
                                color: Color(0xFF8B97A2),
                                fontWeight: FontWeight.w500,
                                fontSize: 12,
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
                              color: Color(0xFF8B97A2),
                              fontWeight: FontWeight.w500,
                              fontSize: 12,
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
                          child: SearchField(
                            suggestions: agentNumberListLocal,
                            controller: careOf,
                            hint: 'Please Enter c/o Agent Number',
                            searchStyle: TextStyle(
                              fontSize: 18,
                              color: Colors.black.withOpacity(0.8),
                            ),
                            searchInputDecoration: InputDecoration(
                              labelText: 'C/O Employee Number',
                              labelStyle: FlutterFlowTheme.bodyText2.override(
                                fontFamily: 'Montserrat',
                                color: Color(0xFF8B97A2),
                                fontWeight: FontWeight.w500,
                                fontSize: 12,
                              ),
                              hintText: 'Please Enter Number',
                              hintStyle: FlutterFlowTheme.bodyText2.override(
                                fontFamily: 'Montserrat',
                                color: Color(0xFF8B97A2),
                                fontWeight: FontWeight.w500,
                                fontSize: 12,
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

                            onSuggestionTap: (x) {

                              careOf.text = x.searchKey;
                              setState(() {
                              });
                            },
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 30,
                    ),
                    Spacer(),
                    // Expanded(
                    //   child: Container(
                    //     width: 330,
                    //     height: 60,
                    //     decoration: BoxDecoration(
                    //       color: Colors.white,
                    //       borderRadius: BorderRadius.circular(8),
                    //       border: Border.all(
                    //         color: Color(0xFFE6E6E6),
                    //       ),
                    //     ),
                    //     child: Padding(
                    //       padding: EdgeInsets.fromLTRB(16, 0, 0, 0),
                    //       child: TextFormField(
                    //         controller: careOfNo,
                    //         obscureText: false,
                    //         decoration: InputDecoration(
                    //           labelText: 'C/O No',
                    //           labelStyle: FlutterFlowTheme.bodyText2.override(
                    //             fontFamily: 'Montserrat',
                    //             color: Color(0xFF8B97A2),
                    //             fontWeight: FontWeight.w500,
                    //             fontSize: 12,
                    //           ),
                    //           hintText: 'Please Enter Number',
                    //           hintStyle: FlutterFlowTheme.bodyText2.override(
                    //             fontFamily: 'Montserrat',
                    //             color: Color(0xFF8B97A2),
                    //             fontWeight: FontWeight.w500,
                    //             fontSize: 12,
                    //           ),
                    //           enabledBorder: UnderlineInputBorder(
                    //             borderSide: BorderSide(
                    //               color: Colors.transparent,
                    //               width: 1,
                    //             ),
                    //             borderRadius: const BorderRadius.only(
                    //               topLeft: Radius.circular(4.0),
                    //               topRight: Radius.circular(4.0),
                    //             ),
                    //           ),
                    //           focusedBorder: UnderlineInputBorder(
                    //             borderSide: BorderSide(
                    //               color: Colors.transparent,
                    //               width: 1,
                    //             ),
                    //             borderRadius: const BorderRadius.only(
                    //               topLeft: Radius.circular(4.0),
                    //               topRight: Radius.circular(4.0),
                    //             ),
                    //           ),
                    //         ),
                    //         style: FlutterFlowTheme.bodyText2.override(
                    //           fontFamily: 'Montserrat',
                    //           color: Color(0xFF8B97A2),
                    //           fontWeight: FontWeight.w500,
                    //           fontSize: 12,
                    //         ),
                    //       ),
                    //     ),
                    //   ),
                    // ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(0, 24, 0, 44),
                child: FFButtonWidget(
                  onPressed: () async {
                    try {
                      final FormState form = widget.form.currentState!;


                      if (form.validate()) {
                        if (fullName.text != '' && mobile.text != ''
                        // &&
                        // email.text != ''
                        ) {
                          bool pressed =
                          await alert(context, 'Register As Customer...');
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
                              'customerId': FieldValue.increment(1),
                              'enquiryId': FieldValue.increment(1),
                            });
                            int custId = doc.get('customerId');
                            int enquiryId = doc.get('enquiryId');
                            custId++;
                            enquiryId++;

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
                              'customerId': 'C' +
                                  currentbranchShortName +
                                  custId.toString(),
                              'userId': currentUserUid,
                              'branchId': currentBranchId,
                            });

                            FirebaseFirestore.instance
                                .collection('customer')
                                .doc('C' +
                                currentbranchShortName +
                                custId.toString())
                                .set({
                              'enquiryId': 'E' +
                                  currentbranchShortName +
                                  enquiryId.toString(),
                              'form': list,
                              'date': DateTime.now(),
                              'status': 0,
                              'name': fullName.text,
                              'mobile': mobile.text,
                              'projects': 0,
                              'countryCode': countryDialCode,
                              'countryShort': countryShortName,
                              'phoneCode': '+91',
                              'email': email.text,
                              'nationality': selectedCountry,
                              'place': '',
                              'travelHistory': [],
                              'educationalDetails': [],
                              'address': '',
                              'branchId': currentBranchId,
                              'branch': currentbranchName,
                              'userId': currentUserUid,
                              'currentStatus': 'Registered',
                              'nextStatus': 'Document Collection',
                              'comments': '',
                              'documents': {},
                              'newDocuments': {},
                              'referenceDetails': [],
                              'agentId': agentIdByNumber[careOf.text] ?? '',
                              // 'careOf': careOf.text ?? '',
                              // 'careOfNo': careOfNo.text ?? '',
                              'statusList': FieldValue.arrayUnion(statusList),
                              'additionalInfo': '',
                              'projectTopic': '',
                              'photo': '',
                              'projectType': '',
                              'paymentDetails': [],
                              'projectDetails': [],
                              'projectCost': 0.00,
                              'projectName': '',
                              'whatsAppNo': whatsAppNo.text,
                              'companyName': '',
                              'companyAddress': '',
                              'companyEmail': '',
                              'customerID': 'C' +
                                  currentbranchShortName +
                                  custId.toString(),
                            }).then((value) {
                              FirebaseFirestore.instance
                                  .collection('status')
                                  .add({
                                'date': DateTime.now(),
                                'status': 'Registered',
                                'comments': '',
                                'link': '',
                                'customerID': 'C' +
                                    currentbranchShortName +
                                    custId.toString(),
                                'userId': currentUserUid,
                                'branchId': currentBranchId,
                              });
                            });
                            showUploadMessage(
                                context, 'New Customer Registered...');

                            setState(() {
                              Navigator.pop(context);
                            });

                            // Navigator.pop(context);

                          }
                        } else {
                          fullName.text == ''
                              ? showUploadMessage(
                              context, 'Please Enter Customer Name')
                              : mobile.text == ''
                              ? showUploadMessage(
                              context, 'Please Enter Mobile Number')
                              : showUploadMessage(
                              context, 'Please Enter Email');
                        }
                      }
                    }
                    catch(ex){
                      
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
              SizedBox(
                height: 25,
              ),
            ],
          ),
        ),
      ),
    );
  }

  // addFieldtoAlldoc() {
  //   FirebaseFirestore.instance.collection('customer').get().then(
  //         (value) => value.docs.forEach(
  //           (element) {
  //             String str = element['email'];
  //
  //             
  //             str = str.replaceAll(' ', '').toLowerCase();
  //
  //             
  //             FirebaseFirestore.instance
  //                 .collection('customer')
  //                 .doc(element.id)
  //                 .update({'email': str});
  //           },
  //         ),
  //       );
  // }
}
